# Description
# All nineties kids will remember the problem of having to program their vhs recorder to tape all their favorite shows. Especially when 2 shows are aired at the same time, which show do we record?
# Today we are going to program the recorder, so that we have a maximum amount of tv shows on one tape.
# Input
# 1530 1600
# 1555 1645
# 1600 1630
# 1635 1715
# Output
# 3
# Input description
# You recieve a timetable with when the shows start and when it ends. All times are in Military time.
# Output description
# You return the maximum number of shows you can record. We can switch between channels instantaneously, so if a shows start on the same time a other one stops, you can record them.
# Bonus 1
# We want to know what shows we have recorded, so instead of showing the number of shows, show the names of the shows we recorded.
# Input
# 1535 1610 Pokémon
# 1610 1705 Law & Order
# 1615 1635 ER
# 1615 1635 Ellen
# 1615 1705 Family Matters
# 1725 1810 The Fresh Prince of Bel-Air
# Output
# Pokémon
# Law & Order
# The Fresh Prince of Bel-Air


input = [
	[1530, 1600],
	[1555, 1645],
	[1600, 1630],
	[1635, 1715]
]

def schedule(input)
	previous_end_time = input[0][1]
	input.sort.each_with_index.map do |times, index|
		can_tape = index == 0 ? true : times[0] >= previous_end_time
		previous_end_time = times[1] if can_tape
		can_tape
	end.select {|v| v}.length
end

p schedule(input)

input = [
	[1535, 1610, "Pokemon"],
	[1610, 1705, "Law & Order"],
	[1615, 1635, "ER"],
	[1615, 1635, "Ellen"],
	[1615, 1705, "Family Matters"],
	[1725, 1810, "The Fresh Prince of Bel-Air"]
]

def fancy_schedule(input)
	previous_end_time = input[0][1]
	input.sort.each_with_index.map do |times, index|
		can_tape = index == 0 ? true : times[0] >= previous_end_time
		previous_end_time = times[1] if can_tape
		can_tape ? times[2] : nil
	end.compact
end

p fancy_schedule(input)

input = [
	["The Fresh Prince of Bel-Air"],
	[1530, 1555, "3rd Rock from the Sun"],
	[1550, 1615, "The Fresh Prince of Bel-Air"],
	[1555, 1615, "Mad About You"],
	[1615, 1650, "Ellen"],
	[1655, 1735, "Quantum Leap"]
]