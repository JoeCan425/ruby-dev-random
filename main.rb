#!/usr/bin/env ruby

require 'digest'
require "socket"

require "vmstat"

# Generate intial seed based on users machine
def get_initial_seed
  Time.now().to_s + Process.pid.to_s + Socket.gethostname + Vmstat.boot_time.to_s
end

# Create entropy based on system settings
def get_entropy(reader, writer, limit)
  reader.read_nonblock(limit)
rescue IO::WaitReadable
  # Sleep a minute to allow the system settings to change
  sleep(1)

  # Collect system info for entropy
  entropy = Vmstat.disk("/").to_s + Vmstat.load_average.to_s +
    + Vmstat.memory.to_s + Vmstat.cpu.to_s
  writer.write(entropy.hash)

  retry
end

# Create a 512 bit digest based on the seed and entropy
def get_hash(seed, entropy)
  Digest::SHA512.hexdigest(seed + entropy)
end

def dev_random(limit)
  reader, writer = IO.pipe
  seed = get_initial_seed()
  
  while true do
    entropy = get_entropy(reader, writer, limit)

    hash = get_hash(seed, entropy)
    STDOUT.write(hash)
      
    # Update the seed to the new hash
    seed = hash
  end
end

def main
  limit = 8
  dev_random(limit)
end

main
