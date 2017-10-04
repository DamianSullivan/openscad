use <MCAD/bearing.scad>;
use <MCAD/materials.scad>;
use <T-Slot.scad>;

$fn=30;

union() {
    union() {
        translate([0,-26,0]) {
            gantry([60,52,4], r=5);
        }
        
        translate([23,-15.5,-3]) {
            difference() {
                rotate([180,0,90]) {
                    carriage();
                }
                translate([-15,-3,-8]) {
                    cylinder(h=10, r=10);
                }
            }
        }
    }
    
}


translate([0,0,-11]) {
    rotate([0,90,0]) {
        2020Profile(200);
    }
    translate([8,18,3.5]) {
            bearing(model=625);
       
    }
    translate([30,12,-2.5]) {
            bearing(model=625);
       
    }
    translate([52,18,3.5]) {
            bearing(model=625);
       
    }
    translate([8,-18,3.5]) {
            bearing(model=625);
       
    }
    translate([30,-12,-2.5]) {
            bearing(model=625);
       
    }
    translate([52,-18,3.5]) {
            bearing(model=625);
    }
}

module carriage() {
    difference() {
        rotate([0,0,90]) {
          import("/home/dsullivan/Downloads/2020_DRAWbot/files/2020_DB_xyJoiner.stl");
        };
        translate([-15,49,0]) {
          cube([70,50,14],center=true);
        };
        translate([5,0,0]) {
          cube([30,41,14],center=true);
        };
        
    }
}

// TODO(dsullivan): Make these measurements relative.
module gantry(size, radius=r) {
    x = size[0];
    y = size[1];
    z = size[2];
    
    difference() {
        rounded_corner_top([x,y,z], r=r);
        translate([8,8,0]) {
            cylinder(h=10, r=2.5);
        }
        translate([52,8,0]) {
            cylinder(h=10, r=2.5);
        }
        translate([8,44,0]) {
            cylinder(h=10, r=2.5);
        }
        translate([52,44,0]) {
            cylinder(h=10, r=2.5);
        }
    }
    translate([8,8,-3]) {
        holed_cone(3, 2.5, 5);
    }
    translate([52,8,-3]) {
        holed_cone(3, 2.5, 5);
    }
    translate([8,44,-3]) {
        holed_cone(3, 2.5, 5);
    }
    translate([52,44,-3]) {
        holed_cone(3, 2.5, 5);
    }
    translate([30,14,0]) {
        rotate([0,180,270]) {
            rail_guide(8.5, 5.1, 5, 1, .75, 2.5);

        }
    }
    translate([30,38,0]) {
        rotate([0,180,90]) {
            rail_guide(8.5, 5.1, 5, 1, .75, 2.5);

        }
    }
}

module holed_cone(height, radius1, radius2) {
    difference() {
        cylinder(h=height, r1=radius1, r2=radius2);
        cylinder(h=height, r=radius1);
    }    
}

module rail_guide(height1, height2, height3, lip, gap, radius) {
    difference() {
        union() {
            half_stem(height1, radius+lip);
            translate([0,0,height1]) {
                cylinder(r=radius, h=height2);
            }
        }
        translate([0,0,height1 + .5*height2]) {
            cylinder(r=1.5, h=.5*height2);
        }
    }
}

module half_stem(height, radius) {
    difference() {
        cylinder(h=height, r=radius);
        translate([0,-radius,0]) {
            cube([radius, 2*radius, height]);
        }
        
    }
}

module rounded_corner_top(size, radius=r) {
    x = size[0];
    y = size[1];
    z = size[2];
    union() {
        difference() {
            cube([x,y,z]);
            translate([x-r,y-r,0]) {
                cube([r,r,z]);
            }
            translate([0,y-r,0]) {
                cube([r,r,z]);
            }
            translate([0,0,0]) {
                cube([r,r,z]);
            }
            translate([x-r,0,0]) {
                cube([r,r,z]);
            }
        }
        translate([x-r,y-r,0]) {
            cylinder(h=z, r=r);
        }
        translate([r,y-r,0]) {
            cylinder(h=z, r=r);
        }
        translate([r,r,0]) {
            cylinder(h=z, r=r);
        }
        translate([x-r,r,0]) {
            cylinder(h=z, r=r);
        }
    }
}

