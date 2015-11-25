# Photo Contest
{<img alt='Stories in Ready' src='https://badge.waffle.io/dmarczal/photo-contest.png?label=ready&title=Ready' />}[https://waffle.io/dmarczal/photo-contest]
== README

O Photo Contest é um sistema para gerenciar concursos de fotografias 

##Funcionalidades
* ADMINISTRADOR 
    * Cria e gerenciar concursos fotográficos;
    * Cria e gerencia págnias dentro do sistema;
    * Altera a página Sobre de acordo com as informações sobre o concurso;
    * Altera a página Contato de acordo com as informações sobre os contatos do concurso.
* FOTOGRÁFO 
    * Cadastrar-se e inscrever-se nos concursos disponíveis.
* PÚBLICO
    * Cadastra-se para votar em um concurso;
    * Vota apenas um vez em cada concurso;
    * Acompanha o ranking em tempo real;
    * Acessa a concursos antigos;
    * Acessa a lista de fotográfos (participantes) e acompanha a sua posição no ranking geral;
    * Acessa o perfil do fotógrafo e suas respectivas quantidades de medalhas;
    * Compartilha a página do sistema nas redes sociais (Facebook, twiiter) ou por email.

##Instalação
1. Faça o download no repositório do [Projeto](https://github.com/dmarczal/photo-contest) ou clone o repositório do projeto utilizando o comando 
    * `git clone git@github.com:dmarczal/photo-contest.git`
2. Instalar as gems necessárias
    * Executar  `bunlde install
2. Crie as tabelas do banco de dados
    * Executar `rake db:migrate`
3. Criar as páginas Sobre e Contato 
    * Executar o comando `rake db:seed`   


##Configuração
1. Criar um Administrador e cadastros default (e.g. concursos, usuários) para o sistema 
    * Alterar o arquivo `lib/tasks/populate.rake`
2. Popular o banco com os dados definidos no arquivo `lib/tasks/populate.rake`
    * Executar o comando `rake db:populate`
3. Inicializar o servidor e acessar a página do projeto
    * Executar `rails s`
    * Acesse o [site](http://localhost:3000) 
4. Acessar o formulário de login do Administrador
    * [/admin](http://localhost:3000/admin)
     
##Demo e Teste
1. Pode-se testar o sistema populando o banco com de usuários e concursos `fakes`
    * Após instalar o sistema executar o comando `rake db:populate`
2. Inicializar o servidor e acessar a página do projeto
    * Executar `rails s`
    * Acesse o [site](http://localhost:3000) 
##Documentação
https://github.com/dmarczal/photo-contest/wiki

##Suporte
Se você tem alguma dúvida, por favor verifique este README ou a Wiki deste projeto