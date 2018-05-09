class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :login, null: false
      t.date :birthday
      t.references :joining_request, null: true
      t.string :nickname, null: false
      t.timestamps
    end
    add_index :users, [:email], unique:true
    add_index :users, [:login], unique:true

    create_table :mentors do |t|
      t.references :user, null: false, foreign_key: true, index: true, unique:true
      t.timestamps
    end

    create_table :question_categories do |t|
      t.string :label, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
    add_index :question_categories, [:label], unique:true

    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :subject, null: false
      t.text :body, null: false
      t.timestamps
    end

    create_table :question_categories_questions do |t|
      t.references :question_category, null: false, foreign_key: true, index: true
      t.references :question, null: false, foreign_key: true,index: true
      t.timestamp :created_at, null: false
    end
    add_index :question_categories_questions, [:question_id, :question_category_id], unique:true, name: "idx_question_categories_questions"

    create_table :answers do |t|
      t.references :question, null: false, foreign_key: true, index: true
      t.integer :seq_num, null: false
      t.text :body, null: false
      t.string :anchor, null: false
      t.references :user, null: false, foreign_key: true, index: true
      t.references :mentor, null: false, foreign_key: true, index: true
      t.timestamps
    end
    add_index :answers, [:question_id, :seq_num], unique:true
    add_index :answers, [:question_id, :anchor], unique:true

    create_table :acknowledgements do |t|
      t.text :body, null: false
      t.references :answer, null: false, foreign_key: true, index: true
      t.integer :seq_num, null: false
      t.timestamp :created_at, null: false
    end
    add_index :acknowledgements, [:answer_id, :seq_num], unique:true

    create_table :joining_requests do |t|
      t.string :email, null: false
      t.string :token, null: false
      t.timestamp :token_expired_at, null: false
      t.timestamp :created_at, null: false
      t.timestamp :verified_at, null: true
    end
    add_index :joining_requests, [:token], unique:true

    create_table :change_email_requests do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string :email, null: false
      t.string :token, null: false
      t.timestamp :token_expired_at, null: false
      t.timestamp :created_at, null: false
      t.timestamp :verified_at, null: true
    end
    add_index :change_email_requests, [:token], unique:true
  end
end
