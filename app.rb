require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/board'
require 'app/boardcase'
require 'app/game'
require 'app/player'
require 'views/show'


class Application
  def perform
    # TO DO : méthode qui initialise le jeu puis contient des boucles while pour faire tourner le jeu tant que la partie n'est pas terminée.
    #
    puts "--------------------------------------------------"
    puts "| Bienvenue sur 'ILS SONT SUR MES POILS' !       |"
    puts "| Un jeu du morpion pas piqué des hannetons !   |"
    puts "--------------------------------------------------"

    puts "Quel est le nom de ton personnage ?"
    print ">"
    player = gets.chomp
    player1 = HumanPlayer.new(player)
    puts player1.accueil


    binding.pry
  end

end


Application.new.perform
