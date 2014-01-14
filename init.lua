-- mods/ut/init.lua

--Lumps

minetest.register_craftitem("ut:magnesium_lump", {
	description = "Magnesium Lump",
	inventory_image = "ut_magnesium_lump.png",
	wield_scale = {x=1,y=1,z=3},
})

minetest.register_craftitem("ut:aluminium_lump", {
	description = "Aluminium Lump",
	inventory_image = "ut_aluminium_lump.png",
	wield_scale = {x=1,y=1,z=3},
})

minetest.register_craftitem("ut:platinum_lump", {
	description = "Platinum Lump",
	inventory_image = "ut_platinum_lump.png",
	wield_scale = {x=1,y=1,z=3},
})

--Bars

minetest.register_craftitem("ut:magnesium_bar", {
	description = "Magnesium Bar",
	inventory_image = "ut_magnesium_bar.png",
	wield_scale = {x=1,y=1,z=2},
})

minetest.register_craftitem("ut:aluminium_bar", {
	description = "Aluminium Bar",
	inventory_image = "ut_aluminium_bar.png",
	wield_scale = {x=1,y=1,z=2},
})

minetest.register_craftitem("ut:platinum_bar", {
	description = "Platinum Bar",
	inventory_image = "ut_platinum_bar.png",
	wield_scale = {x=1,y=1,z=2},
})

--Ores

minetest.register_node("ut:stone_with_magnesium_ore", {
	description = "Magnesium Ore",
	tiles = {"default_stone.png^ut_mineral_magnesium_ore.png"},
	is_ground_content = true,
	groups = {level=2, cracky=1},
	drop = "ut:magnesium_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ut:stone_with_aluminium_ore", {
	description = "Aluminium Ore",
	tiles = {"default_stone.png^ut_mineral_aluminium_ore.png"},
	is_ground_content = true,
	groups = {level=2, cracky=1},
	drop = "ut:aluminium_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ut:stone_with_platinum_ore", {
	description = "Platinum Ore",
	tiles = {"default_stone.png^ut_mineral_platinum_ore.png"},
	is_ground_content = true,
	groups = {level=2, cracky=1},
	drop = "ut:platinum_lump",
	sounds = default.node_sound_stone_defaults(),
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

--Shadow forge

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

local bars = {
	{"ut:magnesium_lump", "ut:magnesium_bar"},
	{"ut:aluminium_lump", "ut:aluminium_bar"},
	{"ut:platinum_lump", "ut:platinum_bar"},
}	

minetest.register_node("ut:shadow_forge", {
	description = "Shadow_forge",
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
			local lump = row[1]
			local bar = row[2]
			if fields.create then
			if	inv:get_stack("lump", 1):get_name() == lump and inv:is_empty("bar") or inv:get_stack("lump", 1):get_name() == lump then
					inv:add_item("bar", bar)
					inv:remove_item("lump", lump)
				end
			end
		end
	end,
	groups = {cracky=1,},
})

--Swords

minetest.register_craft({
	output = "ut:magnesium_sword",
	recipe = {
		{"","","ut:magnesium_bar"},
		{"","ut:magnesium_bar",""},
		{"group:stick","",""},
	}
})

minetest.register_craft({
	output = "ut:magnesium_sword",
	recipe = {
		{"ut:magnesium_bar","",""},
		{"","ut:magnesium_bar",""},
		{"","","group:stick"},
	}
})

minetest.register_tool("ut:magnesium_sword", {
	description = "Magnesium Greatsword",
	inventory_image = "ut_magnesium_sword.png",
	wield_scale = {x=1,y=1,z=0.9},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.50, [2]=0.90, [3]=0.60}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	}
})

minetest.register_craft({
	output = "ut:aluminium_sword",
	recipe = {
		{"","","ut:aluminium_bar"},
		{"","ut:aluminium_bar",""},
		{"group:stick","",""},
	}
})

minetest.register_craft({
	output = "ut:aluminium_sword",
	recipe = {
		{"ut:aluminium_bar","",""},
		{"","ut:aluminium_bar",""},
		{"","","group:stick"},
	}
})

minetest.register_tool("ut:aluminium_sword", {
	description = "Aluminium Greatsword",
	inventory_image = "ut_aluminium_sword.png",
	wield_scale = {x=1,y=1,z=0.8},
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.40, [2]=0.80, [3]=0.50}, uses=35, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	}
})

minetest.register_craft({
	output = "ut:platinum_sword",
	recipe = {
		{"","","ut:platinum_bar"},
		{"","ut:platinum_bar",""},
		{"group:stick","",""},
	}
})

minetest.register_craft({
	output = "ut:platinum_sword",
	recipe = {
		{"ut:platinum_bar","",""},
		{"","ut:platinum_bar",""},
		{"","","group:stick"},
	}
})

minetest.register_tool("ut:platinum_sword", {
	description = "Platinum Greatsword",
	inventory_image = "ut_platinum_sword.png",
	wield_scale = {x=1,y=1,z=0.7},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.30, [2]=0.70, [3]=0.40}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	}
})

--Picels

minetest.register_craft({
	output = "ut:magnesium_picel",
	recipe = {
		{"ut:magnesium_bar", "ut:magnesium_bar", "ut:magnesium_bar"},
		{"", "group:stick", "ut:magnesium_bar"},
		{"group:stick","", "ut:magnesium_bar"},
	}
})

minetest.register_craft({
	output = "ut:magnesium_picel",
	recipe = {
		{"ut:magnesium_bar","ut:magnesium_bar", "ut:magnesium_bar"},
		{"ut:magnesium_bar","group:stick",""},
		{"ut:magnesium_bar","", "group:stick"},
	}
})

minetest.register_tool("ut:magnesium_picel", {
	description = "Magnesium Picel",
	inventory_image = "ut_magnesium_picel.png",
	wield_scale = {x=1,y=1,z=0.9},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.30, [2]=0.80, [3]=0.40}, uses=30, maxlevel=3},
			crumbly = {times={[1]=1.10, [2]=0.70, [3]=0.30}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_craft({
	output = "ut:aluminium_picel",
	recipe = {
		{"ut:aluminium_bar", "ut:aluminium_bar", "ut:aluminium_bar"},
		{"", "group:stick", "ut:aluminium_bar"},
		{"group:stick","", "ut:aluminium_bar"},
	}
})

minetest.register_craft({
	output = "ut:aluminium_picel",
	recipe = {
		{"ut:aluminium_bar","ut:aluminium_bar", "ut:aluminium_bar"},
		{"ut:aluminium_bar","group:stick",""},
		{"ut:aluminium_bar","", "group:stick"},
	}
})


minetest.register_tool("ut:aluminium_picel", {
	description = "Aluminium Picel",
	inventory_image = "ut_aluminium_picel.png",
	wield_scale = {x=1,y=1,z=0.8},
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.20, [2]=0.70, [3]=0.30}, uses=35, maxlevel=3},
			crumbly = {times={[1]=1.00, [2]=0.60, [3]=0.20}, uses=35, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_craft({
	output = "ut:platinum_picel",
	recipe = {
		{"ut:platinum_bar", "ut:platinum_bar", "ut:platinum_bar"},
		{"", "group:stick", "ut:platinum_bar"},
		{"group:stick","", "ut:platinum_bar"},
	}
})

minetest.register_craft({
	output = "ut:platinum_picel",
	recipe = {
		{"ut:platinum_bar","ut:platinum_bar", "ut:platinum_bar"},
		{"ut:platinum_bar","group:stick",""},
		{"ut:platinum_bar","", "group:stick"},
	}
})

minetest.register_tool("ut:platinum_picel", {
	description = "Platinum Picel",
	inventory_image = "ut_platinum_picel.png",
	wield_scale = {x=1,y=1,z=0.7},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.10, [2]=0.60, [3]=0.20}, uses=40, maxlevel=3},
			crumbly = {times={[1]=0.90, [2]=0.50, [3]=0.10}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
})

--Waraxes

minetest.register_craft({
	output = "ut:magnesium_waraxe",
	recipe = {
		{"ut:magnesium_bar", "ut:magnesium_bar","ut:magnesium_bar"},
		{"ut:magnesium_bar", "group:stick","ut:magnesium_bar"},
		{"", "group:stick",""},
	}
})

minetest.register_tool("ut:magnesium_waraxe", {
	description = "Magnesium Waraxe",
	inventory_image = "ut_magnesium_waraxe.png",
	wield_scale = {x=1,y=1,z=0.9},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.10, [2]=0.60, [3]=0.30}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_craft({
	output = "ut:aluminium_waraxe",
	recipe = {
		{"ut:aluminium_bar", "ut:aluminium_bar","ut:aluminium_bar"},
		{"ut:aluminium_bar", "group:stick","ut:aluminium_bar"},
		{"", "group:stick",""},
	}
})

minetest.register_tool("ut:aluminium_waraxe", {
	description = "Aluminium Waraxe",
	inventory_image = "ut_aluminium_waraxe.png",
	wield_scale = {x=1,y=1,z=0.8},
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.00, [2]=0.50, [3]=0.20}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})

minetest.register_craft({
	output = "ut:platinum_waraxe",
	recipe = {
		{"ut:platinum_bar", "ut:platinum_bar","ut:platinum_bar"},
		{"ut:platinum_bar", "group:stick","ut:platinum_bar"},
		{"", "group:stick",""},
	}
})

minetest.register_tool("ut:platinum_waraxe", {
	description = "Platinum Waraxe",
	inventory_image = "ut_platinum_waraxe.png",
	wield_scale = {x=1,y=1,z=0.7},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=0.90, [2]=0.40, [3]=0.10}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=8},
	},
})

--Blocks

minetest.register_craft({
		type = "shapeless",
		output = "ut:magnesium_bar 9",
		recipe = {"ut:magnesium_block"},
	})

minetest.register_craft({
		output = "ut:magnesium_block",
		recipe = {
				{"ut:magnesium_bar","ut:magnesium_bar","ut:magnesium_bar"},
				{"ut:magnesium_bar","ut:magnesium_bar","ut:magnesium_bar"},
				{"ut:magnesium_bar","ut:magnesium_bar","ut:magnesium_bar"},
		}
})

minetest.register_node('ut:magnesium_block', {
    description = 'Magnesium Block',
	tiles = {"ut_magnesium_block.png"},
    groups = {cracky=1,level=3},
    sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
		type = "shapeless",
		output = "ut:aluminium_bar 9",
		recipe = {"ut:aluminium_block"},
	})

minetest.register_craft({
		output = "ut:aluminium_block",
		recipe = {
				{"ut:aluminium_bar","ut:aluminium_bar","ut:aluminium_bar"},
				{"ut:aluminium_bar","ut:aluminium_bar","ut:aluminium_bar"},
				{"ut:aluminium_bar","ut:aluminium_bar","ut:aluminium_bar"},
		}
})

minetest.register_node('ut:aluminium_block', {
    description = 'Aluminium Block',
	tiles = {"ut_aluminium_block.png"},
    groups = {cracky=1,level=3},
    sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
		type = "shapeless",
		output = "ut:platinum_bar 9",
		recipe = {"ut:platinum_block"},
	})

minetest.register_craft({
		output = "ut:platinum_block",
		recipe = {
				{"ut:platinum_bar","ut:platinum_bar","ut:platinum_bar"},
				{"ut:platinum_bar","ut:platinum_bar","ut:platinum_bar"},
				{"ut:platinum_bar","ut:platinum_bar","ut:platinum_bar"},
		}
})

minetest.register_node('ut:platinum_block', {
    description = 'Platinum Block',
	tiles = {"ut_platinum_block.png"},
    groups = {cracky=1,level=3},
    sounds = default.node_sound_stone_defaults(),
})


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