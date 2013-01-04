require 'bundler'
Bundler.require(:default, :development)

class Example
  def hello; 1; end
end

example = Example.new

Benchmark.ips do |bench|
  bench.report('#hello') do
    example.hello
  end

  bench.report('#send(:hello)') do
    example.send(:hello)
  end

  bench.report('#__send__(:hello)') do
    example.__send__(:hello)
  end

  bench.report('with begin') do
    begin
      example.send(:hello)
    rescue Exception
      raise
    end
  end
end
