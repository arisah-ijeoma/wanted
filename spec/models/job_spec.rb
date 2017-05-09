require 'rails_helper'

describe JobDecorator, type: :model do
  let(:job_1) { create(:job) }
  let(:job_2) { create(:job, title: 'iOS Developer', remote: true) }
  let(:jobs) { [job_1, job_2] }

  context "returns correct values" do

    describe do
      it do
        expect(Job.search_by_title('Ruby')).to eq([job_1])
      end

      it do
        expect(Job.filter_by_type('part-time')).to eq([])
      end

      it do
        expect(Job.filter_by_remote(true)).to eq([job_2])
      end

      it do
        expect(Job.filter_by_amount_range(10000, 100001)).to eq(jobs)
      end

      it do
        expect(Job.filter_by_amount_range(1000, 10000)).to eq([])
      end
    end
  end
end
