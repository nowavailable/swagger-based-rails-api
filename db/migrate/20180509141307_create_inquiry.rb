class CreateInquiry < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.string :subject
      t.string :sender_address
      t.references :user
      t.text :body
      t.integer :category
    end
  end
end
