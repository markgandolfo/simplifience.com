module Jekyll
	module AdditionalFilters
		def keys(hash)
			hash.keys
		end
		def contains(list, value)
			return list && (list.include? value)
		end
		def page(title)
			found = @context.registers[:site].posts.find do |post|
				post.data['title'] == title
			end
			found && found.url
		end
	end
end

Liquid::Template.register_filter(Jekyll::AdditionalFilters)
