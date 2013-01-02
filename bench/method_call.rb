require 'delegate'
require 'benchmark/ips'

class Example
  def hi; 1; end
end

class ExampleDelegator < SimpleDelegator
  def hi; 2; end
end

module ExampleMixin
  def hi; 3; end
end

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
end
