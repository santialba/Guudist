require 'rails_helper'

RSpec.describe Task, :type => :model do
  subject {described_class}
  describe "filter" do
    let(:user) { User.create(email: 'test@test.mail', password: 'password_test')}
    let(:tag) {Tag.create({"user_id"=>user.id, "name"=>"tag1"})}
    let(:task1) {Task.create({"title"=>"task1", "weight"=>2, "user_id"=>user.id, "state"=>"to_do", "deadline_at"=>Time.now})}
    let(:task2) {Task.create({"title"=>"task2", "weight"=>5, "user_id"=>user.id, "state"=>"done", "deadline_at"=>Time.now + 14.days, "tags"=>[tag]})}
    it 'filter all tasks by user' do
      expect(subject.filter(user_id: user.id)).to match_array([task1, task2])
    end
    it 'raise error' do
      expect {subject.filter({})}.to raise_error(RuntimeError)
    end
    it 'filter by date' do
      expect(subject.filter(user_id: user.id,
                            init_at: Time.now,
                            finish_at: Time.now + 7.days)).to eq [task1]
    end
    it 'filter by weight' do
      expect(subject.filter(user_id: user.id,
                            weight: 5
                           )).to eq [task2]
    end
    it 'filter by state' do
      expect(subject.filter(user_id: user.id,
                            state: 'done'
                           )).to eq [task2]
    end

    it 'filter by tag_id' do
      expect(subject.filter(user_id: user.id,
                            tag_id: tag.id
                           )).to eq [task2]
    end
  end
end
