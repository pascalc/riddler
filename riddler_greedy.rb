#!/usr/bin/env ruby

# A solution using Greedy Best First Search
#
# Author: Pascal Chatterjee

require 'algorithms'

def max(a,b)
	(a >= b) ? a : b
end

State = Struct.new(:A,:B,:C,:D,:L,:running_cost,:action,:parent)

A_cost = 1
B_cost = 2
C_cost = 5
D_cost = 10

start = State.new(false,false,false,false,false,0,"Let's roll!",nil)

q = Containers::PriorityQueue.new { |x,y| (y <=> x) == 1 }

def heuristic(state)
	# Maximum travel time for people on the left bank	
	return D_cost if(!state.D)
	return C_cost if(!state.C)
	return B_cost if(!state.B)
	return A_cost if(!state.A)
	return 0	
end

q.push(start,start.running_cost)

expanded = 0

until q.empty? do
	node = q.pop
	expanded += 1

	# Check goal condition
	if(node.A && node.B && node.C && node.D && node.L)
		output = []
		output << "Succeeded after #{expanded} node expansions."
		until(node.nil?) do
			output << node.action
			node = node.parent
		end
		puts output.reverse.join("\n")
		break
	end	

	lantern_side = node.L

	fringe_node = State.new
	fringe_node.parent = node
	fringe_node.L = !node.L

	if(node.A == lantern_side)
		# Only A crosses
		fringe_node.A = !node.A
		fringe_node.B = node.B
		fringe_node.C = node.C
		fringe_node.D = node.D
		fringe_node.running_cost = node.running_cost + A_cost
		fringe_node.action = "A crosses, running cost = #{fringe_node.running_cost}"
		
		q.push(fringe_node.dup,heuristic(fringe_node))
	
		if(node.B == lantern_side)	
			# A and B cross
			fringe_node.A = !node.A
			fringe_node.B = !node.B
			fringe_node.C = node.C
			fringe_node.D = node.D
			fringe_node.running_cost = node.running_cost + max(A_cost,B_cost)
			fringe_node.action = "A and B cross, running cost = #{fringe_node.running_cost}"

			q.push(fringe_node.dup,heuristic(fringe_node))
		end

		if(node.C == lantern_side)	
			# A and C cross
			fringe_node.A = !node.A
			fringe_node.B = node.B
			fringe_node.C = !node.C
			fringe_node.D = node.D
			fringe_node.running_cost = node.running_cost + max(A_cost,C_cost) 
			fringe_node.action = "A and C cross, running cost = #{fringe_node.running_cost}"

			q.push(fringe_node.dup,heuristic(fringe_node))
		end

		if(node.D == lantern_side)	
			# A and D cross
			fringe_node.action = "A and D cross"
			fringe_node.A = !node.A
			fringe_node.B = node.B
			fringe_node.C = node.C
			fringe_node.D = !node.D
			fringe_node.running_cost = node.running_cost + max(A_cost,D_cost) 
			fringe_node.action = "A and D cross, running cost = #{fringe_node.running_cost}"

			q.push(fringe_node.dup,heuristic(fringe_node))
		end
	end

	if(node.B == lantern_side)
		# Only B crosses
		fringe_node.A = node.A
		fringe_node.B = !node.B
		fringe_node.C = node.C
		fringe_node.D = node.D
		fringe_node.running_cost = node.running_cost + B_cost
		fringe_node.action = "B crosses, running cost = #{fringe_node.running_cost}"

		q.push(fringe_node.dup,heuristic(fringe_node))
	
		if(node.C == lantern_side)	
			# B and C cross
			fringe_node.A = node.A
			fringe_node.B = !node.B
			fringe_node.C = !node.C
			fringe_node.D = node.D
			fringe_node.running_cost = node.running_cost + max(B_cost,C_cost)
			fringe_node.action = "B and C cross, running cost = #{fringe_node.running_cost}"

			q.push(fringe_node.dup,heuristic(fringe_node))
		end

		if(node.D == lantern_side)	
			# B and D cross
			fringe_node.A = node.A
			fringe_node.B = !node.B
			fringe_node.C = node.C
			fringe_node.D = !node.D
			fringe_node.running_cost = node.running_cost + max(B_cost,D_cost)
		       	fringe_node.action = "B and D cross, running cost = #{fringe_node.running_cost}"	

			q.push(fringe_node.dup,heuristic(fringe_node))
		end
	end

	if(node.C == lantern_side)
		# Only C crosses
		fringe_node.A = node.A
		fringe_node.B = node.B
		fringe_node.C = !node.C
		fringe_node.D = node.D
		fringe_node.running_cost = node.running_cost + C_cost
		fringe_node.action = "C crosses, running cost = #{fringe_node.running_cost}"

		q.push(fringe_node.dup,heuristic(fringe_node))
	
		if(node.D == lantern_side)	
			# C and D cross
			fringe_node.A = node.A
			fringe_node.B = node.B
			fringe_node.C = !node.C
			fringe_node.D = !node.D
			fringe_node.running_cost = node.running_cost + max(C_cost,D_cost)
		       	fringe_node.action = "C and D cross, running cost = #{fringe_node.running_cost}"	

			q.push(fringe_node.dup,heuristic(fringe_node))
		end	
	end

	if(node.D == lantern_side)
		# Only D crosses
		fringe_node.action = "D crosses"
		fringe_node.A = node.A
		fringe_node.B = node.B
		fringe_node.C = node.C
		fringe_node.D = !node.D
		fringe_node.running_cost = node.running_cost + D_cost
		fringe_node.action = "D crosses, running cost = #{fringe_node.running_cost}"

		q.push(fringe_node.dup,heuristic(fringe_node))	
	end
end	
