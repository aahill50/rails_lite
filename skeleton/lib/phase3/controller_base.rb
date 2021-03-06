require_relative '../phase2/controller_base'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content

    def render(template_name)
      template_file = "views/#{controller_name}/#{template_name}.html.erb"
      contents = File.read(template_file)

      erb_template = ERB.new(contents)

      render_content(erb_template.result(binding), "text/html")
    end

    def controller_name
      self.class.name.underscore
    end
  end
end
