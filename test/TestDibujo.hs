{-# OPTIONS_GHC -fno-warn-missing-signatures -fno-warn-type-defaults #-}

module Main (main) where

import Dibujo
import Test.HUnit

l = "asd"

fig = figura True

compleja :: Dibujo Integer
compleja = rotar $ rot45 $ espejar $ figura 42

testComp0 = TestCase (assertEqual "(comp 0 f) is id" l (comp 0 tail l))

testComp1 = TestCase (assertEqual "(comp 1 f) is f" (tail l) (comp 1 tail l))

testR90 = TestCase (assertEqual "(r90 $ fig) is (rotar $ fig)" (r90 fig) (rotar fig))

testR180 = TestCase (assertEqual "(r180 $ fig) is (rotar $ rotar $ fig)" (r180 fig) (rotar $ rotar fig))

testR270 = TestCase (assertEqual "(r270 $ fig) is (rotar $ rotar $ rotar $ fig)" (r270 fig) (rotar $ rotar $ rotar fig))

testR90Comp = TestCase (assertEqual "(r90 $ fig) is (comp 1 rotar $ fig)" (r90 fig) (comp 1 rotar fig))

testR180Comp = TestCase (assertEqual "(r180 $ fig) is (comp 2 rotar $ fig)" (r180 fig) (comp 2 rotar fig))

testR270Comp = TestCase (assertEqual "(r270 $ fig) is (comp 3 rotar $ fig)" (r270 fig) (comp 3 rotar fig))

testMapDibId = TestCase (assertEqual "(mapDib id) is id" (mapDib id compleja) compleja)

testMapDib = TestCase (assertEqual "(mapDib not (figura True)) is (figura False)" (mapDib not (figura True)) (figura False))

testChange = 
  TestCase
    ( assertEqual
        "(change (\\_ -> figura True)) is (rotar $ rot45 $ espejar $ figura True)"
        (change (\_ -> figura True) compleja)
        (rotar $ rot45 $ espejar $ figura True)
    )

testFoldDibId =
  TestCase
    ( assertEqual
        "(foldDib figura rotar rot45 espejar juntar apilar encimar compleja) is compleja"
        (foldDib figura rotar rot45 espejar juntar apilar encimar compleja)
        compleja
    )

testFoldDib =
  TestCase
    ( assertEqual
        "(foldDib id id id id (\\_ _ -> (+)) (\\_ _ -> (+)) (+) compleja) is 42"
        (foldDib id id id id (\_ _ -> (+)) (\_ _ -> (+)) (+) compleja)
        42
    )

testFiguras = TestCase $ assertEqual "(figuras compleja) is [42]" (figuras compleja) [42]

tests =
  TestList
    [ TestLabel "test comp 0" testComp0,
      TestLabel "test comp 1" testComp1,
      TestLabel "test r90" testR90,
      TestLabel "test r180" testR180,
      TestLabel "test r270" testR270,
      TestLabel "test r90 with comp" testR90Comp,
      TestLabel "test r180 with comp" testR180Comp,
      TestLabel "test r270 with comp" testR270Comp,
      TestLabel "test mapDib id" testMapDibId,
      TestLabel "test mapDib" testMapDib,
      TestLabel "test change" testChange,
      TestLabel "test foldDib id" testFoldDibId,
      TestLabel "test foldDib" testFoldDib,
      TestLabel "test figuras" testFiguras
    ]

main :: IO ()
main = runTestTTAndExit tests