class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string  :token
      t.integer :inviter_id
      t.string  :token
      t.string  :email_address
      t.string  :name
      t.text    :message

      t.timestamps
    end
  end
end
