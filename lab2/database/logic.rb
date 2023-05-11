require_relative 'controller'
require_relative 'window'
require_relative '../all_data/data_table'
require_relative 'student_create_form'
class LogicWindow
  include Glimmer

  STUDENTS_PER_PAGE = 10

  def initialize
    @controller = StudentListController.new(self)
    @current_page = 1
    @total_count = 0
  end

  def on_create
    @controller.on_view_created
    @controller.refresh_data(@current_page, STUDENTS_PER_PAGE)
  end

  def on_datalist_changed(new_table)
    arr = new_table.to_my_array
    arr.map do |row|
      row[3]=[row[3][:phone_number] || row[3][:telegram] || row[3][:mail]]
    end

    @table.model_array = arr
  end

  def update_student_count(new_cnt)
    @total_count = new_cnt
    @page_label.text = "#{@current_page} / #{(@total_count / STUDENTS_PER_PAGE.to_f).ceil}"
  end

  def create
    root_container = horizontal_box {

      # 1 область
      vertical_box {
        form {
          stretchy false

          @filter_last_name_initials = entry {
            stretchy false
            label 'Фамилия И. О.'
          }

          @filters = {}
          fields = [[:git, 'Гит'], [:mail, 'Почта'], [:phone_number, 'Телефон'], [:telegram, 'Телеграм']]

          fields.each do |field|
            @filters[field[0]] = {}

            @filters[field[0]][:combobox] = combobox {
              stretchy false
              label "#{field[1]} имеется?"
              items ['Не важно', 'Да', 'Нет']
              selected 0

              on_selected do
                if @filters[field[0]][:combobox].selected == 1
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
        stretchy false
        @table = refined_table(
          table_editable: false,
          filter: lambda do |row_hash, query|
            utf8_query = query.force_encoding("utf-8")
            row_hash['Фамилия И. О'].include?(utf8_query)
          end,
          table_columns: {
            '#' => :text,
            'Фамилия И. О' => :text,
            'Гит' => :text,
            'Контакт' => :text
          },
        )

        @pages = horizontal_box {
          stretchy false

          button("<") {
            stretchy true

            on_clicked do
              @current_page = [@current_page - 1, 1].max
              @controller.refresh_data(@current_page, STUDENTS_PER_PAGE)
            end

          }
          @page_label = label("...") { stretchy false }
          button(">") {
            stretchy true

            on_clicked do
              @current_page = [@current_page + 1, (@total_count / STUDENTS_PER_PAGE.to_f).ceil].min
              @controller.refresh_data(@current_page, STUDENTS_PER_PAGE)
            end
          }
        }
      }

      # 3 область
      vertical_box{
        stretchy false

        button('Добавить') {
          stretchy false
          on_clicked{
            StudentCreateForm.new.create.show
          }
        }
        button('Изменить') { stretchy false }
        button('Удалить') { stretchy false }
        button('Обновить') {
        stretchy false
        on_clicked{
          @controller.refresh_data(@current_page, STUDENTS_PER_PAGE)
        }}
      }
    }
    on_create
    root_container
  end


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