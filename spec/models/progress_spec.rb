require 'rails_helper'

RSpec.describe Progress, type: :model do
  describe "validations" do

    it 'should not save without params' do
      prog = Progress.new.save
      expect(prog).to eq(false)
    end

    it 'ensure surname presence' do
      prog = Progress.new(name: 'Danil', classroom:'11', activity:'Ruby', result: 'first').save
      expect(prog).to eq(false)
    end

    it 'ensure classroom presence' do
      prog = Progress.new(name: 'Danil', surname: 'Nasibullin', activity:'Ruby', result: 'first').save
      expect(prog).to eq(false)
    end

    it 'ensure activity presence' do
      prog = Progress.new(name: 'Danil', surname: 'Nasibullin', classroom:'11', result: 'first').save
      expect(prog).to eq(false)
    end

    it 'ensure result presence' do
      prog = Progress.new(name: 'Danil', surname: 'Nasibullin', classroom:'11', activity:'Ruby').save
      expect(prog).to eq(false)
    end

    it 'should not valid if name length <2' do
      prog = Progress.new(name: 'D', surname: 'Nasibullin', classroom:'11', activity:'Ruby', result:'first').save
      expect(prog).to eq(false)
    end
  end

  before(:each) do
    @prog = Progress.new(name: 'Danil', surname: 'Nasibullin', classroom:'11', activity:'Ruby', result:'first')
    @prog.save
  end

  describe 'db activity' do
    it 'should get data from table' do
      res = Progress.find_by_name('Danil')
      expect(res).to eq(@prog)
    end

    it 'should not find data' do
      res = Progress.find_by_name("danil")
      expect(res).to eq(nil)
    end
  end
end
