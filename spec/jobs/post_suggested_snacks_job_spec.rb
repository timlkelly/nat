require 'rails_helper'

RSpec.describe PostSuggestedSnacksJob, type: :job do
  describe '#perform' do
    it 'enqueues the correct job' do
      ActiveJob::Base.queue_adapter = :test

      expect {
        PostSuggestedSnacksJob.perform_later
      }.to have_enqueued_job(PostSuggestedSnacksJob)
    end

    it 'fetches valid snacks to send' do
      ActiveJob::Base.queue_adapter = :inline

      FactoryGirl.create(:snack)
      FactoryGirl.create(:snack, added_by_employee: true, sent_to_ocd: true)
      valid_snack = FactoryGirl.create(:snack, added_by_employee: true)

      expect_any_instance_of(SnackRequester).to receive(:send_new_snacks).with([valid_snack])

      PostSuggestedSnacksJob.perform_later
    end
  end
end
