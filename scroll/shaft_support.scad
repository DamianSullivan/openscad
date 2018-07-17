include <MCAD/motors.scad>
include <MCAD/stepper.scad>

// Uncomment for testing.
//motor(model=Nema17, size=NemaMedium, dualAxis=false, pos=[0,0,0], orientation = [0,0,0]);
 
 $fn=100;
 thickness = 3;
 support_length = 20;
 support_radius = 10;
 shaft_radius = 2.5;
 
 shaft_support();
 module shaft_support() {   
    difference() {
        // The stepper motor mount wall.
        translate([0, 0, 0]) {
            cube([40, 40, thickness], center=true);
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

    tube(thickness, shaft_radius, 25/2-shaft_radius, true);

    translate([0, 0, support_length/2]) {
        rotate([0, 0, 90]) {
            tube(support_length, shaft_radius, thickness, true);
        }
    }
    
    // Support braces
    translate([-thickness/2, -15, 0]) {
        rotate([0, 0, 0]) {
            prism(thickness, 10, support_length);
        }
    }
    translate([15, -thickness/2, 0]) {
        rotate([0, 0, 90]) {
            prism(thickness, 10, support_length);
        }
    }
    translate([thickness/2, 15, 0]) {
        rotate([0, 0, 180]) {
            prism(thickness, 10, support_length);
        }
    }
    translate([-15, thickness/2, 0]) {
        rotate([0, 0, 270]) {
            prism(thickness, 10, support_length);
        }
    }

}

module prism(l, w, h) {
    polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]);
}
 
// Make a tube with an outer radius with the wall thickness
// on the inside.
module tube(height, radius, thickness, center) {
  difference() {
    cylinder(h=height, r=radius+thickness, center=center);
    cylinder(h=height, r=radius, center=center);
  }   
}