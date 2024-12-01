local Heap = {}

function Heap.new<T>() -- Just some typechecking stuff we'll be using later on
	-- Our heap private virables
	type Item = {HeapIndex: number} & T

	local Items = {} :: {[number]: Item} -- The items in our heap tree (in this case, our nodes)
	local CurrentItemCount = 0 -- The number of items currently in our tree

	local function Swap(a: Item, b: Item)
		Items[a.HeapIndex], Items[b.HeapIndex] = b, a
		local itemAIndex = a.HeapIndex

		a.HeapIndex = b.HeapIndex
		b.HeapIndex = itemAIndex
	end

	local function SortUp(item: Item)
		local parentIndex = (item.HeapIndex-1)/2

		while true do
			local parentItem = Items[parentIndex]

			-- Check if the parent item exists and if the item is greater than the parent
			if parentItem and item - parentItem > 0 then
				-- If so, swap the item with the parent item
				Swap(item, parentItem)
			else
				-- Otherwise, the item is in the correct position, so break out of the loop
				break
			end

			parentIndex = (item.HeapIndex-1)/2
		end
	end

	local function SortDown(item: Item)
		while true do
			local childLeftIndex = item.HeapIndex * 2 + 1
			local childRightIndex = item.HeapIndex * 2 + 2
			local swapIndex = 0

			-- Check if the left child exists
			if childLeftIndex < CurrentItemCount then
				swapIndex = childLeftIndex

				-- If the right child has a higher priority, set the swap index to the right child index
				if childRightIndex < CurrentItemCount then
					-- If so, compare the priorities of the left and right children
					if Items[childLeftIndex] - Items[childRightIndex] < 0 then
						-- If the right child has a higher priority, set the swap index to the right child index
						swapIndex = childRightIndex
					end
				end

				-- Compare the priority of the item with the priority of the child at the swap index
				if item-Items[swapIndex] < 0 then
					-- If the child has a higher priority, swap the item with the child
					Swap(item, Items[swapIndex])
				else
					-- Otherwise, the item is in the correct position, so break out of the loop
					return
				end
			else
				-- If the left child does not exist, the item is at the bottom of the heap and in the correct position
				return
			end
		end
	end

	local Object = {} -- The class' instantiated object

	function Object:RemoveFirst() : Item
		local firstItem = Items[0] -- Get the root node
		CurrentItemCount -= 1 -- Decrease the items count
		Items[0] = Items[CurrentItemCount] -- Set the root node to lowest item
		Items[0].HeapIndex = 0

		SortDown(Items[0]) -- Sort down since the lowest item is at the root node

		return firstItem
	end

	function Object:Add(item: Item)
		item.HeapIndex = CurrentItemCount
		Items[CurrentItemCount] = item

		SortUp(item) -- Sort up since our heap item is at the bottom
		CurrentItemCount += 1
	end

	function Object:Contains(item: T)
		return Items[item.HeapIndex] == item
	end

	function Object:Count() -- Just a simple getter
		return CurrentItemCount
	end

	return Object
end

return Heap
