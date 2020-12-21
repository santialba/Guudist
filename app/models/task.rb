class Task < ApplicationRecord
  include AASM

  belongs_to :user
  has_and_belongs_to_many :tags

  validates :tags, length: { maximum: 3 }

  aasm column: 'state' do
    state :to_do,
          initial: true
    state :done

    event :done do
      transitions from: :to_do, to: :done, guard: :completed_at?
    end
  end
end
