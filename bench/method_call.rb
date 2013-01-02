require 'bundler'
Bundler.require(:default, :development)

class Example
  def hi; 1; end
end

class ExampleDelegator < SimpleDelegator
  def hi; 2; end
end

module ExampleMixin
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
  end

  bench.report('with Delegate') do
    example = ExampleDelegator.new(Example.new)
    example.hi
  end

  bench.report('with Mixin') do
    example = Example.new
    example.extend(ExampleMixin)
    example.hi
  end

  bench.report('with Dicer') do
    example = example_description.delegator.new(Example.new)
    example.hi
  end
end
