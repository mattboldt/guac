require 'guac/commands/up'

RSpec.describe Guac::Commands::Up do
  xit "executes `up` command successfully" do
    output = StringIO.new
    options = {}
    command = Guac::Commands::Up.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
