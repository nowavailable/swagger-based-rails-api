class CreateUserAttributes < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :kana_last_name, :string
    add_column :users, :kana_first_name, :string
    add_column :users, :email_valid, :boolean, null: false, default: true
    add_column :users, :email_valid_date_updated_at, :timestamp
    add_column :users, :registration_by_parent, :boolean, null: false, default: false

    create_table :user_provideds do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.bigint :smp_provided_user_id
      t.string :twitter
      t.bigint :twitter_id
      t.bigint :facebook_id
      t.bigint :google_id
      t.timestamps
    end

    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :tel
      t.integer :zip1
      t.integer :zip2
      t.integer :prefecture
      t.references :user, null: false, foreign_key: true, index: true
      t.timestamps
    end

    create_table :dict_notification_opt_ins do |t|
      t.string :label, null: false
      t.text :description
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end

    create_table :dict_direct_mail_opt_ins do |t|
      t.string :label, null: false
      t.text :description
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end

    create_table :users_notification_opt_ins do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :dict_notification_opt_in, null: false, foreign_key: true, index: true
      t.timestamp :created_at, null: false
    end

    create_table :users_direct_mail_opt_ins do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :dict_direct_mail_opt_in, null: false, foreign_key: true, index: true
      t.timestamp :created_at, null: false
    end

    create_table :user_comments do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.text :about_favorite
      t.text :about_subject
      t.text :depend_reference
      t.text :opportunity
      t.text :feel_science
      t.text :hobby
      t.text :dream
      t.text :comment
      t.timestamps
    end
  end
end
