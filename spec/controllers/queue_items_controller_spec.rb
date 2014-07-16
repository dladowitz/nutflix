require "spec_helper"

describe QueueItemsController do
  let(:user) { users(:james_bond) }

  describe "GET #index" do
    subject { get :index }

    context "for an unauthenticated user" do
      before { subject }

      it "should redirect to the signing page" do
        expect(response).to redirect_to signin_path
      end

    end

    context "for an authenticated user" do
      before { login_as user }

      context "when the user has a queue" do
        it "returns the index template" do
          expect(subject).to render_template :index
        end

        it "finds the correct user" do
          subject
          expect(assigns(:user)).to eq user
        end

        it "finds queue items belonging to only the user" do
          subject
          user_ids = assigns(:queue_items).pluck(:user_id).uniq
          expect(user_ids).to eq [user.id]
          expect(user_ids.count).to eq 1
        end

        it "finds all the queue items for a user" do
          first_qi = queue_items(:james_bond_first_qi)
          second_qi = queue_items(:james_bond_second_qi)
          subject

          expect(assigns(:queue_items)).to match_array [first_qi, second_qi]
        end

        it "orders queue items by 'queue_rank' property" do
          first_qi = queue_items(:james_bond_first_qi)
          second_qi = queue_items(:james_bond_second_qi)
          subject

          expect(assigns(:queue_items).first).to eql first_qi
          expect(assigns(:queue_items).last ).to eql second_qi
        end

        context "when the user doesn't have a queue" do
          let(:user_2) { users(:dr_evil) }
          before do
            login_as user_2
            subject
          end

          it "renders the show template" do
            expect(response).to render_template :index
          end

          it "returns no queue items" do
            subject
            expect(assigns(:queue_items).count).to be 0
          end
        end
      end
    end
  end

  describe "POST #create" do
    let(:video) { videos(:iron_man_2) }
    subject { post :create, user_id: user.id, video_id: video.id }

    context "with an authenticated user" do
      before { login_as user }

      context "when the video is not in the users queue already" do
        it "creates a new queue item in the database" do
          expect { subject }.to change{QueueItem.count}.by(1)
        end

        it "adds the video to the correct users queue" do
          subject
          expect(assigns(:queue_item).user).to eq user
        end

        it "sets the queue rank to the end of the queue" do
          subject
          expect(assigns(:queue_item).queue_rank).to eq user.queue_items.count
        end
      end

      context "when the video is already in the users queue" do
        before { create(:queue_item, user: user, video: video, queue_rank: 10) }

        it "does not create a new queue item" do
          expect { subject }.to_not change{QueueItem.count}
        end

        it "renders the video show page with a notice" do
          subject
          expect(response).to redirect_to video_path video
          expect(flash[:danger]).to eq "Chill, this video is already in your queue."
        end
      end
    end

    context "with an unauthenticated user" do
      it "does not create a new queue_item" do
        expect { subject }.to_not change{QueueItem.count}
      end


      it "redirects to the signin page" do
        expect(subject).to redirect_to signin_path
      end
    end
  end
end
