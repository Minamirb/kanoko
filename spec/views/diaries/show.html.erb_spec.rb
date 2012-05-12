require 'spec_helper'

describe "diaries/show" do
  before(:each) do
    @diary = assign(:diary, stub_model(Diary))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
