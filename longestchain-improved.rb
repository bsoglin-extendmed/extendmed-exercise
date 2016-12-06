# IMPROVING LONGESTCHAIN.RB
#
# A neat property of these sequences: for any completed sequence going down to one, if we choose an intermediate number in the
# chain and follow the sequence from that number down, we'll have the complete sequence for that intermediate number as well.

# Take the sequence that begins with 3, for example:

# 	3->10->5->16->8->4->2->1

# This sequence also contains the sequence that begins with 10 (10->5->16->8->4->2->1), and 5, and 16, and so on. Once we've found
# the sequence for 3, we've already done the work we need to get the length of these other sequences. Redoing this work later is
# costing us time.

# We can save time by keeping a hash, where the key is any already visited number, and the value is the length of the sequence from
# that number to 1. In the recursive get_length method, we can take advantage of the hash table--checking each value it's given to see
# if we've already visited it, and if so, we can just return the already discovered value. My implementation is below.

# I'm quite satisfied with this implementation--avg. time for this on my machine was ~11 seconds, versus ~3:30 for the brute force!

class FindLongestChainImproved

	def initialize
		longest_chain_length = 0
		longest_chain_start = 0
		#Here's the hash!
		@visited_lengths = Hash.new

		(1..999999).each do |counter|
			length = get_length(counter)
			if (length > longest_chain_length)
				longest_chain_length = length
				longest_chain_start = counter
			end
		end

		puts "The longest chain begins with #{longest_chain_start} and contains #{longest_chain_length} terms."
	end

	#The improved get_length function doesn't need to keep a count, because it will work upwards from previously visited values
	def get_length(i)
		#The time-saving step: before computing anything, check to see if this sequence has already been found
		if (@visited_lengths[i] != nil)
			return (@visited_lengths[i])
		elsif ((Math.log2(i)%100).zero?)
			@visited_lengths[i] = Math.log2(i) + 1
			return (@visited_lengths[i])
		else
			@visited_lengths[i] = 1 + get_length(self.seq(i))
			return (@visited_lengths[i])
		end
	end

	def seq(i)
		if (i % 2 == 0)
			return i / 2
		else
			return i * 3 + 1
		end
	end
end

if __FILE__ == $0
  FindLongestChainImproved.new
end