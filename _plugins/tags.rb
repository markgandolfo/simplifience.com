module Jekyll
	class TagPage < Page
		def initialize(site, base, dir, tag)
			@site = site
			@base = base
			@dir = dir
			@name = "#{tag}.html"
			self.process(@name)
			self.read_yaml(File.join(base, '_layouts'), 'tag_page.html')
			self.data['tag'] = tag
			title_prefix = site.config['tag_title_prefix'] || ''
			title_suffix = site.config['tag_title_suffix'] || ''
			title_tag = (site.config['tag_title_capitalize'] == false ?
					tag : tag.capitalize)
			self.data['title'] = "#{title_prefix}#{title_tag}#{title_suffix}"
		end
	end

	class TagGenerator < Generator
		def generate(site)
			if site.layouts.key? 'tag_page'
				dir = site.config['tag_dir'] || 'tag'
				site.tags.keys.each do |tag|
					write_tag_page(site, dir, tag)
				end
			end
		end
		def write_tag_page(site, dir, tag)
			page = TagPage.new(site, site.source, dir, tag)
			page.render(site.layouts, site.site_payload)
			page.write(site.dest)
			site.pages << page
		end
	end

	module TagFilters
		def tagged(posts, tag)
			posts.select{|post| post.tags.include? tag}
		end
	end
end

Liquid::Template.register_filter(Jekyll::TagFilters)
