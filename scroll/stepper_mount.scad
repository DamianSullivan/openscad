include <math.scad>
include <MCAD/motors.scad>
include <MCAD/stepper.scad>

thickness = 3;
$fn=100;

difference() {
    // The stepper motor mount wall.
    translate([0, -10, 0]) {
        cube([50, 60, thickness], center=true);
    }
    
    // Stepper motor mount is 2D, extrude this to "cut" the pattern
    // into the cube.
    linear_extrude(height = thickness,
                   center = true,
                   convexity = 10,
                   twist = 0) {
        stepper_motor_mount(
            nema_standard = 17,
            slide_distance = 0,
            mochup = false, 
            tolerance = .25);
    }
}

difference() {
    // Bottom mount plate.
    rotate([90,0,0]) {
        translate([0, 25 - thickness/2, 40-thickness/2]) {
            cube([72, 50, thickness], center=true);
        }
    }
    
    // Screw holes to the bottom mount plate.
    rotate([90,0,0]) {
        translate([-30,7,40-thickness/2]) {
            cylinder(h=thickness+1, r=0.195 * mm_per_inch / 2, center=true);
        }
        translate([-30,40,40-thickness/2]) {
            cylinder(h=thickness+1, r=0.195 * mm_per_inch / 2, center=true);
        }
        translate([30,7,40-thickness/2]) {
            cylinder(h=thickness+1, r=0.195 * mm_per_inch / 2, center=true);
        }
        translate([30,40,40-thickness/2]) {
            cylinder(h=thickness+1, r=0.195 * mm_per_inch / 2, center=true);
        }
    }

}

// Angled side support
translate([25, 20, thickness/2]) {
    rotate([0,0,180]) {
        prism(thickness, 60, 50-thickness);
    }
}

// Angled side support
translate([-25+thickness, 20, thickness/2]) {
    rotate([0,0,180]) {
        prism(thickness, 60, 50-thickness);
    }
}

translate([0,-23,17]) {
  cube([50, thickness, 34], center=true);
}


motor(model=Nema17,
       size=NemaMedium,
       dualAxis=false,
       pos=[0,0,0],
       orientation = [0,0,0]);

module prism(l, w, h) {
    polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
}
 