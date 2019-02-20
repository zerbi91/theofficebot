module TimeHelper
  def get_time(timeString)
    times = timeString.split(' --> ')
    return [times[0].split(',')[0], times[1].split(',')[0]]
  end

  def time_difference_in_seconds(minor, major)
    minorTimes = minor.split(':')
    majorTimes = major.split(':')
    seconds_difference = (majorTimes[2]).to_i - (minorTimes[2]).to_i
    minutes = 0
    while seconds_difference < 0 do
      minutes += 1
      seconds_difference += 60
    end
    return seconds_difference
  end

  def get_seconds_from_time(time)
    times = time.split(':')
    return (times[0]).to_i * 60 * 60 + (times[1]).to_i * 60 + (times[2]).to_i
  end

  def is_time(timeString)
    return (timeString.split(' --> ')).length == 2
  end

  def is_sentence(sentence)
    if is_time(sentence)
      return false
    end
    if sentence == '' or sentence == '\n'
      return false
    end
    if is_number?(sentence)
      return false
    end
    return true
  end

  def is_begin(sentence)
    startSentence = ['"', '-']
    return /[[:upper:]]/.match(sentence[0]) || startSentence.include?(sentence[0])
  end

  def is_end(sentence)
    endSentence = ['.', '!', '?']
    return endSentence.include?(sentence[-1])
  end

  def is_number? string
    true if Float(string) rescue false
  end

end
