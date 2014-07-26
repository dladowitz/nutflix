require "spec_helper"

describe UsersController do
  describe "GET 'new'" do
    subject{ get :new }

    before { subject }
    it "renders the new page" do
      expect(response).to render_template :new
    end

    it "returns http success" do
      expect(response).to be_success
    end

    it "creates a new user" do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe "POST 'create'" do
    context "with valid input for all fields" do
      subject { post :create, user: {email_address: "tony@stark_labs.com", password: "the_mandarin", full_name: "Tony Stark" } }
      before { subject }

      it "returns http 302 redirect" do
        expect(response.status).to eq 302
      end

      it "redirects to the signin page" do
        expect(response).to redirect_to signin_path
      end

      it "creates a user in the database" do
        expect(assigns(:user)).to eq User.find_by_email_address("tony@stark_labs.com")
      end
    end

    context "with invalid inputs" do
      subject { post :create, user: { email_address: nil, password: nil, full_name: nil } }

      it "renders the new template" do
        expect(subject).to render_template :new
      end

      it "sets @user" do
        subject
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "should not create a record in the database" do
        expect { subject }.to_not change{User.count}
      end
    end
  end

  describe "GET 'show'" do
    let(:user_1) { users(:dr_evil) }
    let(:user_2) { users(:james_bond) }
    subject { get :show, id: user_2.id }

    it_behaves_like "requires signin without an authenticated user" do
      let(:http_request)        { subject }
    end

    context "with an authenticated user" do
      before do
        login_user user_1
        subject
      end

      it_behaves_like "renders template with an authenticated user" do
        let(:http_request)           { subject }
        let(:authenticated_template) { :show }
      end

      it "finds all the users reviews" do
        reviews = user_2.reviews
        expect(assigns(:reviews).count).to eq reviews.count
      end

      it "finds all the videos the users queue" do
        queue_items = user_2.queue_items
        expect(assigns(:queue_items).count).to eq queue_items.count
      end


    end

  end
end
