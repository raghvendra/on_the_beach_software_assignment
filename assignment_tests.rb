require 'minitest/autorun'
require_relative 'assignment'

class AssignmentTests < Minitest::Test

  def setup
    @assignment = Assignment.new
  end

  def test_parse_jobs
    jobs = """
    a => b
    b => c
    """
    job_graph = @assignment.parse_input_jobs(jobs)
    assert_equal "b", job_graph["a"]
    assert_equal "c", job_graph["b"]
    assert_equal 2, job_graph.size
  end

  def test_job_graph_with_cycle1
    jobs = """
    a => a
    b => c
    """
    job_graph = @assignment.parse_input_jobs(jobs)
    is_cycle_present = @assignment.check_presence_of_cycle_in_job_graph(job_graph)
    assert_equal true, is_cycle_present
  end

  def test_job_graph_with_cycle1
    jobs = """
    a => b
    b => c
    c => a
    """
    job_graph = @assignment.parse_input_jobs(jobs)
    is_cycle_present = @assignment.check_presence_of_cycle_in_job_graph(job_graph)
    assert_equal true, is_cycle_present
  end
end
