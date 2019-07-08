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

end
