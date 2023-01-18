
class Conf
  class << self
    def enable_backup
      defined?(ENABLE_BACKUP) ? ENABLE_BACKUP : true
    end

    def task_priority
      defined?(TASK_PRIORITY) ? TASK_PRIORITY : { low_priority: 10, medium_priority: 20, high_priority: 30 }
    end
  end
end