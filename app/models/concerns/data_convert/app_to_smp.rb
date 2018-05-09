# -*- coding: utf-8 -*-
require "builder/xmlmarkup"

module DataConvert::AppToSmp

  #
  @@grade_on_smp =  {
    "1" => "中学1年生", "2" => "中学2年生", "3" => "中学3年生",
    "4" => "高校1年生", "5" => "高校2年生", "6" => "高校3年生",
    "8" => "大学1年生", "9" => "大学2年生", "10" => "大学3年生", "11" => "大学4年生以上",
    "12" => "大学院生（修士課程）", "13" => "大学院生（博士課程）", "14" => "社会人",
    "15" => "教育関係者", "7" => "その他"
  }
  #
  @@app_to_smp_map = {
    users_direct_mail_opt_in: {
      "1" => 2, "2" => 3
    },
    grade_history: {
      DictGrade::KEYS[:juniour_high_1] => 1, DictGrade::KEYS[:juniour_high_2] => 2,
      DictGrade::KEYS[:juniour_high_3] => 3, DictGrade::KEYS[:after_junior_high] => 7,
      DictGrade::KEYS[:hight_school_1] => 4, DictGrade::KEYS[:hight_school_2] => 5,
      DictGrade::KEYS[:hight_school_3] => 6, DictGrade::KEYS[:after_high_school] => 7,
      DictGrade::KEYS[:university_1] => 8, DictGrade::KEYS[:university_2] => 9,
      DictGrade::KEYS[:university_3] => 10, DictGrade::KEYS[:university_4] => 11,
      DictGrade::KEYS[:master] => 12, DictGrade::KEYS[:doctor] => 13,
      DictGrade::KEYS[:vocational_school] => 7,
      DictGrade::KEYS[:tech_college_1] => 4, DictGrade::KEYS[:tech_college_2] => 5, DictGrade::KEYS[:tech_college_3] => 6,
      DictGrade::KEYS[:tech_college_4] => 7, DictGrade::KEYS[:tech_college_5] => 7,
      DictGrade::KEYS[:post_doctoral] => 14,
      DictGrade::KEYS[:business] => 14, DictGrade::KEYS[:education] => 15,
      DictGrade::KEYS[:other] => 7,
    }
  }

  def generate_xml
    str_xml = ""
    xml = Builder::XmlMarkup.new(:target=>str_xml, :indent => 2)
    xml.instruct!(:xml, :encoding => "UTF-8")
    xml.VisitorData(xmlns: "http://smartseminar.jp/", version: "1.5"){
      #---------------------------------------------------------
      # 基本属性
      #---------------------------------------------------------
      if !self.user_provided.blank?
        xml.Id(self.user_provided.smp_provided_user_id)
      end
      xml.LoginId(self.login)
      if !self.password.blank?
        xml.LoginPassword(self.password)
      end
      xml.Email(self.email)
      xml.Name1(self.last_name)
      xml.Name2(self.first_name)
      xml.Name1Ka(self.kana_last_name)
      xml.Name2Ka(self.kana_first_name)
      xml.Zip1("000")
      xml.Zip2("0000")
      xml.Tel("01-2345-6789")
      if !self.gender.blank?
        xml.Attribute23List{
          xml.Attribute23{
            xml.Attribute23Id(self.gender)
            xml.Attribute23Name(User::GENDER[self.gender.to_s])
          }
        }
      end
      xml.Attribute3(self.birthday.year)
      xml.Attribute127List{
        xml.Attribute127{
          xml.Attribute127Id(self.birthday.month)
          xml.Attribute127Name("%02d" % [self.birthday.month])
        }
      }
      xml.Attribute128List{
        xml.Attribute128{
          xml.Attribute128Id(self.birthday.day)
          xml.Attribute128Name("%02d" % [self.birthday.day])
        }
      }
      #---------------------------------------------------------
      # メルマガ関係
      #---------------------------------------------------------
      xml.PermissionType{
        xml.PermissionTypeId(1)
        xml.PermissionTypeName("希望する")
      }
      xml.Attribute18List{
        if !self.users_direct_mail_opt_ins.blank?
          self.users_direct_mail_opt_ins.each do |users_direct_mail_opt_in|
            xml.Attribute18{
              xml.Attribute18Id(
                @@app_to_smp_map[:users_direct_mail_opt_in][users_direct_mail_opt_in.dict_direct_mail_opt_in.key.to_s]
              )
              xml.Attribute18Name(users_direct_mail_opt_in.dict_direct_mail_opt_in.label)
            }
          end
        end
      }
      xml.EmailSendErrorCount(0)
      xml.EmailValid{
        xml.EmailValidId(1)
        xml.EmailValidName("有効")
      }
      #---------------------------------------------------------
      # 志望や学歴関係
      #---------------------------------------------------------
      # 現在の学年
      if !self.grade_histories.blank?
        xml.Attribute95List{
          self.grade_histories.each do |grade_history|
            xml.Attribute95{
              xml.Attribute95Id(
                @@app_to_smp_map[:grade_history][grade_history.dict_grade.key].to_i
              )
              xml.Attribute95Name(
                @@grade_on_smp[@@app_to_smp_map[:grade_history][grade_history.dict_grade.key].to_s]
              )
            }
          end
        }
      end
      # 文理選択
      if !self.latest_career_decisions_history.blank?
        xml.Attribute80List{
          xml.Attribute80{
            xml.Attribute95Id(
              self.latest_career_decisions_history.dict_career_decision.key.to_i
            )
            xml.Attribute95Name(
              self.latest_career_decisions_history.dict_career_decision.label
            )
          }
        }
      end
      # 現在の学校
      current_school_name = self.get_school_name_from_latest_grade
      xml.Attribute126(
        current_school_name.blank? ? "なし" : current_school_name
      )
      # 志望分野
      xml.Attribute134List{
        if !self.latest_users_rikejobs.blank?
          self.latest_users_rikejobs.each do |users_rikejob|
            xml.Attribute134{
              xml.Attribute134Id(users_rikejob.rikejob.key)
              xml.Attribute134Name(users_rikejob.rikejob.name)
            }
          end
        end
      }
      # 志望校
      aspiration_school_name = ""
      if !self.latest_aspiration_university_history.blank?
        aspiration_school_name = self.latest_aspiration_university_history.concat_name
      elsif !self.latest_aspiration_high_school_history.blank?
        aspiration_school_name = self.latest_aspiration_high_school_history.concat_name

      # TODO: 志望企業
      end
      xml.Attribute60(
        aspiration_school_name.blank? ? "なし" : aspiration_school_name
      )

      #---------------------------------------------------------
      # システム関係
      #---------------------------------------------------------
      xml.Membership{
        xml.MembershipId(1)
        xml.MembershipName("使用する")
      }
      xml.RegistrationType{
        xml.RegistrationTypeId(1)
        xml.RegistrationTypeName("本登録")
      }
      xml.InspectionType{
        xml.InspectionTypeId(3)
        xml.InspectionTypeName("未検閲")
      }
      xml.Language{
        xml.LanguageId(1)
        xml.LanguageName("日本語")
      }
      xml.Attribute2List{
        xml.Attribute2{
          xml.Attribute2Id(1)
          xml.Attribute2Name("講談社無料WEB会員")
        }
        xml.Attribute2{
          xml.Attribute2Id(27)
          xml.Attribute2Name("RikejoBOOK会員")
        }
      }
      xml.Attribute133List{
        xml.Attribute133{
          xml.Attribute133Id(1)
          xml.Attribute133Name("ご本人")
        }
      }
    }
#     new_str =<<STR
# <?xml version="1.0" encoding="UTF-8"?>
# <VisitorData xmlns="http://smartseminar.jp/" version="1.5">
#   <LoginId>tsutsumi_rkj12</LoginId>
#   <LoginPassword>pass1234</LoginPassword>
#   <Email>tsutsumi_rkj12@gmail.com</Email>
#   <Name1>テスト講談社</Name1>
#   <Name2>テスト第一事業部</Name2>
#   <Name1Ka>てすとこうだんしゃ</Name1Ka>
#   <Name2Ka>てすとだいいちじぎょうぶ</Name2Ka>
#   <Zip1>000</Zip1>
#   <Zip2>0000</Zip2>
#   <Tel>01-2345-6789</Tel>
#   <Attribute23List>
#     <Attribute23>
#       <Attribute23Id>2</Attribute23Id>
#       <Attribute23Name>女性</Attribute23Name>
#     </Attribute23>
#   </Attribute23List>
#   <Attribute3>2001</Attribute3>
#   <Attribute127List>
#     <Attribute127>
#       <Attribute127Id>5</Attribute127Id>
#       <Attribute127Name>05</Attribute127Name>
#     </Attribute127>
#   </Attribute127List>
#   <Attribute128List>
#     <Attribute128>
#       <Attribute128Id>8</Attribute128Id>
#       <Attribute128Name>08</Attribute128Name>
#     </Attribute128>
#   </Attribute128List>
#   <PermissionType>
#     <PermissionTypeId>1</PermissionTypeId>
#     <PermissionTypeName>希望する</PermissionTypeName>
#   </PermissionType>
#   <Attribute18List>
#     <Attribute18>
#       <Attribute18Id>2</Attribute18Id>
#       <Attribute18Name>Rikejo Life メールマガジン</Attribute18Name>
#     </Attribute18>
#   </Attribute18List>
#   <EmailSendErrorCount>0</EmailSendErrorCount>
#   <EmailValid>
#     <EmailValidId>1</EmailValidId>
#     <EmailValidName>有効</EmailValidName>
#   </EmailValid>
#   <Attribute95List>
#     <Attribute95>
#       <Attribute95Id>4</Attribute95Id>
#       <Attribute95Name>高校1年生</Attribute95Name>
#     </Attribute95>
#   </Attribute95List>
#   <Attribute80List>
#     <Attribute80>
#       <Attribute95Id>2</Attribute95Id>
#       <Attribute95Name>理系選択志望</Attribute95Name>
#     </Attribute80>
#   </Attribute80List>
#   <Attribute126>長野県立松本深志高校</Attribute126>
#   <Attribute134List>
#     <Attribute134>
#       <Attribute134Id>3</Attribute134Id>
#       <Attribute134Name>デジタルで楽しませるお仕事～ｗｅｂ・ゲーム業界</Attribute134Name>
#     </Attribute134>
#     <Attribute134>
#       <Attribute134Id>10</Attribute134Id>
#       <Attribute134Name>お金を動かすお仕事～ビジネス・経営・サービス・金融業界</Attribute134Name>
#     </Attribute134>
#     <Attribute134>
#       <Attribute134Id>11</Attribute134Id>
#       <Attribute134Name>繋げるお仕事～ＩＴ・通信業界</Attribute134Name>
#     </Attribute134>
#     <Attribute134>
#       <Attribute134Id>12</Attribute134Id>
#       <Attribute134Name>伝えるお仕事～マスコミ・広告・エンターテインメント業界</Attribute134Name>
#     </Attribute134>
#   </Attribute134List>
#   <Attribute60>九州芸術工科大学</Attribute60>
#   <Membership>
#     <MembershipId>1</MembershipId>
#     <MembershipName>使用する</MembershipName>
#   </Membership>
#   <RegistrationType>
#     <RegistrationTypeId>1</RegistrationTypeId>
#     <RegistrationTypeName>本登録</RegistrationTypeName>
#   </RegistrationType>
#   <InspectionType>
#     <InspectionTypeId>3</InspectionTypeId>
#     <InspectionTypeName>未検閲</InspectionTypeName>
#   </InspectionType>
#   <Language>
#     <LanguageId>1</LanguageId>
#     <LanguageName>日本語</LanguageName>
#   </Language>
#   <Attribute2List>
#     <Attribute2>
#       <Attribute2Id>1</Attribute2Id>
#       <Attribute2Name>講談社無料WEB会員</Attribute2Name>
#     </Attribute2>
#     <Attribute2>
#       <Attribute2Id>27</Attribute2Id>
#       <Attribute2Name>RikejoBOOK会員</Attribute2Name>
#     </Attribute2>
#   </Attribute2List>
#   <Attribute133List>
#     <Attribute133>
#       <Attribute133Id>1</Attribute133Id>
#       <Attribute133Name>ご本人</Attribute133Name>
#     </Attribute133>
#   </Attribute133List>
# </VisitorData>
# STR

    arr = []
    str_xml.split(/\n/).each do |line|
      arr.push(
        line.gsub(/&#(\d+);/){ [$1.to_i].pack('U') })
    end
    new_str = arr.join("")
    return new_str
  end
end