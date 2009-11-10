God.watch do |w|
  w.name = 'Apache'
  w.group = 'global'
  w.interval = 30.minutes
  
  w.start = '/etc/init.d/apache2 start'
  w.restart = "/etc/init.d/apache2 restart"
  w.stop = "/etc/init.d/apache2 stop"
  w.pid_file = '/var/run/apache2.pid'
  
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  
  w.behavior(:clean_pid_file)
  
  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 150.megabytes
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