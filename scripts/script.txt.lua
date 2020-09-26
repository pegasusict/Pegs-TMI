--## user_prefs ##
var_color_day = 'FFFFFF'        var_color_day_dim = 'CCCCCC'
var_color_night = '00CC00'      var_color_night_dim = '009900'
var_color_charging = 'FF00FF'
var_color_batt_empty = 'FF0000' var_color_batt_full = '0000FF'
var_color_temp_high = 'FC6A6A'  var_color_temp_low = '2CB7FF'
var_color_nightmode_forced = '009900'   var_color_nightmode_enabled = '00AA00'
var_agenda_text_length = 40
var_offset_y = 90
var_move_forward='CubeFromRight' var_move_back='CubeFromLeft'

--## "constants" ##
title = 'TMI2' version = '0.18.0' build = 20200903
var_title = title .. ' v' .. version
var_symbol_appsmenu='f'             var_symbol_brightness='n'
var_symbol_config='p'               var_symbol_triangle='v'
var_symbol_nightmode_enabled='l'    var_symbol_daymode='m'
var_symbol_nightmode_forced='k'     var_symbol_home='y'
var_screens={var_title,'weather','-','-','-','-','-','-','config','-'}
var_num_screens = 10                var_num_wallpapers = 3
var_wallpapers={'belle','pegasus','robotogroep'}

--## UI functions ##
function pos(i,offset,div,padding)
  if not div then div=5 end
  if not offset then offset=0 end
  if not padding then padding=0 end

  return -256+offset+(256/div)+((512/div)*(-1+i))+i*padding
end

function tap_action(index)
  screen = var_screen_active
  if index==1 then select_screen(3)
  elseif index==2 then select_screen(4)
  elseif index==51 then prev_screen()
  elseif index==52 then select_screen(5)
  elseif index==53 then
    if screen==1 then change_wallpaper() else select_screen(1) end
  elseif index==54 then select_screen(9)
  elseif index==55 then next_screen()
  else
    if screen==2 then action='update weather'
    elseif screen==3 then
      if index==11 then action=''
      elseif index==12 then action=''
      elseif index==13 then action=''
      elseif index==14 then action=''
      elseif index==15 then action=''
      elseif index==21 then action=''
      elseif index==22 then action=''
      elseif index==23 then action=''
      elseif index==24 then action=''
      elseif index==25 then action=''
      elseif index==31 then action=''
      elseif index==32 then action=''
      elseif index==33 then action=''
      elseif index==34 then action=''
      elseif index==35 then action=''
      end
    elseif screen==9 then
      if index==21 then taskertask('getVars') end
    end
  end
  if action ~= ''
  then
    wm_schedule { { action='run_function',run_function=action } }
  end
end

--########################################################################
--## agenda functions ####################################################
--########################################################################
function build_agenda_line(item)
  time= wm_tag("{c"..item.."b}")
  text= wm_tag("{c"..item.."t}")

  if time == '00:00'
  then result = text
  else result = time..' '..text
  end

  return result
end

function build_agenda()
  var_h_agenda1 = build_agenda_line(1)
  var_h_agenda2 = build_agenda_line(2)
  var_h_agenda3 = build_agenda_line(3)
  var_h_agenda4 = build_agenda_line(4)
  var_h_agenda5 = build_agenda_line(5)
  var_h_agenda6 = build_agenda_line(6)
  var_h_agenda7 = build_agenda_line(7)
  var_h_agenda8 = build_agenda_line(8)
end

--########################################################################
--## day/night functions #################################################
--########################################################################
function show_colors(day,night)
  result = day
  if (var_s_nightmode==true) then result = night end

  return result
end

function day_or_night()
  if var_nightmode == 2
  then
    var_s_color_nightmode_icon = var_color_nightmode_forced
    var_s_nightmode = true
  elseif (var_nightmode==1 and ({dtp} >= {wssp} or {dtp} <= {wsrp}))
  then
    var_s_nightmode = true
    var_s_color_nightmode_icon = var_color_nightmode_enabled
  else
    var_s_nightmode = false
    var_s_color_nightmode_icon = var_color_day
  end
end

function toggle_nightmode()
  if (var_nightmode==1)
  then
    var_nightmode = 2
    var_icon_nightmode = var_symbol_nightmode_forced
  elseif (var_nightmode==2)
  then
    var_nightmode = 0
    var_icon_nightmode = var_symbol_daymode
  else
    var_nightmode = 1
    var_icon_nightmode = var_symbol_nightmode_enabled
  end

  set_colors()
end

function set_colors()
  day_or_night()
  var_s_color_main = show_colors(var_color_day, var_color_night)
  var_s_color_dim = show_colors(var_color_day_dim, var_color_night_dim)
  var_m_color_high = show_colors( var_color_temp_high,var_color_night)
  var_m_color_low = show_colors( var_color_temp_low,var_color_night)
end

--########################################################################
--## screen functions ####################################################
--########################################################################
function select_screen(screen)
    if not screen or screen == 0 then screen = 1 end

    if var_screen_active > screen
    then animation=var_move_back
    else animotion=var_move_forward
    end

    var_screen_active = screen
    wm_transition(animotion)
    activate_screen()
end

function next_screen()
  if var_screen_active >= var_num_screens
  then select_screen(1)
  else select_screen(var_screen_active+1)
  end
end

function prev_screen()
  if var_screen_active <= 1
  then select_screen(var_num_screens)
  else select_screen(var_screen_active-1)
  end
end

function activate_screen()
    var_screen1 = var_screen_active == 1 and 100 or -1
    var_screen2 = var_screen_active == 2 and 100 or -1
    var_screen3 = var_screen_active == 3 and 100 or -1
    var_screen4 = var_screen_active == 4 and 100 or -1
    var_screen5 = var_screen_active == 5 and 100 or -1
    var_screen6 = var_screen_active == 6 and 100 or -1
    var_screen7 = var_screen_active == 7 and 100 or -1
    var_screen8 = var_screen_active == 8 and 100 or -1
    var_screen9 = var_screen_active == 9 and 100 or -1
    var_screen10 = var_screen_active == 10 and 100 or -1
end

function change_wallpaper(index)
  if not index
  then var_wallpaper_selected = var_wallpaper_selected + 1
  else var_wallpaper_selected = index
  end

  if var_wallpaper_selected > var_num_wallpapers
  then var_wallpaper_selected = 1
  end
end

--########################################################################
--## tasker functions b###################################################
--########################################################################
function taskertask(task)
  if task == '' then return end
  command = make_tasker_function(task)

  wm_action(command)
end

function make_tasker_function(task)
  if task == '' then return end
  command = 'm_task:WM'..task

  return command
end

function set_contains(set, key)
  return set[key] ~= nil
end

function set_value_exists( set, value )
  return set[value] == true
end

function get_profile()
  if not {tprofile}
  then var_s_profile = 'none'
  else var_s_profile = {tprofile}
  end
end

function init_tasker_vars()
  var_m_hsb = -1    --headset battery
  var_s_profile = 'none'
end

 -- Simple lock routine to prevent double presses etc.
function lock()
  if var_lock == 0 then var_lock = 1 else var_lock = 0 end
end

-- Individual functions named according to our table 'functions' below. Not all need to be in the table.
function clear_data()
  wm_action('m_task:WMClear')
end

function confirm_data()
  wm_action('m_task:WMConfirm')
end

function star()
  wm_action('m_task:WMDigitStar')
end
function hash()
  wm_action('m_task:WMDigitHash')
end

-- Delay routine used in conjunction with lock
function delay()
  wm_schedule {
   { action='run_function',run_function=lock },
   { action='sleep',sleep=0.25 },
   { action='run_function',run_function=check_data },
   { action='sleep',sleep=0.05 },
   { action='run_function',run_function=lock }
  }
end

-- Used to update Tasker variable data for Watchmaker
function update_value()
  var_display=wm_tag('{twmdigit}')
end

-- The reset Tasker variable routine
function reset_display()
  wm_schedule {
   { action='run_function',run_function=clear_data },
   { action='sleep',sleep=var_delay },
   { action='run_function',run_function=check_data },
  }
end

function measurements()
 if var_measure == 0 
 then measurement=tonumber(wm_tag({ssc}))
 elseif var_measure == 1
 then measurement=tonumber(wm_tag({bl}))
 end
end

-- Change the tag used for recording. Can use any tag, string or number providing it contains just numerals.

function chg_measurement()
 if var_measure == 0 then
  var_measure=1 else
  var_measure=0
 end
end

--  TODO

function loopy()
  measurements()
  key=nil
  a=tonumber(string.len(measurement))
  s=1
  for i=1,s do
    if var_s_steps == a then break end
    var_s_steps = var_s_steps + s
    step = tonumber(string.sub(measurement,var_s_steps,var_s_steps))
    if set_contains(functions,step)
    then
      wm_schedule {
        { action='run_function',run_function=functions[step] },
      }
    elseif set_contains(safe_chars,step)
    then taskertask(step)
    end

  end
end

-- Reset everything for next send.
function reset()
  key = nil
  var_s_steps = 0
  var_run = 1
  s = 1
  a = 1
  check_data()
end

-- Toggle the on_second running. As to stop the loop from ever running when not needed.
function toggle()
  var_run=var_run%3+1
end

-- The ontap Action to easily reset every (C button).
function run()
 wm_schedule {
  { action='run_function',run_function=toggle },
  { action='sleep',sleep=5 },
  { action='run_function',run_function=reset }
  }
end

--##############################################################################
--## "cron" functions ##########################################################
--##############################################################################

-- On second function to permit the funk happening.
function on_second()
 if var_run == 2 then loopy() end
end

function on_minute(h,m)
  get_profile()
  set_colors()
end

function on_hour(h)
  build_agenda()
end
--[[
function on_bright()
--  taskertask('getVars')
end
--]]

--##############################################################################
--## Data Functions ############################################################
--##############################################################################
Set={}
function Set.new (table)
  local set = {}
  --setmetatable(set, Set.mt)
  for _, l in ipairs(table) do set[l] = true end
  return set
end

--##############################################################################
--## boilerplate ###############################################################
--##############################################################################

-- Tasker functions related
var_delay=.5  var_lock=0  var_s_steps=0   var_measure=0

var_pos_x1=pos(1)  var_pos_y1=pos(1,var_offset_y,6,5)
var_pos_x2=pos(2)  var_pos_y2=pos(2,var_offset_y,6,5)
var_pos_x3=pos(3)  var_pos_y3=pos(3,var_offset_y,6,5)
var_pos_x4=pos(4)  var_pos_header=pos(1,-8)
var_pos_x5=pos(5)  var_pos_footer=pos(5)

var_nightmode=1
var_s_color_main = var_color_day
var_s_color_dim = var_color_day_dim
var_s_color_nightmode_icon = var_color_day
var_icon_nightmode = var_symbol_nightmode_enabled
var_screen_active = 1
var_wallpaper_selected = 1

activate_screen()
on_minute()
on_hour()
init_tasker_vars()