class Rect
	
	# The x-coordinate of the rectangle's upper left corner.
	attr_accessor :x
	
	# The y-coordinate of the rectangle's upper left corner.
	attr_accessor :y
	
	# The rectangle's width.
	attr_accessor :width
	
	# The rectangle's height.
	attr_accessor :height
	
	# :call-seq:
	# Rect.new(x, y, width, height)
	# Rect.new
	#
	# Creates a new Rect object.
	#
	# The default values when no arguments are specified are (0, 0, 0, 0).
	#
	def initialize x = 0, y = 0, width = 0, height = 0
		set x, y, width, height
	end
	
	# :call-seq:
	# set(x, y, width, height)
	# set(rect)
	#
	# Sets all parameters at once.
	#
	# The second format copies all the components from a separate Rect object.
	
	def set x, y = 0, width = 0, height = 0
		if x.is_a? Rect
			@x, @y, @width, @height = *x
		else
			@x, @y, @width, @height = x, y, width, height
		end
	end
	
	def to_s
		"(#{x}, #{y}, #{width}, #{height})"
	end
	
	# Sets all components to 0.
	def empty
		set 0, 0, 0, 0
	end
	
	# Vergleichsmethode
	def == other
		other.is_a?(Rect) && to_a == other.to_a
	end
	
	# Serialisiert das Objekt
	def _dump limit
		to_a.pack 'iiii'
	end
	
	# Deserialisiert das Objekt
	def self._load str
		new *str.unpack('iiii')
	end
	
	def to_a
		[@x, @y, @width, @height]
	end

end
