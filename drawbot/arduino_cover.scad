include <honeycomb.scad>
include <arduino.scad>

translate([0,80,0]) {
    rotate([-180,0,0]) {
        //bottom([260,80,2]);
    }
}

translate([161,140,0]) {
    arduino_row();
    arduino_bumpers();
}

difference() {
    union() {
        difference() {
            angled_cover();
            translate([1.7,1.6,-2]) {
                scale([.97,.97,.97]) {
                    angled_cover();
                }
            }
            // Back grille
            translate([-22,141,7]) {
                rotate([90,0,0]) {
                    honeycomb(38, 7, 3, 3, 4, 20);
                }
            }
            // Mounting screw hole 1
            translate([-34,141,25]) {
                rotate([90,0,0]) {
                    cylinder(h=4, d=5);
                }
            }
            // Mounting screw hole 2
            translate([164,141,25]) {
                rotate([90,0,0]) {
                    cylinder(h=4, d=5, $fn=32);
                }
            }
        }
        // Back grille cutout border
        translate([19,137,16.5]) {
            cube([100, 4, 20]);
        }
    }
    // Back grille cutout
    translate([21,136,18.5]) {
        cube([96, 5, 16]);
    }
    // Title
    translate([132,126,50]) {
        rotate([0,0,180]) {
            linear_extrude(3) {
                text(text="Drawbot", size=25, font="Abyssinica SIL:style=Italic");
            }
        }
    }
}

module arduino_row() {
    rotate([0,0,180]) {
        translate([10, 6.5, 3]) {
            arduino();
        }
        translate([70, 6.5, 3]) {
            arduino();
        }
        translate([130, 6.5, 3]) {
            arduino();
        }
    }
}

module arduino_bumpers() {
    rotate([0,0,180]) {
        render() {
            rotate([0,0,180]) {
                translate([10, 6.5, 0]) {
                    bumper();
                }
                translate([70, 6.5, 0]) {
                    bumper();
                }
                translate([130, 6.5, 0]) {
                    bumper();
                }
            }
        }
    }
}

module angled_cover() {
    union() {
        union() {
            difference() {
                cover([130,80,4]);
                translate([0,0,-2]) {
                    cover([130,80,4]);
                }
            }
        }
        translate([-40,90,2]) {
            cube([210,50,50]);
        }
    }
}

module cover(size=[0,0,0]) {
    x=size[0];
    y=size[1];
    z=size[2];
    minkowski() {
        translate([0,0,0]) {
            cube([x,y,z]);
        }
        union() {
            translate([0,0,13]) {
                sphere(r=4);
            }
            cylinder(40,40,04,$fn=100);
        }
        
    }       
}

module bottom(size=[0,0,0]) {
    x=size[0];
    y=size[1];
    z=size[2];
    hull() {    
        minkowski() {
            translate([0,0,0]) {
                cube([x,y,z]);
            }
            cylinder(h=2, r=20);
        }
        
    }
}
