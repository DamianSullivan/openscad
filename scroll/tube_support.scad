include <MCAD/bearing.scad>

working_dir = "/home/dsullivan/src/openscad/scroll";

rotate([90,0,0]) {
    translate([-34,0,-30]) {
      //import(str(working_dir, "/TowelPart1_V2.STL"));
    }
}

color("black") {
  // bearing(model=608);
}

// Globals
$fn=500;
thickness = 3;

// Tube holder
tube_radius = 19;
tube_support_length = 26;

// The bearing or support structure.
support_length = 12;

// 8mm is exactly the radius of the bearing or motor mound. Make the
// hole only slight bigger to fit snugly to avoid having to use glue or
// screw in place.
support_radius = 8.10;

// The outer guide for the paper to prevent side drift when rescrolling.
brim_radius = 35;
// Allow some room for any excess paper roll material.
brim_gap = 3;

tube_support();

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
      cylinder(h=thickness, r=brim_radius, center=false);

      // Cut out a cylinder slightly larger than the tube support in
      // order to make a gap for any extra paper roll material.
      cylinder(h=2*thickness,
               r=tube_radius + brim_gap,
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

// Make a tube with an outer radius with the wall thickness
// on the inside.
module tube(height, radius, thickness) {
  difference() {
    cylinder(h=height, r=radius, center=false);
    cylinder(h=height, r=radius-thickness, center=false);
  }   
}
 