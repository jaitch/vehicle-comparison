#intro/title
puts "I-90, End to End! \nLet's figure out the most gas-efficient way for multiple people to go from Safeco Field to Fenway Park!"

#Get user input and assign to variables; put input into hashes within an array
cars = []
#c = number of people/cars going on this road trip
puts "\nHow many people need to go from Seattle to Boston? "
c = gets.chomp.to_i
until c > 1
    print "Must be a positive integer greater than one. Please try again. "
    c = gets.chomp.to_i
end

#d = distance in miles of road trip
d = 3000.0
#g = price of gas ($/gallon)
g = 3.0
c.times do |i|
    print "\nPerson #{i + 1}, what kind of car do you have? "
    model = gets.chomp.to_s
    until model.empty? == false
        print "Oops! This program will be more helpful if you don't leave this blank. Please try again. "
        model = gets.chomp.to_s
    end

    print "What is the average miles/gallon that your car gets? "
    mpg = gets.chomp.to_i
    until mpg > 0
        print "Must be a positive integer. Please try again. "
        mpg = gets.chomp.to_i
    end

    print "How many gallons can your gas tank hold? "
    capacity = gets.chomp.to_i
    until capacity > 0
        print "Must be a positive integer. Please try again. "
        capacity = gets.chomp.to_i
    end

    print "How much does maintenance cost at each refueling stop? $"
    maintcost = gets.chomp.to_i
    until maintcost > 0
        print "Must be a positive integer. Please try again. "
        maintcost = gets.chomp.to_i
    end

    cars.push({"cartype" => model, "MPG" => mpg, "capacity" => capacity, "maintcost" => maintcost})
end

puts "\n*** Some Numbers to Consider ***"

#Calculate and output calculations; Add calculated values into hashes
#Distance/tank of gas
puts "\nDistance possible per tank of gas: "
cars.each do |n|
    distpertank = n["MPG"] * n["capacity"]
    puts "   #{n["cartype"]}: #{distpertank} miles"
    n["distpertank"] = distpertank
end

#Number of refueling stops required
puts "\nNumber of refueling stops required, assuming you're beginning with an empty tank: "
cars.each do |n|
    numstops = d/n["distpertank"]
    puts "   #{n["cartype"]}: #{numstops.ceil} stops"
    n["numstops"] = numstops.ceil
end

#Total cost of trip
puts "\nTotal cost of the trip: "
cars.each do |n|
    totalcost = (n["numstops"] * n["maintcost"]) + (g * (d / n["MPG"]))
    puts sprintf"   #{n["cartype"]}: $%.2f", totalcost
    n["totalcost"] = totalcost
end

#Total gallons of fuel for all four vehicles together
sum = 0
cars.each do |n|
    gallons = (d / n["MPG"])
    sum = sum + gallons
end
printf"\nIf all #{c} vehicles go separately, %.2f", sum
puts " total gallons of fuel will be burned for this trip."

#Alternative--carpooling
#Compare totalcosts with a new array of totalcost values
#Order the array then iterate through the array of hashes (cars) to find the match
#and find the corresponding 'cartype'
#!!!What if there is a tie?!!!
compcost = []
cars.each do |n|
    compcost.push(n["totalcost"])
end
compcost = compcost.sort
#lowest cost is compcost[0]
winner = 0
cars.each do |n|
    if compcost[0] == n["totalcost"]
        winner = n["cartype"]
    end
end
puts "\nIf you carpool, the most economical car to take is the #{winner}."

#To find savings when carpooling rather than driving separately, find sum of total costs then subtract cost of taking winner car
supertotal = 0
cars.each do |n|
    supertotal = supertotal + n["totalcost"]
end
savings = (supertotal - compcost[0])
printf "Traveling together in the #{winner}, you #{c} will collectively save $%.2f", savings
puts "!! Do it for the good company and the good karma."
