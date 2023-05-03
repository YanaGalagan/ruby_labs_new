# frozen_string_literal: true
require 'glimmer-dsl-libui'
require_relative 'logic'
class Window

  def initialize
    @logic_tab = LogicWindow.new
  end

  include Glimmer
  def create
    window('Tabs', 1000, 500) {
      margined true
      tab {
        tab_item('Tab 1') {
          @logic_tab.create
        }
        tab_item('Tab 2') { }
        tab_item('Tab 3') { }
      }
    }
  end
end
