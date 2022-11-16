
class Conf
  class << self
    def enable_backup
      defined?(ENABLE_BACKUP) ? ENABLE_BACKUP : true
    end
  end
end