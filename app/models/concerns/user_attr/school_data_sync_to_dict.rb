module UserAttr::SchoolDataSyncToDict
  #
  # 各Profileに入力された大学名や学科名を、辞書データと突き合わせ、
  # 同期をとる。
  #
  attr :attribute_pair_and_dictionary_set, true

  def self.extended(profile)
    case profile.class.name
    when ProfileJuniorHigh.name, ProfileHighSchool.name, AspirationHighSchoolHistory.name
      profile.attribute_pair_and_dictionary_set =
        [{attribute_pair: [:secondary_school_name, :name], dict_clazz: SecondarySchool},
          {attribute_pair: [:secondary_school_course_name, :name], dict_clazz: SecondarySchoolCourse}]
    when ProfileVocationalSchool.name
      profile.attribute_pair_and_dictionary_set =
        [{attribute_pair: [:vocational_school_name, :name], dict_clazz: VocationalSchool},
          {attribute_pair: [:faculty_name, :name], dict_clazz: Faculty},
          {attribute_pair: [:department_name, :name], dict_clazz: Department}]
    when ProfileUniversity.name, ProfileMaster.name, AspirationUniversityHistory.name
      profile.attribute_pair_and_dictionary_set =
        [{attribute_pair: [:university_name, :name], dict_clazz: University},
          {attribute_pair: [:faculty_name, :name], dict_clazz: Faculty},
          {attribute_pair: [:department_name, :name], dict_clazz: Department}]
    when ProfilePostdoctoral.name, ProfileDoctor.name, ProfileEducation.name
      profile.attribute_pair_and_dictionary_set =
        [{attribute_pair: [:institute_name, :name], dict_clazz: Institute},
          {attribute_pair: [:university_name, :name], dict_clazz: University},
          {attribute_pair: [:faculty_name, :name], dict_clazz: Faculty},
          {attribute_pair: [:department_name, :name], dict_clazz: Department}]
    end
  end

  def sync
    self.attribute_pair_and_dictionary_set.each do |h|
      #
      # FIXME:
      # 初めて登録される学校名が複数同時に送信された場合、
      # マスタに同じ学校名が複数登録されてしまう。（意味がない!）
      # 永続化前のオブジェクトも検索対象にしないと?
      #

      attribute_pair = h[:attribute_pair]
      dict_clazz = h[:dict_clazz]

      return if self.send(attribute_pair[0]).blank?

      # TODO: 単なる完全一致ではなくしたい。
      results = dict_clazz.where(["#{attribute_pair[1]} = ?", self.send(attribute_pair[0])])
      if results.blank?
        master = dict_clazz.new(attribute_pair[1] => self.send(attribute_pair[0]))
        master.save!
        self.send(attribute_pair[0].to_s.sub("_name", "_id") + "=", master.id)
      else
        self.send(attribute_pair[0].to_s.sub(/_name$/, "_id") + "=", results.first.id)
      end
    end
  end
end