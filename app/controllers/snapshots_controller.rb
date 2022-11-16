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
    file_data = params[:import][:attachment]
    json_data = JSON.parse(file_data.read)
    json_data.each do |jd|
      task = Task.new(
        title: jd['title'],
        description: jd['description'],
        completed_at: jd['completed_at'],
        repeat_after: jd['repeat_after'],
        user_ids: jd['user_ids'].map{|i| i -1 }
      )
      task.save(validate: false)
    end
    
    redirect_to root_path
  end

end
