#require 'rubygems'
#require 'nokogiri'
require 'open-uri'

class Scrapper
  # défini la page de départ
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

  # Défini le chemin à suivre pour récupérer la valeur (ici adresse mail) qui nous intéresse
  def endget_townhall_email(townhall_url)
  page = Nokogiri::HTML(open(townhall_url))
  # localise où trouver l'information dans le fichier HTML
  townhall_mail = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()')
  # passe l'information en String
  townhall_mail = townhall_mail.to_s
  return townhall_mail
  end

  def get_townhall_urls(page)
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  # localise l'information à chercher
  array_urls = page.xpath("//a[@class='lientxt']/@href")
  # converti chaque information en String
  array_urls = array_urls.map { |url| url.to_s }
  # les 2 lignes suivantes permettent de modifier l'information de façon retourner une URL
  array_urls = array_urls.map { |url| url = url[1..-1] }
  array_urls = array_urls.map { |url| url.prepend("http://annuaire-des-mairies.com") }
  return array_urls
  end

  def city_mail_association(page)
  array_urls = get_townhall_urls(page)
  # créer un array vide pour accueillir les adresses mails scrappées
  array_mails = []
  # créer un array vide pour accueillir les hashes {nom de ville => adresse mail}
  final_array = []

  for townhall_url in array_urls
    # récupère les adressses mails scrappée avec la méthode endget_townhall_email
    array_mails << endget_townhall_email(townhall_url)
  end

  # modification du String URL pour ne garder que le nom de la ville
  array_urls = array_urls.map { |url| url[35..-6] }

  # Pour chaque ville dans la liste, insérer dans un array le hash {ville => adresse mail correspondant}
  for i in 0...array_urls.size
    final_array << {array_urls[i] => array_mails[i]}
  end

  # retourne 10 résultats pour ne pas encombrer ton terminal lors de la correction :)
  puts final_array[0..10]
  end

  #city_mail_association(page)
end

#exemples a adapter
    def json_list
    	File.open("db/emails_array.json","w") do |f|
                          f.write(@list_emails_array.to_json)
                  end

    end

    def self.json
    	File.open("db/emails_hash.json","w") do |f|
    		@all_departments[0].list_emails_array.each do |mairie|
    			f.write(mairie.to_json)
    		end
    	end

    end

    def google_sheet
    	session = GoogleDrive::Session.from_config("config.json")
    	ws = session.spreadsheet_by_key("1LAYsOmHoHsvlgrnVFqpqdm38C3LE2IBpPwRHwNOQ2No").worksheets[0]

    	x=1

    	@list_emails_array.each do |mairie|

    		ws[x, 1] = mairie.keys	#ws[ligne,colonne]
    		ws[x, 2] = mairie.values
    		#ws.save
    	x += 1
    	end
    	ws.save

    	#https://docs.google.com/spreadsheets/d/1LAYsOmHoHsvlgrnVFqpqdm38C3LE2IBpPwRHwNOQ2No/edit#gid=0
    end
