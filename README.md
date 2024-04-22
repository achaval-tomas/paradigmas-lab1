---
title: Laboratorio de Funcional
author: Tomás Achával, Tomás Maraschio, Tomás Peyronel
---
La consigna del laboratorio está en https://tinyurl.com/funcional-2024-famaf

# 1. Tareas
Pueden usar esta checklist para indicar el avance.

## Verificación de que pueden hacer las cosas.
- [ ] Haskell instalado y testeos provistos funcionando. (En Install.md están las instrucciones para instalar.)

## 1.1. Lenguaje
- [ ] Módulo `Dibujo.hs` con el tipo `Dibujo` y combinadores. Puntos 1 a 3 de la consigna.
- [ ] Definición de funciones (esquemas) para la manipulación de dibujos.
- [ ] Módulo `Pred.hs`. Punto extra si definen predicados para transformaciones innecesarias (por ejemplo, espejar dos veces es la identidad).

## 1.2. Interpretación geométrica
- [ ] Módulo `Interp.hs`.

## 1.3. Expresión artística (Utilizar el lenguaje)
- [ ] El dibujo de `Dibujos/Feo.hs` se ve lindo.
- [ ] Módulo `Dibujos/Grilla.hs`.
- [ ] Módulo `Dibujos/Escher.hs`.
- [ ] Listado de dibujos en `Main.hs`.

## 1.4 Tests
- [ ] Tests para `Dibujo.hs`.
- [ ] Tests para `Pred.hs`.

# 2. Experiencia
Completar

# 3. Preguntas
Al responder tranformar cada pregunta en una subsección para que sea más fácil de leer.

## ¿Por qué están separadas las funcionalidades en los módulos indicados? Explicar detalladamente la responsabilidad de cada módulo.
<!-- TODO: ***explicar detalladamente***-->
Las funcionalidades están separadas en módulos para poder abstraernos de sus implementaciones.<br>
Módulo Dibujo: Contiene la declaracion de nuestro "lenguaje" y todo lo relacionado a armar y transformar dibujos como tipo/estructura de datos.<br>
Módulo FloatingPic: Contiene funciones básicas sobre vectores y las definiciones de los tipos FloatingPic (una imagen de un tamaño especificado a renderizar en coordenadas especificadas) y Output (Utilizado como función que convierte un dibujo en una FloatingPic).<br>
Módulo Interp: Se encarga de interpretar los dibujos y sus transformaciones, ajustando sus coordenadas y tamaños.<br>
Módulo Pred: Funciones booleanas sobre dibujos.<br>
Módulo Main: Se encarga de correr el programa, permitiendonos seleccionar un dibujo para mostrarlo en pantalla.
## ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez de eso, es un parámetro del tipo?
Las figuras básicas son un parámetro del tipo Dibujo por razones de **polimorfismo** => poder crear Dibujos de cualquier tipo de figura básica utilizando la misma estructura y formato. Más aún, podemos transformar un Dibujo de un tipo de figura básica a otro!
## ¿Qué ventaja tiene utilizar una función de `fold` sobre hacer pattern-matching directo?
Utilizar la función foldDib nos permite ignorar el despliegue interno de los Dibujos y, con un solo llamado, generar una cadena compuesta de funciones a aplicar sobre sus figuras.
## ¿Cuál es la diferencia entre los predicados definidos en Pred.hs y los tests?
<!-- TODO: what -->
# 4. Extras
<!-- TODO: @tom explicar como generaste los puntos del escher -->