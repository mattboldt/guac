require 'guac/commands/config'

RSpec.describe Guac::Commands::Config do
  xit "executes `config` command successfully" do
    output = StringIO.new
    options = {}
    command = Guac::Commands::Config.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
