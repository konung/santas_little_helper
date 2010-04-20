# SantasLittleHelper

# SYSTEM WIDE

# Determines if Windows platform or not. This will match all windows systems known to me (author). If you find otherwise let me know please.
def windows?
  # Can't match for just 'win' cause it will match darwin as well.
  (/win32|mswin|mingw/).match(RUBY_PLATFORM) ? true : false
end

# Works on Debian and Ubuntu, don't have anything else to test on.
def linux?
  (/linux/).match(RUBY_PLATFORM) ? true : false
end

# Works on my MacBook Pro, don't have anything else to test on,
def mac?
  (/darwin/).match(RUBY_PLATFORM) ? true : false
end

# When something is True / False and I can to_s it, why can't I to_i it?
# There is actually a good theoretical reason, but in real world it really helps if you can output true or false as an int when you are sending soap request to a client, whose api requires it as 1 or 0.
# For an alternative solution check out http://www.ruby-forum.com/topic/206789#new

class TrueClass
  def to_i
    1
  end
end
class FalseClass
  def to_i
    0
  end
end

