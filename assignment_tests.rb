require 'minitest/autorun'
require_relative 'assignment'

class AssignmentTests < Minitest::Test

  def setup
    @assignment = Assignment.new
  end

  def test_job_description_can_be_parsed
    jobs = """
    a => b
    b => c
    """
    job_graph = @assignment.parse_input_jobs(jobs)
    assert_equal "b", job_graph["a"]
    assert_equal "c", job_graph["b"]
    assert_equal 2, job_graph.size
  end

  def test_presence_of_self_dependent_job_is_detected
    jobs = """
    a => a
    b => c
    """
    job_graph = @assignment.parse_input_jobs(jobs)
    is_cycle_present = @assignment.check_if_job_depends_on_self(job_graph)
    assert_equal true, is_cycle_present
  end

  def test_presence_of_cycle_is_detected
    jobs = """
    a => b
    b => c
    c => a
    """
    job_graph = @assignment.parse_input_jobs(jobs)
    is_cycle_present = @assignment.check_presence_of_cycle_in_job_graph(job_graph)
    assert_equal true, is_cycle_present
  end

  def test_perform_jobs_return_nil_if_cycle_is_present
    jobs = """
    a => b
    b => c
    c => a
    """
    performed_jobs = @assignment.perform_jobs(jobs)
    assert_nil performed_jobs
  end

  def test_perform_jobs_return_nil_if_job_depends_on_self
    jobs = """
    a => b
    b => c
    c => c
    """
    performed_jobs = @assignment.perform_jobs(jobs)
    assert_nil performed_jobs
  end

  def test_job_graph_case_1
    jobs = """
    a => b
    b => c
    c => d
    d =>
    """
    performed_jobs = @assignment.perform_jobs(jobs)
    assert_equal ["d", "c", "b", "a"], performed_jobs
  end

  def test_job_graph_case_2
    jobs = """
    a =>
    b => c
    c => f
    d => a
    e => b
    f =>
    """
    performed_jobs = @assignment.perform_jobs(jobs)
    assert_equal ["f", "a", "c", "d", "b", "e"], performed_jobs
  end

  def test_job_graph_case_3
    job_description = """
    a => b
    a => c
    b => d
    c => d
    d =>
    """
    performed_jobs = @assignment.perform_jobs(job_description)
    assert_equal ["d", "b", "c", "a"], performed_jobs
  end
end
