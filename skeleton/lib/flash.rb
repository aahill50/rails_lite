require_relative '../phase6/controller_base'

class Flash < Phase6::ControllerBase
  attr_reader :key, :value, :method

  def initialize(key, value, method = :next)
    @key = key
    @value = value
    @method = method
  end

  def flash[](key)
    cookie = res.cookies.find {|c| c.name == key.to_s}
    cookie.nil? ? nil : JSON.parse(cookie.value)
  end

  def flash[]=(key, value)
    cookie = res.cookies.find {|c| c.name == key.to_s}

    if cookie
      cookie.value << value.to_json
    else
      res.cookies << WEBrick.Cookie.new(key, value: @value.to_json)
    end
  end
end
