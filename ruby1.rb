#Nested classes and modules. Scope (1.5)
class C
  a = 5
  module M
    a = 4
    module N
      a = 3
      class D
        a = 2
        def show_a
          a = 1
          puts a
        end
        puts a
      end
      puts a
    end
    puts a
  end
  puts a
end
d = C::M::N::D.new
d.show_a
 #Output: 23451

 #Accessibility of constants:
module M
  class C
    X = 2
    class D
      module N
        X = 1
      end
    end
  end
end
puts M::C::D::N::X
puts M::C::X
#Output: 1,2

class Painting
  @@styles = []
  @@paintings = {}
  @@total_count = 0
  attr_reader :style
  
  def self.all_paintings
    @@paintings
  end
  def self.total_count
    @@total_count
  end
  def self.add_style_to_library(style)
    if !@@styles.include?(style)
      @@styles << style
      @@paintings[style] = 0
    end
  end

  def initialize(style)
    if @@styles.include?(style)
      puts "Drawing a new painting in #{style} style!"
      @style = style
      @@paintings[style] += 1
      @@total_count += 1
    else
      raise "No such style in the library: #{style}."
    end
  end
  def same_style_count
    @@paintings[self.style]
  end
end
Painting.add_style_to_library("Impressionism")
Painting.add_style_to_library("Cubism")
paint1 = Painting.new("Impressionism")
paint2 = Painting.new("Cubism")
paint3 = Painting.new("Impressionism")
puts "There are #{paint3.same_style_count} paintings in #{paint3.style} style."
puts "There are #{Painting.total_count} paintigs total."
puts Painting.all_paintings
# Drawing a new painting in Impressionism style!
# Drawing a new painting in Cubism style!
# Drawing a new painting in Impressionism style!
# There are 2 paintings in Impressionism style.
# There are 3 paintigs total.
# {"Impressionism"=>2, "Cubism"=>1}