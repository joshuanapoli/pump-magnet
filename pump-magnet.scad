use <lib/pump_4547.scad>

clearance=1;
body_thickness=2;
body_length=0; // matching alignment points
foot_width=pump_4547_foot_width()+2*body_thickness;
foot_height=pump_4547_pump_diameter()/2+body_thickness;
foot_length=body_length+20;
foot_size=[foot_width, foot_height, foot_length];

port_diameter=7.45;
port_inner_diameter=port_diameter-body_thickness;
port_height=9.75;

// % translate([0,0,-10]) pump_4547();


color("green") {
    difference() {
        translate([0,0,1]) union() {            
            // magnetic base
            difference() {
              union() {
                              // pump foot
            translate(-foot_size/2+[0,foot_height/2,-foot_length/2+body_length]) cube(size=foot_size);

                // structural ring
                translate([0,0,-2]) cylinder(h=2, d=30);

                // arm
                for(t=[0:360/3:360]) rotate([0,0,t]) translate([24,0,-2]) cylinder(h=2,d=13+4);
                for(t=[0:360/3:360]) rotate([0,0,t]) translate([0,-17/2,-2]) cube([24,17,2]);
              }
                

              // magnet
              for(t=[0:360/3:360]) rotate([0,0,t]) translate([24,0,-4.5]) cylinder(h=4,d=13);
                  
              // pump body
              translate([0,0,-99]) cylinder(h=100, d=pump_4547_pump_diameter());
            }
        }
        
        // subtract the pump body
        minkowski() {
            pump_4547();
            sphere(d=clearance);
        }
    }
}
