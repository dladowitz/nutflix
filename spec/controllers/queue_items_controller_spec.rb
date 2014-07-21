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
          first_qi  = queue_items(:james_bonds_first_qi)
          second_qi = queue_items(:james_bonds_second_qi)
          third_qi  = queue_items(:james_bonds_third_qi)
          fourth_qi = queue_items(:james_bonds_fourth_qi)
          subject

          expect(assigns(:queue_items)).to match_array [first_qi, second_qi, third_qi, fourth_qi]
        end

        it "orders queue items by 'queue_rank' property" do
          first_qi  = queue_items(:james_bonds_first_qi)
          second_qi = queue_items(:james_bonds_second_qi)
          subject

          expect(assigns(:queue_items).first).to eql first_qi
          expect(assigns(:queue_items).second).to eql second_qi
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
    let(:video) { videos(:iron_man_7) }
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
    let(:first_item)  { queue_items(:james_bonds_first_qi) }
    let(:second_item) { queue_items(:james_bonds_second_qi)}
    let(:third_item)  { queue_items(:james_bonds_third_qi) }
    let(:fourth_item) { queue_items(:james_bonds_fourth_qi)}

    subject { patch :update, { queue_items: [{ id: second_item.id, queue_rank: 1 }] } }

    shared_examples "does not update any items" do
      before { subject }

      it "should not update any of the queue items"  do
        expect(first_item.queue_rank ).to eq 1
        expect(second_item.queue_rank).to eq 2
        expect(third_item.queue_rank ).to eq 3
        expect(fourth_item.queue_rank).to eq 4
      end

      it "should show an error message" do
        expect(flash[:danger]).to eq "Not gonna happen mang"
      end
    end

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

      context "with invalid params" do
        context "when more than one item is changed to have the same rank" do
          subject { patch :update, {queue_items: [{ id: second_item.id, queue_rank: 1}, { id: third_item.id, queue_rank: 1}] } }

          it_behaves_like "does not update any items"
        end

        context "with an invalid queue_item id" do
          subject { patch :update, { queue_items: [{ id: "bad_queue_id", queue_rank: 1 }] } }

          it_behaves_like "does not update any items"
        end

        context "with 1.5 for the queue_rank" do
          subject { patch :update, { queue_items: [{ id: first_item.id, queue_rank: 1.5 }] } }

          it_behaves_like "does not update any items"
        end

        context "with 'aaa' for the queue_rank" do
          subject { patch :update, { queue_items: [{ id: first_item.id, queue_rank: "aaa" }] } }

          it_behaves_like "does not update any items"
        end

        context "with queue_items not belonging to the current user" do
          let(:other_accounts_qi) {queue_items(:dr_evils_first_qi)}
          subject { patch :update, {queue_items: [{ id: other_accounts_qi.id, queue_rank: 1}] } }

          it_behaves_like "does not update any items"
        end
      end

      context "with valid params" do
        context "when only one queue item rank is changed" do
          subject { patch :update, { queue_items: [{ id: second_item.id, queue_rank: 1 }] } }

          it "updates the items to the correct rank and pushes all others down" do
            subject

            expect(first_item.reload.queue_rank ).to eq 2
            expect(second_item.reload.queue_rank).to eq 1
          end
        end

        context "when two queue item ranks are changed" do
          subject { patch :update, {queue_items: [{ id: third_item.id,  queue_rank: 1}, {id: fourth_item.id, queue_rank: 2}] }}

          it "swaps the queue rank for the two items correctly" do
            subject

            expect(third_item.reload.queue_rank ).to eq 1
            expect(fourth_item.reload.queue_rank).to eq 2
          end
        end

        context "when multiple queue item ranks are changed" do
          let(:second_item) { queue_items(:james_bonds_second_qi)}
          let(:third_item)  { queue_items(:james_bonds_third_qi )}
          let(:fourth_item) { queue_items(:james_bonds_fourth_qi)}

          subject { patch :update, {queue_items: [{id: second_item.id,  queue_rank: 1},
                                                  {id: third_item.id,  queue_rank: 4},
                                                  {id: fourth_item.id, queue_rank: 2}] }}

          it "swaps the queue rank for the two items correctly" do
            subject

            expect(second_item.reload.queue_rank).to eq 1
            expect(third_item.reload.queue_rank).to eq 4
            expect(fourth_item.reload.queue_rank).to eq 2
          end
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let(:queue_item)   { queue_items(:james_bonds_first_qi ) }
    let(:queue_item_2) { queue_items(:james_bonds_second_qi) }
    let(:queue_item_3) { queue_items(:james_bonds_third_qi ) }
    let(:queue_item_4) { queue_items(:james_bonds_fourth_qi) }
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

          it "normalizes all remaining queue ranks" do
            subject
            expect(user.queue_items).to eq [queue_item_2, queue_item_3, queue_item_4]
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
