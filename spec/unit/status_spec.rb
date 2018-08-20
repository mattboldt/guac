require 'guac/commands/status'

RSpec.describe Guac::Commands::Status do
  xit "executes `status` command successfully" do
    output = StringIO.new
    options = {}
    command = Guac::Commands::Status.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
