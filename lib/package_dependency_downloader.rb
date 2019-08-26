require "http"
require "oj"

class PackageDependencyDownloader
  attr_reader :url

  def initialize(package_name, version_or_tag)
    @url = "https://registry.npmjs.org/#{package_name}/#{version_or_tag}"
  end

  def self.get(*args)
    new(*args).get
  end

  def get
    Oj.load(HTTP.get(url)).dig("dependencies")
  end
end
