defmodule PingPong do

  def pingpong do
    pinger_pid = spawn(Pinger, :loop, [])
    ponger_pid = spawn(Ponger, :loop, [])

    send(ponger_pid, {pinger_pid, :ping})
  end
end

defmodule Pinger do

  def loop do
    receive do
      {sender_pid, :pong} ->
        send(sender_pid, {self(), :ping})
        IO.puts "#{:ping} from Pinger"
        loop()
      _ ->
        loop()
    end

  end

end

defmodule Ponger do

  def loop do
    receive do
      {sender_pid, :ping} ->
        send(sender_pid, {self(), :pong})
        IO.puts "#{:pong} from Ponger"
        loop()
      _ ->
        loop()
    end
  end

end
