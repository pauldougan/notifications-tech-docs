require 'app/client_docs'
require 'app/external_doc'
require 'lib/unique_identifier_generator'
require 'lib/unique_identifier_extension'
require 'lib/tech_docs_html_renderer'

###
# Page options, layouts, aliases and proxies
###

set :markdown_engine, :redcarpet
set :markdown,
    renderer: TechDocsHTMLRenderer.new(
      with_toc_data: true
    ),
    fenced_code_blocks: true,
    tables: true,
    no_intra_emphasis: true

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

ClientDocs.pages.each do |page|
  proxy "/#{page.client}.html", "client_template.html", locals: {
    repo: page.repository
  }, ignore: true
end

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :autoprefixer
activate :sprockets
activate :syntax

###
# Helpers
###

helpers do
  require 'table_of_contents/helpers'
  include TableOfContents::Helpers
end

configure :build do
  activate :minify_css
  activate :minify_javascript
end

###
# Tech Docs-specific configuration
###

config[:tech_docs] = YAML.load_file('config/tech-docs.yml')
                         .with_indifferent_access

activate :unique_identifier
