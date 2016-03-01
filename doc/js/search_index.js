var search_data = {"index":{"searchIndex":["chromosome","nqueensea","clone()","count_attacks()","create_matingpool()","crosover()","equals()","evaluate_diversity()","generate_population()","generate_positions()","get_chromosome()","get_diversity()","get_fitness()","get_mixfitness()","mutate()","new()","new()","putto_population()","queen_sort()","reproduce_matingpool()","set_diversity=()","set_mixfitness=()","to_s()","gemfile","gemfile.lock","instrucciones","verificarnqueens.feature"],"longSearchIndex":["chromosome","nqueensea","chromosome#clone()","chromosome#count_attacks()","nqueensea#create_matingpool()","chromosome#crosover()","chromosome#equals()","nqueensea#evaluate_diversity()","nqueensea#generate_population()","chromosome#generate_positions()","chromosome#get_chromosome()","chromosome#get_diversity()","chromosome#get_fitness()","chromosome#get_mixfitness()","chromosome#mutate()","chromosome::new()","nqueensea::new()","nqueensea#putto_population()","chromosome#queen_sort()","nqueensea#reproduce_matingpool()","chromosome#set_diversity=()","chromosome#set_mixfitness=()","chromosome#to_s()","","","",""],"info":[["Chromosome","","Chromosome.html","","\n<pre class=\"ruby\"><span class=\"ruby-constant\">Chromosome</span>\n</pre>\n<p>Overview\n\n<pre>Chromosome class consist of a collection of genes(array components)\nwith potential ...</pre>\n"],["NQueensEA","","NQueensEA.html","","\n<pre class=\"ruby\"><span class=\"ruby-constant\">NQueensEA</span>\n</pre>\n<p>Overview\n\n<pre>This class represents the n queens puzzle is the problem of placing n chess\nqueens on ...</pre>\n"],["clone","Chromosome","Chromosome.html#method-i-clone","()","<p>Creates and returns a copy of this object.\n<p>As Chromosome representation are made up of several different …\n"],["count_attacks","Chromosome","Chromosome.html#method-i-count_attacks","()","<p>Since Chromosome representation eliminates row and column conflicts, the\nwrong solutions have only diagonal …\n"],["create_matingpool","NQueensEA","NQueensEA.html#method-i-create_matingpool","()","<p>This method select chromosomes (called parents) for mating in order to\ngenerate new chromosomes (called …\n"],["crosover","Chromosome","Chromosome.html#method-i-crosover","(dad=Chromosome.new(@n_queens,true))","<p>This method return a Chromosome representation.\n<p>When we crossover 2 Chromosomes we choose a gen in the …\n"],["equals","Chromosome","Chromosome.html#method-i-equals","(pair=Chromosome.new(@n_queens,true))","<p>Indicates whether some other Chromosome is “equal to” this one.\n<p>Compares values, not references. …\n"],["evaluate_diversity","NQueensEA","NQueensEA.html#method-i-evaluate_diversity","()","<p>This method update diversity and mixfitness to population\n"],["generate_population","NQueensEA","NQueensEA.html#method-i-generate_population","()","<p>This method generate start population of <strong>n</strong> chromosomes. It\nis implements the first step in the algorithm …\n"],["generate_positions","Chromosome","Chromosome.html#method-i-generate_positions","()","<p>This method randomize the gene (queen) in the chomosome representation\n(chessboard)\n<p>In the array are all …\n"],["get_chromosome","Chromosome","Chromosome.html#method-i-get_chromosome","()","<p>This method return the chromosome representation\n<p><strong>for a deep copy use clone function, this return a\nreference</strong> ...\n"],["get_diversity","Chromosome","Chromosome.html#method-i-get_diversity","()","<p>This method return a diversity value\n<p>The diversity value is a lower-is-better function, so we calculate …\n"],["get_fitness","Chromosome","Chromosome.html#method-i-get_fitness","()","<p>This method return a fitness value A attack is two queens who are able to\nattack each other. This means …\n"],["get_mixfitness","Chromosome","Chromosome.html#method-i-get_mixfitness","()","<p>This method return a diversity value\n<p>The diversity value is a lower-is-better function, so we calculate …\n"],["mutate","Chromosome","Chromosome.html#method-i-mutate","()","<p>This method change gene position in Chromosome representation\n<p>The offspring by mutation is a mechanism …\n"],["new","Chromosome","Chromosome.html#method-c-new","(number_of_queens=8, randomize=false)","<p>Creates a new chromosome represtation by the <strong>n queens</strong>\npuzzle.\n<p>The design of the chromosome and its parameters …\n"],["new","NQueensEA","NQueensEA.html#method-c-new","(num_queens = 8, num_chromosomes = 2000, maxnum_generations = 1000, type_selection=0 ,debug = false)","<p>This method make a new Puzzle whit a number of queens and allow find the\nsolution\n<p>num_queens &mdash; (integer) …\n"],["putto_population","NQueensEA","NQueensEA.html#method-i-putto_population","()","<p>This method replace the worst-ranked part of the population, first order\nthe population according to …\n"],["queen_sort","Chromosome","Chromosome.html#method-i-queen_sort","()","<p>Returns a new array created by sorting self.\n<p>Comparisons for the sort will be done using the &lt;=&gt; …\n"],["reproduce_matingpool","NQueensEA","NQueensEA.html#method-i-reproduce_matingpool","()","<p>This method generate new chromosomes with mutate or crossover function and\nupdate matting pool\n"],["set_diversity=","Chromosome","Chromosome.html#method-i-set_diversity-3D","(value)","<p>This method set a new diversity value\n"],["set_mixfitness=","Chromosome","Chromosome.html#method-i-set_mixfitness-3D","(value)","<p>This method set a new mixfitness value\n"],["to_s","Chromosome","Chromosome.html#method-i-to_s","()","<p>Returns a string representation of the object.\n<p>If the method takes a primitive data type as an argument, …\n"],["Gemfile","","Gemfile.html","","<p>source “rubygems.org” gem ‘cucumber’ gem ‘rspec’\n"],["Gemfile.lock","","Gemfile_lock.html","","<p>GEM\n\n<pre>remote: https://rubygems.org/\nspecs:\n  builder (3.2.2)\n  cucumber (2.0.0)\n    builder (&gt;= 2.1.2)\n ...</pre>\n"],["Instrucciones","","Instrucciones_txt.html","","<p>1 - Que al crear un cromosoma tenga genes distintos                        \nok              …\n"],["VerificarNQueens.feature","","features/VerificarNQueens_feature.html","","<p># language: es # encoding: utf-8 # Archivo: VerificarNQueens.feature #\nAutor: GenomeTeam # Email: (jeffersonamado,humbertropolis,ch.morales90) …\n"]]}}