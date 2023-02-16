conky.config = {
	out_to_x = false,
	out_to_console = true,
	short_units = true,
	update_interval = 1,

};

conky.text = [[

[\
# Kernel:
{
  "full_text": "BAT",
  "color":"\#888888",
  "separator":false,
  "separator_block_width":6
},
{
  "full_text": "${exec acpi -b | awk '{print $4}'}",
  "color":"\#EEEEEE",
  "separator":false,
  "separator_block_width":6
},
{"full_text":"SOUND","color":"\#888888","separator":false,"separator_block_width":6},\
{"full_text":"${exec amixer -c 0 get Master | grep Mono: | cut -d " " -f6 | sed 's/\[//g' | sed 's/\]//g'}","color":"\#EEEEEE","separator":false,"separator_block_width":6},\
{"full_text": "${if_match ${exec amixer -c 0 get Master | grep Mono: | cut -d " " -f8 | sed 's/\[//g' | sed 's/\]//g'|wc -c}==3}on","color":"\#AAF096","separator":false,"separator_block_width":6},\
{"full_text":"${else}off${endif}","color":"\#FF3333","separator":false,"separator_block_width":6},\
## KERNEL
#{"full_text":"KERNEL","color":"\#888888","separator":false,"separator_block_width":6},\
#{"full_text":"${kernel}","color":"\#EEEEEE","separator":false,"separator_block_width":6},\
# CPU temperature:
#{"full_text":"T°","color":"\#888888","separator":false,"separator_block_width":6},\
#{"full_text":"${if_match ${hwmon temp 1}<45}${hwmon temp 1}","color":"\#AAF096","separator":false,"separator_block_width":0},\
#{"full_text":"${else}"},\
#{"full_text":"${if_match ${hwmon temp 1}<50}${hwmon temp 1}","color":"\#F0DC64","separator":false,"separator_block_width":0},\
#{"full_text":"${else}"},\
#{"full_text":"${if_match ${hwmon temp 1}<55}${hwmon temp 1}","color":"\#FF9933","separator":false,"separator_block_width":0},\
#{"full_text":"${else}"},\
#{"full_text":"${if_match ${hwmon temp 1}>=55}${hwmon temp 1}","color":"\#FF3333","separator":false,"separator_block_width":0},\
#{"full_text":"${else}"},\
#{"full_text":"${endif}${endif}${endif}${endif}"},\
#{"full_text":"C°","color":"\#EEEEEE","separator":false,"separator_block_width":6},\
## Download:
#{"full_text":"DOWN","color":"\#888888","separator":false,"separator_block_width":6},\
#{"full_text":"${if_match ${downspeedf p1p1}<100}${downspeed p1p1}","color":"\#AAF096","separator":false,"separator_block_width":6},\
#{"full_text":"${else}"},\
#{"full_text":"${if_match ${downspeedf p1p1}<300}${downspeed p1p1}","color":"\#68B1E8","separator":false,"separator_block_width":6},\
#{"full_text":"${else}"},\
#{"full_text":"${if_match ${downspeedf p1p1}<700}${downspeed p1p1}","color":"\#DB70B8","separator":false,"separator_block_width":6},\
#{"full_text":"${else}"},\
#{"full_text":"${if_match ${downspeedf p1p1}<1000}${downspeed p1p1}","color":"\#9470DB","separator":false,"separator_block_width":6},\
#{"full_text":"${else}"},\
#{"full_text":"${if_match ${downspeedf p1p1}>=1000}${downspeed p1p1}","color":"\#FF3333","separator":false,"separator_block_width":6},\
#{"full_text":"${endif}${endif}${endif}${endif}${endif}"},\
## Upload:
#{"full_text":"UP","color":"\#888888","separator":false,"separator_block_width":6},\
#{"full_text":"${if_match ${upspeedf p1p1}<15}${upspeed p1p1}","color":"\#AAF096","separator":false,"separator_block_width":6},\
#{"full_text":"${else}"},\
#{"full_text":"${if_match ${upspeedf p1p1}<35}${upspeed p1p1}","color":"\#9470DB","separator":false,"separator_block_width":6},\
#{"full_text":"${else}"},\
#{"full_text":"${if_match ${upspeedf p1p1}>=35}${upspeed p1p1}","color":"\#FF3333","separator":false,"separator_block_width":6},\
#{"full_text":"${endif}${endif}${endif}"},\
# Memory:
{"full_text":"MEM","color":"\#888888","separator":false,"separator_block_width":6},\
{"full_text":"${if_match ${memperc}<30}${memeasyfree}","color":"\#AAF096","separator":false,"separator_block_width":6},\
{"full_text":"${else}"},\
{"full_text":"${if_match ${memperc}<60}${memeasyfree}","color":"\#F0DC64","separator":false,"separator_block_width":6},\
{"full_text":"${else}"},\
{"full_text":"${if_match ${memperc}<85}${memeasyfree}","color":"\#FF9933","separator":false,"separator_block_width":6},\
{"full_text":"${else}"},\
{"full_text":"${if_match ${memperc}>=85}${memeasyfree}","color":"\#FF3333","separator":false,"separator_block_width":6},\
{"full_text":"${endif}${endif}${endif}${endif}"},\
# CPU:
{"full_text":"CPU","color":"\#888888","separator":false,"separator_block_width":6},\
{"full_text":"${if_match ${cpu cpu0}<25}${cpu cpu0}","color":"\#AAF096","separator":false,"separator_block_width":0},\
{"full_text":"${else}"},\
{"full_text":"${if_match ${cpu cpu0}<50}${cpu cpu0}","color":"\#F0DC64","separator":false,"separator_block_width":0},\
{"full_text":"${else}"},\
{"full_text":"${if_match ${cpu cpu0}<75}${cpu cpu0}","color":"\#FF9933","separator":false,"separator_block_width":0},\
{"full_text":"${else}"},\
{"full_text":"${if_match ${cpu cpu0}<=100}${cpu cpu0}","color":"\#FF3333","separator":false,"separator_block_width":0},\
{"full_text":"${endif}${endif}${endif}${endif}"},\
{"full_text":"%","color":"\#EEEEEE","separator":false,"separator_block_width":6},\
# Disk usage:
{"full_text":"DISK","color":"\#888888","separator":false,"separator_block_width":6},\
{"full_text":"${fs_used /}/${fs_size /}","color":"\#EEEEEE","separator":false,"separator_block_width":6},\
# Date:
{"full_text":"DATE","color":"\#888888","separator":false,"separator_block_width":6},\
{"full_text":"${time %a %D}","color":"\#EEEEEE","separator":false,"separator_block_width":6},\
# Time (fr)
{"full_text":"FR","color":"\#888888","separator":false,"separator_block_width":6},\
{"full_text":"${tztime Europe/Paris %H:%M}","color":"\#EEEEEE","separator":false},\
# Time (japan):
{"full_text":"JP","color":"\#888888","separator":false,"separator_block_width":6},\
{"full_text":"${tztime Asia/Tokyo %H:%M}","color":"\#EEEEEE","separator":false}
],
]];
