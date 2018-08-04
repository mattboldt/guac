RSpec.describe "`git_pa config` command", type: :cli do
  it "executes `git_pa help config` command successfully" do
    output = `git_pa help config`
    expected_output = <<-OUT
Usage:
  git_pa config

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
