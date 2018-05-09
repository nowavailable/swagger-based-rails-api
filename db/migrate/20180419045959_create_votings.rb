class CreateVotings < ActiveRecord::Migration[5.2]
  def up
    create_table :votings do |t|
      t.references :answer, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.timestamp :created_at, null: false
    end
    add_index :votings, [:answer_id, :user_id], unique:true, name: "idx_votings"

    create_table :notifications do |t|
      t.string :message_body, null: false
      t.bigint :dst_user_id
      t.integer :src_event_id, null: false
      t.string :src_event_type, null: false
      t.integer :src_user_id
      t.boolean :is_read, null: false, default: false
      t.timestamps
    end
    add_foreign_key :notifications, :users, column: "dst_user_id"
    add_index :notifications, [:dst_user_id, :src_event_id, :src_event_type], unique:true, name: "idx_notifications"

    create_table :notification_sends do |t|
      t.references :notification, null: false, foreign_key: true, index: true
      t.timestamp :sent_at
      t.timestamps
    end
  end

  def down
    drop_table :notification_sends
    drop_table :notifications
    drop_table :votings
  end
end
