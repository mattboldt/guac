RSpec.describe "`guac config` command", type: :cli do
  xit "executes `guac help config` command successfully" do
    output = `guac help config`
    expected_output = <<-OUT
Usage:
  guac config

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
