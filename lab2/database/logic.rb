
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

        stretchy true
        @table = table {
          text_column('ФИО') {
            on_clicked do
              sort_by_column(0)
            end
          }
          text_column('Гит') {
            on_clicked do
              sort_by_column(2)
            end
          }
          text_column('Контакт') {
            on_clicked do
              sort_by_column(1)
            end
          }

          editable false

          cell_rows [['Иванов И.И. ', '@vinya', 'ivan@mail.ru'],
                     ['Петров П.П.', '@petr', '+79384568921'],
                     ['Сидоров С.С.', '@sidorov567', 'sidorsidorov@mail.ru']]
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
  }
  private
  def sort_by_column(column_index)
    data = @table.cell_rows
    if @sort_column == column_index
      data.reverse!
      @sort_order = (@sort_order == :asc) ? :desc : :asc
    else
      @sort_column = column_index
      @sort_order = :asc
      data.sort_by! { |row| row[column_index].to_s }
    end
    @table.cell_rows = data
  end

end