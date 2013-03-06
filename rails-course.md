Introduction
============

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
### Exemplo de uso

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
### bundle install

Para gerar uma aplicação

    bundle install

---
DSL
-------

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
### instance\_eval

    obj.instance_eval {| | block } => obj

> Evaluates a string containing Ruby source code, or the given block,
> within the context of the receiver (obj). In order to set the context,
> the variable self is set to obj while the code is executing, giving
> the code access to obj’s instance variables.

---
### Mind trick - class\_eval vs instance\_eval

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
### What’s going to happen? - class\_eval vs instance\_eval

    Foo.class_bar
    Foo.new.class_bar 
    Foo.instance_bar
    Foo.new.instance_bar

---
### What’s going to happen? - class\_eval vs instance\_eval

    Foo.class_bar   #=> undefined method 'class_bar' for Foo:Class
    Foo.new.class_bar #=> "class_bar"
    Foo.instance_bar #=> "instance_bar"
    Foo.new.instance_bar #=> undefined method 'instance_bar' for

---
### É tudo sobre o self - class\_eval vs instance\_eval

l | c | c | r

mechanism & method resolution & method definition & new scope?\
class Person & Person & same & yes\
class \<\< Person Person’s & metaclass & same & yes\
Person.class\_eval & Person & same & no\
Person.instance\_eval & Person & Person’s metaclass & no

---
Desafio - DSL - Receita Macarronada com Queijo
--------------------------------------------------

[how-do-i-build-dsls](http://rubylearning.com/blog/2010/11/30/how-do-i-build-dsls-with-yield-and-instance_eval/)

---
### Qual a estrutura deve ser criada para cuidar disso?

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
### Que tal assim?

    def initialize(name, &block)
      self.name = name
      self.ingredients = []
      self.instructions = []
      instance_eval &block
    end

---
### Métodos auxiliares

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
### DSL - Receita - Resultado

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

### Declarando Gem servers

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

---
### Vantagens

1.  Permite a instalação de várias versões do Ruby

2.  Permite a criação de Gemsets que agrupam versões específicas de
    gemas para certas funcionalidades.

---
### Instalação

        $ \curl -L https://get.rvm.io | bash -s stable --ruby

---
### Instalar um novo Ruby

        $ rvm install jruby
        $ rvm get stable

Para listar as versoes instaladas:

        $ rvm list

Para listar a versão atual:

        $ rvm current

---
### Criando Gemsets

        $ rvm gemset create

Para listar os gemset criados para a versão de ruby atual:

        $ rvm gemset list

Para usar um gemset específico:

        $ rvm use ruby_version@gemset

---
### Criando Gemsets II

Na prática

1.  Criar um gemset para o projeto

2.  Criar um arquivo .rvm no projeto:

            echo "rvm user gemset xxx" > .rvmrc

3.  Voltar ao diretório

4.  Usar bundler normalmente

---
RSpec
---------

<http://rspec.info/>

RSpec is testing tool for the Ruby programming language. Born under the
banner of Behaviour-Driven Development.

---
### Get Started Now

    $ gem install rspec

---
### Rspec - Simple Example

    # bowling_spec.rb
    require 'bowling'

    describe Bowling, "#score" do
      it "returns 0 for all gutter game" do
        bowling = Bowling.new
        20.times { bowling.hit(0) }
        bowling.score.should eq(0)
      end
    end

---
### Rspec - Running

     rspec bowling_spec.rb

    ./bowling_spec.rb:4:
      uninitialized constant Bowling

---
### Rspec - coding BDD

    # bowling.rb
    class Bowling
      def hit(pins)
      end

      def score
        0
      end
    end

---
### Rspec - Running Ok!

    $ rspec bowling_spec.rb --format nested

    Bowling#score
      returns 0 for all gutter game

    Finished in 0.007534 seconds

    1 example, 0 failures

---
### Rspec - Basic structure

    "Describe an order."
    "It sums the prices of its line items."

    describe Order do
      it "sums the prices of its line items" do
        order = Order.new
        order.add_entry(LineItem.new(:item => Item.new(
          :price => Money.new(1.11, :USD)
        )))
        order.add_entry(LineItem.new(:item => Item.new(
          :price => Money.new(2.22, :USD),
          :quantity => 2
        )))
        expect(order.total).to eq(Money.new(5.55, :USD))
      end
    end

---
### Rspec - Nested Groups

    describe Order do
      context "with no items" do
        it "behaves one way" do
          # ...
        end
      end

      context "with one item" do
        it "behaves another way" do
          # ...
        end
      end
    end

---
### Rspec - Nested Groups

    shared_examples "collections" do |collection_class|
      it "is empty when first created" do
        expect(collection_class.new).to be_empty
      end
    end

    describe Array do
      include_examples "collections", Array
    end

    describe Hash do
      include_examples "collections", Hash
    end

---
### Rspec Expectations

---
#### Rspec - Equivalence

    actual.should eq(expected)  # passes if actual == expected
    actual.should == expected   # passes if actual == expected
    actual.should eql(expected) # passes if actual.eql?(expected)

---
#### Rspec - Identity

    actual.should be(expected)    # passes if actual.equal?(expected)
    actual.should equal(expected) # passes if actual.equal?(expected)

---
#### Rspec - Comparisons

    actual.should be >  expected
    actual.should be >= expected
    actual.should be <= expected
    actual.should be <  expected
    actual.should be_within(delta).of(expected)

---
#### Rspec - Regular expressions

    actual.should match(/expression/)
    actual.should =~ /expression/

---
#### Rspec - Types/classes

    actual.should be_an_instance_of(expected)
    actual.should be_a_kind_of(expected)

---
#### Rspec - Truthiness

    actual.should be_true  # passes if actual is truthy (not nil or false)
    actual.should be_false # passes if actual is falsy (nil or false)
    actual.should be_nil   # passes if actual is nil

---
#### Rspec - Expecting errors

    expect { ... }.to raise_error
    expect { ... }.to raise_error(ErrorClass)
    expect { ... }.to raise_error("message")
    expect { ... }.to raise_error(ErrorClass, "message")

---
#### Rspec - Expecting throws

    expect { ... }.to throw_symbol
    expect { ... }.to throw_symbol(:symbol)
    expect { ... }.to throw_symbol(:symbol, 'value')

---
#### Rspec - Yielding

    expect { |b| 5.tap(&b) }.to yield_control # passes regardless of yielded args

    expect { |b| yield_if_true(true, &b) }.to yield_with_no_args # passes only if no args are yielded

    expect { |b| 5.tap(&b) }.to yield_with_args(5)
    expect { |b| 5.tap(&b) }.to yield_with_args(Fixnum)
    expect { |b| "a string".tap(&b) }.to yield_with_args(/str/)

    expect { |b| [1, 2, 3].each(&b) }.to yield_successive_args(1, 2, 3)
    expect { |b| { :a => 1, :b => 2 }.each(&b) }.to yield_successive_args([:a, 1], [:b, 2])

---
#### Rspec - Predicate matchers

    actual.should be_xxx         # passes if actual.xxx?
    actual.should have_xxx(:arg) # passes if actual.has_xxx?(:arg)
    Ranges (Ruby >= 1.9 only)

    (1..10).should cover(3)

---
#### Rspec - Collection membership

    actual.should include(expected)
    actual.should start_with(expected)
    actual.should end_with(expected) 

---
Mongo
---------

<http://www.mongodb.org/>

Mongo é um banco de dados NoSQL.

<http://docs.mongodb.org/manual/tutorial/getting-started-with-the-mongo-shell>
<http://docs.mongodb.org/manual/reference/mongo-shell/>
<http://api.mongodb.org/js/2.3.2/symbols/_global_.html>
<http://docs.mongodb.org/manual/tutorial/getting-started/>

---
### Principais características

-   Document-Oriented Storage

-   Full Index Support

-   Auto-Sharding

-   Querying

-   Map/Reduce

---
### Instalação

Baixar e instalar o pacote adequato em
<http://www.mongodb.org/downloads>.

Executar o daemon: mongod.

---
### Mongo Shell

Mongo possui uma inteface interessante em shell baseado em javascript.

    for (var i=0; i<100; i++) {
       print(i);
     }

---
### Mongo Shell - Database

    show dbs // lista as bases
    use nome_da_base // cria e/ou usa uma base
    db // mostra a base atual selecionada
    show collections // mostra as colecoes da base
    db["3test"].find() // busca todos documentos dessa colecao
    db.getCollection("3test").find() // isso faz a mesma coisa

---
### Mongo Shell - Print

    db.<collection>.find().pretty()

In addition, you can use the following explicit print methods in the
mongo shell:

    print() // to print without formatting
    print(tojson(<obj>)) // to print with JSON 
                //  formatting and equivalent to printjson()
    printjson() // to print with JSON formatting
                // and equivalent to print(tojson(<obj>))

### Mongo Profile - Exemplo

    db.setProfilingLevel(0)

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
### Rails Database Migrations in Mongo

---
### Rails Database Migrations - Take that

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
### Query Interface

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
