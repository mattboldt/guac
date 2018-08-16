module GitPa
  class Repo
    def initialize(config, repo)
      @aliases = repo[:branch_aliases]
      @repo = repo
    end

    def name
      @repo[:name]
    end

    def dir
      @repo[:dir]
    end

    def branch_alias(branch)
      if @aliases
        branch_alias = @aliases[branch]
        branch_alias || branch
      else
        branch
      end
    end
  end
end
