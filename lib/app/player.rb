class Player
#TO DO : la classe a 2 attr_reader, son nom et sa valeur (X ou O).
  attr_reader :player, :table

  def initialize(player)
  #TO DO : doit régler son nom et sa valeur
    @player = player
  end

  def accueil
    puts "Bienvenue #{player}, le jeu va commencer. Voici le plateau vide : "
  end

end
