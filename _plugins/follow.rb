def contains(config, title)
	return false unless config and title
	if config.kind_of?(Array)
		config.include? title
	else
		config == title
	end
end

module Jekyll
	module PageFilters
		def followers(page)
			@context.registers[:site].posts.select do |post|
				contains(post.data['follows'], page['title'])
			end
		end

		def following(page)
			@context.registers[:site].posts.select do |post|
				contains(page['follows'], post.data['title'])
			end
		end

		def page(title)
			post = @context.registers[:site].posts.find do |post|
				post.data['title'] == title
			end
			p "post is ", post
			post ? post.url : "/stub.html"
		end
	end
end

Liquid::Template.register_filter(Jekyll::PageFilters)
