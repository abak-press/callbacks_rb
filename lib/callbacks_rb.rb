require 'callbacks_rb/version'

module CallbacksRb
  def self.included(base)
    base.class_eval do
      attr_reader :callbacks

      extend ClassMethods
    end
  end

  module ClassMethods
    def callback(name)
      send :define_method, "#{name}=" do |method, &block|
        register_callback(name.to_sym, method, &block)
      end

      send :define_method, "#{name}" do |method = nil, &block|
        register_callback(name.to_sym, method, &block)
      end
    end
  end

  def register_callback(name, method = nil, &block)
    init_callbacks_list unless @callbacks.present?
    name = name.to_sym
    if block_given?
      (@callbacks[name] ||= []) << block
    elsif method.present?
      (@callbacks[name] ||= []) << method
    end
    self
  end

  def fire_callback(name, *args)
    name = name.to_sym
    return if !@callbacks || !@callbacks.key?(name)
    @callbacks[name].each { |callback| callback.call(*args) }
  end

  def register_callbacks(list)
    return if list.blank?
    list.each do |name, block|
      register_callback(name, block)
    end
  end

  protected

  def init_callbacks_list
    @callbacks = {}
  end
end
