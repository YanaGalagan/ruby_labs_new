
require 'glimmer-dsl-libui'
class LogicFromWindow
  include Glimmer::LibUI::CustomControl

  body {
    horizontal_box {

      # 1 область
      vertical_box {
        form {
          stretchy false

          @filter_last_name_initials = entry {
            stretchy false
            label 'ФИО'
          }

          @filters = {}
          fields = [[:git, 'Git'], [:mail, 'email'], [:phone, 'номер телефона'], [:telegram, 'телеграм']]

          fields.each do |field|
            @filters[field[0]] = {}

            @filters[field[0]][:radiobuttons] = radio_buttons {
              stretchy false
              label "Указан #{field[1]}? "
              items ['Не учитывать', 'Да', 'Нет']
              selected 0

              on_selected do
                if @filters[field[0]][:radiobuttons].selected == 1
                  @filters[field[0]][:entry].read_only = false
                else
                  @filters[field[0]][:entry].text = ''
                  @filters[field[0]][:entry].read_only = true
                end
              end
            }

            @filters[field[0]][:entry] = entry {
              stretchy false
              label field[1]
              read_only true
            }
          end
        }
      }

      #2 область
      vertical_box {
        @table = table {

          text_column('ФИО')
          text_column('Контакт')
          text_column('Гит')

          editable false
        }


        @pages = horizontal_box {
          stretchy false

          button('1')
          button('2')
          label('...') { stretchy false }
          button('15')
        }
      }

      # 3 область
      vertical_box {
        stretchy true

        button('Добавить') { stretchy false}
        button('Изменить') { stretchy false }
        button('Удалить') { stretchy false }
        button('Обновить') { stretchy false }
      }
    }

    # Добавление строк в таблицу:

  }
end