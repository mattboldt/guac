module GitPa
  class Repo
    def initialize(config, repo)
      @aliases = config[:branch_aliases]
      @repo = repo
    end

    def name
      @repo
    end

    def branch_alias(branch)
      branch_alias = @aliases.find { |a| a['name'] == @repo }
      if branch_alias
        branches = branch_alias['branches']
        branches[0] == branch ? branches[1] : branch
      else
        branch
      end
    end
  end
end
