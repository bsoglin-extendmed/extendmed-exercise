#Brute force approach
class FindLongestChain

	#Finds the length of the chain for each number, and prints the greatest in length
	def initialize
		longest_chain_length = 0
		longest_chain_start = 0

		(2..999999).each do |counter|
			length = get_length(counter, 0)
			if (length > longest_chain_length)
				longest_chain_length = length
				longest_chain_start = counter
			end
		end

		puts "The longest chain begins with #{longest_chain_start} and contains #{longest_chain_length} terms."
	end

	#Recursive method that returns the length of the chain => 1 starting from the number i.
	def get_length(i, count)
		#End condition is that i is a power of two
		if ((Math.log2(i)%100).zero?)
			return (1 + count + Math.log2(i))
		else
			return get_length(self.seq(i), 1 + count)
		end
	end

	#Returns the next number in the sequence
	def seq(i)
		if (i % 2 == 0)
			return i / 2
		else
			return i * 3 + 1
		end
	end
end

if __FILE__ == $0
  FindLongestChain.new
end