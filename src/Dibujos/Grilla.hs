module Dibujos.Grilla
  ( grilla,
    grillaConf,
  )
where

import Dibujo (figura)
import Dibujos.Utils (grilla)
import FloatingPic (Conf (Conf, bas, name, pic), Output)
import Graphics.Gloss (text)
import Graphics.Gloss.Data.Picture (scale, translate)

type Basica = (Int, Int)

interpBasica :: Output Basica
interpBasica (x, y) (dx, dy) (w, _) (_, h) =
  translate (dx + w / 2) (dy + h / 2) $ scale 0.1 0.1 $ text $ "(" ++ show x ++ "," ++ show y ++ ")"

grillaConf :: Conf
grillaConf =
  Conf
    { name = "Grilla",
      pic = grilla $ map (\x -> map (\y -> figura (x, y)) [0 .. 7]) [0 .. 7],
      bas = interpBasica
    }
