module Dibujos.Escher (escherConf) where
    
import FloatingPic(Conf(..), Output)
import Dibujo (Dibujo, figura, juntar, apilar, rot45, r180, r270, rotar, encimar, espejar, cuarteto)
import Graphics.Gloss ( Vector, Picture, line, pictures, blank )

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
esquina n p = cuarteto (esquina (n-1) p) (lado n p) (rotar $ lado n p) u
  where
    u = dibujoU p

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 0 _ = vacia
lado n p = cuarteto (lado (n-1) p) (lado (n-1) p) (rotar t) t
  where
    t = dibujoT p
    

-- Por suerte no tenemos que poner el tipo!
noneto p q r s t u v w x = undefined

-- El dibujo de Escher:
escher :: Int -> Escher -> Dibujo Escher
escher = undefined

escherConf :: Conf
escherConf = Conf {
    name = "Escher",
    pic = esquina 10 $ figura Fish,
    bas = interpBas
}