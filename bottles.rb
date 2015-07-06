class Bottles

	$bOK = true
	$iInitial = 0

	$cooler = {fullBottles: 0,
				emptyBottles: 0,
				bottleCaps: 0,
				bottlesPurchased: 0,
				bottlesFromEmpty: 0,
				bottlesFromCaps: 0,
				totalBottlesChugged: 0
				}

	def self.till(cash)	
		$cooler[:fullBottles] = cash / 2
		$cooler[:bottlesPurchased] = cash / 2
		$iInitial = cash / 2

	end

	def self.recyclingMachine()
		# step 1
		$cooler[:emptyBottles] += $cooler[:fullBottles] #convert full bottles to empty bottles
		
		# step 2
		$cooler[:bottleCaps] += $cooler[:fullBottles] #convert full bottles to bottle caps

		# step 3
		$cooler[:totalBottlesChugged] += $cooler[:fullBottles] #keep count of all bottles drank
		$cooler[:fullBottles] = 0 #all bottles converted to empty bottles and caps
		
		# step 4
		$cooler[:fullBottles] += $cooler[:emptyBottles] / 2 #convert empty bottles to full bottles
		$cooler[:bottlesFromEmpty] += $cooler[:emptyBottles] / 2 #log full bottles converted from empty bottles 
		$cooler[:emptyBottles] = $cooler[:emptyBottles] % 2 #set remaining empty bottles

		# step 5
		$cooler[:fullBottles] += $cooler[:bottleCaps] /4 #convert bottle caps to full bottles
		$cooler[:bottlesFromCaps] += $cooler[:bottleCaps] / 4 #log full bottles converted from empty bottles
		$cooler[:bottleCaps] = $cooler[:bottleCaps] % 4 #set remaining bottle caps 
	
	end

	def self.start_machine(cash)
		till(cash)

		$cooler[:totalBottlesChugged] = 0
		$cooler[:bottlesFromEmpty] = 0
		$cooler[:bottlesFromCaps] = 0

		loop do
			recyclingMachine()

			break if $cooler[:fullBottles] == 0
		end

	end

	def self.reset_cooler()
		$cooler = {fullBottles: 0,
				emptyBottles: 0,
				bottleCaps: 0,
				bottlesPurchased: 0,
				bottlesFromEmpty: 0,
				bottlesFromCaps: 0,
				totalBottlesChugged: 0
				}
	end

	while $bOK

		bOK = true

		puts "Welcome to Lighthouse Markets"
		
		reset_cooler()

		while bOK
			begin
				puts "A bottle of pop costs $2 each, how much would you like to spend?"
				start_machine((Integer(gets.chomp())))
				bOK = false
			rescue
				puts "That is not a valid amount"	
			end
		end

		puts "You purchased a total of #{$iInitial} bottles, drank a total of #{$cooler[:totalBottlesChugged]} bottles,"\
		 		"claimed a total of #{$cooler[:bottlesFromEmpty]} bottles from empty bottles and #{$cooler[:bottlesFromCaps]} from your bottle caps! "
		puts ""
		puts "Next customer? (y/n)"
		
		if gets.chomp().downcase == 'n'
			puts "phew!"
			$bOK = false
		end

	end


end
