class Troble < ActiveRecord::Base
  belongs_to :client
  enum client_type: {"Знаю много слов, но не могу употреблять их" => 1, "Я не могу начать говорить!" => 2, "У меня не получается применить грамматику в речи" => 3, "Я хочу работать в международной компании" => 4, "Хочу путешествовать без гида" => 5}
  validates :client_type, presence: true
  validates :client_type, inclusion: {in: Troble.client_types.keys}
end
