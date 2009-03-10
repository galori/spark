module Spark 
	module Mixins
		def random_paragraph(count=5,min_sentences=1,max_sentences=5,min_words=3,max_words=10)
			sentences = (1..count).inject([]) {|a,_| a << random_sentence(rand(max_sentences)+min_sentences+1,min_words,max_words)}
			sentences.join('.  ')
		end

		def random_sentence(count=5,min_words=3,max_words=10)
			words = (1..count).inject([]) {|a,_| a << random_word(rand(max_words-min_words+1)+min_words)}
			words.join(' ')
		end

		def random_word(length=6)
		  chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789'
		  text = ''
		  length.downto(1) { |i| text << chars[rand(chars.length - 1)].chr }
		  text
		end
		
		def random_name
		  "#{random_first_name} #{random_last_name}"
	  end
	  
	  def random_first_name
	    @@male_first_names ||= read_lines_from_name_file 'male.first'
	    @@female_first_names ||= read_lines_from_name_file 'female.first'
	    random_entry_from(rand(2) ? @@male_first_names : @@female_first_names).downcase.capitalize
    end
    
    def random_last_name
      @@last_names ||= read_lines_from_name_file 'all.last'
      random_entry_from(@@last_names).downcase.capitalize
    end

		def random_email
			"#{random_first_name[0].chr}#{random_last_name}#{random_number}@#{['test','example'][rand(2)]}.#{['com','net','org'][rand(3)]}"
		end
		
    def sequential_number(ident) # hash of hashes, each held hash defaults to one
      @sequentials ||= Hash.new { |hash,key| hash[key] = 1 }
      @sequentials[ident.to_sym] += 1
    end

    def random_number
      rand(32767)+1
    end
    
    private
      def read_lines_from_name_file(which)
        File.readlines(File.join(File.split(__FILE__).first,'../data/',"dist.#{which}")).map do |line|
          line =~ /^(\w+)\s/; $1 
        end
      end
      
      def random_entry_from(lines)
        lines[rand(lines.length)]
      end
      
      # def random_name_from(lines)
      #   # $/ = "%\n"
      #   srand
      #   line = file.each do |line|
      #     break line if rand($.) < 1
      #   end
      #   line =~ /^(\w+)\s/
      #   $1
      # end
      
	end
end