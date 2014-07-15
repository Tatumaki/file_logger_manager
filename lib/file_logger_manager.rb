require "file_logger_manager/version"
require 'file_logger'

class FileLoggerManager
  def initialize(names: nil,prefix: "logger",date: true,dir: "log")
    @loggers = Hash.new
    @prefix = prefix
    @prefix += "_" + Time.now.strftime("%Y%m%d%H%M%S") if date
    @dir = dir
    names.each do |name|
      @loggers[name.to_sym] = open(name)
    end
  end
  
  def filename(name)
    return "#{@dir}/#{@prefix}_"+name.to_s+".log"
  end

  def open(name)
    name = filename(name)
    return FileLogger.new(name)
  end

  def save
    self.each do |logger|
      logger.save
    end
  end

  def [](name)
    unless @loggers.has_key?(name.to_sym)
      @loggers[name.to_sym] = open(name)
      STDERR.puts "New file '#{name}' was opend."
    end
    return @loggers[name.to_sym]
  end

  def list
    @loggers.keys
  end
  
  def delete
    @loggers.each do |key,value|
      value.delete
    end
  end

  def close
    @loggers.each do |key,value|
      value.close
    end
  end

  def each
    @loggers.each do |key,value|
      yield(value)
    end
  end
end
