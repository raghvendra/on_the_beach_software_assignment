class Assignment

  def parse_input_jobs(job_as_string)
    job_graph = Hash.new
    jobs_with_dependency = job_as_string.split("\n").reject do |job|
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

end
