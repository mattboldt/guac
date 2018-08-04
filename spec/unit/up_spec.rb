require 'git_pa/commands/up'

RSpec.describe GitPa::Commands::Up do
  it "executes `up` command successfully" do
    output = StringIO.new
    options = {}
    command = GitPa::Commands::Up.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
