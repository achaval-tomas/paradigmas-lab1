module Dibujos.Escher (escherConf) where

import Dibujo (Dibujo, apilar, cuarteto, encimar, espejar, figura, juntar, r180, r270, rot45, rotar)
import FloatingPic (Conf (..), Output)
import Graphics.Gloss (Picture, Vector, blank, line, pictures)
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

-- Supongamos que eligen.
data Escher = Fish | Blank deriving (Eq, Show)

vacia = figura Blank

plot :: Vector -> Vector -> Vector -> [(Float, Float)] -> Picture
plot d w h ps = line $ map (\(x, y) -> d V.+ (x V.* w) V.+ (y V.* h)) ps

interpBas :: Output Escher
interpBas Fish d w h = plot d w h [(0.25, 0.2), (0.25, 0.8), (0.3, 0.8), (0.3, 0.25), (0.55, 0.25), (0.55, 0.2), (0.25, 0.2)]
interpBas Blank _ _ _ = blank

-- El dibujo u.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU fish = encimar (encimar fish2 $ rotar fish2) (encimar (r180 fish2) (r270 fish2))
  where
    fish2 = espejar $ rot45 fish

-- El dibujo t.
dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT fish = encimar fish $ encimar fish2 fish3
  where
    fish2 = espejar $ rot45 fish
    fish3 = r270 fish2

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
esquina 0 _ = vacia
esquina n p = cuarteto (esquina (n - 1) p) (lado (n - 1) p) (rotar $ lado (n - 1) p) u
  where
    u = dibujoU p

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 0 _ = vacia
lado n p = cuarteto (lado (n - 1) p) (lado (n - 1) p) (rotar t) t
  where
    t = dibujoT p

-- Por suerte no tenemos que poner el tipo!
noneto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
noneto p q r s t u v w x =
  apilar
    1
    2
    (juntar 1 2 p (juntar 1 1 q r))
    (apilar 1 1 (juntar 1 2 s (juntar 1 1 t u)) (juntar 1 2 v (juntar 1 1 w x)))

-- El dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher n p = noneto e l (r270 e) (rotar l) u (r270 l) (rotar e) (r180 l) (r180 e)
  where
    e = esquina n $ figura p
    l = lado n $ figura p
    u = dibujoU $ figura p

escherConf :: Conf
escherConf =
  Conf
    { name = "Escher",
      pic = escher 7 Fish,
      bas = interpBas
    }