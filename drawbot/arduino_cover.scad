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
    
    union() {

        translate([0,30,48]) {
            difference() {
                cube([x - 10, y - 10, 10]);
                cube([
            }
            
        }
        translate([0,30,48]) {
            honeycombed_cube_with_margins([
                x - 10, y - 10, 3], [5, 5], 4, 1);
        }
    }
}
*/


//titlebar([200,20,20]);
module titlebar(size) {
    cube(size);
}

faceplate([200, 85, 4], [10, 10], 2, 4, 1);
module faceplate(size, margin, frame_thickness, aperature, spacing) {
    union() {
        difference() {
          cube(size);
          translate([margin[0], margin[1], 2]) {
              translate([aperature / 2, aperature / 2, 0]) {
                  hex_grid([
                          size[0] - 2 * margin[0],
                          size[1] - 2 * margin[1],
                          size[2]
                      ],
                      aperature,
                      spacing
                  );
                }
            }
        }
        translate([0, 0, size[2]]) {
            union() {
                cube(size);
                translate([frame_thickness/2, frame_thickness/2, 0]) {
                    cube([size[0] - frame_thickness,
                          size[1] - frame_thickness,
                          frame_thickness]);
                }
            }
        }
    }
}


// TODO(dsullivan): The grid does not conform to [x,y] size, find the reason.
module hex_grid(size, aperature, spacing) {
    size_x = size[0];
    size_y = size[1];
    size_z = size[2];

    // Sine of 60 is the y-length from the center of the hexagon to the edge of the facet.
    sin60 = sin(60);
    
    // Cosine of 60 is the x-length from the center of the hexagon to the edge of the facet.
    cos60 = cos(60);

    // The aperature param is the diameter of the circle that the hexagon cell will fit into.
    // To find the y-height of the hexagon froHUm the center of the circle
    // (half the height of the hexagon) to the edge with spacing,
    // we will need to multiply by the sin(60)
    // (the angle is 360 total / 6 sides = 60 degrees for each angle).
    hex_radius = (aperature + spacing) * sin60;

    // The number of hexagons across the grid on the x axis.
    // number_cells_x = floor(size_x / (2 * hex_radius * sin60));
    number_cells_x = floor(size_x / hex_radius) - 1;
    
    // The number of hexagons across the grid on the y axis.
    number_cells_y = floor(size_y / hex_radius) - 1;

    deltaY = number_cells_y % 2 == 1 ? hex_radius / 2 : 0;

    x0 = number_cells_x * hex_radius;
    y0 = number_cells_y * hex_radius;

    for (x = [ 0 : 2 * hex_radius * sin60 : x0]) {
        for (y = [ 0 : hex_radius : y0]) {
            translate([x, y, 0]) {
                cylinder(d = aperature, h = size_z, $fn = 6);
            }
            
            translate([x + hex_radius * sin60, y + hex_radius * cos60 , 0]) {
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
