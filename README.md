# Photo Contest

[<img alt='Stories in Ready' src='https://badge.waffle.io/dmarczal/photo-contest.png?label=ready&title=Ready' />](https://waffle.io/dmarczal/photo-contest)

O Photo Contest é um sistema para gerenciar concursos de fotografias 

##Funcionalidades
* ADMINISTRADOR 
    * Cria e gerência concursos fotográficos;
    * Cria e gerência páginas dentro do sistema;
    * Altera a página Sobre de acordo com as informações sobre o concurso;
    * Altera a página Contato de acordo com as informações sobre os contatos do concurso.
* PÚBLICO
    * Acesso a lista de concursos;
    * Cadastra-se para votar em um concurso;
    * Vota apenas um vez em cada concurso;
    * Acompanha o ranking em tempo real;
    * Acessa os concursos antigos;
    * Acessa a lista de fotográfos (participantes) e ver a sua quantidade de medalhas;
    * Acessa o perfil do fotógrafo e suas respectivas quantidades de medalhas;
    * Acessa o Hall da Fama do sistema;
    * Compartilha a página do sistema nas redes sociais (Facebook, twitter) ou por email.
* FOTOGRÁFO 
    * Cadastrar-se e inscrever-se nos concursos disponíveis;
    * Tem acesso ao mesmo conteúdo que o usuário tem acesso.

##Instalação
1. Faça o download no repositório do [Projeto](https://github.com/dmarczal/photo-contest) ou clone o repositório do projeto utilizando o comando 
    * `git clone git@github.com:dmarczal/photo-contest.git`
2. Instalar as gems necessárias
    * Executar  `bundle install`  
2. Crie as tabelas do banco de dados
    * Executar `rake db:migrate`
3. Criar as páginas Sobre e Contato 
    * Executar o comando `rake db:seed`   


##Configuração
1. Criar um Administrador e cadastros default (e.g. concursos, usuários) para o sistema 
    * Alterar o arquivo `lib/tasks/populate.rake`
2. Popular o banco com os dados definidos no arquivo `lib/tasks/populate.rake`
    * Executar o comando `rake db:populate`
3. Inicializar o servidor e acessar a página do projeto:
    * Executar `rails s`
    * Acesse o [photocontest](https://photocontest-utfpr.herokuapp.com)
4. Acesse o formulário de login do Administrador do sistema:
    * [admin](https://photocontest-utfpr.herokuapp.com/admin)
    * Login para acesso: admin@admin.com, senha: `12345678`
     
##Demo
1. Pode-se testar o sistema populando o banco com de usuários e concursos `fakes`
    * Após instalar o sistema executar o comando `rake db:populate`
2. Se preferir existe um *demo* no *Heroku*:
    * Acesse o [photocontest](https://photocontest-utfpr.herokuapp.com ) no Heroku.

##Documentação
https://github.com/dmarczal/photo-contest/wiki

##Suporte
Se você tem alguma dúvida, por favor verifique este README ou a Wiki deste projeto
