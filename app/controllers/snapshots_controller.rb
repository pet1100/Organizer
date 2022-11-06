class SnapshotsController < HomeController
  def show
  end

  def export
    time = DateTime.now
    time_as_string = time.strftime("%-d/%-m/%y")
    json = Task.all.map(&:ser).as_json
    send_data JSON.generate(json), filename: "backup_at_#{time_as_string}.json"
  end

  def import

  end

  def load
  end

end
