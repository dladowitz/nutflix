require "spec_helper"

describe Admin::VideosController do
  describe "GET #new" do
    let(:non_admin_user) {users(:james_bond)}
    let(:admin_user)     {users(:admin)}
    subject { get :new }

    context "with an admin user" do
      before do
        login_user admin_user
        subject
      end

      it "renders the index template" do
        expect(response).to render_template :new
      end
    end

    context "with an non admin user" do
      before do
        login_user non_admin_user
        subject
      end

      it "redirects to the videos_path" do
        expect(response).to redirect_to videos_path
      end
    end

    context "with a guest" do
      it_behaves_like "requires signin without an authenticated user" do
        let(:http_request)        { subject }
      end
    end
  end

  describe "POST #create" do
    let(:s3_url) {" https://s3-us-west-1.amazonaws.com/nutflix/video_files/enemy_cat.mp4" }
    subject { post :create, video: {title: "Oceans 11", category_id: 2, description: "casino games", video_url: s3_url} }

    context "with an admin user" do
      before { login_user users(:admin) }

      it "creates a new video in the database" do
        expect { subject }.to change{Video.count}.by 1
      end

      it "sets the video url correctly" do
        subject
        video = Video.find_by_title "Oceans 11"
        expect(video.video_url).to eq s3_url
      end

      it "redirects to the video page" do
        subject
        video = assigns(:video)
        expect(response).to redirect_to video
      end
    end

    context "with a non admin user" do
      before { login_user }

      it_behaves_like "redirects with an authenticated user" do
        let(:http_request)      { subject }
        let(:authenticated_path){ videos_path }
      end
    end

    context "with a guest" do
      it_behaves_like "requires signin without an authenticated user" do
        let(:http_request)        { subject }
      end
    end
  end
end
