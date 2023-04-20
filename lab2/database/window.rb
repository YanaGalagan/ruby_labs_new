# frozen_string_literal: true
require 'glimmer-dsl-libui'
require_relative 'logic'
class Window
  include Glimmer
  def create
    window('Tabs', 700, 500) {
      margined true
      tab {
        tab_item('Tab 1') {
          logicfromwindow

        }


        tab_item('Tab 2') { }
        tab_item('Tab 3') { }
      }
    }
  end
end
