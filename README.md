# Photo Contest
{<img alt='Stories in Ready' src='https://badge.waffle.io/dmarczal/photo-contest.png?label=ready&title=Ready' />}[https://waffle.io/dmarczal/photo-contest]
== README

O Photo Contest é um sistema para gerenciar concursos de fotografias 

##Funcionalidades
* ADMINISTRADOR 
    * Cria e gerenciar concursos fotográficos;
    * Cria e gerencia págnias dentro do sisteama;
    * Altera a página Sobre de acordo com as informações sobre o concurso;
    * Altera a página Contato de acordo com as informações sobre os contatos do concurso.
* FOTOGRÁFO 
    * Cadastrar-se e inscrever-se nos concursos disponíveis.
* PÚBLICO
    * Votam apenas um vez em cada concurso;
    * Acompanhamento do ranking em tempo real;
    * Acessa a concursos antigos;
    * Acessa a lista de fotográfos (participantes) com sua respectiva posição no rank geral e número de medalhas;
    * Acessa o perfil do fotógrafo e suas respectivas quantidades de medalhas.

##Instalação

1. Faça o download no repositório do [Projeto](https://github.com/dmarczal/photo-contest) ou clone o repositório do projeto utilizando o comando 
    * `git clone git@github.com:dmarczal/photo-contest.git`
2. Crie as tabelas do banco de dados
    * `rake db:migrate`
3. Start o servidor e acesse a página do projeto
    * `rails s`
    * Acesse o [site](http://localhost:3000)

##Configuração

##Documentação
https://github.com/dmarczal/photo-contest/wiki

##Suporte
Se você tem alguma dúvida, por favor verifique este README ou a Wiki deste projeto