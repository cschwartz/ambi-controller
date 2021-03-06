require "fileutils"

class AmbiTvConfiguration
  include ActiveModel::Model

  def initialize
    @programs = {}
    @components = {}
    reload!
  end

  def reload!(parser = AmbiConfigProcessor.parse(AmbiTvConfiguration.FILENAME))
    @programs.clear
    parser.programs.each do |program|
      @programs[program.name] = program
    end

    @components.clear
    parser.components.each do |component|
      @components[component.name] = component
    end
  end

  def programs
    current_program = File.open(File.join(AmbiTvConfiguration.STATUS_PATH, "current_program")).read.strip
    @programs.each_value do |program|
      program.isCurrent = (program.name == current_program)
    end
    @programs.values
  end

  def program_by_name(name)
    @programs[name]
  end

  def components
    @components.values
  end

  def component_by_name(name)
    @components[name]
  end

  def switch_program(program)
    program_id = program.id
    create_switch_file(program_id)
  end

  def pause(do_pause)
    filename = File.join(AmbiTvConfiguration.TRIGGER_PATH, do_pause ? "stop" : "start")
    if Rails.env.development?
      puts filename
    else
      FileUtils.touch(filename)
    end
  end

  def shutdown(do_shutdown)
    command = "sudo halt"
    if Rails.env.development?
      puts command
    else
      `#{ command }`
    end
  end

  def create_switch_file(program_id)
    filename = File.join(AmbiTvConfiguration.TRIGGER_PATH, "switch_mode.#{ program_id }")
    if Rails.env.development?
      puts filename
    else
      FileUtils.touch(filename)
    end
  end

  def self.FILENAME
    if Rails.env.development?
      "test/fixtures/ambi-tv.conf"
    else
      "/etc/ambi-tv.conf"
    end
  end

  def self.STATUS_PATH
    "/var/ambi-tv/status"
  end

  def self.TRIGGER_PATH
    "/var/ambi-tv/triggers"
  end
end
