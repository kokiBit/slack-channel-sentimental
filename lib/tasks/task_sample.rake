namespace :task_sample do
  desc "実行処理の説明"
  task :task_model => :environment do
    channel_info = Slack.channels_info({channel: "CE6GB9VHN"})["channel"]
    puts User.first().name
    puts channel_info["name"]

    # Instantiates a client
    language = Google::Cloud::Language.new

    # The text to analyze
    text = "デザインがダサい"

    # Detects the sentiment of the text
    response = language.analyze_sentiment content: text, type: :PLAIN_TEXT

    # Get document sentiment from response
    sentiment = response.document_sentiment

    puts "Text: #{text}"
    puts "Score: #{sentiment.score}, #{sentiment.magnitude}"
 end
end
