module Enumerable
	def my_each
		a=self.length
		for i in 0...a do
			yield(self[i])
		end
	end
	def my_each_with_index
		a=self.length
		for i in 0...a do
			yield(self[i], i)
		end
	end
	def my_select
		result = []
		self.my_each do |x|
			result << x if yield(x)
		end
		result
	end
	def my_all?
		x = true
		self.my_each do |value|
			unless yield(value)
				x = false
			end
		end
		return x
	end
	def my_any?
		x = false
		self.my_each do |value|
			if yield(value)
				x = true
			end
		end
		return x
	end
	def my_none?
		x = true
		self.my_each do |value|
			if yield(value)
				x = false
			end
		end
		return x
	end
	def my_count(obj=nil)
		count = 0
		if block_given?
			self.my_each do |x|
				count += 1 if yield(x)
			end
		elsif obj
			self.my_each do |x|
				count += 1 if x == obj
			end
		else
			count = self.length
		end
		count
	end
	def my_map
		result = []
		self.my_each do |x|
			result << proc.call(x)
		end
		result
	end
	def my_inject(a=0)
		total = a
		self.my_each do |value|
			total = yield(total, value)
		end
		total
	end
end


=begin
-----------------For Testing------------------
=end
x = [1, 2, 4, 2,7,2]
puts "My Each"
x.my_each {|a| puts a}
puts "My Each with index"
x.my_each_with_index {|a,i| puts "#{i}: #{a}"}
puts "My select"
puts x.my_select{ |x| x%2 == 0}
puts "My All"
puts x.my_all?{ |x| x%2 == 0}
puts "My Any"
puts x.my_any?{ |x| x%2 == 0}
puts "My All"
puts x.my_none?{ |x| x%2 == 0}
puts "My Count"
puts x.my_count {|a| a}
puts "My Map"
puts x.my_map {|a| a*=2}
puts "My Inject"
puts x.my_inject(0) {|a,b| a+=b}
