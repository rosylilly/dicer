require 'securerandom'

class Entity
  def initialize(data)
    @id = SecureRandom.uuid

    data.each_pair do |key, val|
      instance_variable_set(:"@#{key}", val)

      if key.to_s != 'id'
        (class << self; self; end).class_eval(<<-EOF)
          def #{key}
            @#{key}
          end

          def #{key}=(v)
            @#{key} = v
          end
        EOF
      end
    end
  end

  attr_reader :id

  def ==(other)
    other.class == self.class && other.id == self.id
  end
end
