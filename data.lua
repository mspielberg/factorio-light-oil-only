local recipe = data.raw.recipe["basic-oil-processing"]
recipe.results = { {type = "fluid", name = "light-oil", amount = 50} }

local op_tech = data.raw.technology["oil-processing"]
op_tech.effects[6] = nil
op_tech.effects[7] = nil
table.insert(op_tech.effects, {type="unlock-recipe", recipe="light-oil-cracking"})

local aop_tech = data.raw.technology["advanced-oil-processing"]
aop_tech.effects[3] = nil
table.insert(aop_tech.effects, {type="unlock-recipe", recipe="solid-fuel-from-petroleum-gas"})
table.insert(aop_tech.effects, {type="unlock-recipe", recipe="solid-fuel-from-heavy-oil"})

data.raw.technology["lubricant"].prerequisites = {"advanced-oil-processing"}
data.raw.technology["construction-robotics"].prerequisites[2] = nil
data.raw.technology["logistic-robotics"].prerequisites[2] = nil

local heavy_oil_dependent_techs = {
  "lubricant",
  "electric-engine",
  "robotics",
  "construction-robotics",
  "logistic-robotics",
  "character-logistic-slots-1",
  "character-logistic-slots-2",
  "character-logistic-trash-slots-1",
}

for _, name in pairs(heavy_oil_dependent_techs) do
  log("adding blue science to "..name)
  table.insert(data.raw.technology[name].unit.ingredients, {"chemical-science-pack", 1})
end
log(serpent.dump(data.raw))
