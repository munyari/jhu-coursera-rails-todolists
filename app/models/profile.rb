class Profile < ActiveRecord::Base
  belongs_to :user

  validate :at_least_one_name_not_null
  validates :gender, format: { with: /\A(fe)?male\z/,
                               message: "gender can only be male or female" }
  validate :male_not_sue

  def at_least_one_name_not_null
    if first_name.nil? && last_name.nil?
      errors.add(:first_name, "Both names cannot be nil")
      errors.add(:last_name, "Both names cannot be nil")
    end
  end

  def male_not_sue
    if gender == "male" && first_name == "Sue"
      errors.add(:first_name, "Males cannot have the name Sue")
    end
  end

  def self.get_all_profiles(min_year, max_year)
    Profile.where("birth_year BETWEEN :min_year AND :max_year",
                  min_year: min_year, max_year: max_year).order(birth_year: :asc)
  end
end
