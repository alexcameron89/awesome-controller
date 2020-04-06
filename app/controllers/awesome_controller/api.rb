class AwesomeController::Api < AwesomeController::BasestOfBase
  include AwesomeController::Params

  # @response.body = [stuff] is similar to how metal does it.
  #  - action_controller/metal.rb:174 -
  #
  # def response_body=(body)
  #   body = [body] unless body.nil? || body.respond_to?(:each)
  #   response.reset_body!
  #   return unless body
  #   response.body = body
  #   super
  # end
  def render(json:, status: nil)
    #  This ensures that the status code is in the integer format
    #
    #  This combines code from two places
    #  action_controller/metal/rendering.rb:101 , #_normalize_options for symbol to int
    #  actionpack/lib/action_controller/metal/rendering.rb:118 for setting the status
    @response.status = status if status

    @response.content_type = "application/json"
    self.response_body = json.to_json
  end
end
