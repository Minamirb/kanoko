require 'spec_helper'

describe "diaries/index" do
  before(:each) do
    assign(:diaries, [
      stub_model(Diary),
      stub_model(Diary)
    ])
  end

  it "renders a list of diaries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
