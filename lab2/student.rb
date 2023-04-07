
require 'json'
require_relative '../dent_short'
class Student < StudentShort


  attr_reader :first_name, :middle_name, :phone_number, :mail , :telegram
  def self.is_phone?(phone_number)
    raise ArgumentError, "arg '#{phone_number}' is not string" unless phone_number.class == String or phone_number.nil?
    return true if phone_number=~/^(\+7|8)\s?(\(\d{3}\)|\d{3})[\s\-]?\d{3}[\s\-]?\d{2}[\s\-]?\d{2}/ or phone_number.nil?

    false
  end

  def self.is_name?(name)
    raise ArgumentError, "arg '#{name}' is not string" unless name.class == String
    return true if name=~/^[А-Яа-я]+$/
  end

  def self.is_mail?(mail)
    raise ArgumentError, "arg '#{mail}' is not string" unless mail.class == String or mail.nil?
    return true if mail=~/^[^@\s]+@[^@\s]+\.\w+$/ or mail.nil?
  end

  def self.is_git?(git)
    raise ArgumentError, "arg '#{git}' is not string" unless git.class == String or git.nil?
    return true if git=~/^github\.com\/[a-zA-Z0-9\-_]+$/ or git.nil?

    false
  end

  def self.is_telegram?(telegram)
    raise ArgumentError, "arg '#{telegram}' is not string" unless telegram.class == String or telegram.nil?
    return true if telegram=~/^@[^@]+$/ or telegram.nil?

    false
  end

  #конструктор
  def initialize(first_name: nil, middle_name:nil, surname:nil, id:nil,phone_number:nil, git:nil,telegram:nil, mail:nil)
    self.first_name = first_name
    self.middle_name = middle_name
    self.surname = surname
    self.id = id
    self.git = git
    set_contacts(phone_number: phone_number,mail: mail, telegram:telegram)
  end

  def short_name
    "#{surname} #{first_name[0]}. #{middle_name[0]}."
  end

  def get_info
    result = "#{short_name}" if !(first_name.nil? or middle_name.nil? or surname.nil?)
    result += " #{get_contact}"  unless get_contact.nil?
    result += "git= #{git}" unless git.nil?
    result
  end

  def self.pars_str(str)
    args = JSON.parse(str)
    raise ArgumentError,"The argument must have first_name, middle_name and surname" unless
      (args.has_key?('first_name') and args.has_key?('middle_name') and args.has_key?('surname'))

    new(first_name: args['first_name'], middle_name: args['middle_name'],
        surname: args['surname'], id: args['id'],
        git: args['git'],
        phone_number: args['phone_number'], telegram: args['telegram'],
        mail: args['mail'])
  end
  def to_hash
    attrs = {}
    %i[first_name middle_name surname id phone_number telegram mail git].each do |attr|
      attr_val = send(attr)
      attrs[attr] = attr_val unless attr_val.nil?
    end
    attrs
  end
  def set_contacts(phone_number:nil, mail:nil, telegram:nil)
    self.phone_number = phone_number unless phone_number.nil?
    self.mail = mail unless mail.nil?
    self.telegram = telegram unless telegram.nil?
    @contact = contact
  end

  #сеттеры
  def id=(id_value)
    @id=id_value
  end

  def first_name=(first_name_value)
    raise ArgumentError, "Incorrect value: first_name=#{first_name}!" unless Student.is_name?(first_name_value)

    @first_name=first_name_value
  end

  def middle_name=(middle_name_value)
    raise ArgumentError, "Incorrect value: middle_name=#{middle_name}!" unless Student.is_name?(middle_name_value)

    @middle_name=middle_name_value
  end

  def surname=(surname_value)
    raise ArgumentError, "Incorrect value: surname=#{surname}!" unless Student.is_name?(surname_value)

    @surname=surname_value
  end

  def git=(git_value)
    raise ArgumentError, "Incorrect value: git=#{git}!" unless Student.is_git?(git_value)

    @git=git_value
  end
  protected
  def phone_number=(phone_number_value)
    raise ArgumentError, "Incorrect value: phone_number=#{phone_number_value}!" unless Student.is_phone?(phone_number_value)

    @phone_number=phone_number_value
  end

  def mail=(mail_value)
    raise ArgumentError, "Incorrect value: mail=#{mail}!" unless Student.is_mail?(mail_value)

    @mail=mail_value
  end

  def telegram=(telegram_value)
    raise ArgumentError, "Incorrect value: telegram=#{telegram}!" unless Student.is_telegram?(telegram_value)

    @telegram=telegram_value
  end
  public

  def to_s
    result = "#{first_name} #{middle_name} #{surname}"
    result += " id=#{id}" unless id.nil?
    result += " phone=#{phone_number}" unless phone_number.nil?
    result += " git=#{git}" unless git.nil?
    result += " telegram=#{telegram}" unless telegram.nil?
    result += " mail=#{mail}" unless mail.nil?
    result
  end

  def contact
    return @contact = "phone_number= #{phone_number}" unless phone_number.nil?
    return @contact = "telegram= #{telegram}" unless telegram.nil?
    return @contact = "mail= #{mail}" unless email.nil?

    nil
  end

end

