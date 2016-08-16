class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents ||= {}
  end

  def add_creature(creature_id)
    contents[creature_id.to_s] ||= 0
    contents[creature_id.to_s] += 1
  end

  def count_of(creature_id)
    contents[creature_id.to_s]
  end

  def total # total_quantity
    contents.values.sum
  end

  def total_price
    total_price = 0
    contents.each do |id, qty|
      total_price += qty * Creature.find(id).price
    end
    total_price
  end

  def creatures
    creatures = []
    contents.keys.each do |id|
      creatures << Creature.find(id) unless contents[id] == 0
    end
    creatures
  end

  def subtotal(creature_id)
    contents[creature_id.to_s] * Creature.find(creature_id).price
  end

  def empty?
    contents.values.sum == 0 || nil?
  end

  def not_empty?
    empty? == false
  end
end
