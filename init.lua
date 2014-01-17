-- mods/ut/init.lua

local ores = {
{"magnesium", "Magnesium", 0.1, 0},
{"aluminium", "Aluminium", 0.2, 5},
{"platinum", "Platinum", 0.3, 10}
}

for _, row in ipairs(ores) do
local oretype = row[1]
local desc = row[2]
local stat1 = row[3]
local stat2 = row[4]

--Craftitems
minetest.register_craftitem("ut:"..oretype.."_lump", {
	description = desc.." Lump",
	inventory_image = "ut_"..oretype.."_lump.png",
	wield_scale = {x=1,y=1,z=3},
})

minetest.register_craftitem("ut:"..oretype.."_bar", {
	description = desc.." Bar",
	inventory_image = "ut_"..oretype.."_bar.png",
	wield_scale = {x=1,y=1,z=2},
})

--Nodes
minetest.register_node("ut:stone_with_"..oretype.."_ore", {
	description = desc.." Ore",
	tiles = {"default_stone.png^ut_mineral_"..oretype.."_ore.png"},
	is_ground_content = true,
	groups = {level=2, cracky=1},
	drop = "ut:"..oretype.."_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ut:"..oretype.."_block", {
    description = desc.." Block",
	tiles = {"ut_"..oretype.."_block.png"},
    groups = {cracky=1,level=3},
    sounds = default.node_sound_stone_defaults(),
})

--Tools
minetest.register_tool("ut:"..oretype.."_picel", {
	description = desc.." Picel",
	inventory_image = "ut_"..oretype.."_picel.png",
	wield_scale = {x=1,y=1,z=1-stat1},
	tool_capabilities = {
		full_punch_interval = 1-stat1,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.40-stat1, [2]=0.90-stat1, [3]=0.50-stat1}, uses=30+stat2, maxlevel=3},
			crumbly = {times={[1]=1.20-stat1, [2]=0.80-stat1, [3]=0.40-stat1}, uses=30+stat2, maxlevel=3},
		},
		damage_groups = {fleshy = (4 + stat1 * 10)},
	},
})

minetest.register_tool("ut:"..oretype.."_waraxe", {
	description = desc.." Waraxe",
	inventory_image = "ut_"..oretype.."_waraxe.png",
	wield_scale = {x=1,y=1,z=1-stat1},
	tool_capabilities = {
		full_punch_interval = 1-stat1,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.20-stat1, [2]=0.70-stat1, [3]=0.40-stat1}, uses=30+stat2, maxlevel=2},
		},
		damage_groups = {fleshy=(5 + stat1 * 10)},
	},
})

minetest.register_tool("ut:"..oretype.."_sword", {
	description = desc.." Greatsword",
	inventory_image = "ut_"..oretype.."_sword.png",
	wield_scale = {x=1,y=1,z=(1-stat1)},
	tool_capabilities = {
		full_punch_interval = 1-stat1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=(1.60 - stat1), [2]=(1.00 - stat1), [3]=(0.70 - stat1)}, uses=(30 + stat2), maxlevel=3},
		},
		damage_groups = {fleshy=(6 + stat1 * 10)},
	}
})

--Crafts
minetest.register_craft({
	output = "ut:"..oretype.."_sword",
	recipe = {
		{"","","ut:"..oretype.."_bar"},
		{"","ut:"..oretype.."_bar",""},
		{"group:stick","",""},
	}
})

minetest.register_craft({
	output = "ut:"..oretype.."_sword",
	recipe = {
		{"ut:"..oretype.."_bar","",""},
		{"","ut:"..oretype.."_bar",""},
		{"","","group:stick"},
	}
})

minetest.register_craft({
	output = "ut:"..oretype.."_picel",
	recipe = {
		{"ut:"..oretype.."_bar", "ut:"..oretype.."_bar", "ut:"..oretype.."_bar"},
		{"", "group:stick", "ut:"..oretype.."_bar"},
		{"group:stick","", "ut:"..oretype.."_bar"},
	}
})

minetest.register_craft({
	output = "ut:"..oretype.."_waraxe",
	recipe = {
		{"ut:"..oretype.."_bar", "ut:"..oretype.."_bar","ut:"..oretype.."_bar"},
		{"ut:"..oretype.."_bar", "group:stick","ut:"..oretype.."_bar"},
		{"", "group:stick",""},
	}
})

minetest.register_craft({
		type = "shapeless",
		output = "ut:"..oretype.."_bar 9",
		recipe = {"ut:"..oretype.."_block"},
	})

minetest.register_craft({
		output = "ut:"..oretype.."_block",
		recipe = {
				{"ut:"..oretype.."_bar","ut:"..oretype.."_bar","ut:"..oretype.."_bar"},
				{"ut:"..oretype.."_bar","ut:"..oretype.."_bar","ut:"..oretype.."_bar"},
				{"ut:"..oretype.."_bar","ut:"..oretype.."_bar","ut:"..oretype.."_bar"},
		}
})

--Shadow Forge

minetest.register_craft({
	output = "ut:shadow_forge",
	recipe = {
		{"default:obsidian","default:obsidian","default:obsidian"},
		{"default:obsidian","default:furnace","default:obsidian"},
		{"default:mese","bucket:bucket_lava","default:mese"},
	},	
})

local shadowforgeformspec = 
	"size[8,8]"..
	"label[3,0;Shadow forge]"..
	"list[current_name;lump;3,1;1,1;]"..
	"label[2,1;  Lump:]"..
	"list[current_name;bar;3,3;1,1;]"..
	"label[2,3; Bar:]"..
	"list[current_player;main;0,4;8,4;]"..
	"button[4,2;2,1;create;Smelt]"

minetest.register_node("ut:shadow_forge", {
	description = "Shadow forge",
	tiles = {"ut_shadow_forge_side.png", "ut_shadow_forge_side.png", "ut_shadow_forge_side.png", "ut_shadow_forge_side.png", "ut_shadow_forge_side.png", "ut_shadow_forge.png"},
	light_source = 10,
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",shadowforgeformspec)
		meta:set_string("infotext", "Shadow Forge")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		inv:set_size("lump", 1*1)
		inv:set_size("bar", 1*1)		
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname == "lump" then
			return stack:get_count()
		else
			return 0
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if to_list == "bar" then
			return 0
		else
			return 1
		end
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("lump") then
			return false
		elseif not inv:is_empty("bar") then
			return false
		end
		return true
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		for _, row in ipairs(bars) do
			if fields.create then
			if	inv:get_stack("lump", 1):get_name() == "ut:"..oretype.."_lump" and inv:is_empty("bar") or inv:get_stack("lump", 1):get_name() == "ut:"..oretype.."_lump" then
					inv:add_item("bar", "ut:"..oretype.."_bar")
					inv:remove_item("lump", "ut:"..oretype.."_lump")
				end
			end
		end
	end,
	groups = {cracky=1,},
})
end

--Ultimate tools
minetest.register_craft({
	output = "ut:ultimate_sword",
	recipe = {
		{"ut:magnesium_sword", "ut:aluminium_sword","ut:platinum_sword"},
		{"default:mese", "default:diamondblock","default:mese"},
	}
})

minetest.register_tool("ut:ultimate_sword", {
	description = "Excalibur",
	inventory_image = "ut_ultimate_sword.png",
	wield_scale = {x=1,y=1,z=0.6},
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.10, [2]=0.50, [3]=0.20}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=12},
	}
})

minetest.register_craft({
	output = "ut:ultimate_paxel",
	recipe = {
		{"ut:magnesium_picel", "ut:aluminium_picel","ut:platinum_picel"},
		{"ut:magnesium_waraxe", "ut:aluminium_waraxe","ut:platinum_waraxe"},
		{"default:mese", "default:diamondblock","default:mese"},
	}
})

minetest.register_tool("ut:ultimate_paxel", {
	description = "Draxel",
	inventory_image = "ut_ultimate_paxel.png",
	wield_scale = {x=1,y=1,z=0.6},
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level=3,
		groupcaps={
			choppy = {times={[1]=0.80, [2]=0.40, [3]=0.10}, uses=50, maxlevel=2},
			crumbly = {times={[1]=0.80, [2]=0.40, [3]=0.10}, uses=50, maxlevel=3},
			cracky = {times={[1]=0.80, [2]=0.40, [3]=0.10}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=10},
	},
})

--Ore generation

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "ut:stone_with_magnesium_ore",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 6,
	clust_size     = 5,
	height_min     = -300,
	height_max     = -150,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "ut:stone_with_magnesium_ore",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 7,
	clust_size     = 6,
	height_min     = -350,
	height_max     = -200,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "ut:stone_with_aluminium_ore",
	wherein        = "default:stone",
	clust_scarcity = 17*17*17,
	clust_num_ores = 4,
	clust_size     = 3,
	height_min     = -400,
	height_max     = -250,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "ut:stone_with_aluminium_ore",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 6,
	clust_size     = 4,
	height_min     = -400,
	height_max     = -250,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "ut:stone_with_platinum_ore",
	wherein        = "default:stone",
	clust_scarcity = 19*19*19,
	clust_num_ores = 4,
	clust_size     = 3,
	height_min     = -500,
	height_max     = -300,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "ut:stone_with_platinum_ore",
	wherein        = "default:stone",
	clust_scarcity = 17*17*17,
	clust_num_ores = 7,
	clust_size     = 5,
	height_min     = -450,
	height_max     = -300,
	flags          = "absheight",
})