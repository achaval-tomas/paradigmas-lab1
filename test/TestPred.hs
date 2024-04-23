{-# OPTIONS_GHC -fno-warn-missing-signatures -fno-warn-type-defaults #-}
module Main (main) where

import Dibujo
import Pred
import Test.HUnit

testDib :: Dibujo Integer
testDib = juntar 1 1 (encimar (figura 10) (figura 8)) (rot45 (figura 5))

testCambiar = TestCase
    ( assertEqual 
       "cambiar (<6) (\\x -> figura (x-2)) changes 5 to 3"
        (cambiar (<6) (\x -> figura (x-2)) testDib)
        (juntar 1 1 (encimar (figura 10) (figura 8)) (rot45 (figura 3)))
    )

testAnyDibTrue = TestCase
    ( assertEqual 
       "anyDib (<6) is True"
        (anyDib (<6) testDib)
        True
    )

testAnyDibFalse = TestCase
    ( assertEqual 
       "anyDib (>6) is False"
        (anyDib (>20) testDib)
        False
    )

testAllDibTrue = TestCase
    ( assertEqual 
       "allDib (>0) is True"
        (allDib (>0) testDib)
        True
    )

testAllDibFalse = TestCase
    ( assertEqual 
       "allDib (>8) is False"
        (allDib (>8) testDib)
        False
    )

testAndPTrue = TestCase
    ( assertEqual 
       "andP (<10) (>5) (8) is True"
        (andP (<10) (>5) (8))
        True
    )

testAndPFalse = TestCase
    ( assertEqual 
       "andP (>10) (<20) (8) is False"
        (andP (>10) (<20) (8))
        False
    )

testOrPTrue = TestCase
    ( assertEqual 
       "orP (<6) (>7) (8) is True"
        (orP (<6) (>7) (8))
        True
    )

testOrPFalse = TestCase
    ( assertEqual 
       "orP (>10) (<5) (8) is False"
        (orP (>10) (<5) (8))
        False
    )

tests =
    TestList
      [ TestLabel "test cambiar" testCambiar,
        TestLabel "test anyDib true" testAnyDibTrue,
        TestLabel "test anyDib false" testAnyDibFalse,
        TestLabel "test allDib true" testAllDibTrue,
        TestLabel "test allDib false" testAllDibFalse,
        TestLabel "test andP true" testAndPTrue,
        TestLabel "test andP false" testAndPFalse,
        TestLabel "test orP true" testOrPTrue,
        TestLabel "test orP false" testOrPFalse
      ]

main :: IO ()
main = runTestTTAndExit tests