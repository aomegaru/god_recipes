God.watch do |w|
  jesus_path = ROOT + '/../../../jesus/'
  
  w.name = 'Jesus'
  w.group = 'global'
  w.interval = 30.minutes
  
  w.start = "cd #{jesus_path}; sudo /usr/bin/unicorn -c unicorn.rb -D"
  w.stop = "kill -QUIT `cat /tmp/jesus.pid`"
  w.restart = "kill -USR2 `cat /tmp/jesus.pid`"
  w.pid_file = "/tmp/jesus.pid"
  
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  
  w.behavior(:clean_pid_file)
  
  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 300.megabytes
      c.times = [3, 5] #3 out of 5 intervals
      c.notify = 'damien'
    end
    
    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
      c.notify = 'damien'
    end
  end
  
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
  
  # lifecycle
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end