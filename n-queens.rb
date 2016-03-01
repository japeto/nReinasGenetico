#! /usr/bin/ruby
#--
########################################################################
#   _____                              _______
#  / ____|                            |__   __|
# | |  __  ___ _ __   ___  _ __ ___   ___| | ___  __ _ _ __ ___
# | | |_ |/ _ \ '_ \ / _ \| '_ ` _ \ / _ \ |/ _ \/ _` | '_ ` _ \
# | |__| |  __/ | | | (_) | | | | | |  __/ |  __/ (_| | | | | | |
#  \_____|\___|_| |_|\___/|_| |_| |_|\___|_|\___|\__,_|_| |_| |_|
#
########################################################################
# file: n-queens.rb
# date: 2015-06-09
# last: 2015-06-15
########################################################################
#++

##
# Chromosome
#
#= Overview
# Chromosome class consist of a collection of genes(array components)
# with potential solutions to n queens puzzle.
#
#= Details
# This class implements characteristics the chromosome as time alive, fitness,
# status, etc. and other utilities as mutate and crosover functions
#
#= Usage
#  Usage:
#       Chromosome.new
#       Chromosome.new(N, true)
#       Chromosome.new(N).generate_positions
#
# Authors::GnomeTeam (jeffersonamado,humbertropolis,ch.morales90) @gmail.com
#--
# edited by JAPeTo
#++
#
class Chromosome < Array
    ##
    # Creates a new chromosome represtation by the <b>n queens</b> puzzle.
    #
    # The design of the chromosome and its parameters help to the problem to be solved,
    # where each array position is a row chessboard and value is a id queen
    #
    # number_of_queens:: (integer) Number of queens in chessboard
    # randomize:: (boolean) If <b>true</b> randomize and return Chromosome, if <b>false</b> make up a empty Chromosome representation.
    #
    def initialize(number_of_queens=8, randomize=false)
        #numero de reinas
        @n_queens = number_of_queens
        #tiempo de vida del cromosoma
        @time_alive = 0
        #aptitud del cromosoma
        @fitness=0
        #diversidad del cromosoma
        @diversity=0
        #aptitud mixta
        @mixfitness=0
        #Si el parametro es verdadero retorna el cromosoma
        #con sus posiciones aleatorizadas
        if(randomize)
            generate_positions()
        end
    end
    ##
    # This method randomize the gene (queen) in the chomosome representation (chessboard)
    #
    # In the array are all the queens orderly manner from 0 to n-1, so Chromosome
    # representation eliminates row and column conflicts, then randomize the array,
    # each queen change position and update fitness
    #
    #
    # <b>Diagonal attacks between queens may exist, generate_positions function does not guarantee this.</b>
    #
    #
	def generate_positions()
        #creo un array con todas la reinas y se cambian las posiciones
        #aleatoriamente
		array = Array(0..@n_queens-1).shuffle!
        #como heredamos de array, se los copiamos a la clase(autopuntero self)
		array.each {|x| self<< x}
        #cuento los ataque que se han generado
        count_attacks()
        #retorno el array representativo (autopuntero self)
        self
	end
    ##
    #
    # Since Chromosome representation eliminates row and column conflicts,
    # the wrong solutions have only diagonal attacks between queens.
    #
    # This method count this diagonal attacks between queens and return an
    # fitness value. The fitness values should count diagonal attacks.
    # A queen that occupies i-th column and qi-th row is located
    # on the (i + q_i - 1) left and (n - i + q_i)  right diagonal.
    #
    # i-th and j-th queens share a diagonal if:
    #
    # <b>
    # (i + q_i = j + q_j ) or  (i - q_i = j- q_j)
    # </b>
    #
    def count_attacks()
       #inicilamente la actitud es 0
	   @fitness =0
       #para recorrer las diagonales
       (0..@n_queens-2).each do |i|
        ((i+1)..@n_queens-1).each do |j|
            if i + self[i] == j + self[j] or i - self[i] == j - self[j]
                 #el incremento es entero, buscamos minimizar
                 @fitness += 1
            end
        end
       end
       #retorno la actitud
       @fitness
    end
    #--
    #** getter and setters **
    #++

    ##
    # This method return the chromosome representation
    #
    # <b>for a deep copy use clone function, this return a reference to current
    # Chromosome representation</b>
    #
    def get_chromosome
        self
    end
    ##
    # This method return a fitness value
    # A attack is two queens who are able to attack each other.
    # This means they are in the same diagonal, the same row or the same column.
    #
    # The fitness value is a lower-is-better function, so we calculate it by adding
    # the amount of collisions that occur in the current Chromosome
    #
    # <b>A solution would have 0 collisions and thus a fitness of 0</b>.
    #
    def get_fitness
        @fitness
    end
    ##
    # This method set a new diversity value
    #
    def set_diversity=(value)
      @diversity = value
    end
    ##
    # This method return a diversity value
    #
    # The diversity value is a lower-is-better function, so we calculate it adding 
    # the amount of occurences in population 
    #
    def get_diversity
        @diversity
    end  
    ##
    # This method set a new mixfitness value
    #
    def set_mixfitness=(value)
      @mixfitness = value
    end
    ##
    # This method return a diversity value
    #
    # The diversity value is a lower-is-better function, so we calculate it adding 
    # the amount minimum between fitness and diversity divided the current generation
    #
    def get_mixfitness
        @mixfitness
    end  
    #--
    #** tools and methods***
    #++

    ##
    # This method change gene position in Chromosome representation
    #
    # The offspring by mutation is a mechanism that generates random
    # changes between queens, that result in “valid” new Chromosome representation.
    #
    #
    def mutate()
        #Se realiza una copia profunda del cromosoma
        son = self.clone
        #Se obtienen las posiciones a cambiar aleatoriamente
        source = rand(@n_queens)
        target = rand(@n_queens)
        #Si las posiciones son diferentes
        if source != target
            tmp = son[source]
            son[source] = son[target]
            son[target] = tmp
        #Si las posiciones son iguales
        elsif source == target
            #si es menor que el limite le aumento 1 al destino
            if target < (@n_queens-1)
                target+=1;
            #Si es menor se lo resto
            else
                target-=1;
            end
            #hago el cambio
            tmp = son[source]
            son[source] = son[target]
            son[target] = tmp
        end
        #Cuento nuevamente los ataques
        son.count_attacks
        #Retorno el hijo resultante
        son
    end
    ##
    # Creates and returns a copy of this object.
    #
    # As Chromosome representation are made up of several different parts
    # (array elements, fitness value, etc.), copying becomes nontrivial.
    #
    # In the process of deep copying the Chromosome source (self),
    # the chromosome twin actually copy all genes
    #
    def clone()
        #cromosoma gemelo
        twin = Chromosome.new(@n_queens)
        #cada elemento es copiado desde el hermano
        self.each {|x| twin << x}
        #Cuento los ataque, debe ser el mismo de su hermano
        twin.count_attacks
        #retorno el gemelo
        twin
    end
    ##
    # Returns a new array created by sorting self.
    #
    # Comparisons for the sort will be done using the <=> operator or using an optional code block.
    # update the fitness value
    #
    def queen_sort()
        target = self.clone
        target.sort! {
            |x,y|  x <=> y
        }
        target.count_attacks
        target
    end
    ##
    # This method return a Chromosome representation.
    #
    # When we crossover 2 Chromosomes we choose a gen in the Chromosome <b>son</b>
    # where we should get randomly father or mother gene.
    #
    # The son Chromosome is then the combination of these parents, it is similar
    # but not identical to them
    #
    # <b>We would never be able to get a solution because a solution requires
    # a queen in each row, and crossover function does not guarantee this.</b>
    #
    # dad:: (Chromosome) Chromosome source by default is a Chromosome representation that is generates randomize
    #
    def crosover(dad=Chromosome.new(@n_queens,true))
        #creo el cromosoma hijo
        son = Chromosome.new(@n_queens)
        #itero segun el numero de genes
        @n_queens.times do | i |
            #si el aleatorio es 1 escojo de la madre de lo contrario del padre
            #y este el gen que queda en el hijo
            son << if rand(2) == 1; self[i] else dad[i] end
        end
        #cuento nuevamente los ataques en el hijo
        son.count_attacks
        #retorno el hijo
        son
    end
    ##
    # Returns a string representation of the object.
    #
    # If the method takes a primitive data type as an argument, then the String
    # object representing the primitive data type value is return.
    #
    def to_s
        #Retorno el string con el contenido del cromosoma entre corchetes y la reina
        #separda  entre comas, con el valor del fitness
       "Chromosome: [#{self.join(", ")}] with fitness #{@fitness}, diversity #{@diversity} and mixed #{@mixfitness}\n"
    end
    ##
    # Indicates whether some other Chromosome is "equal to" this one.
    #
    # Compares values, not references. The use of equals is similar to  == with 
    # Chromosome values but is generally limited to compare elements and equals
    # perform elements and fitness
    #       
    # pair:: (Chromosome) Chromosome to compare, <b>true</b> if self and pair are 
    # equals and false 
    def equals(pair=Chromosome.new(@n_queens,true))
        state = false;
        if pair.get_fitness == self.get_fitness and (self - pair).empty?
            state = true
        end
        state
    end

end
#--
#~ ################################################################################
#~ a= Chromosome.new(8).generate_positions
#~ puts "#{a}#{a.mutate}"
#~ c= Chromosome.new(8).generate_positions
#~ puts "#{a}#{c} => #{c.crosover a } => #{c.mutate} "
#~ ################################################################################
#++

##
# NQueensEA
#
#= Overview
# This class represents the n queens puzzle is the problem of placing n chess
# queens on an n×n chessboard  so that no two queens threaten each other.
#
#=Details
#==Genetic Algorithm
# 1) Generate initial population
# 2) Each individual in the population have evaluate the fitness
# -> 3) Select random (tournament) individuals to reproduce (matting)
# -> 4) Create new generation through mutation and evaluate the individual fitnesses
# -> 5) Repeat 3) until number of generations (terminating condition)
# 6) Return best chromosome, position 0 in the population
#
#==Description
# In each iteration (generation) of algorithm, a certain number of best-ranking
# individuals (Chromosomes) is selected in the manner to create new better
# individuals (son).
#
# The son are created by some type of recombination (mutation) and
# they replace the  worst-ranked part of the population.
#
# This Candidate solutions (Chromosome) play the role of individuals in a population,
# and the fitness function determines the quality of the solutions, Thus, a solution
# requires that no two queens share the same row, column, or diagonal.
#
# For a correct solution, the fitness function will return zero.
#
# Authors::GnomeTeam (jeffersonamado,humbertropolis,ch.morales90) @gmail.com
#
#
class NQueensEA
    ##
    # This method make a new Puzzle whit a number of queens and allow find the solution
    #
    # num_queens:: (integer) Number de queens in chessboard <b>(n)</b>
    # num_chromosome:: (integer) Number of different ways the <b>(n)</b> queens can be placed on an <b>(n) x (n)</b> chessboard or number of chromosomes in the population
    # maxnum_generations:: (integer) Number of generations where select individual, mutate and put to population
    # debug:: (boolean) Show debug messages in standard output
    #
    #
    def initialize(num_queens = 8, num_chromosomes  = 2000, maxnum_generations = 1000, type_selection=0 ,debug = false)
        #Numero de individuos o cromosomas, esta es como el numero de filas
        @maxnum_chromosome  = num_chromosomes
        #generaciones que se van a generar
        @maxnum_generations = maxnum_generations
        #numero de reinas
        @num_queens = num_queens
        #cantidad de cromosomas en el matting
        @mating_pool = 2
        #tipo de reproducion
        @only_mutation = true
        #habilita los mensajes de depuracion
        @type_selection = type_selection
        @debug = debug
        #mensaje debug
        if debug
            puts "Run NQueensEA with #{@num_queens} queens, #{@maxnum_chromosome}
            individual.\n#{@maxnum_generations} generations and matting of #{@mating_pool} individuals"
        end
        #array para el matting pool
        @mating_array = Array.new
        #numero de cromosomas nuevos
        @numold_chromosome  = @maxnum_chromosome - @mating_pool
        #generacion actual
        @generation = 1
        #creo el array para la poblacion
        @population = Array.new
        #genero la poblacion base
        generate_population()
        #~ ##puts "Esta es la poblacion: \n#{@population}"
        (1..@maxnum_generations).each do |i|
                @generation=i
                #Se genera una nueva poblacion a partir de la anterior
                create_matingpool()
                reproduce_matingpool()
                putto_population()
                evaluate_diversity()
                #para si ha encontrado la solucion
                break if @population[0].get_fitness == 0 and @type_selection == 0 or @population[0].get_diversity == 0 and @type_selection == 1 or @population[0].get_mixfitness == 0 and @type_selection == 2
                #mensaje debug
                if @debug
                    puts "> Generation: #{@generation}  with best solution: #{@population[0].to_s}"
                end
        end
        #mensaje
        if @debug
            puts "last population:"
            @maxnum_chromosome.times do |i|
                puts "#{i} : #{@population[i].to_s}"
            end
        end
        #print solution
        puts "> Solution: #{@population[0].to_s} in Generation: #{@generation}"
    end
    ##
    # This method generate start population of <b>n</b> chromosomes.
    # It is implements the first step in the algorithm functioning, then,
    # this population contains several representation that encodes a possible
    # solution to a problem.
    #
    # Where each Chromosome x in the population has evaluate your fitnesss
    #
    def generate_population()
        @maxnum_chromosome.times{
            @population << Chromosome.new(@num_queens).generate_positions
        }
        evaluate_diversity()
        if @debug
            puts "start population:"
            @maxnum_chromosome.times do |i|
            puts "#{i} : #{@population[i].to_s}"
            end
        end
    end
    ##
    # This method select chromosomes (called parents) for mating in order to
    # generate new chromosomes (called offspring).
    #
    # The methods is tournament selection this selection way is more commonly used
    # approach, a set of chromosomes (known as tournament size) are randomly chosen the
    # fittest chromosome from the set is then placed in mating pool.
    #
    def create_matingpool()
        #seleccion por torneo cualquier
        (0..@mating_pool-1).each do |i|
            #Genero una posicion aleatoria
            pos =rand(@maxnum_chromosome)
            #obtengo el cromosoma de la poblacion
            chromosome = @population[pos]
            #Genero una posicion aleatoria
            pos =rand(@maxnum_chromosome)
            if @type_selection == 0
                #Si la aptitud que tengo es mayor pues el
                #me quedo con el cromosoma de menor aptitud
                if chromosome.get_fitness > @population[pos].get_fitness
                    chromosome =@population[pos]
                end
            elsif @type_selection ==1
                #Si la diversidad que tengo es mayor pues el
                #me quedo con el cromosoma de menor diversidad
                if chromosome.get_diversity > @population[pos].get_diversity
                    chromosome =@population[pos]
                end            
            elsif @type_selection==2
                #Si la aptitud mixta que tengo es mayor pues el
                #me quedo con el cromosoma de menor  aptitud mixta            
                if chromosome.get_mixfitness > @population[pos].get_mixfitness
                    chromosome =@population[pos]
                end            
            end
            #Lo agrego al matting pool
            @mating_array[i]= chromosome
        end
        if @debug
            puts "Matting :\n #{@mating_array}"
        end
    end

    ##
    # This method generate new chromosomes with mutate or crossover function
    # and update matting pool
    #
    def reproduce_matingpool()
        (0..@mating_pool-1).each do |i|
            #tipo de reproduccion
            #~ if @only_mutation
                @mating_array[i]= @mating_array[i].mutate
            #~ else
                #~ @mating_array[i]= @mating_array[i].crosover
                #Mutation is performed after crossover by
                #randomly choosing a chromosome in the new
                #generation to mutate in order to explore new
                #areas in the search space and to add diversity to
                #the population of chromosomes to prevent
                #being trapped in a local optimum
                #~ @mating_array[i]= @mating_array[i].mutate
            #~ end
        end
        if @debug
            puts "Offspring :\n #{@mating_array}"
        end
    end
    ##
    # This method replace the worst-ranked part of the population, first order
    # the population according to fitness value
    #
    def putto_population()
        #numero de cromosomas que se deben obtener nuevos
        #ordeno para obtener los mejores
        @population.sort! {
            |x,y|  x.get_fitness <=> y.get_fitness
        }
        #dejo los viejos y luego reemplazo los del matting pool en estas
        #posiciones
        (@numold_chromosome..@maxnum_chromosome-1).each do |i|
            @population[i] = @mating_array[i-@numold_chromosome]
        end
    end
    ##
    # This method update diversity and mixfitness to population
    #
    def evaluate_diversity()
        #Actualiza el valor de la diversidad de todos los cromosomas
        @maxnum_chromosome.times do |i|
            #Cuantos elemento en la poblacion tienen el fitness del cromosoma i
            @population[i].set_diversity  = @population.count{ |x| x.get_fitness == @population[i].get_fitness}
            #El valor minimo entre el fitness y la diversity este dividido por la generacion
            #este es una especie de costo beneficion, por que la mejora que me produce o bien
            #sea la aptitud o la diversidad (minimo entre estos), dividido el costo que he generado
            #para llegar a este valor (generacion)
            @population[i].set_mixfitness = [@population[i].get_fitness, @population[i].get_diversity].min / @generation
        end
    end
end


################################################################################
# PRUEBA
################################################################################
parameters = ARGV.length

if parameters == 0
    NQueensEA.new
elsif parameters == 1
    NQueensEA.new ARGV[0].to_i
elsif parameters == 2
    NQueensEA.new ARGV[0].to_i,ARGV[1].to_i
elsif parameters == 3
    NQueensEA.new ARGV[0].to_i,ARGV[1].to_i,ARGV[2].to_i
elsif parameters == 4
    NQueensEA.new ARGV[0].to_i,ARGV[1].to_i,ARGV[2].to_i, ARGV[3].to_i
elsif parameters == 5
     NQueensEA.new ARGV[0].to_i,ARGV[1].to_i,ARGV[2].to_i, ARGV[3].to_i , true   
end

