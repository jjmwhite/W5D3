require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require 'byebug'
require 'active_support/inflector'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise 'ERROR!' if already_built_response?
    @res['Location'] = url
    @res.status = 302
    @already_built_response = true
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise 'ERROR!' if already_built_response?
    @res.write(content)
    @res['Content-Type'] = content_type
    @already_built_response = true
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  
  #"views/#{controller_name}/#{template_name}.html.erb"
  def render(template_name)
    controller_name = "#{self.class.name.underscore}"
    root_folder = File.dirname(__FILE__)
    path = "#{root_folder}/../views/#{controller_name}/#{template_name}.html.erb" 
    
    erb = ERB.new(File.read(path))
    content = erb.result(binding)
    render_content(content, 'text/html')
    
    
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end

