# on_the_beach_software_assignment

I approached the problem as a directed graph processing problem, 
where job is a node of the graph and edge represents depends_on relationship between two jobs.

First task was to check the presence of cycle. This was done by performing "depth_first_search"
on each node. If a job gets visited again, then there is cycle present in the job_graph

After that reverse the job_graph and get the jobs which are present as key in the reverse_job_graph 
but not in job_graph key.
This returns the jobs that can be performed independely.

Perform independent jobs and then get their dependent jobs.

# I used ruby language and have used 'minitest' gem for writing tests.
