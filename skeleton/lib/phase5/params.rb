require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    def initialize(req, route_params = {})
      @params = {}
      query_params = parse_www_encoded_form(req.query_string)
      body_params = parse_www_encoded_form(req.body)

      @params.merge!(query_params)
      @params.merge!(body_params)
      @params.merge!(route_params)
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      params = {}

      if www_encoded_form
        key_values = URI.decode_www_form(www_encoded_form)
        key_values.each do |key_array, value|
          scope = params

          key_seq = parse_key(key_array)
          key_seq.each_with_index do |key, idx|
            if (idx + 1) == key_seq.count
              scope[key] = value
            else
              scope[key] ||= {}
              scope = scope[key]
            end
          end
        end
      end

      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end


