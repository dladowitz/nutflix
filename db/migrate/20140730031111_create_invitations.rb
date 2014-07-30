class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :token
      t.integer :inviter_id

      t.timestamps
    end
  end
end
