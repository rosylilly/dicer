class Value < Hash
  def [](val)
    super(val.to_s)
  end

  def []=(name, val)
    super(name.to_s, val)
  end

  def method_missing(name, *args)
    if name.to_s[-1] == '='
      name = name[0 .. -2]
      self[name] = args[0]
      (class << self; self; end).class_eval(<<-EOF)
        def #{name}; self["#{name}"]; end
        def #{name}=(v); self["#{name}"] = v; end
      EOF
    else
      super
    end
  end
end
