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
end
