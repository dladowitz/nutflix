require "spec_helper"

describe JavascriptTestsController, "GET #show" do
  subject { get :show }

  it "renders the show template" do
    expect(subject).to render_template :show
  end

  it "returns success" do
    expect(subject.response).to eq 200
  end
end
