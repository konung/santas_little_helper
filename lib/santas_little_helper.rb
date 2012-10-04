# SantasLittleHelper

# SYSTEM WIDE

# Determines if Windows platform or not. This will match all windows systems known to me (author). If you find otherwise let me know please.
# There is one pitful - if you are running on jruby - it returns "java", as supposedly it it is platform independent. So if you are checking
# for os and running jruby - it will return false, since it won't match. You should use it in conjunction with jruby? & mri? if you are 
# unticipating that to be a problem. I'm not defining java? as it may cause problems with jruby potentially.
# Not really worried about maglev & rubinius & ironruby right now - as they are not really mutiplatform, not as widespread and I can't test for 
# them right now.

# Works on Windows XP, 2003, 7 running Ruby 1.8.6 & 1.8.7 installed from RubyInstaller
def windows?
  # Can't match for just 'win' cause it will match darwin as well.
  (/win32|mswin|mingw/).match(RUBY_PLATFORM) ? true : false
end

# Works on Debian Sarge & Lenny and Ubuntu 9.10 running REE 1.8.7, don't have anything else to test on.
def linux?
  (/linux/).match(RUBY_PLATFORM) ? true : false
end

# Works on my MacBook Pro OS 10.6 running Ruby 1.8.7 and rvm version of 1.9.1 , don't have anything else to test on,
def mac?
  (/darwin/).match(RUBY_PLATFORM) ? true : false
end



# I test and deploy some of the project on jruby - this makes it easier to customize my gemfiles.
# Works for ruby 1.8.7 & 1.9.3 & 1.9.2 on windows( 7 & xp) & linux ( debian Lenny)  using rubyinstaller for windows and using mri ruby buillt from source for linux
# Works for jruby 1.7.0.rc1 and jruby 1.6.3 on windows (7 & xp)
def jruby?
  (/java/).match(RUBY_PLATFORM) ? true : false
end  

def mri?
  (/i386|x86_64|x86/).match(RUBY_PLATFORM) ? true : false
end


# In case ruby ever reaches version 19 :-) or some 2.19 :-) only matching 1.9 at the begining of the line 
def version_1_9?
  (/^1.9./).match(RUBY_VERSION) ? true : false
end

def version_1_8?
  (/^1.8./).match(RUBY_VERSION) ? true : false
end


# When something is True / False and I can to_s it, why can't I to_i it?
# There is actually a good theoretical reason, but in real world it really helps if you can output true or false as an int when you are sending soap request to a client, whose api requires it as 1 or 0, or humanize to "yes" & "no" form.
# For an alternative solution check out http://www.ruby-forum.com/topic/206789#new

class TrueClass
  # Rails conventions for boolean / tinyint
  def to_i
    1
  end
  
  # Humanize. to_s returns "true"
  def to_h
    "yes"
  end
  
  # Really I need to spell it out to you?
  def to_teenager
    "Yeah, yeah. Here you go. Did you get what you came for? Now disappear."
  end  
end
class FalseClass
  # Rails conventions for boolean / tinyint
  def to_i
    0
  end
  # Humanize. to_s returns "false".
  def to_h
    "no"
  end
  # Little obnoxious teenager.
  def to_teenager
    "Can't you leave me alone? I don't have anything!"
  end   
end
class NilClass
  # Since in if/else nil is interpreted as false, return same as false.
  def to_i
    0
  end

  # Humanize. to_s returns "" as well, this is really to be consistent with other classes.
  def to_h
    ""
  end
  
  # A very rude teenager nihilist.
  def to_teenager
    "Zip! Nada! Babkis! Nothing to see here! Get out of my room!"
  end   
end
