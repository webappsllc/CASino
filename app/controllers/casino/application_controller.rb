require 'casino'

class CASino::ApplicationController < ::ApplicationController
  include ApplicationHelper

  layout 'application'

  rescue_from ActionController::UnknownFormat do
    head :not_acceptable
  end

  unless Rails.env.development?
    rescue_from ActionView::MissingTemplate, with: :missing_template
  end

  def cookies
    super
  end

  protected
  def missing_template(exception)
    render plain: 'Format not supported', status: :not_acceptable
  end
end
