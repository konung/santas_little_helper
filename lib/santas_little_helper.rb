# SantasLittleHelper

# SYSTEM WIDE

# Determines if Windows platform or not. This will match all windows systems known to me (author). If you find otherwise let me know please.
# There is one pitful - if you are running on jruby - it returns "java", as supposedly it it is platform independent. So if you are checking
# for os and running jruby - it will return false, since it won't match. You should use it in conjunction with jruby? & mri? if you are
# unticipating that to be a problem. I'm not defining java? as it may cause problems with jruby potentially.
# Not really worried about maglev & rubinius & ironruby right now - as they are not really mutiplatform, not as widespread and I can't test for
# them right now.


def ruby_platform
  case RUBY_PLATFORM
    when /win32|mswin|mingw/
      # Works on Windows XP, 2003, 7, 8 running Ruby 1.8.6 & 1.8.7, 1.9.2, 1.9.3 & 2.0.0 installed from RubyInstaller
      # Can't match for just 'win' cause it will match darwin as well.
      'windows'
    when /linux/
      # Works on Debian Sarge, Lenny & Wheezy and Ubuntu 9.10 running REE 1.8.7 & MRI 2.0.0 32-bit & 64-bit, don't have anything else to test on.
      'linux'
    when /darwin/
      # Works on my MacBook Pro OS 10.6 running Ruby 1.8.7 and .rbenv version of 1.9.3 & 2.0.0 , don't have anything else to test on,
      'mac'
    else
      nil
  end
end

def ruby_platform?(os='')
  # Takes a string or a method like so platform?(:windows)
  os.to_s.match(ruby_platform) ? true : false
end

# These are just aliases for convinience, I really doubt somebody would use them System Wide on an object for any other purpose.
def windows?
  ruby_platform?(:windows)
end
def linux?
  ruby_platform?(:linux)
end
def mac?
  ruby_platform?(:mac)
end



# I test and deploy some of the project on jruby - this makes it easier to customize my gemfiles.
# Works for ruby 1.8.7 & 1.9.3 & 1.9.2 on windows( 7 & xp) & linux ( debian Lenny)  using rubyinstaller for windows and using mri ruby buillt from source for linux
# Works for jruby 1.7.0.rc1 and jruby 1.6.3 on windows (7 & xp)
# At this point it's essentially just an alias fro platform & platform?, since it queries RUBY_PLATFORM, but this may change in the future
# In the future I may start using RUBY_ENGINE
def ruby_implementation
  case RUBY_ENGINE
    when /java/
      'jruby'
    when /ruby/
      # I'm actually not sure what rubinius or maglev or other implementions would return. I don't use rubies, other than mri or jruby.
      'mri'
    else
      nil
  end
end
def ruby_implementation?(written_in='')
  written_in.to_s.match(ruby_implementation) ? true : false
end
def jruby?
  ruby_implementation?(:jruby)
end
def mri?
  ruby_implementation?(:mri)
end


# In case ruby ever reaches version 19 :-) or some 2.19 :-) only matching 1.9 at the begining of the line
# Returns an integer for easy version comparison 200 > 187 ( Version two is newer :-) )
# if ruby_version > 187 , install new version of the gem.
def ruby_version
  RUBY_VERSION.gsub(/[^0-9]/,'').to_i
end
def ruby_version?(version_to_check)
  # Be careful - this will only match up to minor release. It will not match patch versions.
  # You can ask it things in the following formats ruby_version?(1), ruby_version?(1.8), ruby_version?('200')
  version_to_check = version_to_check.to_s.gsub(/[^0-9]/,'')
  RUBY_VERSION.gsub(/[^0-9]/,'')[0..(version_to_check.size-1)] == version_to_check[0..(version_to_check.size-1)]
end




# When something is True / False and I can to_s it, why can't I to_i it?
# There is actually a good theoretical reason, but in real world it really helps if you can output true or false
# as an int when you are sending soap request to a client, whose api requires it as 1 or 0, or humanize to "yes" & "no" form
# since users apperently are not good at understaning what true or false means in some context.
# Also why this can be done at a presentation level, when you are trying to create a meta method to handle complex objects
# this is much more convinient and readable.
# For an alternative solution check out http://www.ruby-forum.com/topic/206789#new


class TrueClass
  # Rails conventions for boolean / tinyint
  def to_i
    1
  end

  # Humanize. to_s returns "true"
  def to_human
    "yes"
  end

  # Really?! Do I need to spell it out to you?
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
  def to_human
    "no"
  end

  # Little obnoxious teenager.
  def to_teenager
    "No means no!!! Can't you leave me alone?"
  end
end
class NilClass
  # Since in if/else nil is interpreted as false, return same as false.
  def to_i
    0
  end

  # Humanize. to_s returns "" as well, this is really to be consistent with other classes.
  def to_human
    ""
  end

  # A very rude teenager nihilist.
  def to_teenager
    "Zip! Nada! Babkis! Nothing to see here! Get out of my room!"
  end
end
class String
  # See http://stackoverflow.com/questions/8119970/string-true-and-false-to-boolean
  # In this context empty string is nil which is the same as false
  def to_boolean
    !!(self =~ /^(true|t|yes|y|1)$/i)
  end
  def to_human
    self.to_s
  end
  def to_teenager
    "What did you say to me? What? #{self.to_human}"
  end
end
class Fixnum
  # Same idea as string: 1 or any number (positive) is true, 0 or negative number is false
  def to_boolean
    if self <= 0
      false
    else
      true
    end
  end
  def to_human
    self.to_s
  end
  def to_teenager
    "I'm not good with whole numbers! I don't like math! Take your #{self.to_human} and go bother someone else!"
  end
end
class Float
  # Same idea as string: 1 or any number (positive) is true, 0 or negative number is false
  def to_boolean
    if self <= 0
      false
    else
      true
    end
  end
  def to_human
    self.to_s
  end
  def to_teenager
    "I told you I'm not good with whole numbers, what makes you think, I'm good with with fractions like this?  #{self.to_human}"
  end
end