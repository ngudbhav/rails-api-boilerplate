# == Schema Information
#
# Table name: sessions
#
#  id           :bigint           not null, primary key
#  data         :text(65535)
#  discarded_at :datetime
#  ip_address   :string(255)
#  user_agent   :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  session_id   :string(255)
#  user_id      :bigint           not null
#
# Indexes
#
#  index_sessions_on_discarded_at  (discarded_at)
#  index_sessions_on_session_id    (session_id) UNIQUE
#  index_sessions_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Session < ApplicationRecord
  belongs_to :user

  before_save :set_session_id

  private

  def set_session_id
    self.session_id ||= SecureRandom.uuid
  end
end
