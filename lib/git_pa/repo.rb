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
      branch_config = @aliases.find { |a| a['name'] == name }
      if branch_config
        branch_alias = branch_config[branch]
        branch_alias || branch
      else
        branch
      end
    end
  end
end
