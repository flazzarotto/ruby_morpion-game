Class HumanPlayer

attr_accessor :name, :max_life_points, :life_points

def initialize(name)

  @name = name
  @max_life_points = 10
  @life_points = 10

end


def show_state
  puts "#{@name} a #{@life_points} points de vie"
end


def return_state
  return "#{@name} a #{@life_points} points de vie."
end


def gets_damage(damage)

  @life_points -= (damage)

  if is_dead? then
    puts "Le joueur #{@name} a été tué !"
    @life_points = 0
  end

end


def attacks(player)

  puts "Le joueur #{@name} attaque le joueur #{player.name}"
  damage = compute_damage
  puts "il lui inflige #{damage} dommages"
  player.gets_damage(damage)

end


def compute_damage
  return rand(1..6)
end


def is_dead?

  if (@life_points <= 0) then
    return true
  else
    return false
  end

end

def is_live?

  if (is_dead?) then
    return false
  else
    return true
  end

end
