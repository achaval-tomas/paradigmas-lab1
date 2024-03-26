{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Eta reduce" #-}

module Interp
  ( interp,
    initial,
  )
where

import Dibujo
import FloatingPic
import Graphics.Gloss (Display (InWindow), Picture, color, display, makeColorI, pictures, translate, white)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V
import Graphics.Gloss.Data.Vector (mulSV)

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: Conf -> Float -> IO ()
initial (Conf n dib intBas) size = display win white $ withGrid fig size
  where
    win = InWindow n (ceiling size, ceiling size) (0, 0)
    fig = interp intBas dib (0, 0) (size, 0) (0, size)
    desp = -(size / 2)
    withGrid p x = translate desp desp $ pictures [p, color grey $ grid (ceiling $ size / 10) (0, 0) x 10]
    grey = makeColorI 100 100 100 100

-- Interpretación de (^^^)
ov :: Picture -> Picture -> Picture
ov p q = undefined

r45 :: FloatingPic -> FloatingPic
r45 = undefined

rot :: FloatingPic -> FloatingPic
rot f d w h = f (d V.+ w) h (V.negate w)

esp :: FloatingPic -> FloatingPic
esp f d w h = f (d V.+ w) (V.negate w) h

sup :: FloatingPic -> FloatingPic -> FloatingPic
sup f g d w h = pictures [f d w h, g d w h]

jun :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
jun = undefined

api :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
api wf wg f g d w h = pictures [f df w hf, g d w hg]
  where
    wt = wf + wg -- wt: weight total
    sf = wf / wt -- sf: share of f
    sg = 1 - sf -- sg: share of g
    hf = sf `mulSV` h -- hf: height of f
    hg = sg `mulSV` h -- hg: height of g
    df = d V.+ hg

interp :: Output a -> Output (Dibujo a)
interp b = undefined