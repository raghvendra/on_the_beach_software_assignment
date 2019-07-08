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

end
