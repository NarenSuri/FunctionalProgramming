defmodule Profilehashmapimage do
  @moduledoc """
  Documentation for Profilehashmapimage.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Profilehashmapimage.hello
      :world

  """
  def hello do
    :world
  end
  
  def imagegeneration(input) do 
  hashProcessing(input)
  |> rgbgeneration()
  end
  
  def rgbgeneration(imagestruct) do 
  # we can reuse the struct we already created
  imagestruct
  
  end
  
  def hashProcessing(input) do 
  hexval = :crypto.hash(:md5,input)
  |> :binary.bin_to_list()
  
  
  end
  
  
  
end
