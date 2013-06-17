module TasksHelper

  def count_of_tasks_need_verify
    Task.count(:conditions => "status = 3")
  end

  def count_of_available_tasks
    Task.count(:conditions => "status = 1")
  end
  
end
