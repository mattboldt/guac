require 'guac/commands/setup'

RSpec.describe Guac::Commands::Setup do
  xit "executes `setup` command successfully" do
    output = StringIO.new
    options = {}
    command = Guac::Commands::Setup.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
