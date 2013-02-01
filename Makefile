STYLES = $(shell find stylus -name "*.styl")
GENERATEDCSS = $(patsubst stylus/%.styl,css/%.css,$(STYLES))

COFFEES = $(shell find coffee -name "*.coffee")
GENERATEDJS = $(patsubst coffee/%.coffee,js/%.js,$(COFFEES))

watchers:
	stylus -o css/ -w stylus/ &
	coffee -o js/ -w coffee/ &
	jekyll --server --auto --pygments --no-lsi --kramdown &

clean:
	rm -f $(GENERATEDCSS) $(GENERATEDJS)
