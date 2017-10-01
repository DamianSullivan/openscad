//include <arduino.scad>

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

cover_squared_off(
    4,              // thickness
    [200, 20, 60],  // sidebar_size
    5,              // side_depth
    [200, 85, 4],   // faceplate_size
    [10, 10],       // faceplate_margin
    2,              // faceplate_frame_thickness
    4,              // aperature
    1,              // spacing
    "Drawbot",      // title_text
    12,             // title_size
    "Abyssinica SIL:style=Italic", // title_font
    10,              // title_height
    [-4, -4]);      // title_margin

module cover_squared_off(
    thickness, sidebar_size, side_depth, faceplate_size,
    faceplate_margin, faceplate_frame_thickness, aperature, spacing,
    title_text, title_size, title_font, title_height, title_margin) {
    union() {
        sidebar(sidebar_size, thickness, side_depth,
                title_text, title_size, title_font, title_height,
                title_margin);
        translate([0,
                   sidebar_size[1] - thickness,
                   sidebar_size[2] - side_depth - thickness]) {
            faceplate(faceplate_size,
                      faceplate_margin,
                      faceplate_frame_thickness,
                      aperature,
                      spacing);
        }
        translate([0, sidebar_size[1] - thickness, 0]) {
            faceplate_box([faceplate_size[0],
                   faceplate_size[1],
                   sidebar_size[2] - side_depth],
                   thickness);
        }
    }
}

//sidebar([200,60,60], 4, 10);
module sidebar(size, thickness, side_depth,
               title_text, title_size, title_font, title_height,
               title_margin) {
    difference() {
        // The general shape.
        cube(size);

        // Hollow out the cube.
        translate([thickness, thickness, -thickness]) {
            cube([
                size[0] - 2 * thickness,
                size[1] - 2 * thickness,
                size[2] - thickness]);
        }

        // Cutout that leaves a side depth.
        translate([thickness, size[1] - thickness, -thickness]) {
            cube([
                size[0] - 2 * thickness,
                thickness,
                size[2] - side_depth]);
        }

        translate([
            size[0] + title_margin[0],
            size[1] + title_margin[1],
            size[2] - 2 * thickness]) {
            rotate([0, 0, 180]) {
                title(title_text, title_size, title_font, title_height);
            }
        }
    }
}

// title("Drawbot", 12, "Abyssinica SIL:style=Italic", 2);
module title(title_text, title_size, title_font, title_height) {
    linear_extrude(title_height) {
        text(
            text=title_text,
            size=title_size,
            font=title_font);
    }
}

// faceplate([200, 85, 4], [10, 10], 2, 4, 1);
module faceplate(size, margin, frame_thickness, aperature, spacing) {
    union() {
        honeycomb_grid_with_margin(size, margin, aperature, spacing);
        translate([0, 0, size[2]]) {
            frame(size, frame_thickness);
        }
    }
}

// faceplate_box([200, 84, 50], 4);
module faceplate_box(size, thickness) {
    difference() {
        cube(size);
        translate([thickness, 0, 0]) {
            cube([size[0] - 2 * thickness,
                  size[1] - thickness,
                  size[2]]);
        }
    }
}

// mounting_screws();
module mounting_screws() {
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

// honeycomb_grid_with_margin([200, 85, 4], [10, 10], 4, 1);
module honeycomb_grid_with_margin(size, margin, aperature, spacing) {
    difference() {
        cube(size);
        translate([margin[0], margin[1], 0]) {
            // The hexagons are centered, so shifting here to fit in a rectangle.
            translate([aperature / 2, aperature / 2, 0]) {
                hex_grid([
                    size[0] - 2 * margin[0],
                    size[1] - 2 * margin[1],
                    size[2]
                ],
                aperature,
                spacing);
            }
        }
    }
}

// frame([200, 85, 4], 2);
module frame(size, frame_thickness) {
    //translate([0, 0, frame_thickness / 2]) {
        difference() {
            cube([size[0], size[1], frame_thickness]);
            translate([frame_thickness, frame_thickness, 0]) {
                cube([size[0] - 2 * frame_thickness,
                      size[1] - 2 * frame_thickness,
                      frame_thickness]);
            }
        }
    //}
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
