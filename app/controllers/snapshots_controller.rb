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
    add_breadcrumb selected_department.name, root_path
    add_breadcrumb folder.name, folder if folder
    add_breadcrumb "Spørgeskemaer", questionnaires_path(folder_id: folder.id)
    add_breadcrumb "Importer"

    @folders = selected_department.folders.map { |f| [f.name, f.id] }
    @selected_folder = params[:folder_id]
  end

end
