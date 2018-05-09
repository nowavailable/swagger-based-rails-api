class User < ApplicationRecord
  belongs_to :joining_request #, optional: true # 実際には必須だが、バリデ−ションは不要。
  has_many :questions, dependent: :restrict_with_exception
  has_many :acknowledgements, dependent: :restrict_with_exception
  has_many :addresses, dependent: :restrict_with_exception
  has_many :user_comments, dependent: :restrict_with_exception
  has_one :user_provided, dependent: :restrict_with_exception

  # 選択したメ−ルサ−ビス
  has_many :users_direct_mail_opt_ins
  # has_many :direct_mail_opt_ins, source: :dict_direct_mail_opt_in,
  #   through: :users_direct_mail_opt_ins
  attr_accessor :direct_mail_opt_in_ids, :direct_mail_opt_in_ids_default
  # 選択した通知設定
  has_many :users_notification_opt_ins

  # 学年履歴
  has_many :grade_histories
  has_one :latest_grade_history,
    -> (user){
      where(["id = (select max(id) from grade_histories where user_id = ?)", user.id])
    }, class_name: GradeHistory.name, validate: false
  # 文理選択履歴
  has_many :career_decisions_histories
  has_one :latest_career_decisions_history,
    -> (user){
      where(["revision = (select max(revision) from career_decisions_histories where user_id = ?)", user.id])
    }, class_name: CareerDecisionsHistory.name, validate: false

  attr_accessor :latest_career_decision, :dict_career_decision_id

  # 志望分野履歴
  has_many :users_rikejobs #, dependent: :restrict_with_exception
  has_many :latest_users_rikejobs,
    -> (user){
      where(["revision = (select max(revision) from users_rikejobs where user_id = ?)", user.id])
    }, class_name: UsersRikejob.name, validate: false
  # has_many :rikejobs, source: :rikejob, through: :latest_users_rikejobs
  attr_accessor :rikejob_ids, :rikejob_ids_default
  # 志望校（高校）
  has_many :aspiration_high_school_histories, dependent: :restrict_with_exception
  has_one :latest_aspiration_high_school_history,
    -> (user){
      where(["revision = (select max(revision) from aspiration_high_school_histories where user_id = ?)", user.id])
    }, class_name: AspirationHighSchoolHistory.name, validate: false
  # 志望校（大学）
  has_many :aspiration_university_histories, dependent: :restrict_with_exception
  has_one :latest_aspiration_university_history,
    -> (user){
      where(["revision = (select max(revision) from aspiration_university_histories where user_id = ?)", user.id])
    }, class_name: AspirationUniversityHistory.name, validate: false

  # 中学校（在学または学歴）
  has_one :profile_junior_high, dependent: :restrict_with_exception
  has_one :current_profile_junior_high,
    -> (user){
      where(["entered_year = (select max(entered_year) from profile_junior_highs where user_id = ?)", user.id])
    }, class_name: ProfileJuniorHigh.name
  # 高校（在学または学歴）
  has_many :profile_high_schools, dependent: :restrict_with_exception
  has_one :current_profile_high_school,
    -> (user){
      where(["entered_year = (select max(entered_year) from profile_high_schools where user_id = ?)", user.id])
    }, class_name: ProfileHighSchool.name
  # 専門学校（在学または学歴）
  has_many :profile_vocational_schools, dependent: :restrict_with_exception
  has_one :current_profile_vocational_school,
    -> (user){
      where(["entered_year = (select max(entered_year) from profile_vocational_schools where user_id = ?)", user.id])
    }, class_name: ProfileVocationalSchool.name
  # 大学（在学または学歴）
  has_many :profile_universities, dependent: :restrict_with_exception
  has_one :current_profile_university,
    -> (user){
      where(["entered_year = (select max(entered_year) from profile_universities where user_id = ?)", user.id])
    }, class_name: ProfileUniversity.name
  # 修士課程（在学または学歴）
  has_many :profile_masters, dependent: :restrict_with_exception
  has_one :current_profile_master,
    -> (user){
      where(["entered_year = (select max(entered_year) from profile_masters where user_id = ?)", user.id])
    }, class_name: ProfileMaster.name
  # 博士課程（在学または学歴）
  has_many :profile_doctors, dependent: :restrict_with_exception
  has_one :current_profile_doctor,
    -> (user){
      where(["entered_year = (select max(entered_year) from profile_doctors where user_id = ?)", user.id])
    }, class_name: ProfileDoctor.name
  # ポスドク（在職または職歴）
  has_many :profile_postdoctorals, dependent: :restrict_with_exception
  has_one :current_profile_postdoctoral,
    -> (user){
      where(["id = (select max(id) from profile_postdoctorals where user_id = ?)", user.id])
    }, class_name: ProfilePostdoctoral.name
  # 教育関係（在職または職歴）
  has_many :profile_educations, dependent: :restrict_with_exception
  has_one :current_profile_education,
    -> (user){
      where(["id = (select max(id) from profile_educations where user_id = ?)", user.id])
    }, class_name: ProfileEducation.name
  # 在職または職歴
  has_many :profile_businesses, dependent: :restrict_with_exception
  has_one :current_profile_business,
    -> (user){
      where(["id = (select max(id) from profile_businesses where user_id = ?)", user.id])
    }, class_name: ProfileBusiness.name
  # その他学歴
  has_many :profile_other_academics, dependent: :restrict_with_exception
  has_one :current_profile_other_academic,
    -> (user){
      where(["id = (select max(id) from profile_other_academics where user_id = ?)", user.id])
    }, class_name: ProfileOtherAcademic.name

  accepts_nested_attributes_for :latest_grade_history
  accepts_nested_attributes_for :latest_career_decisions_history
  accepts_nested_attributes_for :profile_junior_high, allow_destroy: true
  accepts_nested_attributes_for :current_profile_junior_high
  accepts_nested_attributes_for :profile_high_schools, allow_destroy: true
  accepts_nested_attributes_for :current_profile_high_school
  accepts_nested_attributes_for :profile_vocational_schools, allow_destroy: true
  accepts_nested_attributes_for :current_profile_vocational_school
  accepts_nested_attributes_for :profile_universities, allow_destroy: true
  accepts_nested_attributes_for :current_profile_university
  accepts_nested_attributes_for :profile_masters, allow_destroy: true
  accepts_nested_attributes_for :current_profile_master
  accepts_nested_attributes_for :profile_doctors, allow_destroy: true
  accepts_nested_attributes_for :current_profile_doctor
  accepts_nested_attributes_for :profile_postdoctorals, allow_destroy: true
  accepts_nested_attributes_for :current_profile_postdoctoral
  accepts_nested_attributes_for :profile_educations, allow_destroy: true
  accepts_nested_attributes_for :current_profile_education
  accepts_nested_attributes_for :profile_businesses, allow_destroy: true
  accepts_nested_attributes_for :current_profile_business
  accepts_nested_attributes_for :profile_other_academics, allow_destroy: true
  accepts_nested_attributes_for :current_profile_other_academic
  accepts_nested_attributes_for :latest_aspiration_high_school_history
  accepts_nested_attributes_for :latest_aspiration_university_history

  attr_accessor :password, :token
  attr_accessor :attr_canceler

  GENDER = {"1" => "男性", "2" => "女性"}
  @@message_label = {
    password: "半角英数字およびハイフン、アンダーバー記号のみを使用してください。",
    login: "半角小文字英数字およびアンダーバー記号のみを使用してください。",
  }

  validates :password, presence: true, length: { maximum: 256 },
    format: {with: /\A[a-zA-Z0-9_\-]+\z/, message: "は、" + @@message_label[:password]},
    on: :create
  validates :token, presence: true, length: { maximum: 256 }, on: :create
  validates :login, presence: true, length: { maximum: 256 }, uniqueness: true,
    format: {with: /\A[a-z0-9_\-]+\z/, message: "は、" + @@message_label[:login]}
  validates :email, presence: true, length: { maximum: 256 },
    'valid_email_2/email': { mx: false, disposable: false, disallow_subaddressing: false}
  validates :email_without_gmail_style, presence: true, length: { maximum: 256 },
    'valid_email_2/email': { mx: false, disposable: false, disallow_subaddressing: false}
  validates :birthday, presence: true
  validates :nickname, presence: true, length: { maximum: 256 }, uniqueness: true
  validates :last_name, presence: true, length: { maximum: 256 }
  validates :first_name, presence: true, length: { maximum: 256 }
  validates :kana_last_name, presence: true, length: { maximum: 256 }
  validates :kana_first_name, presence: true, length: { maximum: 256 }

  validates :dict_career_decision_id, presence: true,
    if: ->(u){!u.latest_career_decision.blank?}
  validate do |r|
    if msg = Rules::Email.check(r.email)
      r.errors.add(:email, msg)
    end
  end

  before_validation do |r|
    r.email_without_gmail_style =
      Rules::Email.remove_gmail_style(r.email)
  end

  before_create do |r|
    r.email_valid_date_updated_at = Time.now
  end

  def get_school_from_latest_grade
    return nil if self.latest_grade_history.blank?

    school = nil
    if [DictGrade::KEYS[:juniour_high_1], DictGrade::KEYS[:juniour_high_2], DictGrade::KEYS[:juniour_high_3]].
      include?(self.latest_grade_history.dict_grade.key)
      school = self.current_profile_junior_high
    elsif [DictGrade::KEYS[:hight_school_1], DictGrade::KEYS[:hight_school_2], DictGrade::KEYS[:hight_school_3]].
      include?(self.latest_grade_history.dict_grade.key)
      school = self.current_profile_high_school
    elsif [DictGrade::KEYS[:university_1], DictGrade::KEYS[:university_2],
      DictGrade::KEYS[:university_3], DictGrade::KEYS[:university_4]].
      include?(self.latest_grade_history.dict_grade.key)
      school = self.current_profile_university
    elsif [DictGrade::KEYS[:tech_college_1], DictGrade::KEYS[:tech_college_2],
      DictGrade::KEYS[:tech_college_3], DictGrade::KEYS[:tech_college_4], DictGrade::KEYS[:tech_college_5]].
      include?(self.latest_grade_history.dict_grade.key)
      school = self.current_profile_high_school
    elsif [DictGrade::KEYS[:vocational_school]].include?(self.latest_grade_history.dict_grade.key)
      school = self.current_profile_vocational_school
    elsif [DictGrade::KEYS[:master]].include?(self.latest_grade_history.dict_grade.key)
      school = self.current_profile_master
    elsif [DictGrade::KEYS[:doctor]].include?(self.latest_grade_history.dict_grade.key)
      school = self.current_profile_doctor
    end
    return school
  end

  def get_school_name_from_latest_grade
    school = get_school_from_latest_grade
    return "" if school.blank?

    name = ""
    case school.class.name
    when ProfileJuniorHigh.name
      name = school.secondary_school_name
    when ProfileHighSchool.name, ProfileUniversity.name, ProfileMaster.name,
      ProfileVocationalSchool.name, ProfileDoctor.name
      name = school.concat_name
    end
    return name
  end

  # def on_destroy
  #   # 識別情報はマスキング
  #   # 属性情報は残す
  #
  # end

  # 記事として参照されるときの、リード（先頭から何文字まで、とか）の生成ルール等要.
  # それはroleだろうか。

end
