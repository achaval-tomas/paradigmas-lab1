module Pred
  ( Pred,
    allDib,
    andP,
    anyDib,
    cambiar,
    falla,
    orP,
  )
where

import Dibujo (Dibujo, apilar, encimar, espejar, figura, foldDib, juntar, rot45, rotar)

-- `Pred a` define un predicado sobre figuras básicas. Por ejemplo,
-- `(== Triangulo)` es un `Pred TriOCuat` que devuelve `True` cuando la
-- figura es `Triangulo`.
type Pred a = a -> Bool

-- Dado un predicado sobre figuras básicas, cambiar todas las que satisfacen
-- el predicado por el resultado de llamar a la función indicada por el
-- segundo argumento con dicha figura.
-- Por ejemplo, `cambiar (== Triangulo) (\x -> Rotar (Figura x))` rota
-- todos los triángulos.
cambiar :: Pred a -> (a -> Dibujo a) -> Dibujo a -> Dibujo a
cambiar p f = foldDib (\x -> if p x then f x else figura x) rotar rot45 espejar juntar apilar encimar


-- Alguna básica satisface el predicado.
anyDib :: Pred a -> Dibujo a -> Bool
anyDib p = foldDib p id id id f f (||)
  where f _ _ = (||)

-- Todas las básicas satisfacen el predicado.
allDib :: Pred a -> Dibujo a -> Bool
allDib p = foldDib p id id id f f (&&)
  where f _ _ = (&&)

-- Los dos predicados se cumplen para el elemento recibido.
andP = undefined

-- Algún predicado se cumple para el elemento recibido.
orP = undefined

falla = True
