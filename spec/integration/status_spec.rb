RSpec.describe "`git_pa status` command", type: :cli do
  it "executes `git_pa help status` command successfully" do
    output = `git_pa help status`
    expected_output = <<-OUT
Usage:
  git_pa status

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
