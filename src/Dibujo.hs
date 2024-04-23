-- {-# OPTIONS_GHC -Wno-unused-top-binds #-}

module Dibujo
  ( Dibujo,
    comp,
    figura,
    encimar,
    apilar,
    juntar,
    rot45,
    rotar,
    espejar,
    (^^^),
    (.-.),
    (///),
    r90,
    r180,
    r270,
    encimar4,
    cuarteto,
    ciclar,
    mapDib,
    change,
    foldDib,
    figuras,
  )
where

data TriORect = Triangulo | Rectangulo deriving (Eq, Show)

-- nuestro lenguaje
data Dibujo a
  = Figura a
  | Rotar (Dibujo a)
  | Rot45 (Dibujo a)
  | Espejar (Dibujo a)
  | Encimar (Dibujo a) (Dibujo a)
  | Juntar Float Float (Dibujo a) (Dibujo a)
  | Apilar Float Float (Dibujo a) (Dibujo a)
  deriving (Eq, Show)

-- combinadores
infixr 6 ^^^

infixr 7 .-.

infixr 8 ///

comp :: Int -> (a -> a) -> a -> a
comp 0 _ = id
comp n f = f . comp (n - 1) f

-- Funciones constructoras
figura :: a -> Dibujo a
figura = Figura

encimar :: Dibujo a -> Dibujo a -> Dibujo a
encimar = Encimar

apilar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
apilar = Apilar

juntar :: Float -> Float -> Dibujo a -> Dibujo a -> Dibujo a
juntar = Juntar

rot45 :: Dibujo a -> Dibujo a
rot45 = Rot45

rotar :: Dibujo a -> Dibujo a
rotar = Rotar

espejar :: Dibujo a -> Dibujo a
espejar = Espejar

(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) = Encimar

(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) = Apilar 1 1

(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) = Juntar 1 1

-- rotaciones
r90 :: Dibujo a -> Dibujo a
r90 = Rotar

r180 :: Dibujo a -> Dibujo a
r180 = Rotar . Rotar

r270 :: Dibujo a -> Dibujo a
r270 = Rotar . Rotar . Rotar

-- una figura repetida con las cuatro rotaciones, superimpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 d = Encimar d $ Encimar (r90 d) $ Encimar (r180 d) (r270 d)

-- cuatro figuras en un cuadrante.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto a b c d = Apilar 1 1 (Juntar 1 1 a b) (Juntar 1 1 c d)

-- un cuarteto donde se repite la imagen, rotada (¡No confundir con encimar4!)
ciclar :: Dibujo a -> Dibujo a
ciclar d = cuarteto d (r90 d) (r180 d) (r270 d)

-- map para nuestro lenguaje
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f (Figura d) = Figura $ f d
mapDib f (Rotar d) = Rotar $ mapDib f d
mapDib f (Rot45 d) = Rot45 $ mapDib f d
mapDib f (Espejar d) = Espejar $ mapDib f d
mapDib f (Encimar d e) = Encimar (mapDib f d) (mapDib f e)
mapDib f (Juntar x y d e) = Juntar x y (mapDib f d) (mapDib f e)
mapDib f (Apilar x y d e) = Apilar x y (mapDib f d) (mapDib f e)

-- verificar que las operaciones satisfagan
-- 1. map figura = id
-- 2. map (g . f) = mapDib g . mapDib f

-- Cambiar todas las básicas de acuerdo a la función.
change :: (a -> Dibujo b) -> Dibujo a -> Dibujo b
change f = foldDib f rotar rot45 espejar juntar apilar encimar

-- Principio de recursión para Dibujos.
-- Estructura general para la semántica (a no asustarse). Ayuda:
-- pensar en foldr y las definiciones de intro a la lógica
-- foldDib aplicado a cada constructor de Dibujo debería devolver el mismo
-- dibujo
foldDib ::
  (a -> b) ->
  (b -> b) ->
  (b -> b) ->
  (b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (Float -> Float -> b -> b -> b) ->
  (b -> b -> b) ->
  Dibujo a ->
  b
foldDib f rot r45 esp junt api enc dib = case dib of
  Figura a -> f a
  Rotar d -> rot $ foldDib f rot r45 esp junt api enc d
  Rot45 d -> r45 $ foldDib f rot r45 esp junt api enc d
  Espejar d -> esp $ foldDib f rot r45 esp junt api enc d
  Juntar x y d d' -> junt x y (foldDib f rot r45 esp junt api enc d) (foldDib f rot r45 esp junt api enc d')
  Apilar x y d d' -> api x y (foldDib f rot r45 esp junt api enc d) (foldDib f rot r45 esp junt api enc d')
  Encimar d d' -> enc (foldDib f rot r45 esp junt api enc d) (foldDib f rot r45 esp junt api enc d')

figuras :: Dibujo a -> [a]
figuras = foldDib (: []) id id id f f (++)
  where
    f _ _ = (++)