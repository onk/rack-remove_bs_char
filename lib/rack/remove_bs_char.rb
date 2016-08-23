module Rack
  # rack middleware to remove `0x08`(`\b`).
  # `0x08` is easily inserted in japanese FEP of Mac OSX.
  class RemoveBsChar
    def initialize(app)
      @app = app
    end

    def call(env)
      # form_params
      unless env["REQUEST_METHOD"] == "GET" || env["REQUEST_METHOD"] == "HEAD"
        env["rack.input"] = StringIO.new(parse_query(env["rack.input"].read))
        env["CONTENT_LENGTH"] = env["rack.input"].length.to_s
      end
      # query_params
      env["QUERY_STRING"] = parse_query(env["QUERY_STRING"])

      @app.call(env)
    end

    private

      def parse_query(str)
        return nil unless str

        new_array = []
        str.split("&").each do |param_pair|
          k, v = param_pair.split("=")
          k = remove_bs_char(k) if k
          v = remove_bs_char(v) if v
          new_array << "#{k}=#{v}" if k
        end

        new_array.join("&")
      end

      def remove_bs_char(str)
        ::Rack::Utils.escape(::Rack::Utils.unescape(str).delete("\b"))
      end
  end

  if defined?(Rails)
    class Railtie < Rails::Railtie
      initializer "rack-remove_bs_char.insert_middleware" do |app|
        app.config.middleware.use "Rack::RemoveBsChar"
      end
    end
  end
end
