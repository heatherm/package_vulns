require "rails_helper"
require "package_dependency_decorator"

RSpec.describe PackageDependencyDecorator do
  let(:npm_response) { { "accepts": "~1.3.7", "array-flatten": "1.1.1", "body-parser": "1.19.0" } }

  it "prepares a structure for bootstrap-treeview" do
    result = PackageDependencyDecorator.transform(npm_response)
    expect(result).to eq([{ nodes: [], text: "accepts, ~1.3.7" },
                          { nodes: [], text: "array-flatten, 1.1.1" },
                          { nodes: [], text: "body-parser, 1.19.0" }])
  end
end
