# This code help us print out log in both stdout and log file

class MultiLogger
  def initialize(*targets)
    @targets = targets
  end

  %w(log debug info warn error fatal unknown).each do |m|
    define_method(m) do |*args|
      @targets.map { |t| t.send(m, *args) }
    end
  end
end

$stderr_log = Logger.new(STDERR)
$file_log = Logger.new('logger.log', 5, 1024 * 1024)
$stderr_log.level = Logger::INFO
$file_log.level = Logger::DEBUG

$log = MultiLogger.new( $stderr_log, $file_log )

# How to use
$log.info 'log info...'
$log.warn 'warning message log...'
