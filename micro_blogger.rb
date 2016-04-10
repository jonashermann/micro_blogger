require 'jumpstart_auth'
class MicroBlogger
  attr_reader :client

    def initialize
    	puts"Initializing MicroBlogger"
    	@client = JumpstartAuth.twitter
    end

    def tweet(message)
        if message.length < 140 || message.length == 140
    	@client.update(message)
        else
            print "Your tweet is too long"
        end    
    end

    def run
    	command = ""
    	while command != "q"
    		printf"enter command: "
            input = gets.chomp
            parts = input.split(" ")
            command = parts[0]
            case command
              when "q" then puts "Goodbye!"
              when "dm" then dm(parts[1], parts[2..-1].join(" "))  
              when "t" then tweet(parts[1..-1].join(" "))
              when "spam" then spam_my_followers(parts[1..-1].join(" "))
              when "elt" then everyones_last_tweet
              when "s" then shorten(parts[-1])
              when "turl" then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))    
              else
               puts "Sorry, I don't know how to #{command}"
            end
        end
    end

    def dm(target, message)
        puts "Trying to send #{target} this direct message"
        puts message
        message = "d @#{target} #{message}"
        screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name}
        if screen_names.include?target
            tweet(message)
        else
            print "Sorry i can only DM my followers!"    
        end
        
    end

    def followers_list
        screen_names = Array.new
        @client.followers.each {| follower| screen_names << @client.user(follower).screen_name}
        return screen_names
    end

    def spam_my_followers(message)
        list = followers_list
        list.each { |follower| dm(follower, message)}
    end

    def everyones_last_tweet
        friends = @client.friends.sort_by {|elt| elt.friend.screen_name.downcase}
        friends.each do |friend|
            last_tweet = friend.status.source
            timestamp = friend.status.created_at
            print "#{friend.screen_name}\t"
            print "#{last_tweet}\t"
            print "#{timestamp.strftime("%A, %b %d")}"
            puts ""
        end
    end

    def shorten(original_url)
        require 'bitly'
        Bitly.use_api_version_3
        bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
        puts "Shortening this URL: #{original_url}"
        return original_url.short_url
    end
end

