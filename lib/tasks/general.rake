task fetch_snacks: :environment do
  FetchSnacksJob.perform_later
end
