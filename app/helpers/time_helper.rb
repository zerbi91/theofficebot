module TimeHelper
  def get_time(timeString):
    times = timeString.split(' --> ')
    return [times[0].split(',')[0], times[1].split(',')[0]]
  end

  def time_difference_in_seconds(minor, major):
    minorTimes = minor.split(':')
    majorTimes = major.split(':')
    seconds_difference = int(majorTimes[2]) - int(minorTimes[2])
    minutes = 0
    while seconds_difference < 0:
      minutes += 1
      seconds_difference += 60
    return seconds_difference
  end

  def get_seconds_from_time(time):
    times = time.split(':')
    return int(times[0]) * 60 * 60 + int(times[1]) * 60 + int(times[2])
  end

  def is_time(timeString):
    return len(timeString.split(' --> ')) == 2
  end

  def is_sentence(sentence):
    if Helper.is_time(sentence):
      return False
    if sentence == '' or sentence == '\n':
      return False
    if sentence.isdigit():
      return False
    return True
  end

  def is_begin(sentence):
    startSentence = ['"', '-']
    return sentence[0].isupper() or sentence[0] in startSentence
  end

  def is_end(sentence):
    endSentence = ['.', '!', '?']
    return sentence[-1] in endSentence
  end
end
