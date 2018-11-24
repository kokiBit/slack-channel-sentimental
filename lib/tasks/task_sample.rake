namespace :task_sample do
  desc "実行処理の説明"
  task :task_model, ['channel_id'] => :environment do |task, args|
    channel_info = Slack.channels_info({channel: args["channel_id"]})["channel"]

    channel_name = channel_info["name"]

    # ID, Nameを登録
    Channel.create(channel_id: args["channel_id"], name: channel_name)

    # Member 登録
    channel_members = channel_info["members"]

    channel_members.each do |member_id|
      member_info = Slack.users_info({user: member_id})["user"]
      member_name = member_info["real_name"]
      User.create(user_id: member_id, name: member_name)
    end

    # 会話を取得する
    messages = Slack.channels_history({channel: args["channel_id"], count: 100})["messages"]

    messages.each do |message|
      if message["text"].include?('Query:') then
        next
      end

      language = Google::Cloud::Language.new
      response = language.analyze_sentiment content: message["text"], type: :PLAIN_TEXT
      sentiment = response.document_sentiment

      channel = Channel.find_by(channel_id: args["channel_id"])
      user = User.find_by(user_id: message["user"])

      check = false
      channel.users.each_with_rel.each do |node, rel|
        if node === user
          check = true
          rel.total_message_count = rel.total_message_count + 1
          rel.sentimental_score = ((rel.sentimental_score + sentiment.score) / 2).round(3)
          rel.save!
          break
        end
      end

      if check then
        next
      end

      Join.create(from_node: user, to_node: channel, total_message_count: 1,sentimental_score: sentiment.score.round(3))
    end

 end
end
