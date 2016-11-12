
if GetObjectName(GetMyHero()) ~= "Blitzcrank" then return end


require("OpenPredict")
local BlitzcrankMenu = Menu("Blitzcrank", "Blitzcrank")
BlitzcrankMenu:SubMenu("Combo", "Combo")
BlitzcrankMenu.Combo:Boolean("Q", "Use Q", true)
BlitzcrankMenu.Combo:Boolean("W", "Use W", true)
BlitzcrankMenu.Combo:Boolean("E", "Use E", true)
BlitzcrankMenu.Combo:Boolean("R", "Use R", true)
BlitzcrankMenu.Combo:Boolean("KSR", "Killsteal with R", true)
BlitzcrankMenu.Combo:Boolean("E", "Use E vs Enemy AA", true)
BlitzcrankMenu:SubMenu("draw", "Draws")
BlitzcrankMenu.draw:Slider("cwidth", "Circle Width", 1, 1, 10, 1)
BlitzcrankMenu.draw:Slider("cquality", "Circle Quality", 1, 0, 8, 1)
BlitzcrankMenu.draw:Boolean("qdraw", "Draw Q", true)
BlitzcrankMenu.draw:ColorPick("qcirclecol", "Q Circle color", {255, 134, 26, 217}) 
BlitzcrankMenu.draw:Boolean("rdraw", "Draw R", true)
BlitzcrankMenu.draw:ColorPick("rcirclecol", "R Circle color", {255, 134, 26, 217})
tsg = TargetSelector(1100,TARGET_LESS_CAST_PRIORITY,DAMAGE_PHYSICAL,true,false)


local BlitzcrankQ = {delay = 0.250, range = 925, width = 70, speed = 1750}

OnTick(function()
local target = GetCurrentTarget()
if IOW:Mode() == "Combo" then
  UseQ1()

  if BlitzcrankMenu.Combo.W:Value() and IsReady(_W) and ValidTarget(target, 150) then
    CastSpell(_W)
  end
  if BlitzcrankMenu.Combo.E:Value() and IsReady(_E) and ValidTarget(target, 150) then
    CastSpell(_E)
  end
  if BlitzcrankMenu.Combo.R:Value() and IsReady(_R) and ValidTarget(target, 600) then
    CastSpell(_R)
  end
end
for _, enemy in pairs(GetEnemyHeroes()) do
  if BlitzcrankMenu.Combo.R:Value() and BlitzcrankMenu.Combo.KSR:Value() and IsReady(_R) and ValidTarget(enemy, 600) then
    if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (125 + 125 * GetCastLevel(myHero,_R) + GetBonusAP(myHero))) then
      CastSpell(_R)
    end
  end
end

end)

  function UseQ1()
    local QT = tsg:GetTarget()
    if QT ~= nil then
      local QpI = GetPrediction(QT, BlitzcrankQ)
      if IsReady(_Q) and ValidTarget(QT, GetCastRange(myHero, _Q)) and QpI and QpI.hitChance >=0.25 and not QpI:mCollision(1) then
        CastSkillShot(_Q, QpI.castPos)

      end
    end
end
OnDraw (function()
 if not IsDead(myHero) then
  if BlitzcrankMenu.draw.qdraw:Value() and IsReady(_Q) then
   DrawCircle(GetOrigin(myHero), 925, BlitzcrankMenu.draw.cwidth:Value(), BlitzcrankMenu.draw.cquality:Value(), BlitzcrankMenu.draw.qcirclecol:Value())
  end
  if BlitzcrankMenu.draw.rdraw:Value() and IsReady(_R) then 
   DrawCircle(GetOrigin(myHero), 600, BlitzcrankMenu.draw.cwidth:Value(), BlitzcrankMenu.draw.cquality:Value(), BlitzcrankMenu.draw.rcirclecol:Value())
end
end
end)

    print("Blitzcrank  lyý Oyunlar Good Game")
