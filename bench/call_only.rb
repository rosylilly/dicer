require 'bundler'
Bundler.require(:default, :development)
require 'delegate'
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
  example = Example.new

  bench.report('instance method') do
    example.hi
    example.hello
  end

  delegated = ExampleDelegator.new(Example.new)
  bench.report('with Delegate') do
    delegated.hi
    delegated.hello
  end

  forwardabled = ExampleForwardable.new(Example.new)
  bench.report('with Forwardable') do
    forwardabled.hi
    forwardabled.hello
  end

  extended = Example.new.extend(ExampleMixin)
  bench.report('with #extend') do
    extended.hi
    extended.hello
  end

  specific = Example.new
  class << specific; def hello; 1; end; end
  bench.report('with specific method') do
    specific.hi
    specific.hello
  end

  dicer = example_description.delegator.new(Example.new)
  bench.report('with Dicer') do
    dicer.hi
    dicer.hello
  end
end

