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
    results = Array.new(5) do |i|
      {
        type: :mpeg4_gif,
        id: "#{query}-#{i}",
        mpeg4_url: "https://i.pinimg.com/originals/9d/1e/37/9d1e37914b558bb7f01c73489fbdfb4f.gif",
        thumb_url: "TBI",
        description: "#{Rails.root}/data/srt/*"
      }
    end

    # files_srt = Dir.glob("#{Rails.root}/data/srt/*")

    # files_srt.eahc do |file|
    #   p file
    #   openedFile
    # end

    # print "Cerco: " + frase
    # print "Tempo Before: " + str(beforeTime)
    # print "Tempo After: " + str(afterTime)
    # print 'Cerco nei file .srt'
    # all_files = glob.glob('burned/*.srt')
    # name = 0
    # for file in all_files:
    #   print "Cerco in " + file
    #   openedFile = open(file).readlines()
    #   currentSentence = ""
    #   startTime = ''
    #   endTime = ''
    #   for index in xrange(0, len(openedFile)):
    #     line = openedFile[index]
    #     line = line.replace('\n', '')
    #     if Helper.is_sentence(line):
    #       if Helper.is_begin(line):
    #         currentSentence = line
    #         # startTime
    #         i = -1
    #         while not Helper.is_time(openedFile[index + i]):
    #           i -= 1
    #         startTime = Helper.get_time(openedFile[index + i])[0]
    #       else:
    #         currentSentence += line
    #       if Helper.is_end(line):
    #         # endTime
    #         i = -1
    #         while not Helper.is_time(openedFile[index + i]):
    #           i -= 1
    #         endTime = Helper.get_time(openedFile[index + i])[1]
    #         # c'è un a capo
    #         founded = True
    #         for word in frase.split(' '):
    #           if not word.lower() in currentSentence.lower():
    #             founded = False
    #         if founded:
    #           name += 1
    #           # print '~~~TROVATA~~~'
    #           # print startTime
    #           # print currentSentence
    #           # print endTime
    #           start = Helper.get_seconds_from_time(startTime) - beforeTime
    #           end = Helper.get_seconds_from_time(endTime) + afterTime
    #           comand = "ffmpeg " + " -ss " + str(start) + " -strict -2 " + " -to " + str(end) + " -i " + file.replace('.srt', '.mp4') + " " + str(name) + ".mp4"
    #           # print(comand)
    #           system(comand)
    #           #  ffmpeg -ss 00:01:00 -i input.mp4 -to 00:02:00 -c copy output.mp4
    #           # -strict -2 probabilmente non è istantaneo come -c copy, ma taglia correttamente


    answer_inline_query results
  end

end
