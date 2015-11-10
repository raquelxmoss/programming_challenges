input = <<-sample_input
	According to a research team at Cambridge University, it doesn't matter in what order the letters in a word are, 
	the only important thing is that the first and last letter be in the right place. 
	The rest can be a total mess and you can still read it without a problem.
	This is because the human mind does not read every letter by itself, but the word as a whole. 
	Such a condition is appropriately called Typoglycemia.
 sample_input

def scramble_word(word)
	if word.length <= 2
		word
	else
		split_word = word.split('')
		sub_word = word.scan(/\,|\./).empty? ? split_word.slice!(1...split_word.length - 1).shuffle : split_word.slice!(1...split_word.length - 2).shuffle
		sub_word.unshift(split_word.shift)
						.push(split_word.join)
						.join
	end
end

p input.split.map {|w| scramble_word(w) }.join(" ")