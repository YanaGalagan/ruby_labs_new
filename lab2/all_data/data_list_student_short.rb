# frozen_string_literal: true

require_relative 'data_list'

class DataListStudentShort < DataList

  def initialize(objects)
    super(objects)
  end

  def get_names
    ["short_name_initials", "git", "contact"]
  end

  protected def table_fields(object)
    [object.short_name_initials, object.git, object.contact]
  end
end
