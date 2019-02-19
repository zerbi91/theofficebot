class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def start!(*)
    respond_with :message, text: t('.hi')
  end

  def inline_query(query, _offset)
    print "query"
    print query
    print "offset"
    print _offset
    query = query.first(10) # it's just an example, don't use large queries.
    results = Array.new(5) do |i|
      {
        type: :article,
        title: "#{query}-#{i}",
        id: "#{query}-#{i}",
        description: "#{Rails.root}/data/srt/*",
        input_message_content: {
          message_text: "Messaggio #{i}",
        },
      }
    end

    files_srt = Dir.glob("#{Rails.root}/data/srt/*")

    p files_srt
    answer_inline_query results
  end

end
