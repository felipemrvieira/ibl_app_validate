class Message < ApplicationRecord
  # after_create :send_confirmation

  # private

  # def send_confirmation
  #   MessageMailer.with(message: self).submit.deliver_later
  # end
end
