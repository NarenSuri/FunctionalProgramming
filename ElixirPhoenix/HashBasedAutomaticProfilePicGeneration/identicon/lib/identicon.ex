defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello
      :world

  """
  def hello do
    :world
  end
  

  
  def imagegeneration(input) do 
	  hashProcessing(input)
	  |> rgbgeneration
	  |> grid
	  |> filterTupledList 
      |> pixelmap
      |> renderImage
	  |> saveimage(input)	  
  end
  
  
  def rgbgeneration(imagestruct) do 
	 # we can reuse the struct we already created   
     %Identicon.Image{hex: hexval} = imagestruct
	 [r,g,b |_tail] = hexval
	 [r,g,b]
	 %Identicon.Image{imagestruct | color: {r,g,b}}
  end

  
  def grid(hashimagestruct) do     
		%Identicon.Image{hex: hexval, color: colorval} = hashimagestruct
		grid = hexval |> Enum.chunk(3)
		|> Enum.map(&mirror/1)
		|> List.flatten
		|> Enum.with_index
		%Identicon.Image{hashimagestruct | grid: grid}
  end
  
  def filterTupledList(imagestruct) do 
	  %Identicon.Image{grid: grid} = imagestruct
	  # enum filter takes input data to be filtered on and the funciton to be applied on it.
	  filter = Enum.filter grid, fn({value,_index}) -> 
	  rem(value,2)== 0 
	  end
	  %Identicon.Image{imagestruct | filteredresult: filter}
  end
  
  def pixelmap(imagestruct) do 
	%Identicon.Image{grid: grid, hex: hexval, color: rgb, filteredresult: filter} = imagestruct
	maplocations= Enum.map grid, fn({_code,index}) ->
		horizontal = rem(index,5)*50
		vertical = div(index,5) * 50	
		topleft = {horizontal, vertical}
		bottomright = {horizontal+50, vertical+50}
		{topleft,bottomright}
	end
	%Identicon.Image{imagestruct | mappixellocations: maplocations}
  end
  
  
  def renderImage(imagestruct) do 
		%Identicon.Image{color: rgb, mappixellocations: maplocations} = imagestruct
		image = :egd.create(250,250)
		fillcolor = :egd.color(rgb)
		Enum.each maplocations, fn({topleft,bottomright}) ->
			:egd.filledRectangle(image,topleft,bottomright,fillcolor)
		end
		:egd.render(image)  
  end
    
  def mirror(enumchunkdata) do 
	  [a,b |_tail] = enumchunkdata
	  enumchunkdata ++ [b,a]  
  end
  
  def saveimage(pixelmapdata, input) do 
	# File.write(filename, contentvariable)
	File.write("#{input}.jpg",pixelmapdata)  
  end
  
  
  def hashProcessing(input) do 
	  hexval = :crypto.hash(:md5,input)
	  |> :binary.bin_to_list()  
	  %Identicon.Image{hex: hexval}  
  end
  
  
end
