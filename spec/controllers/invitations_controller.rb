require "spec_helper"

describe InvitationsController do
  describe "GET #new" do
    subject { get :new }

    it "renders the new template" do
      expect(subject).to render_template :new
    end
  end
end
