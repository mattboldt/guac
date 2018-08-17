RSpec.describe "`guac up` command", type: :cli do
  it "executes `guac help up` command successfully" do
    output = `guac help up`
    expected_output = <<-OUT
Usage:
  guac up

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
