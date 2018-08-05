module GitPa
  class Repo
    def initialize(config, repo)
      @aliases = config[:branch_aliases]
      @repo = repo
    end

    def name
      @repo.split('/').last
    end

    def dir
      @repo
    end

    def branch_alias(branch)
      branch_alias = @aliases.find { |a| a['name'] == name }
      if branch_alias
        branches = branch_alias['branches']
        branches[0] == branch ? branches[1] : branch
      else
        branch
      end
    end
  end
end
