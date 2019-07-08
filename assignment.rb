class Assignment

  def parse_input_jobs(jobs_as_string)
    job_graph = Hash.new
    jobs_with_dependency = jobs_as_string.split("\n").reject do |job|
      job.nil? || job.strip.empty?
    end
    .map do |job|
      job.strip
    end
    jobs_with_dependency.each do |job_with_dependency|
      jobs = job_with_dependency.split("=>").map { |job| job.strip }
      job_graph[jobs[0]] = jobs[1]
    end
    job_graph
  end

  def check_presence_of_cycle_from_job(starting_job, job_graph)
    job_stack = [starting_job]
    visited_jobs = [starting_job]

    while job_stack.length != 0
      job = job_stack.pop
      if job_graph.key?(job)
        dependent_job = job_graph[job]
        if visited_jobs.include? dependent_job
          return true
        else
          visited_jobs.append(dependent_job)
          job_stack.append(dependent_job)
        end
      end
    end
    false
  end

  def check_presence_of_cycle_in_job_graph(job_graph)
    job_graph.keys.each do |job|
      if check_presence_of_cycle_from_job(job, job_graph)
        return true
      end
    end
    return false
  end

  def check_if_job_depends_on_self(job_graph)
    job_graph.keys.each do |job|
      if job_graph[job] == job
        return true
      end
    end
    return false
  end

  def create_reverse_job_graph(job_graph)
    reverse_graph = Hash.new
    job_graph.each do |key,value|
      if value.nil?
        next
      end
      if reverse_graph.key? value
        reverse_graph[value].append(key)
      else
        reverse_graph[value] = [key]
      end
    end
    reverse_graph
  end

  def perform_jobs(job_description)
    job_graph = parse_input_jobs(job_description)

    is_any_job_depends_on_itself = check_if_job_depends_on_self(job_graph)
    if is_any_job_depends_on_itself
      puts "Can not perform jobs : A job depends on itself"
      return
    end

    is_cycle_present = check_presence_of_cycle_in_job_graph(job_graph)
    if is_cycle_present
      puts "Can not perform jobs : presence of cycle detected"
      return
    end

    # Get the difference between job_graph and reverse_job_graph
    # This is to find out the jobs which can be performed independently
    r_job_graph = create_reverse_job_graph(job_graph)
    job_graph_keys = job_graph.select { |k,v| k unless v.nil? }.keys
    independent_jobs = r_job_graph.keys - job_graph_keys

    jobs_to_perform = independent_jobs
    performed_jobs = Array.new

    # Loop through the jobs_to_perform
    # Perform the job and add the job which are dependent on it
    while jobs_to_perform.length != 0
      job = jobs_to_perform.shift
      if job.nil?
        next
      end
      unless performed_jobs.include? job
        performed_jobs.append(job)
      end
      if r_job_graph.key? job
        dependent_jobs = r_job_graph[job]
        dependent_jobs.each do |j|
          jobs_to_perform.append(j)
        end
      end
    end
    performed_jobs
  end

end
