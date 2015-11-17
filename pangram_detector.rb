class PangramDetector
	def initialize number_of_lines
		@number_of_lines = number_of_lines
		@lines = []
	end

	def ask_for_input
		@number_of_lines.times { @lines << gets.chomp }
	end

	def detect
		@lines.map do |line|
			l = line.downcase.chars.select {|c| c =~ /[a-z]/ }
			('a'..'z').to_a - l == [] ? true : false
		end
	end
end

detector = PangramDetector.new(3)
detector.ask_for_input
p detector.detect