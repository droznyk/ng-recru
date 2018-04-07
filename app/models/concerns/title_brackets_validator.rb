class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    validate_number_of_normal_brackets(@record)
    validate_number_of_curly_brackets(@record)
    validate_number_of_square_brackets(@record)
    validate_normal_brackets_order_if_brackets_are_present(@record)
    validate_normal_brackets_are_not_empty_if_brackets_are_present(@record)
  end

  private

  def validate_number_of_normal_brackets(record)
    unless record.title.count('(') == record.title.count(')')
      record.errors.add(:title, "Invalid number of brackets")
    end
  end

  def validate_number_of_curly_brackets(record)
    unless record.title.count('{') == record.title.count('}')
      record.errors.add(:title, "Invalid number of brackets")
    end
  end

  def validate_number_of_square_brackets(record)
    unless record.title.count('[') == record.title.count(']')
      record.errors.add(:title, "Invalid number of brackets")
    end
  end

  def validate_normal_brackets_order_if_brackets_are_present(record)
    if record.title.include?('(') && record.title.include?(')')
      unless record.title.index('(') < record.title.index(')')
        record.errors.add(:title, "Brackets in wrong order")
      end
    end
  end

  def validate_normal_brackets_are_not_empty_if_brackets_are_present(record)
    if record.title.include?('(') && record.title.include?(')')
      if record.title.index('(') +1 == record.title.index(')')
        record.errors.add(:title, "Brackets are empty")
      end
    end
  end
end
