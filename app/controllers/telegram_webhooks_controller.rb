class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include TimeHelper

  def start!(*)
    respond_with :message, text: t('.hi')
  end

  def inline_query(query, _offset)
    print "query"
    print query
    print "offset"
    print _offset
    query = query.first(10) # it's just an example, don't use large queries.

    query.strip!
    if query.blank?
      return
    end
    results = Array.new()

    files_srt = Dir.glob("#{Rails.root}/data/srt/*")
    beforeTime = 1
    afterTime = 2
    print "Cerco: " + query
    print "Tempo Before: #{beforeTime}"
    print "Tempo After: #{afterTime}"
    print 'Cerco nei file .srt'
    frase = query
    name = 0
    files_srt.each do |file|
      # print "Cerco in " + file
      openedFile = open(file).readlines()
      currentSentence = ""
      startTime = ''
      endTime = ''
      openedFile.each_with_index do |line, index|
        break if name > 10
        line = line.strip
        if is_sentence(line)
          if is_begin(line)
            currentSentence = line
            # startTime
            i = -1
            while !is_time(openedFile[index + i].strip) do
              i -= 1
            end
            startTime = get_time(openedFile[index + i].strip)[0]
          else
            currentSentence += line
          end
          if is_end(line)
            # endTime
            i = -1
            while !is_time(openedFile[index + i].strip) do
              i -= 1
            end
            endTime = get_time(openedFile[index + i].strip)[1]
            # c'è un a capo
            founded = true
            frase.split(' ').each do |word|
              unless currentSentence.downcase.include? word.downcase
                founded = false
              end
            end
            if founded
              name += 1
              print '~~~TROVATA~~~'
              start = get_seconds_from_time(startTime) - beforeTime
              endTs = get_seconds_from_time(endTime) + afterTime
              # Salvare il file con ffmpeg
              # Darlo come url assoluto (panico)
              comand = "ffmpeg -ss #{start} -strict -2 -to #{endTs} -y -i #{file.gsub '.srt', '.mp4'} #{Rails.public_path}/gifs/#{name}.mp4"
              print(comand)
              system(comand)
              results << {
                type: :mpeg4_gif,
                id: "#{query}-#{name}",
                mpeg4_url: "https://i.pinimg.com/originals/9d/1e/37/9d1e37914b558bb7f01c73489fbdfb4f.gif",
                thumb_url: "http://www.kensap.org/wp-content/uploads/empty-photo.jpg"
              }
              #  ffmpeg -ss 00:01:00 -i input.mp4 -to 00:02:00 -c copy output.mp4
              # -strict -2 probabilmente non è istantaneo come -c copy, ma taglia correttamente
            end
          end
        end
      end
    end

    answer_inline_query results
  end

end
