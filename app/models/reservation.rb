class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room
   
  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :person, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validate :check_out_future 
  validate :check_in_past
  validate :check_in_out_same



  def check_out_future
    if check_in.present? && check_out < check_in
      errors.add(:check_out, "日をチェックイン日より後の日付を選んでください")
    end
  end

  def check_in_past
      if check_in.present? && check_in < Date.today
        errors.add(:check_in, "を本日の日付より後の日付を選んでください")
      end
   end
  def check_in_out_same
  if check_in == check_out
    errors.add(:base, "チェックイン日とチェックアウト日が同じになっています")
  end
 end
end
