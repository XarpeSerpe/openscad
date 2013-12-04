/* arduino shield mp3 geeetech.scad
 *
 * A adaptation of arduino.scad of Jestin Stoffel 2012
 * Modified by Xarpe Serpe 2013
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the Free
 * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

// Throughout this entire model, (0,0) is the top left mounting hole (nearest  the USB port)

// thickness of the PCB
board_height = 1.8;

// solid_holes - specifies if mounting holes should be added to or subtracted from the model
// combined_headers - specifies if space should be left between adjacent female headers, or if they should be rendered as a single header
// extend_ports - extends the sound jacks by a centimeter, so that holes are more easily made when a model is used as a negative


module ArduinoMp3Shield(solid_holes, combined_headers, extend_ports)
{
	echo(str("solid_holes: ", solid_holes));
	echo(str("combined_headers: ", combined_headers));
	echo(str("extend_ports: ", extend_ports));

	if (solid_holes == 1)
	{
		echo("solid holes");
		union()
		{
			BoardMp3Shield();
			FemaleHeadersMp3Shield(combined_headers);
			ResetButtonMp3Shield();
			MountingHolesMp3Shield();
			SdSoketMp3Shield();
			SoundJacksMp3Shield(extend_ports);
			MaleHeadersMp3Shield(combined_headers);
		}
	}
	else
	{
		echo("regular holes");
		difference()
		{
			union()
			{
				Board();
				FemaleHeadersMp3Shield(combined_headers);
				ResetButtonMp3Shield();
				SdSoketMp3Shield();
				SoundJacksMp3Shield(extend_ports);
				MaleHeadersMp3Shield(combined_headers);
			}
			MountingHolesMp3Shield();
		}
	}
}


module SoundJacksMp3Shield(extended)
{
	color([0.3, 0.3, 0.3])
	translate([42.625,-33.935, board_height])
	union()
	{
		if(extended == 1)
		{
			cube([24, 6.54, 5.38]);
			translate([0,-10.8, 0])
			cube([24, 6.54, 5.38]);
		}
		else
		{
			cube([14, 6.54, 5.38]);
			translate([0,-10.8, 0])
			cube([14, 6.54, 5.38]);
		}
		
	}
}

module ResetButtonMp3Shield()
{
	translate([-3, -32.295, board_height])
	{
		color([0.8, 0.8, 0.8])
		cube([6, 6, 2.2]);
		
		color([0.6, 0.4, 0.2])
		translate([3, 3, 0]) cylinder(r=1.4, h=3.5, $fn=25);
	}
}

module SdSoketMp3Shield()
{
	translate([-7,-20.975, board_height])
	color([0.3, 0.3, 0.3])
	cube([17.6, 14.3, 2]);
}

module FemaleHeadersMp3Shield(combined)
{
	color([0.3, 0.3, 0.3])
	translate([0, 0, board_height])
	{
		translate([0, -2, 0])
		{
			translate([7, -0.975, 0])
			{
				if(combined == 1)
				{
					cube([43, 2, 8.2]);
				}
				else
				{
					cube([21, 2, 8.2]);
					translate([22, 0, 0]) cube([21, 2, 8.2]);
				}
			}
		}

		translate([0, -51.975, 0])
		{
			translate([17, 0, 0])
			{
				if(combined == 1)
				{
					cube([33, 2, 8.2]);
				}
				else
				{
					cube([15.5, 2, 8.2]);
					translate([17.5, 0, 0]) cube([15.5, 2, 8.2]);
				}
			}
		}
	}
}
module MaleHeadersMp3Shield(combined)
{
	//pins
	color([1,1,0]) translate([8.5,0, 0]) rotate([180,0,0])
	for(j= [0:1])
	{
		translate([22*j,0,0])
		for(i=[0:7])
		{
		translate([i*20/8, 0, 0])
		cylinder( h = 8, r =0.5, $fn=10);
		}
	}
	color([1,1,0]) translate([18.5,-49, 0]) rotate([180,0,0])
	for(j= [0:1])
	{
		translate([17.5*j,0,0])
		for(i=[0:5])
		{
		translate([i*20/8, 0, 0])
		cylinder( h = 8, r =0.5, $fn=10);
		}
	}
	color([0.3, 0.3, 0.3])
	translate([0, 0, -board_height])
	{
		translate([7, -1, 0])
		{
			if(combined == 1)
			{
				cube([43, 2, 2]);
			}
			else
			{
				cube([21, 2, 2]);
				translate([22, 0, 0]) cube([21, 2, 2]);
			}
		
		}

		translate([0, -49.975, 0])
		{
			translate([17, 0, 0])
			{
				if(combined == 1)
				{
					cube([33, 2, 2]);
				}
				else
				{
					cube([15.5, 2, 2]);
					translate([17.5, 0, 0]) cube([15.5, 2, 2]);
				}
			}
		}
	}
}

module BoardMp3Shield()
{
	color([1, 0, 0])
	linear_extrude(height = board_height, convexity = 11, twist = 0)
	{
		polygon( points =
						[ [-6.375, 2.545],
						[49.4, 2.545],
						[50.925, 1.021],
						[50.925, -10.409],
						[53.465, -12.949],
						[53.465, -45.715],
						[50.925, -48.255],
						[50.925, -53.775],
						[0,-53.775],
						[0,-40.675],
						[-6.375, -34.235] ],
				paths = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]],
				convexity = 11);
	}
}

module MountingHolesMp3Shield()
{
	translate([0, 0, -10])
	{
		ArduinoHole(25);
		translate([51, -15.25, 0]) ArduinoHole(25);
	}
}

module ArduinoHoleMp3Shield(length)
{
	color([0.7, 0.7, 0.7])
	cylinder(r=1.5, h=length, $fn=25);
}
