class Password
  attr_reader :password, :repeat_password, :validation
  def initialize
    @validation = Validation.new
  end
  def get_password(repeat = false)
    repeat ? @repeat_password = gets.chomp : @password = gets.chomp
  end
  def valid?
    @validation.match?(@password, @repeat_password) && @validation.length?(@password) && @validation.upper?(@password) && @validation.lower?(@password) && @validation.has_number?(@password)
  end
end
class UI
  def self.password
    puts "Ingresa contraseña"
  end
  def self.repeat_password
    puts "Repite tu contraseña"
  end
  def self.match_error
    puts "Las contraseñas no coinciden"
  end
  def self.length_error
    puts "Debe tener minimo 8 caracteres maximo 40"
  end
  def self.capitalized_error
    puts "Debe tener al menos una letra mayuscula"
  end
  def self.downcase_error
    puts "Debe tener al menos una letra minuscula"
  end
  def self.number_error
    puts "Debe tener al menos un numero"
  end
end
class Validation

  def match?(password, repeat_password)
    return true if password == repeat_password
    UI.match_error
    false
  end

  def length? (password)
    return true if (password.length >= 8 && password.length <= 40)
    UI.length_error
    false
  end

  def upper? (password)
    return  true if /[[:upper:]]/.match(password) != nil
    UI.capitalized_error
    false
  end

  def lower? (password)
    return  true if /[[:lower:]]/.match(password) != nil
    UI.downcase_error
    false
  end
  def has_number? (password)
  return true if password.count("0-9") > 0
  UI.number_error
  false
end
end
password_user = Password.new
validation = false
while(!validation)
  UI.password
  password_user.get_password
  UI.repeat_password
  password_user.get_password(true)
  validation = password_user.valid?
end
