#!/usr/bin/env ruby

# A solution that also uses A* Search, but also uses Ruby metaprogramming. This does not perform as well as the solution in riddler_a_star.rb
#
# Author: Pascal Chatterjee

require 'algorithms'

def max(a,b)
	(a >= b) ? a : b
end

State = Struct.new(:A,:B,:C,:D,:L,:running_cost,:action,:parent)

Cost = { "A" => 1,
	 "B" => 2,
	 "C" => 5,
	 "D" => 10 }

Characters = Cost.keys

Limit = 19

start = State.new(false,false,false,false,false,0,"Let's roll!",nil)

$q = Containers::PriorityQueue.new { |x,y| (y <=> x) == 1 }

def heuristic(state)
	return D_cost if(!state.D)
	return C_cost if(!state.C)
	return B_cost if(!state.B)
	return A_cost if(!state.A)
	return 0
end

def push_successor(node, fringe_node, char)
	val = node.send char
	fringe_node.send (char + "="),!val
	Characters.select { |c| c != char }.each { |c| fringe_node.send (c + "="),(node.send c) } 
	
	fringe_node.running_cost = node.running_cost + Cost[char]
	fringe_node.action = "#{char} crosses, running cost = #{fringe_node.running_cost}"
	
	$q.push(fringe_node.dup,fringe_node.running_cost)
end

def push_successors(node, fringe_node, char1, char2)
	val1 = node.send char1
	val2 = node.send char2
	fringe_node.send (char1 + "="),!val1
	fringe_node.send (char2 + "="),!val2
	Characters.select { |c| (c != char1) && (c != char2) }.each { 
		|c| fringe_node.send (c + "="),(node.send c) 
	}
	
	fringe_node.running_cost = node.running_cost + max(Cost[char1],Cost[char2])
	fringe_node.action = "#{char1} and #{char2} cross, running cost = #{fringe_node.running_cost}"
	
	$q.push(fringe_node.dup,fringe_node.running_cost)
end
	
$q.push(start,start.running_cost)

until $q.empty? do
	node = $q.pop

	# Check goal condition
	if(node.A && node.B && node.C && node.D && node.L)
		output = []
		output << "Success!"
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
		push_successor(node,fringe_node,"A")
	
		if(node.B == lantern_side)	
			push_successors(node,fringe_node,"A","B")
		end

		if(node.C == lantern_side)	
			push_successors(node,fringe_node,"A","C")
		end

		if(node.D == lantern_side)
			push_successors(node,fringe_node,"A","D")	
		end
	end

	if(node.B == lantern_side)
		push_successor(node,fringe_node,"B")

		if(node.C == lantern_side)
			push_successors(node,fringe_node,"B","C")	
		end

		if(node.D == lantern_side)
			push_successors(node,fringe_node,"B","D")		
		end
	end

	if(node.C == lantern_side)
		push_successor(node,fringe_node,"C")
			
		if(node.D == lantern_side)
			push_successors(node,fringe_node,"C","D")		
		end	
	end

	if(node.D == lantern_side)
		push_successor(node,fringe_node,"D")
	end
end	
