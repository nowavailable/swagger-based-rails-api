# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_05_03_073629) do

  create_table "acknowledgements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "answer_id", null: false
    t.integer "seq_num", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["answer_id", "seq_num"], name: "index_acknowledgements_on_answer_id_and_seq_num", unique: true
    t.index ["answer_id"], name: "index_acknowledgements_on_answer_id"
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "tel"
    t.integer "zip1"
    t.integer "zip2"
    t.integer "prefecture"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.integer "seq_num", null: false
    t.text "body", null: false
    t.string "anchor", null: false
    t.bigint "user_id", null: false
    t.bigint "mentor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentor_id"], name: "index_answers_on_mentor_id"
    t.index ["question_id", "anchor"], name: "index_answers_on_question_id_and_anchor", unique: true
    t.index ["question_id", "seq_num"], name: "index_answers_on_question_id_and_seq_num", unique: true
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "aspiration_high_school_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "secondary_school_id"
    t.bigint "secondary_school_course_id"
    t.string "secondary_school_name"
    t.string "secondary_school_course_name"
    t.text "description"
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.bigint "grade_history_id"
    t.integer "revision", default: 0, null: false
    t.index ["grade_history_id"], name: "index_aspiration_high_school_histories_on_grade_history_id"
    t.index ["secondary_school_course_id"], name: "idx_aspiration_high_school_histories_2"
    t.index ["secondary_school_id"], name: "idx_aspiration_high_school_histories_1"
    t.index ["user_id", "revision"], name: "index_aspiration_high_school_histories_on_user_id_and_revision"
    t.index ["user_id"], name: "index_aspiration_high_school_histories_on_user_id"
  end

  create_table "aspiration_university_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "university_id"
    t.bigint "faculty_id"
    t.bigint "department_id"
    t.string "university_name"
    t.string "faculty_name"
    t.string "department_name"
    t.text "description"
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.bigint "grade_history_id"
    t.integer "revision", default: 0, null: false
    t.index ["department_id"], name: "index_aspiration_university_histories_on_department_id"
    t.index ["faculty_id"], name: "index_aspiration_university_histories_on_faculty_id"
    t.index ["grade_history_id"], name: "index_aspiration_university_histories_on_grade_history_id"
    t.index ["university_id"], name: "index_aspiration_university_histories_on_university_id"
    t.index ["user_id", "revision"], name: "index_aspiration_university_histories_on_user_id_and_revision"
    t.index ["user_id"], name: "index_aspiration_university_histories_on_user_id"
  end

  create_table "career_decisions_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "dict_career_decision_id", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.bigint "grade_history_id"
    t.integer "revision", null: false
    t.index ["dict_career_decision_id"], name: "index_career_decisions_histories_on_dict_career_decision_id"
    t.index ["grade_history_id"], name: "index_career_decisions_histories_on_grade_history_id"
    t.index ["user_id", "dict_career_decision_id", "revision"], name: "idx_career_decisions_histories"
    t.index ["user_id", "revision"], name: "index_career_decisions_histories_on_user_id_and_revision"
    t.index ["user_id"], name: "index_career_decisions_histories_on_user_id"
  end

  create_table "change_email_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "email", null: false
    t.string "token", null: false
    t.timestamp "token_expired_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "created_at", null: false
    t.timestamp "verified_at"
    t.index ["token"], name: "index_change_email_requests_on_token", unique: true
    t.index ["user_id"], name: "index_change_email_requests_on_user_id"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dict_career_decisions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "label", null: false
    t.text "description"
    t.boolean "is_active", default: true, null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "key", null: false
    t.index ["key"], name: "index_dict_career_decisions_on_key", unique: true
  end

  create_table "dict_direct_mail_opt_ins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "label", null: false
    t.text "description"
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key", null: false
    t.index ["key"], name: "index_dict_direct_mail_opt_ins_on_key", unique: true
  end

  create_table "dict_grades", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "label", null: false
    t.boolean "is_active", default: true, null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "key", null: false
    t.index ["key"], name: "index_dict_grades_on_key", unique: true
  end

  create_table "dict_notification_opt_ins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "label", null: false
    t.text "description"
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key", null: false
    t.index ["key"], name: "index_dict_notification_opt_ins_on_key", unique: true
  end

  create_table "faculties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_master", default: false, null: false
    t.boolean "is_doctor", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grade_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "dict_grade_id", null: false
    t.bigint "user_id", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["dict_grade_id"], name: "index_grade_histories_on_dict_grade_id"
    t.index ["user_id"], name: "index_grade_histories_on_user_id"
  end

  create_table "institutes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "joining_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "token", null: false
    t.timestamp "token_expired_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "created_at", null: false
    t.timestamp "verified_at"
    t.index ["token"], name: "index_joining_requests_on_token", unique: true
  end

  create_table "mentors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mentors_on_user_id"
  end

  create_table "moral_hazards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "entry_id", null: false
    t.string "entry_type", null: false
    t.text "comment"
    t.timestamp "created_at"
    t.index ["entry_id", "entry_type", "user_id"], name: "idx_moral_hazards", unique: true
    t.index ["user_id"], name: "index_moral_hazards_on_user_id"
  end

  create_table "notification_sends", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "notification_id", null: false
    t.timestamp "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_id"], name: "index_notification_sends_on_notification_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "message_body", null: false
    t.bigint "dst_user_id"
    t.integer "src_event_id", null: false
    t.string "src_event_type", null: false
    t.integer "src_user_id"
    t.boolean "is_read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dst_user_id", "src_event_id", "src_event_type"], name: "idx_notifications", unique: true
  end

  create_table "profile_businesses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "company_name", null: false
    t.string "responsibility"
    t.integer "entered_year"
    t.integer "graduated_year"
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "rikejob_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rikejob_id"], name: "index_profile_businesses_on_rikejob_id"
    t.index ["user_id"], name: "index_profile_businesses_on_user_id"
  end

  create_table "profile_doctors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "entered_year", default: 0, null: false
    t.integer "graduated_year"
    t.boolean "graduated", default: true, null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "university_id"
    t.bigint "faculty_id"
    t.bigint "department_id"
    t.bigint "institute_id"
    t.string "university_name"
    t.string "faculty_name"
    t.string "department_name"
    t.string "institute_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_profile_doctors_on_department_id"
    t.index ["faculty_id"], name: "index_profile_doctors_on_faculty_id"
    t.index ["institute_id"], name: "index_profile_doctors_on_institute_id"
    t.index ["university_id"], name: "index_profile_doctors_on_university_id"
    t.index ["user_id"], name: "index_profile_doctors_on_user_id"
  end

  create_table "profile_educations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "entered_year"
    t.integer "graduated_year"
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "university_id"
    t.bigint "faculty_id"
    t.bigint "department_id"
    t.bigint "institute_id"
    t.string "university_name"
    t.string "faculty_name"
    t.string "department_name"
    t.string "institute_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_profile_educations_on_department_id"
    t.index ["faculty_id"], name: "index_profile_educations_on_faculty_id"
    t.index ["institute_id"], name: "index_profile_educations_on_institute_id"
    t.index ["university_id"], name: "index_profile_educations_on_university_id"
    t.index ["user_id"], name: "index_profile_educations_on_user_id"
  end

  create_table "profile_high_schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "entered_year", default: 0, null: false
    t.integer "graduated_year"
    t.boolean "graduated", default: true, null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "secondary_school_id"
    t.bigint "secondary_school_course_id"
    t.string "secondary_school_name", null: false
    t.string "secondary_school_course_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["secondary_school_course_id"], name: "index_profile_high_schools_on_secondary_school_course_id"
    t.index ["secondary_school_id"], name: "index_profile_high_schools_on_secondary_school_id"
    t.index ["user_id"], name: "index_profile_high_schools_on_user_id"
  end

  create_table "profile_junior_highs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "entered_year", default: 0, null: false
    t.integer "graduated_year"
    t.boolean "graduated", default: true, null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "secondary_school_id"
    t.bigint "secondary_school_course_id"
    t.string "secondary_school_name", null: false
    t.string "secondary_school_course_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["secondary_school_course_id"], name: "index_profile_junior_highs_on_secondary_school_course_id"
    t.index ["secondary_school_id"], name: "index_profile_junior_highs_on_secondary_school_id"
    t.index ["user_id"], name: "index_profile_junior_highs_on_user_id"
  end

  create_table "profile_masters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "entered_year", default: 0, null: false
    t.integer "graduated_year"
    t.boolean "graduated", default: true, null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "university_id"
    t.bigint "faculty_id"
    t.bigint "department_id"
    t.string "university_name", null: false
    t.string "faculty_name"
    t.string "department_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_profile_masters_on_department_id"
    t.index ["faculty_id"], name: "index_profile_masters_on_faculty_id"
    t.index ["university_id"], name: "index_profile_masters_on_university_id"
    t.index ["user_id"], name: "index_profile_masters_on_user_id"
  end

  create_table "profile_other_academics", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "description", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profile_other_academics_on_user_id"
  end

  create_table "profile_postdoctorals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "entered_year"
    t.integer "graduated_year"
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "university_id"
    t.bigint "faculty_id"
    t.bigint "department_id"
    t.bigint "institute_id"
    t.string "university_name"
    t.string "faculty_name"
    t.string "department_name"
    t.string "institute_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_profile_postdoctorals_on_department_id"
    t.index ["faculty_id"], name: "index_profile_postdoctorals_on_faculty_id"
    t.index ["institute_id"], name: "index_profile_postdoctorals_on_institute_id"
    t.index ["university_id"], name: "index_profile_postdoctorals_on_university_id"
    t.index ["user_id"], name: "index_profile_postdoctorals_on_user_id"
  end

  create_table "profile_universities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "entered_year", default: 0, null: false
    t.integer "graduated_year"
    t.boolean "graduated", default: true, null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "university_id"
    t.bigint "faculty_id"
    t.bigint "department_id"
    t.string "university_name", null: false
    t.string "faculty_name"
    t.string "department_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_profile_universities_on_department_id"
    t.index ["faculty_id"], name: "index_profile_universities_on_faculty_id"
    t.index ["university_id"], name: "index_profile_universities_on_university_id"
    t.index ["user_id"], name: "index_profile_universities_on_user_id"
  end

  create_table "profile_vocational_schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "entered_year", default: 0, null: false
    t.integer "graduated_year"
    t.boolean "graduated", default: true, null: false
    t.text "description"
    t.bigint "user_id", null: false
    t.bigint "vocational_school_id"
    t.bigint "faculty_id"
    t.bigint "department_id"
    t.string "vocational_school_name", null: false
    t.string "faculty_name"
    t.string "department_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_profile_vocational_schools_on_department_id"
    t.index ["faculty_id"], name: "index_profile_vocational_schools_on_faculty_id"
    t.index ["user_id"], name: "index_profile_vocational_schools_on_user_id"
    t.index ["vocational_school_id"], name: "index_profile_vocational_schools_on_vocational_school_id"
  end

  create_table "question_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "label", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label"], name: "index_question_categories_on_label", unique: true
  end

  create_table "question_categories_questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "question_category_id", null: false
    t.bigint "question_id", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["question_category_id"], name: "index_question_categories_questions_on_question_category_id"
    t.index ["question_id", "question_category_id"], name: "idx_question_categories_questions", unique: true
    t.index ["question_id"], name: "index_question_categories_questions_on_question_id"
  end

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "subject", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "rikejobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "copy"
    t.text "comment"
    t.text "job_type"
    t.text "study_type"
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key", null: false
    t.index ["key"], name: "index_rikejobs_on_key", unique: true
  end

  create_table "secondary_school_courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "secondary_schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "universities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "about_favorite"
    t.text "about_subject"
    t.text "depend_reference"
    t.text "opportunity"
    t.text "feel_science"
    t.text "hobby"
    t.text "dream"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_comments_on_user_id"
  end

  create_table "user_provideds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "smp_provided_user_id"
    t.string "twitter"
    t.bigint "twitter_id"
    t.bigint "facebook_id"
    t.bigint "google_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_provideds_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "login", null: false
    t.date "birthday"
    t.bigint "joining_request_id"
    t.string "nickname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "kana_last_name"
    t.string "kana_first_name"
    t.boolean "email_valid", default: true, null: false
    t.timestamp "email_valid_date_updated_at"
    t.boolean "registration_by_parent", default: false, null: false
    t.string "email_without_gmail_style", null: false
    t.integer "gender", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["email_without_gmail_style"], name: "idx_users_against_gmail_style", unique: true
    t.index ["joining_request_id"], name: "index_users_on_joining_request_id"
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "users_direct_mail_opt_ins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "dict_direct_mail_opt_in_id", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["dict_direct_mail_opt_in_id"], name: "index_users_direct_mail_opt_ins_on_dict_direct_mail_opt_in_id"
    t.index ["user_id"], name: "index_users_direct_mail_opt_ins_on_user_id"
  end

  create_table "users_notification_opt_ins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "dict_notification_opt_in_id", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["dict_notification_opt_in_id"], name: "index_users_notification_opt_ins_on_dict_notification_opt_in_id"
    t.index ["user_id"], name: "index_users_notification_opt_ins_on_user_id"
  end

  create_table "users_rikejobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "rikejob_id", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamp "revoked_at"
    t.bigint "grade_history_id"
    t.integer "revision", null: false
    t.index ["grade_history_id"], name: "index_users_rikejobs_on_grade_history_id"
    t.index ["rikejob_id"], name: "index_users_rikejobs_on_rikejob_id"
    t.index ["user_id", "revision"], name: "index_users_rikejobs_on_user_id_and_revision"
    t.index ["user_id", "rikejob_id", "revision"], name: "idx_users_rikejobs"
    t.index ["user_id"], name: "index_users_rikejobs_on_user_id"
  end

  create_table "vocational_schools", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "answer_id", null: false
    t.bigint "user_id", null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["answer_id", "user_id"], name: "idx_votings", unique: true
    t.index ["answer_id"], name: "index_votings_on_answer_id"
    t.index ["user_id"], name: "index_votings_on_user_id"
  end

  add_foreign_key "acknowledgements", "answers"
  add_foreign_key "addresses", "users"
  add_foreign_key "answers", "mentors"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "aspiration_high_school_histories", "users"
  add_foreign_key "aspiration_university_histories", "users"
  add_foreign_key "career_decisions_histories", "dict_career_decisions"
  add_foreign_key "career_decisions_histories", "users"
  add_foreign_key "change_email_requests", "users"
  add_foreign_key "grade_histories", "dict_grades"
  add_foreign_key "grade_histories", "users"
  add_foreign_key "mentors", "users"
  add_foreign_key "moral_hazards", "users"
  add_foreign_key "notification_sends", "notifications"
  add_foreign_key "notifications", "users", column: "dst_user_id"
  add_foreign_key "profile_businesses", "users"
  add_foreign_key "profile_doctors", "users"
  add_foreign_key "profile_educations", "users"
  add_foreign_key "profile_high_schools", "users"
  add_foreign_key "profile_junior_highs", "users"
  add_foreign_key "profile_masters", "users"
  add_foreign_key "profile_other_academics", "users"
  add_foreign_key "profile_postdoctorals", "users"
  add_foreign_key "profile_universities", "users"
  add_foreign_key "profile_vocational_schools", "users"
  add_foreign_key "question_categories_questions", "question_categories"
  add_foreign_key "question_categories_questions", "questions"
  add_foreign_key "questions", "users"
  add_foreign_key "user_comments", "users"
  add_foreign_key "user_provideds", "users"
  add_foreign_key "users_direct_mail_opt_ins", "dict_direct_mail_opt_ins"
  add_foreign_key "users_direct_mail_opt_ins", "users"
  add_foreign_key "users_notification_opt_ins", "dict_notification_opt_ins"
  add_foreign_key "users_notification_opt_ins", "users"
  add_foreign_key "users_rikejobs", "rikejobs"
  add_foreign_key "users_rikejobs", "users"
  add_foreign_key "votings", "answers"
  add_foreign_key "votings", "users"
end
