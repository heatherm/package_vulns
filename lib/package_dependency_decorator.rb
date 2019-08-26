class PackageDependencyDecorator
  attr_reader :dependencies

  def initialize(dependencies)
    @dependencies = dependencies
  end

  def self.transform(*args)
    new(*args).convert_to_tree
  end

  def convert_to_tree
    dependencies.keys.each_with_object([]) do |k, a|
      a << { text: "#{k}, #{dependencies[k]}", nodes: [] }
    end
  end
end
