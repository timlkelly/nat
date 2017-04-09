task fetch_snacks: :environment do
  FetchSnacksJob.perform_later
end

task send_new_snacks: :environment do
  PostSuggestedSnacksJob.perform_later
end
