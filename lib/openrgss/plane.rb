# The Plane class. Planes are special sprites that tile bitmap patterns across the entire screen and are used to display parallax backgrounds and so on.
class Plane
	
	# Refers to the bitmap (Bitmap) used in the plane.
	attr_accessor :bitmap
	
	# Refers to the viewport (Viewport) associated with the plane.
	#attr_accessor :viewport
	
	# The plane's visibility. If TRUE, the plane is visible. The default value is TRUE.
	#attr_accessor :visible
	
	# The plane's z-coordinate. The larger the value, the closer to the player the plane will be displayed.
	#
	# If multiple objects share the same z-coordinate, the more recently created object will be displayed closest to the player.
	#attr_accessor :z
	
	# The x-coordinate of the plane's starting point. Change this value to scroll the plane.
	attr_accessor :ox
	
	# The y-coordinate of the plane's starting point. Change this value to scroll the plane.
	attr_accessor :oy
	
	# The plane's x-axis zoom level. 1.0 denotes actual pixel size.
	#attr_accessor :zoom_x
	
	# The plane's y-axis zoom level. 1.0 denotes actual pixel size.
	#attr_accessor :zoom_y
	
	# The plane's opacity (0-255). Out-of-range values are automatically corrected.
	#attr_accessor :opacity
	
	# The plane's blending mode (0: normal, 1: addition, 2: subtraction).
	#attr_accessor :blend_type
	
	# The color (Color) to be blended with the plane. Alpha values are used in the blending ratio.
	#attr_accessor :color
	
	# The plane's color tone (Tone).
	#attr_accessor :tone
	
	# Creates a Plane object. Specifies a viewport (Viewport) when necessary.
	def initialize viewport = nil
		@ox = 0
		@oy = 0
		@sprite = Sprite.new viewport
		@bitmap = nil
	end
	
	# Frees the plane. If the plane has already been freed, does nothing.
	
	def dispose
		@sprite.dispose if @sprite && !@sprite.disposed?
	end
	
	# Returns TRUE if the plane has been freed.
	
	def disposed?
		@sprite.nil? or @sprite.disposed?
	end
	
	def bitmap= bitmap
		@bitmap = bitmap
		refresh_sprite
	end
	
	def method_missing symbol, *args
		@sprite.respond_to?(symbol) ? @sprite.send(symbol, *args) : super
	end
	
	def respond_to_missing? *args
		@sprite.respond_to?(*args) || super
	end
	
	private def refresh_sprite
		unless @bitmap
			@sprite.bitmap.clear
			return
		end
		
		if @sprite.viewport
			drawn_width = @sprite.viewport.rect.width
			drawn_height = @sprite.viewport.rect.height
		else
			drawn_width = Graphics.width
			drawn_height = Graphics.height
		end
		@sprite.bitmap.dispose if @sprite.bitmap && !@sprite.bitmap.disposed?
		@sprite.bitmap = Bitmap.new drawn_width + @bitmap.width,
		                            drawn_height + @bitmap.height
		
		rect = @bitmap.rect
		(0...drawn_width).step @bitmap.width do |x|
			(0...drawn_height).step @bitmap.height do |y|
				@sprite.bitmap.blt x, y, @bitmap, rect
			end
		end
		
		leftover_width = @sprite.width % @bitmap.width
		rect = Rect.new 0, 0, leftover_width, @bitmap.height
		(0...drawn_height).step @bitmap.height do |y|
			@sprite.bitmap.blt drawn_width, y, @bitmap, rect
		end
		
		leftover_height = @sprite.height % @bitmap.height
		rect = Rect.new 0, 0, @bitmap.width, leftover_height
		(0...drawn_width).step @bitmap.width do |x|
			@sprite.bitmap.blt x, drawn_height, @bitmap, rect
		end
		
		rect = Rect.new 0, 0, leftover_width, leftover_height
		@sprite.bitmap.blt drawn_width, drawn_height, @bitmap, rect
		
		@sprite.x = @ox.modulo(@bitmap.width) - @bitmap.width
		@sprite.y = @oy.modulo(@bitmap.height) - @bitmap.height
=begin
		vp_width = @sprite.viewport.nil? ?
				           Graphics.width : @sprite.viewport.rect.width
		vp_height = @sprite.viewport.nil? ?
				            Graphics.height : @sprite.viewport.rect.height
		x_steps = [(vp_width / bitmap.width).ceil, 1].max * 2
		y_steps = [(vp_height / bitmap.height).ceil, 1].max * 2
		bmp_width = x_steps * bitmap.width
		bmp_height = y_steps * bitmap.height
		@src_bitmap = bitmap
		@sprite.bitmap.dispose if @sprite.bitmap && !@sprite.bitmap.disposed?
		@sprite.bitmap = Bitmap.new bmp_width, bmp_height
		x_steps.times do |ix|
			y_steps.times do |iy|
				@sprite.bitmap.blt ix * bitmap.width, iy * bitmap.height,
				                   @src_bitmap, @src_bitmap.rect
			end
		end
=end
		nil
	end

end
