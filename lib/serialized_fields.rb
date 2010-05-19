module SerializedFields
  def self.included(base)
    base.send :extend, ClassMethods
  end
  module ClassMethods
    def serialized(*args)
      args.each do |column|
        if column_names.include?(column.to_s)
          self.class_eval do
            define_method("#{column}="){|val| write_attribute(column, val.to_yaml)}
            define_method(column){YAML::load(read_attribute(column))}
          end
        else
          raise "There is no column named #{column}!"
        end
      end
    end
  end
end