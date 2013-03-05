Introduction
================

---
O que sabemos
-----------------

Ruby é uma linguagem dinâmica que favorece a metaprogramação.

A linguagem favorece a criação de artefatos que tornam a programação
mais enxuta e expressiva.

---
Referências
---------------

[Ruby on Rails guides](http://guias.rubyonrails.com.br/)

---
Ecosistema Ruby on Rails
============================


---
Gems
--------

Sistema de pacotes do Ruby

-   Instalação do pacote (similar ao apt-get)

-   Repositório de pacotes

---
Exemplo de uso

    gem install methodize

    Successfully installed methodize-0.2.2
    1 gem installed

---
Bundler
-----------

---
### Bundler by Bundler

Bundler tracks an application’s code and the rubygems it needs to run,
so that an application will always have the exact gems (and versions)
that it needs to run.

---
### Bundler + Gemfile

Assim como o apt-get, gem install irá procurar a última versão da
biblioteca procurada.

Um Gemfile é similar ao pom.xml do Maven

    # These gems are in the :default group
    gem "nokogiri"
    gem "sinatra"

    gem "wirble", :group => :development

    group :test do
      gem "rspec"
      gem "faker"
    end
---
Para gerar uma aplicação a

    bundle install
---
DSL
---

Gemfile é bom exemplo como Ruby favorece a criação de DSLs.

Ruby possui três comandos para interpretação de texto:

1.  eval
2.  instance\_eval
3.  class\_eval

---
class\_eval
---------------

    mod.class_eval(string [, filename [, lineno]]) => obj

> Evaluates the string or block in the context of mod. This can be used
> to add methods to a class.

---
instance\_eval

    obj.instance_eval {| | block } => obj

> Evaluates a string containing Ruby source code, or the given block,
> within the context of the receiver (obj). In order to set the context,
> the variable self is set to obj while the code is executing, giving
> the code access to obj’s instance variables.

---
Mind trick - class\_eval vs instance\_eval

    Foo = Class.new
    Foo.class_eval do
      def class_bar
        "class_bar"
      end
    end
    Foo.instance_eval do
      def instance_bar
        "instance_bar"
      end
    end

---
What’s going to happen? - class\_eval vs instance\_eval

    Foo.class_bar
    Foo.new.class_bar 
    Foo.instance_bar
    Foo.new.instance_bar

---
What’s going to happen? - class\_eval vs instance\_eval

    Foo.class_bar   #=> undefined method 'class_bar' for Foo:Class
    Foo.new.class_bar #=> "class_bar"
    Foo.instance_bar #=> "instance_bar"
    Foo.new.instance_bar #=> undefined method 'instance_bar' for

---
É tudo sobre o self - class\_eval vs instance\_eval


<table>
<tr><td>mechanism </td><td> method resolution </td><td> method definition </td><td> new scope?</td></tr>
<tr><td>class Person </td><td> Person </td><td> same </td><td> yes</td></tr>
<tr><td>class Person Person’s </td><td> metaclass </td><td> same </td><td> yes</td></tr>
<tr><td>Person.class\_eval </td><td> Person </td><td> same </td><td> no</td></tr>
<tr><td>Person.instance\_eval </td><td> Person </td><td> Person’s metaclass </td><td> no</td></tr>
</table>

---
 
Desafio - DSL - Receita Macarronada com Queijo
----------------------------------------------

[how-do-i-build-dsls](http://rubylearning.com/blog/2010/11/30/how-do-i-build-dsls-with-yield-and-instance_eval/)

---
Qual a estrutura deve ser criada para cuidar disso?

    mac_and_cheese = Recipe.new("Mac and Cheese") do
      ingredient "Water", :amount => "2 cups"
      ingredient "Noodles", :amount => "1 cup"
      ingredient "Cheese", :amount => "1/2 cup"

      step "Heat water to boiling.", :for => "5 minutes"
      step "Add noodles to boiling water.", :for => "6 minutes"
      step "Drain water."
      step "Mix cheese in with noodles."
    end

---
Que tal assim?

    def initialize(name, &block)
      self.name = name
      self.ingredients = []
      self.instructions = []
      instance_eval &block
    end

---
Métodos auxiliares

    def ingredient(name, options = {})
        ingredient = name
        ingredient << " (#{options[:amount]})" if options[:amount]
        ingredients << ingredient
      end

      def step(text, options = {})
        instruction = text
        instruction << " (#{options[:for]})" if options[:for]
        instructions << instruction
      end

---
DSL - Receita - Resultado

    file = File.open(ARGV[0], "rb")
    contents = file.read
    recipe = Recipe.new ARGV[0], contents
    p recipe

    ruby recipes.rb mac_cheese.txt 
    #<Recipe:0x00000101086f90 @name="mac_cheese.txt", 
    @ingredients=["Water (2 cups)", 
    #"Noodles (1 cup)", "Cheese (1/2 cup)"], 
    #@instructions=["Heat water to boiling. (5 minutes)", 
    #"Add noodles to boiling water. (6 minutes)", 
    #"Drain water.", "Mix cheese in with noodles."]>

---
Gemfile detalhes
--------------------
## Declarando Gem servers

    source :rubygems
    source "http://rubygems.org"
    source :rubyforge
    source "http://gems.rubyforge.org"
    source :gemcutter
    source "http://gemcutter.org"

---
### Especificando a versão adequada das gemas

    gem "nokogiri"
    gem "rails", "3.0.0.beta3"
    gem "rack",  ">=1.0"
    gem "thin",  "~>1.1"

---
### Nota sobre os Espeficiadores de versão

Most of the version specifiers, like $\geq 1.0$, are self-explanatory.
The specifier `~>` has a special meaning, best shown by example.
`~> 2.0.3` is identical to $\geq 2.0.3$ and $<  2.1$. `~> 2.1` is
identical to $ \geq 2.1$ and $< 3.0$.

---
### Obtendo gemas do Git

    gem "nokogiri", :git => "git://github.com/tenderlove/nokogiri.git", :branch => "1.4"

    git "git://github.com/wycats/thor.git", :tag => "v0.13.4"
    gem "thor"

---
### Grupos no Gemfile

É possível atribuir gemas que são úteis em contextos específicos

    # These gems are in the :default group
    gem "nokogiri"
    gem "sinatra"

    gem "wirble", :group => :development

    group :test do
      gem "rspec"
      gem "faker"
    end

Install all gems, except those in the listed groups. Gems in at least
one non-excluded group will still be installed.

    $ bundle install --without test development

---
RVM
-------

### Instalação:

    $ \curl -L https://get.rvm.io | bash -s stable --ruby

Como usar:

1. Criar um gemset para o projeto
2. Criar um arquivo .rvm no projeto:

    echo "rvm user gemset xxx" > .rvmrc

3. Voltar ao diretório
4. Usar bunlder normalment


---
Mongo
---------

---
MongoMapper
---------------

---
Rails - Primeiros Passos
============================

---
Rails HelloWorld
--------------------

---
Model
=========

---
Rails Database Migrations
-----------------------------

This guide covers how you can use Active Record migrations to alter your
database in a structured and organized manner.

---
Rails Database Migrations in Mongo

---
Rails Database Migrations - Take that

Não há necessidadde de migrations porque estamos usando mongo. Evitamos
dor e sofrimento.

---
MongoMapper Validations and Callbacks
-----------------------------------------

This guide covers how you can use Active Record validations and
callbacks.

---
MongoMapper Associations
----------------------------

This guide covers all the associations provided by Active Record.

---
Query Interface

This guide covers the database query interface provided by Active
Record.

---
Views
=========

---
Layouts e Renderização no Rails
-----------------------------------

Este guia cobre o básico dos recursos de layout do Action Controller e
Action View, incluindo renderização e redirecionamento, usando blocos
content\_for, e trabalhando com partials.

---
Action View Form Helpers
----------------------------

Guia para utilização dos Form helpers do Rails.

---
Jsonify
-----------

---
REST in rails
-----------------

Controllers Visão Geral do Action Controller Este guia explica como os
controllers trabalham e como eles se encaixam no ciclo de requisição de
sua aplicação. Ele inclue sessões, filtros, cookies, streaming de dados,
como trabalhar com exceções levantadas por um request, entre outros
tópicos.

Roteamento Rails de Fora para Dentro Este guia cobre as maravilhas do
sistema de roteamento do Rails. Se você quer entender como usar as rotas
em suas aplicações Rails, comece por aqui.

Rails on Rack Este guia cobre a integração do Rails com Rack e sua
interface com componentes Rack.
