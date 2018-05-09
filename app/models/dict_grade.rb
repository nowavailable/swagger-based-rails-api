class DictGrade < ApplicationRecord
  validates :label, presence: true
  validates :key, presence: true

  KEYS = {
    juniour_high_1: "10", juniour_high_2: "20", juniour_high_3: "30",
    after_junior_high: "31",
    hight_school_1: "40", hight_school_2: "50", hight_school_3: "60",
    after_high_school: "61",
    university_1: "80", university_2: "90", university_3: "100", university_4: "110",
    master: "120", doctor: "130",
    vocational_school: "131",
    tech_college_1: "132", tech_college_2: "133", tech_college_3: "134",
    tech_college_4: "135", tech_college_5: "136",
    post_doctoral: "139",
    business: "140", education: "150", other: "70",
  }
  SEED = {
    KEYS[:juniour_high_1] => "中学1年生",
    KEYS[:juniour_high_2] => "中学2年生",
    KEYS[:juniour_high_3] => "中学3年生",
    KEYS[:after_junior_high] => "高校浪人",
    KEYS[:hight_school_1] => "高校1年生",
    KEYS[:hight_school_2] => "高校2年生",
    KEYS[:hight_school_3] => "高校3年生",
    KEYS[:after_high_school] => "大学浪人",
    KEYS[:university_1] => "大学1年生",
    KEYS[:university_2] => "大学2年生",
    KEYS[:university_3] => "大学3年生",
    KEYS[:university_4] => "大学4年生以上",
    KEYS[:master] => "大学院生（修士課程）",
    KEYS[:doctor] => "大学院生（博士課程）",
    KEYS[:vocational_school] => "専門学校",
    KEYS[:tech_college_1] => "高専1年生",
    KEYS[:tech_college_2] => "高専2年生",
    KEYS[:tech_college_3] => "高専3年生",
    KEYS[:tech_college_4] => "高専4年生",
    KEYS[:tech_college_5] => "高専5年生",
    KEYS[:post_doctoral] => "博士研究員",
    KEYS[:business] => "社会人",
    KEYS[:education] => "教育関係者",
    KEYS[:other] => "その他",
  }

end
