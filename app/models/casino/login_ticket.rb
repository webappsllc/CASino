class CASino::LoginTicket < ActiveRecord::Base
  include CASino::ModelConcern::Ticket
  include CASino::ModelConcern::ConsumableTicket

  self.ticket_prefix = 'LT'.freeze

  def self.cleanup
    all.delete_all(['created_at < ?', CASino.config.login_ticket[:lifetime].seconds.ago])
  end

  def expired?
    (Time.now - (created_at || Time.now)) > CASino.config.login_ticket[:lifetime].seconds
  end
end
