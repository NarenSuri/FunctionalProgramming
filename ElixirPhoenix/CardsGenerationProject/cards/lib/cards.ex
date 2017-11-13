defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello
      :world

  """
  def hello do
    "Hello world."
  end
  
  def createDeck do
  ["Ace","Two","Three"]
  end
  
  def shuffleDeck(deck) do
  Enum.shuffle(deck)
  end
  
  def generateDeck do
  values = ["One","Two","Three","Four"]
  suits=["Spades","Clubs","Hearts","Diamonds"]
  cards = for value <- values do
	for suit <- suits do 
	"#{suit} of #{value}"
	end
  end 
  
  end
  
  def pickToHands(cards,size) do
  Enum.split(cards,size)
  end
  
  def pipedPiperDeck(splitSiz) do
  
 {leftHand , rightHand} =  generateDeck()
  |> shuffleDeck()
  |> List.flatten()
  |> pickToHands(splitSiz)
  
  leftHand ++  rightHand

  end
  
  def saveAndLoad(name) do
   cardstosave = generateDeck()
  |> shuffleDeck()
  |> List.flatten()
  File.write(name,:erlang.term_to_binary(cardstosave))
  {status, data} = File.read(name)  
  :erlang.binary_to_term(data)
  
  case status do
  :ok -> :erlang.binary_to_term(data)
  :error -> "Sorry something went wrong"
  end  
 end
end
