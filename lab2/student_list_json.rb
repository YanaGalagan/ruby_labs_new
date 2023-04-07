# frozen_string_literal: true
require_relative '../dent_list_strat'
require 'json'

class StudentListJson < StudentListStrategy

  public_class_method :new

  def string_to_list(str)
    JSON.parse(str, {symbolize_names: true})
  end

  def list_to_string(list)
    JSON.generate(list)
  end
end