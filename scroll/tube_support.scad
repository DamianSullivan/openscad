// Globals
$fn=100;
thickness = 3;

// Tube holder
// Tube for Bienfang No. 106 is 19mm. Making this a tiny bit wider to
// make it snug so the motor can turn it.
tube_radius = 19;
tube_support_length = 15;

// The bearing or support structure.
support_length = 12;

// 8mm is exactly the radius of the bearing or motor mound. Make the
// hole only slight bigger to fit snugly to avoid having to use glue or
// screw in place.
support_radius = 8.20;

// The outer guide for the paper to prevent side drift when rescrolling.
brim_radius = 35;
// Allow some room for any excess paper roll material.
brim_gap_radius = 14;
brim_gap_depth = 4;

tube_support();
translate([0,0,thickness]) {
    tube_grip(tube_radius, .4, tube_support_length);
}

module tube_support() {
    
  // The guard disk with a hole to hold the bearing or
  // other support.
  difference() {
    // The guard disk.
    cylinder(h=thickness, r=brim_radius, center=false);
    
    // The hole for the tube that will hold the bearing or support.
    cylinder(h=thickness, r=support_radius, center=false);
  }
  
  translate([0,0, thickness]) {
    // Add a secondary brim to form a gap for excess roll material to go,
    // but allows the brim to stay flush with the paper to guide it.
    difference() {
      // The secondary brim
      cylinder(h=brim_gap_depth, r=brim_radius, center=false);

      // Cut out a cylinder slightly larger than the tube support in
      // order to make a gap for any extra paper roll material.
      cylinder(h=brim_gap_depth,
               r=tube_radius + brim_gap_radius,
               center=false);
    }
  }

  translate([0,0,thickness]) {
    // The tube that will hold the roll. 
    tube(tube_support_length, tube_radius, thickness);
    
    // The tube that will hold the bearing or support.
    tube(support_length + thickness, support_radius + thickness, thickness);
    
    // The cap at the end of the tube that will hold the bearing or support.
    // Two thicknesses: one for the guard disk, and one for the end of the
    // support tube.
    translate([0, 0, support_length]) {
      difference() {
        cylinder(h=thickness, r=support_radius, center=false); 
        // Put a hole in the support cap in case there is a long rod as a
        // support.
        cylinder(h=thickness, r=support_radius+2, center=false); 
      }
    }
  }
}

module tube_grip(tube_radius, grip_radius, height) {
    for (i=[1:45:360]) {
        rotate([0,0,i]) {
            translate([0,tube_radius,0]) {
                translate([0,0,height/2]) {
                    cylinder(h=height/2, r1=grip_radius, r2=0, center=false);
                }
                cylinder(h=height/2, r=grip_radius, center=false);
            }
        }
    }
}

// Make a tube with an outer radius with the wall thickness
// on the inside.
module tube(height, radius, thickness) {
  difference() {
    cylinder(h=height, r=radius, center=false);
    cylinder(h=height, r=radius-thickness, center=false);
  }   
}
 