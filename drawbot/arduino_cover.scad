include <arduino.scad>

/*
translate([0,80,0]) {
    rotate([-180,0,0]) {
        bottom([260,80,2]);
    }
}

translate([0,0,0]) {
    arduino_row();
}
*/

/*
cover_squared_off([200,85,50], 2, [100, 42.5]);
module cover_squared_off(size, thickness, opening_size) {
    x = size[0];
    y = size[1];
    z = size[2];
    
    opening_size_x = opening_size[0];
    opening_size_y = opening_size[1];
    
    difference() {
        union() {
            difference() {
                cube([x,y,z]);
                translate([thickness,thickness,-thickness]) {
                    cube([x-2*thickness,y-2*thickness,z-thickness]);
                    
                }
                // Back grille
                translate([20,3,5]) {
                    rotate([90,0,0]) {
                        
                        honeycomb(36, 7, 3, 3, 4, 20);
                    }
                }
                // Mounting screw hole 1
                translate([8,0,z/2]) {
                    rotate([90,0,0]) {
                        cylinder(h=4, d=5);
                    }
                }
                // Mounting screw hole 2
                translate([x-5,0,z/2]) {
                    rotate([90,0,0]) {
                        cylinder(h=2*thickness, d=5, $fn=32);
                    }
                }
            }
            // Back grille cutout border
            translate([((x-96)/2)-2,0,16.5]) {
                cube([100, 4, 20]);
            }
        }
        // Back grille cutout
        translate([(x-96)/2,0,18.5]) {
            cube([96, 5, 16]);
        }
        // Title
        translate([171,37,50]) {
            rotate([0,0,180]) {
                linear_extrude(3) {
                    text(text="Drawbot", size=12, font="Abyssinica SIL:style=Italic");
                }
            }
        }
    }
}
*/

honeycombed_cube_with_margins([210, 55, 2], [5, 5], 4, 1);
module honeycombed_cube_with_margins(size, margin, aperature, spacing) {
    // The base size of the cube
    size_x = size[0];
    size_y = size[1];
    size_z = size[2];
    
    // The space between the honeycomb grid and the edge of the cube.
    margin_x = margin[0];
    margin_y = margin[1];
    
    // The size of the box containing the honeycombs.
    hex_box_x = size_x - 2 * margin_x;
    hex_box_y = size_y - 2 * margin_y;
    hex_box_z = size_z;
    
    difference() {
        // Base shape
        cube(size);
        // Honeycomb grille
        translate([margin_x, margin_y, 0]) {
            translate([aperature / 2, aperature / 2, 0]) {
                hex_grid(
                    [hex_box_x, 
                     hex_box_y, 
                     hex_box_z],
                    aperature,
                    spacing);
            }
        }
    }
    
}
// TODO(dsullivan): The grid does not conform to [x,y] size, find the reason.
// TODO(dsullivan): Document the math in this module.
module hex_grid(size, aperature, spacing) {
    size_x = size[0];
    size_y = size[1];
    size_z = size[2];

    cos60 = cos(60);
    sin60 = sin(60);
    cell_size = aperature + spacing;
    // TODO(dsullivan): Rename this var.
    a = cell_size * sin60;

    numberX = floor(size_x / (2 * a * sin60));
    oddX = numberX % 2;

    numberY =  floor(size_y / a);
    oddY = numberY % 2;

    deltaY = oddY == 1 ? a / 2 : 0;

    x0 = numberX * 2 * a * sin60;
    y0 = numberY * a/2 + deltaY;

    for (x = [ 0 : 2 * a * sin60 : x0]) {
        for (y = [ 0 : a : y0]) {
            translate([x, y, 0]) {
                cylinder(d = aperature, h = size_z, $fn = 6);
            }
            
            translate([x + a * sin60, y + a * cos60 , 0]) {
                cylinder(d = aperature, h = size_z, $fn = 6);
            }
       }
    }
}

module arduino_row() {
    translate([10, 6.5, 3]) {
        arduino();
    }
    translate([70, 6.5, 3]) {
        arduino();
    }
    translate([130, 6.5, 3]) {
        arduino();
    }
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