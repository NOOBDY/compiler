{-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Avoid lambda using `infix`" #-}
{-# HLINT ignore "Eta reduce" #-}

module Main where

import Control.Exception (assert)
import Control.Monad (unless)
import Control.Monad.ST (runST)
import Control.Monad.ST.Lazy (ST)
import Data.Map qualified as Map
import Data.STRef (STRef, newSTRef, readSTRef, writeSTRef)
import Data.Set qualified as Set
import Text.Printf (printf)
import Prelude hiding (last, null)

type IChar = (Char, Int)

data RegExp
    = Epsilon
    | Character IChar
    | Union RegExp RegExp
    | Concat RegExp RegExp
    | Star RegExp

type CSet = Set.Set IChar

type State = CSet

type CMap a = Map.Map Char a
type SMap a = Map.Map State a

data Autom = Autom
    { start :: State
    , trans :: SMap (CMap State)
    }
    deriving (Show)

null :: RegExp -> Bool
null Epsilon = True
null (Star _) = True
null (Character _) = False
null (Union e1 e2) = null e1 || null e2
null (Concat e1 e2) = null e1 && null e2

first :: RegExp -> State
first Epsilon = Set.empty
first (Character c) = Set.singleton c
first (Union e1 e2) = Set.union (first e1) (first e2)
first (Concat e1 e2) =
    if null e1
        then Set.union (first e1) (first e2)
        else first e1
first (Star e) = first e

last :: RegExp -> State
last Epsilon = Set.empty
last (Character e) = Set.singleton e
last (Union e1 e2) = Set.union (last e1) (last e2)
last (Concat e1 e2) =
    if null e2
        then Set.union (last e1) (last e2)
        else last e2
last (Star e) = last e

follow :: IChar -> RegExp -> State
follow c Epsilon = Set.empty
follow c (Character _) = Set.empty
follow c (Union e1 e2) = Set.union (follow c e1) (follow c e2)
follow c (Concat e1 e2) =
    if Set.member c (last e1)
        then Set.union s (first e2)
        else s
  where
    s = Set.union (follow c e1) (follow c e2)
follow c (Star e) =
    if Set.member c (last e)
        then Set.union s (first e)
        else s
  where
    s = follow c e

eof :: IChar
eof = ('#', -1)

nextState :: RegExp -> State -> Char -> State
nextState e q c =
    Set.foldl
        ( \acc ic@(c', _) ->
            if c' == c
                then Set.union (follow ic e) acc
                else acc
        )
        Set.empty
        q

makeDFA :: RegExp -> Autom
makeDFA e =
    let
        e' = Concat e (Character eof)
        q0 = first e'
        transition q ref = do
            t <- readSTRef ref
            unless
                (Map.member q t)
                ( do
                    writeSTRef ref (Map.insert q delta t)
                    mapM_ (\q' -> transition q' ref) delta
                )
          where
            delta =
                Set.foldl
                    ( \acc' (c, _) ->
                        let q' = nextState e' q c
                         in Map.insert c q' acc'
                    )
                    Map.empty
                    q

        trans = runST $ do
            ref <- newSTRef Map.empty
            transition q0 ref
            readSTRef ref
     in
        Autom{start = q0, trans = trans}

recognize :: Autom -> String -> Bool
recognize a s =
    let
        q0 = start a
     in
        isFinal $ foldl aux (Just q0) s
  where
    isFinal :: Maybe State -> Bool
    isFinal (Just q) = Set.member eof q
    isFinal Nothing = False

    aux :: Maybe State -> Char -> Maybe State
    aux (Just q) c = do
        q's <- Map.lookup q (trans a)
        Map.lookup c q's
    aux Nothing _ = Nothing

fprintState :: State -> String
fprintState q = Set.foldl print' "" q
  where
    print' acc (c, i) =
        acc
            <> ( if c == '#'
                    then "# "
                    else printf "%c%i " c i
               )

fprintTransition :: State -> Char -> State -> String
fprintTransition q c q' =
    printf
        "\"%s\" -> \"%s\" [label=\"%c\"];\n"
        (fprintState q)
        (fprintState q')
        c

fprintAutom :: Autom -> String
fprintAutom a =
    "digraph A {\n"
        <> printf " \"%s\" [ shape = \"rect\"];\n" (fprintState (start a))
        <> Map.foldlWithKey print' "" (trans a)
        <> "\n}"
  where
    print' acc q t = acc <> Map.foldlWithKey print'' "" t
      where
        print'' acc' c q' = acc' <> fprintTransition q c q'

main :: IO ()
main = do
    -- ex1
    let a = Character ('a', 0)
    let !_ = assert ((not . null) a)
    let !_ = assert (null (Star a)) ()
    let !_ = assert (null (Concat Epsilon (Star Epsilon))) ()
    let !_ = assert (null (Union Epsilon a)) ()
    let !_ = assert ((not . null) (Concat a (Star a))) ()

    -- ex2
    let ca = ('a', 0)
        cb = ('b', 0)
    let a = Character ca
        b = Character cb
    let ab = Concat a b

    let !_ = assert (first a == Set.singleton ca) ()
    let !_ = assert (first ab == Set.singleton ca) ()
    let !_ = assert (first (Star ab) == Set.singleton ca) ()
    let !_ = assert (last b == Set.singleton cb) ()
    let !_ = assert (last ab == Set.singleton cb) ()
    let !_ = assert (Set.size (first (Union a b)) == 2) ()
    let !_ = assert (Set.size (first (Concat (Star a) b)) == 2) ()
    let !_ = assert (Set.size (last (Concat a (Star b))) == 2) ()

    -- ex3
    let ca = ('a', 0)
        cb = ('b', 0)
    let a = Character ca
        b = Character cb
    let ab = Concat a b

    let !_ = assert (follow ca ab == Set.singleton cb) ()
    let !_ = assert (Set.null (follow cb ab)) ()

    let r = Star (Union a b)

    let !_ = assert (Set.size (follow ca r) == 2) ()
    let !_ = assert (Set.size (follow cb r) == 2) ()

    let r2 = Star (Concat a (Star b))

    let !_ = assert (Set.size (follow cb r2) == 2) ()

    let r3 = Concat (Star a) b

    let !_ = assert (Set.size (follow ca r3) == 2) ()

    -- ex4
    -- (a|b)*a(a|b)
    let e1 =
            Concat
                (Star (Union (Character ('a', 1)) (Character ('b', 1))))
                ( Concat
                    (Character ('a', 2))
                    (Union (Character ('a', 3)) (Character ('b', 2)))
                )

    let a1 = makeDFA e1
    putStrLn $ fprintAutom a1
    -- writeFile "autom.dot" $ fprintAutom a

    -- ex5
    let !_ = assert (recognize a1 "aa") ()
    let !_ = assert (recognize a1 "ab") ()
    let !_ = assert (recognize a1 "abababaab") ()
    let !_ = assert (recognize a1 "babababab") ()
    let !_ = assert (recognize a1 $ replicate 1000 'b' <> "ab") ()
    let !_ = assert (not $ recognize a1 "") ()
    let !_ = assert (not $ recognize a1 "a") ()
    let !_ = assert (not $ recognize a1 "b") ()
    let !_ = assert (not $ recognize a1 "ba") ()
    let !_ = assert (not $ recognize a1 "aba") ()
    let !_ = assert (not $ recognize a1 "abababaaba") ()

    -- (a*|ba*b)*
    let e2 =
            Star
                ( Union
                    (Star (Character ('a', 1)))
                    ( Concat
                        (Character ('b', 1))
                        ( Concat
                            (Star (Character ('a', 2)))
                            (Character ('b', 2))
                        )
                    )
                )

    let a2 = makeDFA e2
    putStrLn $ fprintAutom a2
    -- writeFile "autom2.dot" $ fprintAutom a2

    let !_ = assert (recognize a2 "") ()
    let !_ = assert (recognize a2 "bb") ()
    let !_ = assert (recognize a2 "aaa") ()
    let !_ = assert (recognize a2 "aaabbaaababaaa") ()
    let !_ = assert (recognize a2 "bbbbbbbbbbbbbb") ()
    let !_ = assert (recognize a2 "bbbbabbbbabbbabbb") ()
    let !_ = assert (not $ recognize a2 "b") ()
    let !_ = assert (not $ recognize a2 "ba") ()
    let !_ = assert (not $ recognize a2 "ab") ()
    let !_ = assert (not $ recognize a2 "aaabbaaaaabaaa") ()
    let !_ = assert (not $ recognize a2 "bbbbbbbbbbbbb") ()
    let !_ = assert (not $ recognize a2 "bbbbabbbbabbbabbbb") ()
    return ()
