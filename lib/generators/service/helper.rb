module Service
  module Helper
    extend self

    def service_name(arg)
      if arg.include? "/"
        root = arg.split("/").first
        sub_domain = arg.split("/").last
        "#{root.underscore}_service/#{sub_domain}"
      else
        "#{arg.underscore}_service"
      end
    end

    def service_path(arg)
      "app/services/#{service_name(arg)}"
    end

    def spec_path(arg)
      "spec/services/#{service_name(arg)}"
    end
  end
end