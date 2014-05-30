class HardWorker
  include Sidekiq::Worker

  def self.perform_async(*args)
    queue = "queue:elixir"
    json = 
    { 
      queue: queue,
      class: self.class.to_s,
       args: args,
        jid: SecureRandom.hex(12),
enqueued_at: Time.now.to_f
    }.to_json
    
    client = Sidekiq.redis { |conn| conn }
    client.lpush(queue, json)
  end

  def perform(*args)
    puts "Received: #{args}"
  end
  
end
