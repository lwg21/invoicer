module Snapshotable
  extend ActiveSupport::Concern

  class_methods do
    def snapshot_fields
      @snapshot_fields || {}
    end

    def set_snapshot_fields(fields)
      @snapshot_fields = fields
      define_snapshot_readers!
    end

    private

    def define_snapshot_readers!
      @snapshot_fields.each_key do |table|
        define_method("#{table}_field") do |field|
          if issued?
            public_send("#{table}_#{field}")
          else
            public_send(table).public_send(field)
          end
        end
      end
    end
  end

  def take_snapshot!
    data = {}
    self.class.snapshot_fields.each do |table, fields|
      fields.each do |field|
        data["#{table}_#{field}"] = public_send(table).public_send(field)
      end
    end
    self.update(data)
  end
end
