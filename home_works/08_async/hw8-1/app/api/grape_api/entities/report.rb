class GrapeApi
  module Entities
    class Report < Grape::Entity
      # Отображает идентификатор отчета
      expose :id, documentation: { type: 'Integer', desc: 'Идентификатор отчёта', required: true }
      # Отображает пользовательское название отчета
      expose :name, documentation: { type: 'String', desc: 'Пользовательское название отчёта', required: false }
      # Отображает тело отчета
      expose :body, documentation: { type: 'String', desc: 'Тело отчёта', required: false }
      # Отображает тип отчета
      expose :report_type, documentation: { type: 'Integer', desc: 'Тип отчёта', required: true }

      # Метод для динамического преобразования тела отчета из JSON в хэш
      def body
        # Преобразование строки JSON в хэш, если тело отчета не пусто
        body_hash = JSON.parse(object.body) unless object.body.nil?
        body_hash
      end
    end
  end
end
