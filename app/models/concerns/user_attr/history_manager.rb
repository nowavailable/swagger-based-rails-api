module UserAttr::HistoryManager

  #
  # 変更のあった行を、新たな行としてbuildする などの処理
  #
  def append_histories(user)
    # 文理選択
    if !user.latest_career_decisions_history.blank? and
      user.latest_career_decisions_history.changed?
      new_career_decision_attr = user.latest_career_decisions_history.
        attributes.reject{|k,v|k == "id"}
      if !user.latest_career_decisions_history.new_record?
        user.latest_career_decisions_history.reload
      end
      user.career_decisions_histories.build(new_career_decision_attr)
    end
    # 学年
    if user.latest_grade_history.changed?
      new_grade_history_attr = user.latest_grade_history.
        attributes.reject{|k,v|k == "id"}
      if !user.latest_grade_history.new_record?
        user.latest_grade_history.reload
      end
      user.grade_histories.build(new_grade_history_attr)
    end
    # 志望分野
    if (user.rikejob_ids_default or []).reject{|e|e.blank?}.map{|e|e.to_i}.sort !=
      user.rikejob_ids.reject{|e|e.blank?}.map{|e|e.to_i}.sort
      user.rikejob_ids.reject{|e|e.blank?}.each do |rikejob_id|
        user.users_rikejobs.build(rikejob_id: rikejob_id)
      end
    end
    # 志望高校
    if !user.latest_aspiration_high_school_history.blank? and
      user.latest_aspiration_high_school_history.changed?
      new_latest_aspiration_high_school_history_attr = user.latest_aspiration_high_school_history.
        attributes.reject{|k,v|k == "id"}
      if !user.latest_aspiration_high_school_history.new_record?
        user.latest_aspiration_high_school_history.reload
      end
      user.aspiration_high_school_histories.build(
        secondary_school_name: new_latest_aspiration_high_school_history_attr["secondary_school_name"],
        secondary_school_course_name: new_latest_aspiration_high_school_history_attr["secondary_school_course_name"],
        description: new_latest_aspiration_high_school_history_attr["description"]
      )
    end
    # 志望大学
    if !user.latest_aspiration_university_history.blank? and
      user.latest_aspiration_university_history.changed?
      new_latest_aspiration_university_history_attr = user.latest_aspiration_university_history.
        attributes.reject{|k,v|k == "id"}
      if !user.latest_aspiration_university_history.new_record?
        user.latest_aspiration_university_history.reload
      end
      user.aspiration_university_histories.build(
        university_name: new_latest_aspiration_university_history_attr["university_name"],
        faculty_name: new_latest_aspiration_university_history_attr["faculty_name"],
        department_name: new_latest_aspiration_university_history_attr["department_name"],
        description: new_latest_aspiration_university_history_attr["description"],
      )
    end
    return user
  end

  def set_revision(user)
    users_rikejob_revision =
      (user.latest_users_rikejobs.blank? or
        user.latest_users_rikejobs.last.new_record?) ? 1 :
        user.latest_users_rikejobs.last.revision.to_i + 1
    user.users_rikejobs.each do |users_rikejob|
      if users_rikejob.new_record?
        users_rikejob.revision = users_rikejob_revision
      end
    end

    if !user.latest_career_decisions_history.blank?
      if user.career_decisions_histories.blank?
        # 新規登録
        user.latest_career_decisions_history.revision = 1
      elsif user.career_decisions_histories.last.new_record?
        # 行追記
        revision =
          (user.career_decisions_histories.length == 1 ? 1 :
             user.career_decisions_histories[-2].revision.to_i + 1)
        user.career_decisions_histories.last.revision = revision
      end
    end
    if !user.latest_aspiration_high_school_history.blank?
      if user.aspiration_high_school_histories.blank?
        # 新規登録
        user.latest_aspiration_high_school_history.revision = 1
      elsif user.aspiration_high_school_histories.last.new_record?
        # 行追記
        revision =
          (user.aspiration_high_school_histories.length == 1 ? 1 :
             user.aspiration_high_school_histories[-2].revision.to_i + 1)
        user.aspiration_high_school_histories.last.revision = revision
      end
    end
    if !user.latest_aspiration_university_history.blank?
      if user.aspiration_university_histories.blank?
        # 新規登録
        user.latest_aspiration_university_history.revision = 1
      elsif user.aspiration_university_histories.last.new_record?
        # 行追記
        revision =
          (user.aspiration_university_histories.length == 1 ? 1 :
             user.aspiration_university_histories[-2].revision.to_i + 1)
        user.aspiration_university_histories.last.revision = revision
      end
    end
    return user
  end

  # レコード作成時の学年情報
  def prepare_grade_history(user)
    user.users_rikejobs.each do |users_rikejob|
      if users_rikejob.new_record?
        users_rikejob.grade_history = user.latest_grade_history
      end
    end
    return user
  end

  #
  # 交差テーブル永続化後に、さらに二次的な外部参照キーを与える。
  #
  def complement_grade_history(user)
    entity_arr = []
    if !user.career_decisions_histories.blank?
      user.career_decisions_histories.each do |e|
        if !e.grade_history_id
          e.grade_history_id = user.latest_grade_history.id
          entity_arr.push(e)
        end
      end
    end

    if !user.aspiration_high_school_histories.blank?
      user.aspiration_high_school_histories.each do |e|
        e.grade_history_id = user.latest_grade_history.id
        entity_arr.push(e)
      end
    end
    if !user.aspiration_university_histories.blank?
      user.aspiration_university_histories.each do |e|
        e.grade_history_id = user.latest_grade_history.id
        entity_arr.push(e)
      end
    end
    return entity_arr
  end
end
