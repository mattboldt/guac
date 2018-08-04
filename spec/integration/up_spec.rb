RSpec.describe "`git_pa up` command", type: :cli do
  it "executes `git_pa help up` command successfully" do
    output = `git_pa help up`
    expected_output = <<-OUT
Usage:
  git_pa up

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
