module TasksHelper

  def count_of_tasks_need_verify
    Task.count(:conditions => "status = 3")
  end
  
  def count_of_assigned_tasks(user)
    user.tasks.count(:conditions => "status = 1")
  end

  def count_of_available_tasks
    Task.count(:conditions => "status = 1")
  end
  
  def time_format(task)
    if task.updated_at.strftime('%m/%d/%Y') == Date.today.strftime('%m/%d/%Y')
      '%l:%M %P'
    else
      '%m/%d/%Y'
    end
  end

end
