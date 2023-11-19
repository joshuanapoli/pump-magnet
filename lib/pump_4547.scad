function pump_4547_pump_diameter() = 22.71;
function pump_4547_foot_width() = 21;

// Submersible 3V DC Water Pump - 1 Meter Vertical Type, Adafruit 4547
// https://www.adafruit.com/product/4547
// JT-DC3W-3
// The component body has three main parts:
// - pump: a 10mm long housing with a fan attached to the motor shaft. The pump has a port meant to attach a hose
// - motor: a 27mm long housing containing a DC motor. The motor has a foot meant to slide into a slot for mounting
// - end: a short section covering the electrical connection on the back of the motor
module pump_4547() {
    pump_length=10;
    intake_diameter=10;
    lip_height=1;
    lip_diameter=13;
    alignment_offset=9;
    alignment_diameter=2;
    alignment_height=2;
    port_diameter=7.45;
    port_inner_diameter=port_diameter-2;
    port_height=9.75;
    motor_diameter=22.71;
    motor_length=27;
    end_length=42.6-motor_length-pump_length;
    end_diameter=23.9;

    translate([0,0,-pump_length]) union() {
        // pump
        difference() {
            union() {
                // pump body
                cylinder(h=pump_length, d=pump_4547_pump_diameter());
                
                // pump port
                translate([pump_4547_pump_diameter()/2-port_diameter/2,0,pump_length/2]) rotate([90,0,0]) difference() {
                    cylinder(h=port_height+pump_4547_pump_diameter()/2, d=port_diameter);
                    cylinder(h=port_height+pump_4547_pump_diameter()/2, d=port_inner_diameter);
                }
                
                // pump intake lip
                cylinder(h=pump_length+lip_height, d=lip_diameter);
                
                // alignment points
                for(t=[0:360/3:360]) rotate([0,0,t]) translate([0,-alignment_offset,0]) cylinder(h=pump_length+alignment_height, d=alignment_diameter);
            }
            
            // pump intake
            cylinder(h=pump_length+lip_height, d=intake_diameter);
        }
        
        // motor
        translate([0,0,-motor_length]) {
            cylinder(h=motor_length, d=motor_diameter);
            linear_extrude(motor_length) polygon([
            [-pump_4547_foot_width()/2+2,motor_diameter/2],
            [-pump_4547_foot_width()/2+1,motor_diameter/2+0.5],
            [-pump_4547_foot_width()/2,motor_diameter/2+0.5],
            [-pump_4547_foot_width()/2,motor_diameter/2],
            [0,0],
            [pump_4547_foot_width()/2,motor_diameter/2],
            [pump_4547_foot_width()/2,motor_diameter/2+0.5],
            [pump_4547_foot_width()/2-1,motor_diameter/2+0.5],        [pump_4547_foot_width()/2-2,motor_diameter/2]
            ]);
        }

        // end
        translate([0,0,-end_length-motor_length]) {
            cylinder(h=end_length, d=end_diameter);
        }
    }
}

color("beige") pump_4547();
