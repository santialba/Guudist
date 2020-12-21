class Task < ApplicationRecord
  include AASM

  belongs_to :user

  aasm column: 'state' do
    state :to_do,
          initial: true
    state :done

    event :done do
      transitions from: :to_do, to: :done, guard: :completed_at?
    end
  end
end
