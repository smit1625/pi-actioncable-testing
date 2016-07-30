class GpioUtil
  BIN_PATH = File.expand_path('../../bin/gpio_util', __FILE__)

  def initialize(pin:)
    @pin = pin
  end

  def write(value:)
    command_pin! value
  end

  def read(mode: 'read')
    command_pin!("-d in -m down -a #{mode}") unless mode == 'read'
    yield read_from_pin
  end

  protected
  attr_reader :pin

  def command_pin!(command)
    Kernel.system formulate_command command
  end

  def read_from_pin
    `#{formulate_command '-d in -m down'}`
  end

  private

  def formulate_command(command)
    "#{BIN_PATH} -p #{pin} #{command}"
  end

end