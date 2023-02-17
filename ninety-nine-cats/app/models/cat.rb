require action_view


class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper
    CAT_COLORS = ['white', 'black', 'orange']
    validates :name, :birth_date, :color, presence: true
    validates :sex, presence: true, length: {is: 1}, inclusion: { in: %w(M F)}
    validates :color, inclusion: { in: CAT_COLORS}
    validate :birth_date_cannot_be_future

    def birth_date_cannot_be_future
        if birth_date > Date.today
            errors.add(:birth_date, "Can't be in the future")
        end
    end

    def age
        time_ago_in_words(Time.now, birth_date, include_seconds: true)
    end

end