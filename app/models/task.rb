# frozen_string_literal: true

class Task < ApplicationRecord
  include AASM

  belongs_to :user
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  validates :title, presence: true
  validates :deadline_at, presence: true
  validates :tag_ids, length: { maximum: 3 }

  aasm column: 'state' do
    state :to_do,
          initial: true
    state :done

    event :done do
      transitions from: :to_do, to: :done
    end
  end

  def self.filter(params)
    raise 'user_id is mandatory in params' if params[:user_id].nil?

    params[:deadline_at] = params[:init_at]..params[:finish_at]
    tag_id = params[:tag_id]
    params = params.slice(:user_id, :weight, :state, :deadline_at)
    tasks = where(params).order('weight DESC, deadline_at')
    if tag_id.present?
      tasks.joins(:tags).where('tags.id = ?', tag_id)
    else
      tasks
    end
  end
end
