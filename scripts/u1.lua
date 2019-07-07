var_day_color = 'FFFFFF'
var_night_color = '00CC00'
var_day_color_dim ='CCCCCC'
var_night_color_dim = '009900'

var_charging_color = 'FF00FF'

var_m_main_color = 'FFFFFF'
var_m_dim_color = 'FFFFFF'

function on_hour(hour)
  var_h_countdown1=1
  var_h_countdown2=2
  var_h_countdown3=3
end

function on_minute()
-- check if the sun is up
  var_m_nighttime = (dtp >= wssp or dtp <= wsrp) and  true or false
-- set primary colors
  if var_m_nighttime 
  then
    var_m_main_color=var_night_color
    var_m_dim_color=var_night_color
  else 
    var_m_main_color = var_day_color_dim
    var_m_dim_color=var_night_color_dim
  end
end


function on_second(second)
  -- set battery colors
  var_s_wbc = 'bc' ~= 'Discharging' and var_charging_color or ({bl} > 66 and string.format('%.2x%s',(100-{bl})*255/33,'FF00') or {bl} > 16 and string.format('%s%.2x%s','FF',({bl}-16)*255/50,'00') or 'FF0000')
var_s_pbc = 'pbc' ~= 'Discharging' and var_charging_color or ({pbl} > 66 and string.format('%.2x%s',(100-{bl})*255/33,'FF00') or {pbl} > 16 and string.format('%s%.2x%s','FF',({pbl}-16)*255/50,'00') or 'FF0000')
end