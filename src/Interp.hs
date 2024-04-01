{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Eta reduce" #-}

module Interp
  ( interp,
    initial,
  )
where

import Dibujo (Dibujo, foldDib)
import FloatingPic
import Graphics.Gloss (Display (InWindow), color, display, makeColorI, pictures, translate, white)
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
ov :: FloatingPic -> FloatingPic -> FloatingPic
ov f g d w h = pictures [f d w h, g d w h]

r45 :: FloatingPic -> FloatingPic
r45 f d w h = f (d V.+ new_w) new_w new_h
  where
    new_w = 0.5 V.* (w V.+ h)
    new_h = 0.5 V.* (h V.- w)

rot :: FloatingPic -> FloatingPic
rot f d w h = f (d V.+ w) h (V.negate w)

esp :: FloatingPic -> FloatingPic
esp f d w h = f (d V.+ w) (V.negate w) h

sup :: FloatingPic -> FloatingPic -> FloatingPic
sup f g d w h = pictures [f d w h, g d w h]

jun :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
jun f_weight g_weight f g d w h = pictures [f d f_width h, g d_g g_width h]
  where
    total_weight = f_weight + g_weight
    f_share = f_weight / total_weight
    f_width = mulSV f_share w
    g_width = mulSV (1 - f_share) w
    d_g = d V.+ f_width

api :: Float -> Float -> FloatingPic -> FloatingPic -> FloatingPic
api f_weight g_weight f g d w h = pictures [f df w f_height, g d w g_height]
  where
    total_weight = f_weight + g_weight
    f_share = f_weight / total_weight
    f_height = mulSV f_share h
    g_height = mulSV (1 - f_share) h
    df = d V.+ g_height

interp :: Output a -> Output (Dibujo a)
interp intBas = foldDib intBas rot r45 esp jun api sup
