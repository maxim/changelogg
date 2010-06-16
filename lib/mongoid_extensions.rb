module Mongoid
  module Attributes
    def has_attribute?(name)
      access = name.to_s
      !fields[access].nil?
    end
    
    alias :[] :read_attribute
    alias :[]= :write_attribute
  end
end