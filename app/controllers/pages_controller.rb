require "package_dependency_downloader"
require "package_dependency_decorator"

class PagesController < ApplicationController
  def root
  end

  def search
    dependencies = ::PackageDependencyDownloader.get(params[:package], params[:version])
    if dependencies
      decorated_dependencies = ::PackageDependencyDecorator.transform(dependencies)
      render js: "$('#dependencies').treeview({data:#{decorated_dependencies.to_json}});"
    else
      render js: "$('#dependencies').html('No data found.');"
    end
  end
end
