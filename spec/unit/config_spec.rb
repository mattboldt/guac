require 'git_pa/commands/config'

RSpec.describe GitPa::Commands::Config do
  it "executes `config` command successfully" do
    output = StringIO.new
    options = {}
    command = GitPa::Commands::Config.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
