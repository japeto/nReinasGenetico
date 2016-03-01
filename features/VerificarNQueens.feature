# language: es
# encoding: utf-8
# Archivo: VerificarNQueens.feature
# Autor: GenomeTeam
# Email: (jeffersonamado,humbertropolis,ch.morales90) @gmail.com
# Fecha creación: 2015-06-11
# Fecha última modificación: 2015-06-17
# Versión: 0.4
# Licencia: GPL

Característica: Probar el tablero de n-reinas validando la creacion correcta de cromosomas, la operacion correcta de mutacion, cruce uniforme y verificar que funciona que evalua correctamente los ataques entre reinas.

  Antecedentes: Crear un cromosoma de tamaño n
    Dado un problema para n=10 reinas se crea un cromosoma de tamaño n 

  Escenario: Verificar que el cromosoma sea valido
    Dado un cromosoma para n reinas
    Cuando obtengo el valor de cada gen en el cromosoma este debe estar 0 y n-1
    Entonces los valores de los genes en el cromosoma van de 0 y n-1
    Y los genes de este cromosoma no pueden estar ordenados
  
  Escenario: Verificar el operador de mutacion
    Dado un cromosoma valido
    Cuando aplico el operador mutar este cromosoma
    Entonces el cromosoma resultado es diferente en sus genes   
    
  Escenario: Verificar el operador de cruce uniforme
    Dado un cromosoma valido
    Cuando aplico el operador cruzar este cromosoma
    Entonces el cromosoma resultado debe parecerse a sus padres pero no debe ser igual a ninguno de los dos

  Escenario: Verificar ataque con 2 reinas
    Cuando el tablero es
      |   |   |   |   |
      |   | X |   |   |
      | X |   |   |   |
      |   |   |   |   |
    Entonces al evaluarlo debe indicar 1 conflictos
    
  Escenario: Verificar ataque con 3 reinas
    Cuando el tablero es
      |   |   |   |   |
      |   | X |   |   |
      | X |   |   |   |
      |   |   | X |   |
    Entonces al evaluarlo debe indicar 1 conflictos
  Escenario: Verificar ataque con 3 reinas
    Cuando el tablero es
      |   | X |   |   |
      | X |   |   |   |
      |   |   | X |   |
      |   |   |   |   |
    Entonces al evaluarlo debe indicar 1 conflictos

  Escenario: Verificar ataque con 4 reinas
    Cuando el tablero es
      | X |   |   |   |
      |   | X |   |   |
      |   |   |   | X |
      |   |   | X |   |
    Entonces al evaluarlo debe indicar 2 conflictos

  Escenario: Verificar ataque con 4 reinas
    Cuando el tablero es
      | X |   |   |   |
      |   | X |   |   |
      |   |   | X |   |
      |   |   |   | X |
    Entonces al evaluarlo debe indicar 6 conflictos

  Escenario: Verificar ataque con 4 reinas
    Cuando el tablero es
      |   |   |   | X |
      |   |   | X |   |
      |   | X |   |   |
      | X |   |   |   |
    Entonces al evaluarlo debe indicar 6 conflictos




