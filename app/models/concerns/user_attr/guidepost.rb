module UserAttr::Guidepost
  #
  # ユーザーが、どのProfileXXXを必要としているかを判定し、
  # アソシエーション名リストを返す。
  #
  MAP = {
    # -------------------------------------------------------------
    # 中学
    DictGrade::KEYS[:juniour_high_1] => {
      aspiration: [
        [:latest_career_decisions_history, 0],         # 文理選択
        [:rikejobs, 0],                              # 志望分野
        [:latest_aspiration_high_school_history, 0]     # 志望校（高校）
      ],
      currently: [:current_profile_junior_high, 0]
    },
    DictGrade::KEYS[:juniour_high_2] => {
      aspiration: [
        [:latest_career_decisions_history, 0],         # 文理選択
        [:rikejobs, 0],                              # 志望分野
        [:latest_aspiration_high_school_history, 0]     # 志望校（高校）
      ],
      currently: [:current_profile_junior_high, 0]
    },
    DictGrade::KEYS[:juniour_high_3] => {
      aspiration: [
        [:latest_career_decisions_history, 0],         # 文理選択
        [:rikejobs, 0],                              # 志望分野
        [:latest_aspiration_high_school_history, 0]     # 志望校（高校）
      ],
      currently: [:current_profile_junior_high, 0]
    },
    DictGrade::KEYS[:after_junior_high] => {
      aspiration: [
        [:latest_career_decisions_history, 0],         # 文理選択
        [:rikejobs, 0],                              # 志望分野
        [:latest_aspiration_high_school_history, 0]     # 志望校（高校）
      ],
      past: [
        [:profile_junior_high, 0],                 # 学歴（中学）
      ]
    },
    # -------------------------------------------------------------
    # 高校
    DictGrade::KEYS[:hight_school_1] => {
      aspiration: [
        [:latest_career_decisions_history, 1],         # 文理選択
        [:rikejobs, 1],                            # 志望分野
        [:latest_aspiration_university_history, 0]    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_high_school, 0]
    },
    DictGrade::KEYS[:hight_school_2] => {
      aspiration: [
        [:latest_career_decisions_history, 1],         # 文理選択
        [:rikejobs, 1],                            # 志望分野
        [:latest_aspiration_university_history, 0]    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_high_school, 0]
    },
    DictGrade::KEYS[:hight_school_3] => {
      aspiration: [
        [:latest_career_decisions_history, 1],         # 文理選択
        [:rikejobs, 1],                             # 志望分野
        [:latest_aspiration_university_history, 0]    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_high_school, 0]
    },
    DictGrade::KEYS[:after_high_school] => {
      aspiration: [
        [:latest_career_decisions_history, 1],         # 文理選択
        [:rikejobs, 1],                             # 志望分野
        [:latest_aspiration_university_history, 0]    # 志望校（大学・専門学校）
      ],
      past: [:profile_high_schools, 0]
    },
    # -------------------------------------------------------------
    # 大学
    DictGrade::KEYS[:university_1] => {
      aspiration: [
        [:latest_career_decisions_history, 1],          # 文理選択
        [:rikejobs, 1],                             # 志望分野
        [:latest_aspiration_university_history, 0],    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_university, 1],
      past: [
        [:profile_high_schools, 0],                 # 学歴（高校）
        [:profile_vocational_schools, 0],          # 学歴（専門学校）
        [:profile_universities, 0],                 # 学歴（大学）
        [:profile_other_academics, 0],             # 学歴（その他）
        [:profile_businesses, 0],                  # 職歴
      ]
    },
    DictGrade::KEYS[:university_2] => {
      aspiration: [
        [:latest_career_decisions_history, 1],          # 文理選択
        [:rikejobs, 1],                             # 志望分野
        [:latest_aspiration_university_history, 0],    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_university, 1],
      past: [
        [:profile_high_schools, 0],                 # 学歴（高校）
        [:profile_vocational_schools, 0],          # 学歴（専門学校）
        [:profile_universities, 0],                 # 学歴（大学）
        [:profile_other_academics, 0],             # 学歴（その他）
        [:profile_businesses, 0],                  # 職歴
      ]
    },
    DictGrade::KEYS[:university_3] => {
      aspiration: [
        [:latest_career_decisions_history, 1],          # 文理選択
        [:rikejobs, 1],                             # 志望分野
        [:latest_aspiration_university_history, 0],    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_university, 1],
      past: [
        [:profile_high_schools, 0],                 # 学歴（高校）
        [:profile_vocational_schools, 0],          # 学歴（専門学校）
        [:profile_universities, 0],                 # 学歴（大学）
        [:profile_other_academics, 0],             # 学歴（その他）
        [:profile_businesses, 0],                  # 職歴
      ]
    },
    DictGrade::KEYS[:university_4] => {
      aspiration: [
        [:latest_career_decisions_history, 1],          # 文理選択
        [:rikejobs, 1],                      # 志望分野
        [:latest_aspiration_university_history, 0],    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_university, 1],
      past: [
        [:profile_high_schools, 0],                 # 学歴（高校）
        [:profile_vocational_schools, 0],          # 学歴（専門学校）
        [:profile_universities, 0],                 # 学歴（大学）
        [:profile_other_academics, 0],             # 学歴（その他）
        [:profile_businesses, 0],                  # 職歴
      ]
    },
    # -------------------------------------------------------------
    # 大学院生（修士課程）
    DictGrade::KEYS[:master] => {
      aspiration: [
        # :latest_career_decisions_history,         # 文理選択
        [:rikejobs, 1],                          # 志望分野
        [:latest_aspiration_university_history, 0],    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_master, 1],
      past: [
        [:profile_universities, 1],                 # 学歴（大学）
        [:profile_masters, 0],                      # 学歴（大学院修士）
        [:profile_high_schools, 0],                 # 学歴（高校）
        [:profile_vocational_schools, 0],          # 学歴（専門学校）
        [:profile_other_academics, 0],             # 学歴（その他）
        [:profile_businesses, 0],                  # 職歴
      ]
    },
    # 大学院生（博士課程）
    DictGrade::KEYS[:doctor] => {
      currently: [:current_profile_doctor, 0],
      past: [
        [:profile_universities, 1], # 学歴（大学）
        [:profile_masters, 1], # 学歴（大学院修士）
        [:profile_doctors, 0], # 学歴（大学院博士）
        [:profile_high_schools, 0], # 学歴（高校）
        [:profile_vocational_schools, 0], # 学歴（専門学校）
        [:profile_other_academics, 0], # 学歴（その他）
        [:profile_businesses, 0], # 職歴
      ]
    },
    # -------------------------------------------------------------
    # ポスドク
    DictGrade::KEYS[:post_doctoral] => {
      currently: [:current_profile_postdoctoral, 1],
      past: [
        [:profile_universities, 1], # 学歴（大学）
        [:profile_masters, 1], # 学歴（大学院修士）,
        [:profile_doctors, 0], # 学歴（大学院博士）
        [:profile_high_schools, 0], # 学歴（高校）
        [:profile_vocational_schools, 0], # 学歴（専門学校）
        [:profile_postdoctorals, 0],
        [:profile_other_academics, 0], # 学歴（その他）
        [:profile_businesses, 0], # 職歴
      ]
    },
    # -------------------------------------------------------------
    # 専門学校
    DictGrade::KEYS[:vocational_school] => {
      aspiration: [
        :vocational_school_name,
        # :latest_career_decisions_history,         # 文理選択
        [:rikejobs, 1],                            # 志望分野
        [:latest_aspiration_university_history, 0],    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_vocational_school, 0],
      past: [
        [:profile_high_schools, 0],                 # 学歴（高校）
        [:profile_universities, 0],                 # 学歴（大学）
        [:profile_other_academics, 0],             # 学歴（その他）
        [:profile_businesses, 0],                  # 職歴
      ]
    },

    # -------------------------------------------------------------
    # 高専生
    DictGrade::KEYS[:tech_college_1] => {
      aspiration: [
        [:latest_career_decisions_history, 1],         # 文理選択
        [:rikejobs, 1],                            # 志望分野
        [:latest_aspiration_university_history, 0]    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_high_school, 1],
    },
    DictGrade::KEYS[:tech_college_2] => {
      aspiration: [
        [:latest_career_decisions_history, 1],         # 文理選択
        [:rikejobs, 1],                            # 志望分野
        [:latest_aspiration_university_history, 0]    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_high_school, 1],
    },
    DictGrade::KEYS[:tech_college_3] => {
      aspiration: [
        [:latest_career_decisions_history, 1],         # 文理選択
        [:rikejobs, 1],                            # 志望分野
        [:latest_aspiration_university_history, 0]    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_high_school, 1],
    },
    DictGrade::KEYS[:tech_college_4] => {
      aspiration: [
        # :latest_career_decisions_history,         # 文理選択
        [:rikejobs, 1],                      # 志望分野
        [:latest_aspiration_university_history, 0]    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_high_school, 1],
    },
    DictGrade::KEYS[:tech_college_5] => {
      aspiration: [
        # :latest_career_decisions_history,         # 文理選択
        [:rikejobs, 1],                            # 志望分野
        [:latest_aspiration_university_history, 0]    # 志望校（大学・専門学校）
      ],
      currently: [:current_profile_high_school, 1],
    },
    # -------------------------------------------------------------
    # 社会人
    DictGrade::KEYS[:business] => {
      aspiration: [
        [:latest_aspiration_university_history, 0],    # 志望校（大学・専門学校）
        [:rikejobs, 0],                              # 志望分野
      ],
      past: [
        [:profile_businesses, 0],                  # 職歴
        [:profile_high_schools, 0],                 # 学歴（高校）
        [:profile_universities, 0],                 # 学歴（大学）
        [:profile_vocational_schools, 0],          # 学歴（専門学校）
        [:profile_other_academics, 0],             # 学歴（その他）
      ]
    },
    # 教育関係者
    DictGrade::KEYS[:education] => {
      currently: [:current_profile_education, 1],
      past: [
        [:profile_educations, 0],
        [:profile_businesses, 0],                  # 職歴
        # :profile_high_schools,                 # 学歴（高校）
        [:profile_universities, 0],                 # 学歴（大学）
        # :profile_vocational_schools,          # 学歴（専門学校）
        [:profile_other_academics, 0],             # 学歴（その他）
      ]
    },
    # その他
    DictGrade::KEYS[:other] => {
      aspiration: [
        [:latest_aspiration_university_history, 0],    # 志望校（大学・専門学校）
        [:rikejobs, 0],                              # 志望分野
      ],
      past: [
        [:profile_businesses, 0],                  # 職歴
        [:profile_high_schools, 0],                 # 学歴（高校）
        [:profile_universities, 0],                 # 学歴（大学）
        [:profile_vocational_schools, 0],          # 学歴（専門学校）
        [:profile_other_academics, 0],             # 学歴（その他）
      ]
    }
  }
  
  INPUT_FIELDS = {
    latest_grade_history: [:dict_grade_id, :id],

    direct_mail_opt_in_ids: [],
    rikejobs: [],

    latest_career_decisions_history: [:dict_career_decision_id, :id],
    profile_junior_high: [
      :secondary_school_name, :secondary_school_course_name,
      :entered_year, :graduated_year, :graduated, :description ,:_destroy, :id
    ],
    profile_high_schools: [
      :secondary_school_name, :secondary_school_course_name,
      :entered_year, :graduated_year, :graduated, :description ,:_destroy, :id
    ],
    profile_vocational_schools: [
      :vocational_school_name, :faculty_name, :department_name, :entered_year, :graduated_year,
      :graduated, :description ,:_destroy, :id
    ],
    profile_universities: [
      :university_name, :faculty_name, :department_name,
      :entered_year, :graduated_year, :graduated, :description ,:_destroy, :id
    ],
    profile_masters: [
      :university_name, :faculty_name, :department_name,
      :entered_year, :graduated_year, :graduated, :description ,:_destroy, :id
    ],
    profile_doctors: [
      :institute_name,
      :university_name, :faculty_name, :department_name,
      :entered_year, :graduated_year, :graduated, :description ,:_destroy, :id
    ],
    profile_postdoctorals: [
      :institute_name,
      :university_name, :faculty_name, :department_name,
      :entered_year, :graduated_year, :description ,:_destroy, :id
    ],
    profile_educations: [
      :name, :institute_name, :university_name, :faculty_name, :department_name,
      :entered_year, :graduated_year, :description ,:_destroy, :id
    ],
    profile_businesses: [
      :responsibility, :company_name, :entered_year, :graduated_year, :description ,:_destroy, :id
    ],
    profile_other_academics: [:description ,:_destroy, :id],

    current_profile_junior_high: [
      :secondary_school_name, :secondary_school_course_name,
      :entered_year, :graduated_year, :graduated, :description, :id
    ],
    current_profile_high_school: [
      :secondary_school_name, :secondary_school_course_name,
      :entered_year, :graduated_year, :graduated, :description, :id
    ],
    current_profile_vocational_school: [
      :vocational_school_name, :faculty_name, :department_name, :entered_year, :graduated_year,
      :graduated, :description, :id
    ],
    current_profile_university: [
      :university_name, :faculty_name, :department_name,
      :entered_year, :graduated_year, :graduated, :description, :id
    ],
    current_profile_master: [
      :university_name, :faculty_name, :department_name,
      :entered_year, :graduated_year, :graduated, :description, :id
    ],
    current_profile_doctor: [
      :institute_name,
      :university_name, :faculty_name, :department_name,
      :entered_year, :graduated_year, :graduated, :description, :id
    ],
    current_profile_postdoctoral: [
      :institute_name,
      :university_name, :faculty_name, :department_name,
      :entered_year, :graduated_year, :description, :id
    ],
    current_profile_education: [
      :name, :institute_name, :university_name, :faculty_name, :department_name,
      :entered_year, :graduated_year, :description, :id
    ],
    current_profile_business: [
      :responsibility, :company_name, :entered_year, :graduated_year, :description, :id
    ],
    current_profile_other_academic: [:description, :id],

    latest_aspiration_high_school_history: [
      :secondary_school_name, :secondary_school_course_name, :id
    ],
    latest_aspiration_university_history: [
      :university_name, :faculty_name, :department_name, :id
    ]
  }

  class << self
    def profiles_constrained(dict_grade_key)
      return MAP[dict_grade_key]
    end
  end
end