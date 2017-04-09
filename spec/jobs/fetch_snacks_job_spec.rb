require 'rails_helper'

RSpec.describe FetchSnacksJob, type: :job do
  describe '#perform' do
    it 'enqueues the correct job' do
      ActiveJob::Base.queue_adapter = :test

      expect {
        FetchSnacksJob.perform_later
      }.to have_enqueued_job(FetchSnacksJob)
    end
  end
end
