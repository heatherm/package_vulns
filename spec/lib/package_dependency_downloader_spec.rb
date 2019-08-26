require "rails_helper"
require "package_dependency_downloader"

RSpec.describe PackageDependencyDownloader do
  describe "#download" do
    it "should use a simpler download method with needs_js: false" do
      VCR.use_cassette "page_downloader/download/express", record: :once do
        downloader = PackageDependencyDownloader.new("express", "4.17.1")
        dependency_json = downloader.get

        expect(dependency_json).to include(
          "accepts" => "~1.3.7",
            "array-flatten" => "1.1.1",
            "body-parser" => "1.19.0",
            "statuses" => "~1.5.0",
            "type-is" => "~1.6.18",
            "utils-merge" => "1.0.1",
            "vary" => "~1.1.2"
        )
      end
    end
  end
end
