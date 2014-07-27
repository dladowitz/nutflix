require "spec_helper"

describe RelationshipsController do
  let(:james_bond) { users(:james_bond) }
  let(:dr_evil)    { users(:dr_evil)    }

  before  { login_user james_bond }

  describe "POST #create" do
    subject { post :create, followed_user_id: dr_evil.id }

    it_behaves_like "requires signin without an authenticated user" do
      let(:http_request) { subject }
    end

    it "creates a relationship between two users" do
      expect { subject }.to change{Relationship.count}.by 1
    end

    it "does not create the same relationship twice" do
      post :create, followed_user_id: dr_evil.id

      expect { subject }.to_not change{Relationship.count}
    end

    it "does not allow the same user to be both sides of a relationship" do
      expect { post :create, followed_user_id: current_user.id }.to_not change{Relationship.count}
    end
  end

  describe "GET #index" do
    subject { get :index }

    it_behaves_like "requires signin without an authenticated user" do
      let(:http_request) { subject }
    end

    it "finds all people the current user is following" do
      subject
      expect(assigns(:relationships)).to match_array james_bond.followed_user_relationships
    end
  end
end


