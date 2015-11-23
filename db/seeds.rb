# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Page.create!(name: "Sobre",
             permalink: "about",
             content: "Anualmente a UTFPR Câmpus Guarapuava realiza um concurso fotográfico, no qual os alunos elegem a melhor foto dentre várias postadas pelos participantes do concurso. Porém, a votação e o cadastro dos participantes são feitas manualmente. Pensando em automatizar os procedimentos do concurso, a photo-contest, visa oferecer, da melhor maneira possível, uma solução web para gerenciamento de concursos de fotografia da UTFPR Câmpus Guarapuava")

Page.create!(name: "Contato",
             permalink: "contact",
             content: "Entrar em contato com o professor Dr. Diego Marczal pelo email: dmarczal@gmail.com")