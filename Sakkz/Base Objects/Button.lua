local partsWithId = {}
local awaitRef = {}

local root = {
	ID = 0;
	Type = "TextButton";
	Properties = {
		FontSize = Enum.FontSize.Size14;
		TextColor3 = Color3.new(0,0,0);
		BorderColor3 = Color3.new(58/255,58/255,58/255);
		Text = "";
		AutoButtonColor = false;
		Font = Enum.Font.SourceSans;
		Name = "Button";
		Position = UDim2.new(0,0,0,135);
		Size = UDim2.new(1,0,0.050000000745058,25);
		TextSize = 14;
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.new(7/51,7/51,7/51);
	};
	Children = {
		{
			ID = 1;
			Type = "ImageLabel";
			Properties = {
				ImageColor3 = Color3.new(26/255,26/255,26/255);
				ScaleType = Enum.ScaleType.Slice;
				Name = "Box";
				Image = "rbxassetid://6987764914";
				BackgroundTransparency = 1;
				Position = UDim2.new(0,15,0,5);
				SliceScale = 0.03999999910593;
				Size = UDim2.new(1,-30,0,30);
				BackgroundColor3 = Color3.new(1,1,1);
				SliceCenter = Rect.new(Vector2.new(100,100),Vector2.new(100,100));
			};
			Children = {
				{
					ID = 2;
					Type = "TextLabel";
					Properties = {
						FontSize = Enum.FontSize.Size14;
						TextColor3 = Color3.new(1,1,1);
						BorderColor3 = Color3.new(58/255,58/255,58/255);
						Text = "Button";
						Font = Enum.Font.Gotham;
						Name = "Label";
						BackgroundTransparency = 1;
						Size = UDim2.new(1,0,1,0);
						TextSize = 14;
						BorderSizePixel = 0;
						BackgroundColor3 = Color3.new(7/51,7/51,7/51);
					};
					Children = {};
				};
			};
		};
	};
};

local function Scan(item, parent)
	local obj = Instance.new(item.Type)
	if (item.ID) then
		local awaiting = awaitRef[item.ID]
		if (awaiting) then
			awaiting[1][awaiting[2]] = obj
			awaitRef[item.ID] = nil
		else
			partsWithId[item.ID] = obj
		end
	end
	for p,v in pairs(item.Properties) do
		if (type(v) == "string") then
			local id = tonumber(v:match("^_R:(%w+)_$"))
			if (id) then
				if (partsWithId[id]) then
					v = partsWithId[id]
				else
					awaitRef[id] = {obj, p}
					v = nil
				end
			end
		end
		obj[p] = v
	end
	for _,c in pairs(item.Children) do
		Scan(c, obj)
	end
	obj.Parent = parent
	return obj
end

return function() return Scan(root, nil) end