defmodule Queue do
  use GenServer

  # CLIENT

  @doc """
  Start GenServer

  ## Examples

      iex> {:ok, pid} = Queue.start_link([1,2,3])
      {:ok, #PID<0.122.0>}

  """
  def start_link(initial_state) when is_list(initial_state) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  @doc """
  Add a element at the end of list

  ## Examples

      iex> Queue.enqueue(pid, 5)
      :ok

  """
  def enqueue(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  @doc """
  Remove a element at the start of list

  ## Examples

      iex> Queue.dequeue(pid)
      1

  """
  def dequeue(pid) do
    GenServer.call(pid, :pop)
  end

  # SERVER (CALLBACKS)

  @impl true
  def init(initial_state) when is_list(initial_state) do
    {:ok, initial_state}
  end

  # sync
  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    new_state = tail

    return = head

    # IO.inspect(new_state)

    # reply = respondendo pra quem chamou
    {:reply, return, new_state}
  end

  @impl true
  def handle_call(:pop, _from, []) do
    new_state = []

    return = nil

    {:reply, return, new_state}
  end

  # async
  @impl true
  def handle_cast({:push, element}, current_state) do
    new_state = current_state ++ [element]

    # IO.inspect(new_state)

    {:noreply, new_state}
  end
end
