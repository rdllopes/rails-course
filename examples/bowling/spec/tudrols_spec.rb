require 'rspec'
  include Spec::Matchers

describe "Teste" do
  expect { Born.new }.to raise_error  
  expect { 1/0 }.to raise_error
  expect { raise "Boom" }.to raise_error
  
end