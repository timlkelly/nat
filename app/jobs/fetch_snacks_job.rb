class FetchSnacksJob < ApplicationJob
  queue_as :default

  # Create Job to fetch snacks. Use rake task to automate this every 24h
  # This will allow application to stay up to date with current company
  # snacks

  def perform(*args)
    # Do something later
  end
end
