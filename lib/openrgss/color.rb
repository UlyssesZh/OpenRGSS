# The RGBA color class. Each component is handled with a floating-point value (Float).
class Color
	
	# :call-seq:
	# Color.new(red, green, blue[, alpha])
	# Color.new
	#
	# Creates a Color object. If alpha is omitted, it is assumed to be 255.
	#
	# The default values when no arguments are specified are (0, 0, 0, 0).
	
	def initialize red = 0, green = 0, blue = 0, alpha = 255
		@red, @blue, @green, @alpha = red, blue, green, alpha
	end
	
	# :call-seq:
	# set(red, green, blue[, alpha])
	# set(color)
	#
	# Sets all components at once.
	#
	# The second format copies all the components from a separate Color object.
	
	def set red, blue = 0, green = 0, alpha = 255
		if red.is_a? Color
			@red, @blue, @green, @alpha = *red
		else
			@red, @blue, @green, @alpha = red, blue, green, alpha
		end
		self
	end
	
	# The red value (0-255). Out-of-range values are automatically corrected.
	attr_accessor :red
	
	# The green value (0-255). Out-of-range values are automatically corrected.
	attr_accessor :blue
	
	# The blue value (0-255). Out-of-range values are automatically corrected.
	attr_accessor :green
	
	# The alpha value (0-255). Out-of-range values are automatically corrected.
	attr_accessor :alpha
	
	def to_s() # :nodoc:
		"(#{@red}, #{@blue}, #{@green}, #{@alpha})"
	end
	
	def _dump depth = 0 # :nodoc:
		to_a.pack 'D*'
	end
	
	def self._load string # :nodoc:
		self.new *string.unpack('D*') #fix by zh99998
	end
	
	def red= val # :nodoc:
		@red = val.clamp 0, 255
	end
	
	def blue= val # :nodoc:
		@blue = val.clamp 0, 255
	end
	
	def green= val # :nodoc:
		@green = val.clamp 0, 255
	end
	
	def alpha= val # :nodoc:
		@alpha = val.clamp 0, 255
	end
	
	def == other # :nodoc:
		other.is_a?(Color) && to_a == other.to_a
	end
	
	def === other # :nodoc:
		other.is_a?(Color) && to_a == other.to_a
	end
	
	def eql? other # :nodoc:
		other.is_a?(Color) && to_a == other.to_a
	end
	
	def to_a
		[@red, @green, @blue, @alpha]
	end
	
	def zip_map color, &block
		Color.new *to_a.zip(color.to_a).map(&block)
	end
end
