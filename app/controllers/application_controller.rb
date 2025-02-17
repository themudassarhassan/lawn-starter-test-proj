class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from SwapiService::ResourceNotFound, with: :render_not_found

  private

  def render_not_found(e)
    render inertia: "not_found/index", props: { message: e.message }
  end
end
