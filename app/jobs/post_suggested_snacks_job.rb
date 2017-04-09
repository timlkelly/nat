class PostSuggestedSnacksJob < ApplicationJob
  queue_as :default

  def perform
    snacks = Snack.where(added_by_employee: true, sent_to_ocd: false)

    SnackRequester.new.send_new_snacks(snacks)
  end
end

# See snack_requester.rb for comments, as they apply in a few places
