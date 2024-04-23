---
title: Laboratorio de Funcional
author: Tomás Achával, Tomás Maraschio, Tomás Peyronel
---
La consigna del laboratorio está en https://tinyurl.com/funcional-2024-famaf

# 1. Tareas
Pueden usar esta checklist para indicar el avance.

## Verificación de que pueden hacer las cosas.
- [x] Haskell instalado y testeos provistos funcionando. (En Install.md están las instrucciones para instalar.)

## 1.1. Lenguaje
- [x] Módulo `Dibujo.hs` con el tipo `Dibujo` y combinadores. Puntos 1 a 3 de la consigna.
- [x] Definición de funciones (esquemas) para la manipulación de dibujos.
- [x] Módulo `Pred.hs`. Punto extra si definen predicados para transformaciones innecesarias (por ejemplo, espejar dos veces es la identidad).

## 1.2. Interpretación geométrica
- [x] Módulo `Interp.hs`.

## 1.3. Expresión artística (Utilizar el lenguaje)
- [x] El dibujo de `Dibujos/Feo.hs` se ve lindo.
- [x] Módulo `Dibujos/Grilla.hs`.
- [x] Módulo `Dibujos/Escher.hs`.
- [x] Listado de dibujos en `Main.hs`.

## 1.4 Tests
- [x] Tests para `Dibujo.hs`.
- [x] Tests para `Pred.hs`.

# 2. Experiencia
Hacer el laboratorio fue una buena experiencia, nos hizo recordar Haskell (incluso aprender más) y también tuvo algunas dificultades que supimos enfrentar. La checklist fue útil para trabajar paso a paso.<br>
Está bueno hacer programas que tengan un output visual, de esta forma es más entretenido y da lugar a algo más de creatividad. Fue interesante aprender sobre Gloss, y su [documentación](https://hackage.haskell.org/package/gloss), simple pero completa, fue muy útil.<br>
Algunas observaciones y sugerencias desde nuestro punto de vista:<br>
- Quizás la explicación en comentarios de algunas funciones como foldDib nos pareció insuficiente (por ej, ¿Qué representa cada argumento?).
- El módulo definido en Pred.hs nos resultó poco útil por fuera de los tests, quizás algun punto más en la consigna podría dar lugar a su utilización.
- El código del kickstart _no coincidía_ al 100% con el del enunciado, por lo tanto algunas partes se volvieron confusas.

# 3. Preguntas

## ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo.
Las funcionalidades están separadas en módulos para poder abstraernos de sus implementaciones, y cada uno de estos módulos se encarga de solucionar un problema especifico:<br>
Módulo Dibujo: Contiene la declaracion de nuestro DSL y todo lo relacionado a armar y transformar dibujos como tipo/estructura de datos.<br>
Módulo FloatingPic: Contiene funciones básicas sobre vectores y las definiciones de los tipos FloatingPic (una imagen de un tamaño especificado a renderizar en coordenadas especificadas) y Output (Utilizado como función que convierte un dibujo en una FloatingPic).<br>
Módulo Interp: Se encarga de interpretar los dibujos y sus transformaciones, ajustando sus coordenadas y tamaños.<br>
Módulo Pred: Funciones booleanas sobre dibujos.<br>
Módulo Main: Se encarga de correr el programa, permitiendonos seleccionar un dibujo para mostrarlo en pantalla.
## ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez de eso, es un parámetro del tipo?
Las figuras básicas son un parámetro del tipo Dibujo por razones de **polimorfismo** => poder crear Dibujos de cualquier tipo de figura básica utilizando la misma estructura y formato. Más aún, ¡podemos transformar un Dibujo de un tipo de figura básica a otro!
## ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?
Utilizar la función foldDib nos permite ignorar la implementación interna de los Dibujos (por lo tanto, sus constructores podrian cambiar de nombre sin problemas) y, con un solo llamado, generar una cadena compuesta de funciones a aplicar sobre sus figuras.
## ¿Cuál es la diferencia entre los predicados definidos en Pred.hs y los tests?
En Pred.hs están definidas funciones que se usan para definir predicados,
mientras que en los tests definimos algunos predicados que queremos que sean ciertos
en base a las funciones definidas en Pred.hs.
# 4. Extras
Para implementar interpBas FishHD en Escher.hs, primero dibujamos un SVG en un editor
vectorial. Luego, creamos un script que convierte un SVG con curvas a una serie de secuencias
de puntos.

