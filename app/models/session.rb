class Session < ApplicationRecord
  belongs_to :user

  before_save :set_session_id

  private

  def set_session_id
    self.session_id ||= SecureRandom.uuid
  end
end
