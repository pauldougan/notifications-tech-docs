require 'faraday'

class ExternalDoc
  def self.fetch(repository:, branch: "master", file: "documentation")

    url = "https://raw.githubusercontent.com/#{repository}/#{branch}/#{file}.md"

    response = Faraday.get(url)

    response.body.force_encoding("UTF-8")
  end
end
