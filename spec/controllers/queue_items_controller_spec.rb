require "spec_helper"

describe QueueItemsController do
  let(:user) { users(:james_bond) }

  shared_examples "unauthenticated_access to the queue" do
    it "does not add or delete queue_items" do
      expect { subject }.to_not change{QueueItem.count}
    end

    it "redirects to the signin page" do
      expect(subject).to redirect_to signin_path
    end
  end

  describe "GET #index" do
    subject { get :index }

    it_behaves_like "unauthenticated_access to the queue"

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
          first_qi = queue_items(:james_bonds_first_qi)
          second_qi = queue_items(:james_bonds_second_qi)
          subject

          expect(assigns(:queue_items)).to match_array [first_qi, second_qi]
        end

        it "orders queue items by 'queue_rank' property" do
          first_qi = queue_items(:james_bonds_first_qi)
          second_qi = queue_items(:james_bonds_second_qi)
          subject

          expect(assigns(:queue_items).first).to eql first_qi
          expect(assigns(:queue_items).last ).to eql second_qi
        end
      end

      context "when the user doesn't have any queued items" do
        let(:user_2) { users(:fat_bastard) }
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

  describe "POST #create" do
    let(:video) { videos(:iron_man_2) }
    subject { post :create, video_id: video.id }

    it_behaves_like "unauthenticated_access to the queue"

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

  end

  describe "PATCH #update" do
    subject { patch :update }

    context "with an unauthenticated user" do
      it_behaves_like "unauthenticated_access to the queue"
    end

    context "with an authenticated user" do
      before do
        login_as user
      end

      it "redirects to the index page" do
        expect(subject).to redirect_to queue_path
      end

      context "with two items in the queue" do
        it "finds both items in the database" do
          all_items = QueueItem.where(user: user)
          subject

          expect(assigns(:queue_items)).to match_array all_items
        end

        it "swaps the queue rank of the items" do
          first = QueueItem.where(user: user, queue_rank: 1).first
          second = QueueItem.where(user: user, queue_rank: 2).first

          subject

          expect(first.reload.queue_rank).to eq 2
          expect(second.reload.queue_rank).to eq 1
        end
      end

      context "with four items in the queue" do
        context "when only one queue rank is changed in the ui" do
          it "updates the items to the correct rank and pushes all others down"

        end

        context "when the queue rank for two items are swapped in the ui" do
          it "swaps the queue rank for the two items correctly"

        end

        context "when the queue rank for three items are changed" do

        end

        context "when two items are given the same queue rank" do
          it "sets the queue rank only on the item with the higher initial queue rank"
        end

        context "when there are gaps in the queue rank order" do
          it "moves items up in rank to have a continuous ranking"
        end

        context "when none of the queue ranks where changed in the ui" do
          it "doesn't change anything"
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let(:queue_item) { queue_items(:james_bonds_first_qi) }
    subject { delete :destroy, id: queue_item.id}

    it_behaves_like "unauthenticated_access to the queue"

    context "with an athenticated user" do
      before { login_as user }

      context "with a valid queue_item_id" do
        context "with an item matching an item in the queue" do
          it "redirects to the queue index page" do
            expect(subject).to redirect_to queue_path
          end

          it "finds the correct queue item" do
            subject
            expect(assigns(:queue_item)).to eq queue_item
          end

          it "removes the video from the users queue" do
            expect { subject }.to change{QueueItem.count}.by(-1)
          end
        end

        context "with an item not matching an item in the queue" do
          let(:queue_item) { queue_items(:dr_evils_first_qi) }

          it "does not remove anything from the users queue" do
            expect { subject }.to_not change{QueueItem.count}
          end

          it "adds a message to the flash" do
            subject
            expect(flash[:error]).to eq "Whoa, hold on partna'. That video isn't in your queue"
          end
        end
      end

      context "with an invalid video_id" do
        subject { delete :destroy, id: "bad-id"}
        it "does not remove anything from the users queue" do
          expect { subject }.to_not change{QueueItem.count}
        end

        it "adds a message to the flash" do
          subject
          expect(flash[:error]).to eq "That not even an item in anyone's queue."
        end
      end
    end
  end
end
