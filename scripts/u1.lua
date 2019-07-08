#!/bin/lua
function load_user_prefs()
    var_day_color       = 'FFFFFF'  var_day_color_dim   = 'CCCCCC'
    var_night_color     = '00CC00'  var_night_color_dim = '009900'
    var_m_main_color    = 'FFAA00'  var_m_dim_color     = 'FFAA00'
    var_charging_color  = 'FF00FF'
    var_countdown_dates_yearly = {
-- format: {month,day,label}
-- IMPORTANT: dates need to be entered in chronological order!!!
        {1,1,"Fred"}
        ,{1,21,"Dominique"}
        ,{1,28,"Alex"}
        ,{4,30,"Cindy"}
        ,{5,6,"Diana"}
        ,{7,19,"My Bday"}
        ,{8,3,"anniversary"}
        ,{8,11,"Dylan"}
        ,{8,21,"Nancy"}
        ,{9,24,"proposed"}
        ,{10,14,"Xsandra"}
        ,{11,21,"Arjan"}
    }
end

function pre_init() -- initialising some periodically set values
    var_y_this_year     = dyy       var_y_next_year     = dyy+1     var_m_this_month    = dn                var_w_week_number   = dw
    var_d_day_of_week   = dd0       var_d_day_of_month  = dd        var_d_todays_date   = dyy..dnn..ddz
    var_days_of_week    = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday" ,"Friday" ,"Saturday" }
    var_days_of_month   = { [1]=31,[2]=28,[3]=31,[4]=30,[5]=31,[6]=30,[7]=31,[8]=31,[9]=30,[10]=31,[11]=30,[12]=31 }
    var_d_cd_days={{"100","timer1"},{"200","timer2"},{"300","timer3"}}
end

function set_countdown()
    var_d_cd_days={}
    for datesindex, dates in pairs(var_countdown_dates_yearly) do
        for datesindex,datesdata in pairs(var_countdown_dates_yearly) do
          if var_countdown_dates_yearly[datesindex][1] >= var_m_this_month
           and var_countdown_dates_yearly[datesindex][2] > var_d_day_of_month then
            var_d_cd_days[]=calculate_day_of_year(var_countdown_dates_yearly[datesindex][2],var_countdown_dates_yearly[datesindex][1],var_y_this_year)
          else
            var_d_cd_days[]=calculate_day_of_year(var_countdown_dates_yearly[datesindex][2],var_countdown_dates_yearly[datesindex][1],var_y_next_year)
          end
        end
    end
end

function calculate_day_of_year(day,month,year)
    var_leap = 0
    if year ~= var_y_this_year then
        result = 365
        if var_y_this_year%4==0 then var_leap = 1 end
    end
    if year%4==0 and month > 2 then var_leap = 1 end
    result = day + var_leap
    for i=1,month-1 do  result = result + var_days_of_month[i] end
    return result
end

function is_nighttime()
  if dtp >= wssp then
    return true
  elseif dtp <= wsrp then
    return true
  else
    return false
  end
end

function set_colors()
-- set primary colors
  if is_nighttime()
  then
    var_m_main_color    = var_night_color
    var_m_dim_color     = var_night_color_dim
  else
    var_m_main_color    = var_day_color
    var_m_dim_color     = var_day_color_dim
  end
end

function set_batt_colors()
-- set battery colors
  -- set watch battery color
  if bc == 'Charging' then
    var_s_watch_batt_color = var_charging_color
  elseif bl > 66 then
    var_s_watch_batt_color = string.format('%.2x%s',(100-bl)*255/33,'FF00')
  elseif bl > 16 then
    var_s_watch_batt_color = string.format('%s%.2x%s','FF',(bl-16)*255/50,'00')
  else
    var_s_watch_batt_color = 'FF0000'
  end
  -- set phone battery color
  if pbc == 'Charging' then
   var_s_phone_batt_color = var_charging_color
  elseif pbl > 66 then
    var_s_phone_batt_color = string.format('%.2x%s',(100-pbl)*255/33,'FF00')
  elseif pbl > 16 then
    var_s_phone_batt_color = string.format('%s%.2x%s','FF',(pbl-16)*255/50,'00')
  else
    var_s_phone_batt_color = 'FF0000'
  end
end

function init()
  pre_init()
  load_user_prefs()
  set_colors()
  set_batt_colors()
  set_countdown()


end

function on_second()
  set_batt_colors()
end

function on_minute()

end

function on_hour()
  var_h_this_hour = dh23

  if var_h_this_hour == 0 then on_day() end
end
function on_day()
  var_d_day_of_week     = dd0
  var_d_day_of_month    = dd
  set_countdown()
  if var_d_day_of_week == 0 then on_week() end
  if var_d_day_of_month == 1 then on_month() end
end
function on_thisday(var_this_day) end
function on_week()
  var_w_week_number = dw
  if var_w_week_number % 2 == 0 then
  var_w_week_is_even = true
  else
  var_w_week_is_even = false
  end
end
function on_month()

end

-- ########################################################
init()
