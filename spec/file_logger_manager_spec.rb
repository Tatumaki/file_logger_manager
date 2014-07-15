require 'spec_helper'

describe FileLoggerManager do
  it 'has a version number' do
    expect(FileLoggerManager::VERSION).not_to be nil
  end

  it 'created some log files to current dir.' do
    loggers = FileLoggerManager.new(names: [:one,:two,:three],prefix: "TEST",date: false,dir: ".")
    loggers[:one].puts :one
    loggers[:two].puts :two
    loggers[:three].puts :three

    one = loggers[:one].get
    two = loggers[:two].get
    three = loggers[:three].get

    loggers.close
    
    ret  = File.exist?(one)
    ret &= File.exist?(two)
    ret &= File.exist?(three)

    expect(ret).not_to be false

    File.delete one
    File.delete two
    File.delete three
  end
end
