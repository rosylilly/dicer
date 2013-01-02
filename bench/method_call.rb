require 'bundler'
Bundler.require(:default, :development)
require 'forwardable'

class Example
  def hi; 1; end
  def hello; '1'; end
end

class ExampleDelegator < SimpleDelegator
  def hi; 2; end
end

class ExampleForwardable
  extend Forwardable

  def_delegator :@example, :hello

  def initialize(example)
    @example = example
  end

  def hi; 3; end
end

module ExampleMixin
  include Dicer::Behavior

  def hi; 3; end
end

example_description = Dicer::Context::Description.new(Example) do
  it_behaves_like ExampleMixin
end
example_delegator = example_description.delegator

Benchmark.ips do |bench|
  bench.report('without Mixin') do
    example = Example.new
    example.hi
    example.hello
  end

  bench.report('with Delegate') do
    example = ExampleDelegator.new(Example.new)
    example.hi
    example.hello
  end

  bench.report('with Forwardable') do
    example = ExampleForwardable.new(Example.new)
    example.hi
    example.hello
  end

  bench.report('with Mixin') do
    example = Example.new
    example.extend(ExampleMixin)
    example.hi
    example.hello
  end

  bench.report('with Dicer') do
    example = example_description.delegator.new(Example.new)
    example.hi
    example.hello
  end
end
