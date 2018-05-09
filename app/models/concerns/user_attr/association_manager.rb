module UserAttr::AssociationManager
  #
  # フォ−ム表示に際しての処理。空の association を build するなど。
  #
  def build_empty_association(user, dict_direct_mail_opt_in_all, rikejobs_all)
    user.build_latest_grade_history if user.latest_grade_history.blank?
    user.build_latest_career_decisions_history if user.latest_career_decisions_history.blank?
    user.build_profile_junior_high if user.profile_junior_high.blank?
    user.profile_high_schools.build if user.profile_high_schools.blank?
    user.profile_vocational_schools.build if user.profile_vocational_schools.blank?
    user.profile_universities.build if user.profile_universities.blank?
    user.profile_masters.build if user.profile_masters.blank?
    user.profile_doctors.build if user.profile_doctors.blank?
    user.profile_postdoctorals.build if user.profile_postdoctorals.blank?
    user.profile_educations.build if user.profile_educations.blank?
    user.profile_businesses.build if user.profile_businesses.blank?
    user.profile_other_academics.build if user.profile_other_academics.blank?
    user.build_current_profile_junior_high if user.current_profile_junior_high.blank?
    user.build_current_profile_high_school if user.current_profile_high_school.blank?
    user.build_current_profile_vocational_school if user.current_profile_vocational_school.blank?
    user.build_current_profile_university if user.current_profile_university.blank?
    user.build_current_profile_master if user.current_profile_master.blank?
    user.build_current_profile_doctor if user.current_profile_doctor.blank?
    user.build_current_profile_postdoctoral if user.current_profile_postdoctoral.blank?
    user.build_current_profile_education if user.current_profile_education.blank?
    user.build_current_profile_business if user.current_profile_business.blank?
    user.build_current_profile_other_academic if user.current_profile_other_academic.blank?
    user.build_latest_aspiration_high_school_history if user.latest_aspiration_high_school_history.blank?
    user.build_latest_aspiration_university_history if user.latest_aspiration_university_history.blank?

    return user
  end

  #
  # user.latest_grade_history の値に応じて、値を受け入れる association、
  # 受け入れない association がある。その制御。
  #
  def omit_association(user_params, profiles_constrained)
    # omitteds = []
    # あり得るすべての associationフィ−ルド と、必須項目。
    associations_all =
      [:latest_grade_history].concat(
        UserAttr::Guidepost::MAP.values.map{|h| h.values}.flatten.
          uniq.reject{|e|e.is_a?(Integer)})

    associations_all.each do |association|
      key_assoc = association.to_s + "_attributes"
      if user_params[key_assoc].blank?
      else
        #---------------------------------------------------------
        # 必ず受け入れる association = 何もしない
        #---------------------------------------------------------
        if [:latest_grade_history].include?(association)
        elsif !(profiles_constrained and profiles_constrained.values.flatten.include?(association))
          # 受け入れる必要の無いassociation
          user_params.delete(key_assoc)
          # omitteds.push(key_assoc)
        else
          #---------------------------------------------------------
          # すべての入力が空欄で送信された association は、
          # 送信されていないのと同じ扱い。
          #---------------------------------------------------------
          idx = profiles_constrained.values.flatten.index(association)
          # 必須ならこの処理スキップ
          next if profiles_constrained.values.flatten[idx + 1] == 1

          # ボタンでキャンセルされていたら
          if user_params[:attr_canceler][association.to_s + "_canceler"] and
            user_params[:attr_canceler][association.to_s + "_canceler"].to_i == 1
            user_params.delete(key_assoc)
            # omitteds.push(key_assoc)
            next
          end

          dirties = check_dirties(user_params, association)
          dirties.each do |idx|
            user_params[key_assoc].delete(idx)
          end
          if user_params[key_assoc].keys.empty?
            user_params.delete(key_assoc)
            # omitteds.push(key_assoc)
          end
        end
      end
    end
    return user_params
    # return omitteds
  end

  def check_dirties(user_params, association)
    key_assoc = association.to_s + "_attributes"
    dirties = []
    return dirties if user_params[key_assoc].blank?

    fields_of_the_association =
      UserAttr::Guidepost::INPUT_FIELDS[association].reject{|e| e == :id}

    if !user_params[key_assoc].keys.blank? and
      m = user_params[key_assoc].keys.first.match(/\A[0-9]+\z/)
      #
      # has_many
      #
      user_params[key_assoc].keys.each do |idx|
        empty_fields = []
        fields_of_the_association.each do |input_field|
          result = check_empty_fields(input_field, user_params[key_assoc][idx][input_field])
          empty_fields.concat(result) if result.length > 0
        end
        dirties.push(idx) if empty_fields == fields_of_the_association
      end
    else
      #
      # has_one
      #
      empty_fields = []
      fields_of_the_association.each do |input_field|
        result = check_empty_fields(input_field, user_params[key_assoc][input_field])
        empty_fields.concat(result) if result.length > 0
      end
      dirties.concat(empty_fields) if empty_fields == fields_of_the_association
    end
    return dirties
  end
  private :check_dirties

  def check_empty_fields(input_field, val_of_it)
    empty_fields = []
    # graduated のようなboolean値は、empty にはならない。のでここでは empty として扱ってしまう。
    if [:graduated].include?(input_field)
      empty_fields.push(input_field)
    elsif [:entered_year].include?(input_field)
      empty_fields.push(input_field) if val_of_it.to_i == 0
    else
      empty_fields.push(input_field) if val_of_it.blank? or
        val_of_it.to_s == "false"
    end
    return empty_fields
  end
  private :check_empty_fields

  #
  # latest_grade_history = "現在の学年" selectボックス等は、値として
  # 使用しているキーがあるが、それをidに変換
  #
  def convert_key_to_id(user)
    if !user.latest_grade_history.blank? and
      !user.latest_grade_history.dict_grade_id.blank?
      dict_grades = DictGrade.where(key: user.latest_grade_history.dict_grade_id)
      if !dict_grades.blank?
        user.latest_grade_history.dict_grade_id = dict_grades.first.id
      end
    end
    return user
  end

  #
  # latest_grade_history = "現在の学年" selectボックス等は、値として
  # キーを使用しているので、id から key を書き戻す必要がある。
  #
  def convert_id_to_key(user)
    if !user.latest_grade_history.blank? and
      !user.latest_grade_history.dict_grade_id.blank?
      dict_grades = DictGrade.where(id: user.latest_grade_history.dict_grade_id)
      if !dict_grades.blank?
        user.latest_grade_history.dict_grade_id = dict_grades.first.key
      end
    end
    return user
  end

end