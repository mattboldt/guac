require 'git_pa/commands/status'

RSpec.describe GitPa::Commands::Status do
  it "executes `status` command successfully" do
    output = StringIO.new
    options = {}
    command = GitPa::Commands::Status.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
