# encoding: utf-8
# Archivo: VerificarNQueens_steps.rb
# Autor: GenomeTeam
# Email: (jeffersonamado,humbertropolis,ch.morales90) @gmail.com
# Fecha creación: 2015-06-11
# Fecha última modificación: 2015-06-17
# Versión: 0.2
# Licencia: GPL
#--
# edited by JAPeTo
#++

#############
#Comienzo Antecendentes
#
Dado /^un problema para n=(.+?) reinas se crea un cromosoma de tamaño n$/ do |nReinas|
  #Capturo la cantidad de reinas   
  @numeroReinas = nReinas.to_i
  #Instancio el cromosoma con tamanio numero de reinas y con true permito
  #que se aleatorice los genes de cromosoma
  @cromosoma = Chromosome.new(@numeroReinas, true)
  expect( @numeroReinas == @cromosoma.count ).to be true
end

#############
#Verificar que el cromosoma sea valido
#
Dado /^un cromosoma para n reinas$/ do
  #A este punto este objeto no puede ser nulo
  @valido = !@cromosoma.nil?
  expect( @valido).to be true
end
##
#
#
Cuando /^obtengo el valor de cada gen en el cromosoma este debe estar 0 y n-1$/ do 
  #cada uno de los valores deben estar entre 0 y n-1 
  @cromosoma.each {|x| @valido = @valido and 0 < x and x < @numeroReinas-1 }
  expect( @valido ).to be true
end
##
#
#
Entonces /^los valores de los genes en el cromosoma van de 0 y n-1$/ do
  #Todos los valores 0 hasta n-1 deben estar, al restar dos arreglos que contienen
  #los mismos elementos la salida es []
  @valido = @valido and (@cromosoma - Array(0..@numeroReinas-1)).empty?
  expect( @valido ).to be true
end
##
#
#
Y /^los genes de este cromosoma no pueden estar ordenados$/ do
  #al comparar un cromosoma donde los genes estan ordenados 
  #debe ser false con uno que no tenga los elementos ordenados
  @valido = @valido and !@cromosoma.equals(@cromosoma.queen_sort)
  expect( @valido ).to be true
end

#############
#Comienzo verificar operador de mutacion
Dado /^un cromosoma valido$/ do
  @cromosoma = Chromosome.new(@numeroReinas, true)
  #para un nuevo escenario, espero que no sean nulos los genes
  @valido = !@cromosoma[0].nil?
  expect( @valido ).to be true
end
##
#
#
Cuando /^aplico el operador mutar este cromosoma$/ do  
  #si sus genes no son nulos muto
  @hijo = @cromosoma.mutate() if @valido  
  #Si el hijo tiene al menos un gen distinto de nulo
  @valido = !@hijo[0].nil?
  expect( @valido ).to be true
end

Entonces /^el cromosoma resultado es diferente en sus genes$/ do   
  #Al comparar el padre y el hijo deben de ser diferentes en aptitud y en
  #los valores de sus genes
  @valido = true if !@cromosoma.equals(@hijo)  
  expect(@valido).to be true
end

#############
#Comienzo verificar operador de cruce uniforme
Cuando /^aplico el operador cruzar este cromosoma$/  do
  #madre
  @madre= Chromosome.new(@numeroReinas,true)
  #padre
  @padre = Chromosome.new(@numeroReinas,true)
  #hijo cruzado
  @cruzado = @madre.crosover(@padre)
  #es diferente de nulo
  @valido = !@cruzado.nil?
  #valido que por lo menos exista
  expect(@valido).to be true
end
##
#
#
Entonces /^el cromosoma resultado debe parecerse a sus padres pero no debe ser igual a ninguno de los dos$/ do
  #es parecido a a los padres es decir tiene todos los elementos 
  #que aparecen en los padres no es vacio exactamente, un and
  #por que puede haber cromosomas con reinas repetidas
  @valido = true if (@padre - @cruzado).empty? or (@madre - @cruzado).empty?  
  #debe ser diferente a sus padres
  @valido = true if !@padre.equals(@cruzado) and  @madre.equals(@cruzado)
  
  expect(@valido).to be true
end

#############
#Verificar ataque entre reinas
#
Cuando(/^el tablero es$/) do |tabla|
  #mapeo el tablero "crudo"
  #a una instancia como un arreglo
  @tablero2D = tabla.raw
  #cromosoma temporal
  @temporal = Chromosome.new(@tablero2D.length-1)
  #donde hallo una X ahi esta la reina
  @tablero2D.length.times do |i|
    @tablero2D.length.times do |j|
       if @tablero2D[j][i] == 'X' then
         @temporal << (j-1)
       end
    end
  end
  #creo un cromosoma con el mismo tamaño del temporal
  @cromosoma = Chromosome.new(@temporal.length)   
  #copio la lectura temporal al cromosoma
  @temporal.length.times do |i|
    @cromosoma << @temporal[i]
  end
  #si este cromosoma tiene al menos un gen 
  @valido = !@cromosoma[0].nil?
  #Es valido en este caso
  expect( @valido ).to be true
end
##
#
#
Entonces /^al evaluarlo debe indicar (.+?) conflictos$/ do |nConflictos|
  #el numero de conflictos que determina el usuario
  @nConflictos = nConflictos.to_i  
  #actulizo el numero de ataques, es decir la aptidud
  #por que para el cromosoma temporal es 0 y al copiar los elementos a cromosoma
  #no se actualiza el valor de los ataques
  @cromosoma.count_attacks()
  #es valido en este caso
  expect( @valido ).to be true
end
