class MusicalInstrument

  def self.family
    @family # self: MusicalInstrument class
  end

  def self.set_family
    @family = 'wind instruments'
  end

  def family
    @family # self: instance of MusicalInstrument class
  end

  def set_family
    @family = 'flutes'
  end
end

MusicalInstrument.set_family
new_instrument = MusicalInstrument.new
new_instrument.set_family

p new_instrument.family # flutes
p MusicalInstrument.family # wind instruments


class C
  def set_v
    @v = 'I am an instance variable and I belong to any instance of C.'
  end
  def show_var
    puts @v
  end
  def self.set_v
    @v = 'I am an instance variable and I belong to C.'
  end
end
C.set_v
c = C.new
c.set_v
c.show_var
