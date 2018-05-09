class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :secondary_schools do |t|
      t.string :name, null: false
      t.timestamps
    end
    create_table :secondary_school_courses do |t|
      t.string :name, null: false
      # t.references :secondary_school, index: true
      t.timestamps
    end

    create_table :universities do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :faculties do |t|
      t.string :name, null: false
      # t.references :university, index: true
      t.boolean :is_master, null: false, default: false
      t.boolean :is_doctor, null: false, default: false
      t.timestamps
    end

    create_table :vocational_schools do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :institutes do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :departments do |t|
      t.string :name, null: false
      # t.references :university, index: true
      # t.references :vocational_school, index: true
      # t.references :institute, index: true
      # t.boolean :is_master, null: false, default: false
      # t.boolean :is_doctor, null: false, default: false
      t.timestamps
    end

    create_table :profile_high_schools do |t|
      t.integer :entered_year
      t.integer :graduated_year
      t.boolean :graduated, null: false, default: true
      t.text :description, null: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :secondary_school, index: true
      t.references :secondary_school_course, index: true
      t.string :secondary_school_name, null: false
      t.string :secondary_school_course_name
      t.timestamps
    end

    create_table :profile_junior_highs do |t|
      t.integer :entered_year
      t.integer :graduated_year
      t.boolean :graduated, null: false, default: true
      t.text :description, null: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :secondary_school, index: true
      t.references :secondary_school_course, index: true
      t.string :secondary_school_name, null: false
      t.string :secondary_school_course_name
      t.timestamps
    end

    create_table :profile_vocational_schools do |t|
      t.integer :entered_year
      t.integer :graduated_year
      t.boolean :graduated, null: false, default: true
      t.text :description, null: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :vocational_school, index: true
      t.references :faculty, index: true
      t.references :department, index: true
      t.string :vocational_school_name, null: false
      t.string :faculty_name
      t.string :department_name
      t.timestamps
    end

    create_table :profile_universities do |t|
      t.integer :entered_year
      t.integer :graduated_year
      t.boolean :graduated, null: false, default: true
      t.text :description, null: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :university, index: true
      t.references :faculty, index: true
      t.references :department, index: true
      t.string :university_name, null: false
      t.string :faculty_name
      t.string :department_name
      t.timestamps
    end

    create_table :profile_masters do |t|
      t.integer :entered_year
      t.integer :graduated_year
      t.boolean :graduated, null: false, default: true
      t.text :description, null: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :university, index: true
      t.references :faculty, index: true
      t.references :department, index: true
      t.string :university_name, null: false
      t.string :faculty_name
      t.string :department_name
      t.timestamps
    end

    create_table :profile_doctors do |t|
      t.integer :entered_year
      t.integer :graduated_year
      t.boolean :graduated, null: false, default: true
      t.text :description, null: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :university, index: true
      t.references :faculty, index: true
      t.references :department, index: true
      t.references :institute, index: true
      t.string :university_name
      t.string :faculty_name
      t.string :department_name
      t.string :institute_name
      t.timestamps
    end

    create_table :profile_postdoctorals do |t|
      t.integer :entered_year
      t.integer :graduated_year
      t.text :description, null: true
      # t.boolean :graduated, null: false, default: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :university, index: true
      t.references :faculty, index: true
      t.references :department, index: true
      t.references :institute, index: true
      t.string :university_name
      t.string :faculty_name
      t.string :department_name
      t.string :institute_name
      t.timestamps
    end

    create_table :profile_businesses do |t|
      t.string :company_name, null: false
      t.string :responsibility
      t.integer :entered_year
      t.integer :graduated_year
      t.text :description, null: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :rikejob, index: true
      t.timestamps
    end

    create_table :profile_educations do |t|
      t.string :name
      t.integer :entered_year
      t.integer :graduated_year
      t.text :description, null: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :university, index: true
      t.references :faculty, index: true
      t.references :department, index: true
      t.references :institute, index: true
      t.string :university_name
      t.string :faculty_name
      t.string :department_name
      t.string :institute_name
      t.timestamps
    end

    create_table :profile_other_academics do |t|
      t.text :description, null: false
      t.references :user, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
