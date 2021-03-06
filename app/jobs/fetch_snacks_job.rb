require './lib/integrations/snack_requester'
require './lib/integrations/snack_processor'

class FetchSnacksJob < ApplicationJob
  queue_as :default

  # this job will make the API request and add any new snacks to the
  # db async.

  def perform
    snacks_json = SnackRequester.new.request_snacks

    SnackProcessor.new.create(snacks_json)
  end
end

# See snack_requester.rb for comments, as they apply in a few places
