RSpec.describe "`guac status` command", type: :cli do
  xit "executes `guac help status` command successfully" do
    output = `guac help status`
    expected_output = <<-OUT
Usage:
  guac status

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
