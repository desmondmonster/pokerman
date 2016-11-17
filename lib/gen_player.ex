defmodule GenPlayer do
  use GenServer

  # Public API

  def start_link(player_name) do
    GenServer.start_link(__MODULE__, player_name, name: Player)
  end

  def name(pid), do: GenServer.call(pid, {:name})

  def stack(pid), do: GenServer.call(pid, {:stack})

  def cards(pid), do: GenServer.call(pid, {:cards})

  def buy_chips(pid, amount), do: GenServer.cast(pid, {:add_chips, amount})

  # Callbacks

  def init(player_name) do
    {:ok, %{name: player_name, stack: 0, cards: []}}
  end

  def handle_cast({:add_chips, amount}, player_details) do
    player_details  = Map.update!(player_details, :stack, &(&1 + amount))
    {:noreply, player_details}
  end

  def handle_call({:name}, _from, player_details) do
    {:reply, player_details[:name], player_details}
  end

  def handle_call({:stack}, _from, player_details) do
    {:reply, player_details[:stack], player_details}
  end

  def handle_call({:cards}, _from, player_details) do
    {:reply, player_details[:cards], player_details}
  end
end
