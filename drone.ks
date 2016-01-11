//kOS
//Author: SaivNator
//Policy: IT'S MINE! but u can use it too :)
print "drone v1".

local RUNNING is true.

local ser1 is ADDONS:IR:ALLSERVOS[0].
local ser2 is ADDONS:IR:ALLSERVOS[1].
local ser3 is ADDONS:IR:ALLSERVOS[2].
local ser4 is ADDONS:IR:ALLSERVOS[3].

local ser1_1 is ADDONS:IR:ALLSERVOS[4].
local ser1_2 is ADDONS:IR:ALLSERVOS[5].
local ser2_1 is ADDONS:IR:ALLSERVOS[6].
local ser2_2 is ADDONS:IR:ALLSERVOS[7].
local ser3_1 is ADDONS:IR:ALLSERVOS[8].
local ser3_2 is ADDONS:IR:ALLSERVOS[9].
local ser4_1 is ADDONS:IR:ALLSERVOS[10].
local ser4_2 is ADDONS:IR:ALLSERVOS[11].

declare function up
{
	print "up". 
}

declare function set_rotor_pitch
{
	parameter rotor.
	parameter pitch.

	if rotor = 1 {
		ser1_1:MOVETO(pitch, 1).
		ser1_2:MOVETO(pitch, 1).
	} else if rotor = 2 {
		ser2_1:MOVETO(pitch, 1).
		ser2_2:MOVETO(pitch, 1).
	} else if rotor = 3 {
		ser3_1:MOVETO(pitch, 1).
		ser3_2:MOVETO(pitch, 1).
	} else if rotor = 4 {
		ser4_1:MOVETO(pitch, 1).
		ser4_2:MOVETO(pitch, 1).
	}
}

declare function set_all_rotor_pitch
{
	parameter pitch.
	
	set_rotor_pitch(1, pitch).
	set_rotor_pitch(2, pitch).
	set_rotor_pitch(3, pitch).
	set_rotor_pitch(4, pitch).
}

declare function start_rotor
{
	parameter speed.

	set ser1:speed to speed.
	set ser2:speed to speed.
	set ser3:speed to speed.
	set ser4:speed to speed.

	ser1:moveright().
	ser2:moveright().
	ser3:moveright().
	ser4:moveright().
}

//Program

local pitch is SHIP:CONTROL:PILOTPITCH.
local yaw is SHIP:CONTROL:PILOTYAW.
local roll is SHIP:CONTROL:PILOTROLL.
local throttle is SHIP:CONTROL:PILOTMAINTHROTTLE.
local old_pitch is pitch.
local old_yaw is yaw.
local old_roll is roll.
local old_throttle is throttle.

set_all_rotor_pitch(-20).

until not running
{ 
	set pitch to SHIP:CONTROL:PILOTPITCH.
	set yaw to SHIP:CONTROL:PILOTYAW.
	set roll to SHIP:CONTROL:PILOTROLL.
	set throttle to SHIP:CONTROL:PILOTMAINTHROTTLE.
	
	if pitch <> old_pitch {
		if pitch > 0 {
			set_rotor_pitch(3, -20).
			set_rotor_pitch(4, -20).
		} else if pitch < 0 {
			set_rotor_pitch(1, -20).
			set_rotor_pitch(2, -20).
		} else if pitch = 0 {
			set_all_rotor_pitch(0).
		}
	}
	if yaw <> old_yaw {
		if yaw > 0 {
			set_rotor_pitch(1, -20).
			set_rotor_pitch(4, -20).
		} else if yaw < 0 {
			set_rotor_pitch(2, -20).
			set_rotor_pitch(3, -20).
		} else if yaw = 0 {
			set_all_rotor_pitch(0).
		}
	}
	if roll <> old_roll {
		if roll > 0 {
			set_all_rotor_pitch(-20).
		} else if roll < 0 {
			set_all_rotor_pitch(20).
		} else if roll = 0 {
			set_all_rotor_pitch(0).
		}
	}
	if throttle <> old_throttle {
		if throttle > 0 {start_rotor(50).}
		if throttle = 0 {start_rotor(0).}
	}

	set old_pitch to pitch.
	set old_yaw to yaw.
	set old_roll to roll.
	set old_throttle to throttle.
}

