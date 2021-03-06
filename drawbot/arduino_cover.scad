include <arduino.scad>

// Controls for rendering partial parts of the box.
print_sidebar = true;
print_faceplate = true;
print_faceplate_box = true;
print_title_support_holes = true;
print_bottom_plate = true;

// Testing:

// Prints the title lettering over the title supports for testing alignment.
print_test_title = false;

// Print a arduino model in the expected location.
print_test_arduino_row = false;

// TODO(dsullivan): Faceplate dimensions have changed to honeycomb.
cover_squared_off(
    2,              // thickness
    [140, 20, 45],  // sidebar_size
    0,              // side_depth
    [140, 65, 2],   // faceplate_size
    [7, 6],          // faceplate_margin
    0,            // faceplate_frame_thickness
    8,              // aperature
    1.5,            // spacing
    "Drawbot",     // title_text
    12,             // title_size
    "Bitstream Charter:style=Bold Italic", // title_font
    10,             // title_height
    1,              // title_spacing
    [-4, -4]);       // title_margin

if (print_bottom_plate) {    
    translate([0,80,0]) {
        rotate([-180,0,0]) {
            bottom([260,80,2]);
        }
    }
}
    
if (print_test_arduino_row) {
    translate([0,0,-3]) {
        arduino_row();
    }
}

module cover_squared_off(
    thickness, sidebar_size, side_depth, faceplate_size,
    faceplate_margin, faceplate_frame_thickness, aperature, spacing,
    title_text, title_size, title_font, title_height, title_spacing, title_margin) {
    union() {
        if (print_sidebar) {
            difference() {
                // Create a raised sidebar.
                sidebar(sidebar_size, thickness, side_depth);
                
                // Embed a title on the sidebar.
                translate([
                    sidebar_size[0] + title_margin[0],
                    sidebar_size[1] + title_margin[1],
                    sidebar_size[2] + .75]) {
                        rotate([0, 0, 180]) {
                            // Draw the holes for the lettering support.
                            if (print_title_support_holes) {
                                drawbot_letter_supports(3, .5, .5);
                            }
                        } 
                }
            }
        }
        if (print_faceplate) {
            // Create the faceplate.
            translate([thickness,
                      sidebar_size[1],
                      sidebar_size[2] - side_depth - thickness]) {
                honeycomb_grid_with_margin([
                          faceplate_size[0] - 2 * thickness,
                          faceplate_size[1] - thickness,
                          faceplate_size[2]],
                    faceplate_margin,
                    aperature,
                    spacing);
            }
        }
        
        if (print_faceplate_box) {
            // Make a faceplate box under the faceplate.
            translate([0, sidebar_size[1], 0]) {
                faceplate_box([
                    faceplate_size[0],
                    faceplate_size[1],
                    sidebar_size[2] - side_depth],
                    thickness);
           }
       }
    }
}

//sidebar([200,60,60], 4, 10);
module sidebar(size, thickness, side_depth) {
    difference() {
        // The general shape.
        cube(size);

        // Hollow out the cube.
        translate([thickness, thickness, -thickness]) {
            cube([
                size[0] - 2 * thickness,
                size[1] - 2 * thickness,
                size[2]]);
        }

        // Cutout that leaves a side depth.
        translate([thickness, size[1] - thickness, -thickness]) {
            cube([
                size[0] - 2 * thickness,
                thickness,
                size[2] - side_depth]);
        }
        translate([size[0]/4, 0, 5]) {
            cube([70, 3, 35]);
        }
    }
    
    
    
    /*
    // Nameplate mounting tabs
    translate([5.5, size[1] - 3/2, 12]) {
        rotate([90, 0, 0]) {
            mounting_screw_hole(5, 3, 3, 3);
        }
    }
    translate([size[0] - 5.5, size[1] - 3/2, 12]) {
        rotate([90, 0, 180]) {
            mounting_screw_hole(5, 3, 3, 3);
        }
    }
    */
}

// title("Drawbot", 11, "Abyssinica SIL:style=Italic", 2, 1.1);
module title(title_text, title_size, title_font, title_height, title_spacing) {
    linear_extrude(title_height) {
        text(
            text=title_text,
            size=title_size,
            font=title_font,
            spacing = title_spacing);
    }
}

// title_with_supports([60, 14, 2], [1, 1], "Drawbot", 12, "Abyssinica SIL:style=Italic", 2, 1);
module title_with_supports(size, margin, title_text, title_size, title_font, title_height, title_spacing) {
    union() {
        title(title_text, title_size, title_font, title_height, title_spacing);
        drawbot_letter_supports(3, .5, .5);
    }
}

// Make a test plate with the lettering support holes 
// title_test_plate([60, 14, 2]);
module title_test_plate(size) {
   difference() {
        cube(size);
        translate([0, 0, 3]) {
           drawbot_letter_supports(2, .5, .5);
        }
   }
}

// Manually adjust the lettering supports since OpenCAD cannot give the dimensions of the 
// letters to position automatically.
module drawbot_letter_supports(height, radius1, radius2) {
    $fn=20;
    z_pos = -3;
    
    // Y axis points common to all the letters, homogenizing to keep things simpler.
    y_pos1 = 1.1;
    y_pos2 = 4.6;
    y_pos3 = 7.2;
    y_pos4 = 9.5;
    
    // D
    translate([2.7, y_pos1, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([2.7, y_pos4, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([10.1, y_pos2, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    
    // r
    translate([13.55 , y_pos3, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([13.67 , y_pos1, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([17 , y_pos3, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    
    // a
    translate([19.95, y_pos3, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([19.4, y_pos1, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([23.9, y_pos1, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    
    // w
    translate([28, y_pos3, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([29.7, y_pos1, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([32.8, y_pos3, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([35, y_pos1, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([37.39, y_pos3, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    
    // b
    translate([40.9, y_pos4, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([40.9, y_pos1, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([46.35, y_pos2, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    
    // o
    translate([49.2, y_pos2, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    translate([55.3, y_pos2, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }
    
    // t
    translate([58.9, y_pos3, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
    }   
    translate([59.1, y_pos1, z_pos]) {
        cylinder(h=height, r1=radius1, r2=radius2);
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
    
    // Faceplate mounting tabs
    translate([5.5, 3, 4]) {
        mounting_screw_hole(5, 3, 3, 3);
    }
    translate([5.5, size[1] - 5, 4]) {
        mounting_screw_hole(5, 3, 3, 3);
    }
    translate([size[0] - 5.5, 3, 4]) {
        rotate([0, 0, 180]) {
            mounting_screw_hole(5, 3, 3, 3);
        }
    }
    translate([size[0] - 5.5, size[1] - 5, 4]) {
        rotate([0, 0, 180]) {
            mounting_screw_hole(5, 3, 3, 3);
        }
    }
    translate([size[0]/2, size[1] - 5, 4]) {
        rotate([0, 0, 270]) {
            mounting_screw_hole(5, 3, 3, 3);
        }
    }
    
    /*
    translate([size[0]/2, -15, 4]) {
        rotate([0, 0, 90]) {
            mounting_screw_hole(5, 3, 3, 3);
        }
    }
    
    
    // Frame mounting tabs
    translate([size[0] - 10, size[1], 0]) {
        mounting_tab([10, 10, 3], 5, 5);
    }
    translate([0, size[1], 0]) {
        mounting_tab([10, 10, 3], 5, 5);
    }
    
    // Nameplate mounting tabs
    translate([5.5, 1, 12]) {
        rotate([90, 0, 0]) {
            mounting_screw_hole(5, 3, 3, 3);
        }
    }
    translate([size[0] - 5.5, 1, 12]) {
        rotate([90, 0, 180]) {
            mounting_screw_hole(5, 3, 3, 3);
        }
    }
    */
}

module mounting_tab(size, protrusion, diameter) {
    difference() {
        cube([size[0], size[1] + protrusion, size[2]]);
        translate([size[0] - diameter, size[1] - diameter + protrusion, 0]) {
            cylinder(h=size[2], d=diameter, $fn=32);
        }    
    }
}

module mounting_screw_hole(outside_diameter, inside_diameter, height, protrusion) {
    union() {
        translate([-protrusion, 0, 0]) {
            cube([protrusion, outside_diameter, height], center = true);
        }
        difference() {
            cube([outside_diameter, outside_diameter, height], center = true);
            cylinder(h=height, d=inside_diameter, $fn=32, center = true);
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
            // TODO(dsullivan): Find the reason for these fudge factors to center.
            translate([aperature / 2 - 2.5, aperature / 2 - 1.2, 0]) {
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
    /*
    translate([margin[0] / 2, margin[1] / 2, -size[2] + (size[2] - 4)]) {
        screw_hole(5, 3, 6);
    }
    translate([size[0] - margin[0] / 2, margin[1] / 2, -size[2] + (size[2] - 4)]) {
        screw_hole(5, 3, 6);
    }
    translate([size[0] - margin[0] / 2, size[1] - margin[1] / 2, -size[2] + (size[2] - 4)]) {
        screw_hole(5, 3, 6);
    }
    translate([margin[0] / 2, size[1] - margin[1] / 2, -size[2] + (size[2] - 4)]) {
        screw_hole(5, 3, 6);
    }
    */
}

module screw_hole(outside_diameter, inside_diameter, height) {
    difference() {
        cylinder(h=height, d=outside_diameter, $fn=32);
        cylinder(h=height, d=inside_diameter, $fn=32);
    }
} 



/*
// frame([200, 85, 4], 2);
module frame(size, frame_thickness) {
    difference() {
        cube([size[0], size[1], frame_thickness]);
        translate([frame_thickness, frame_thickness, 0]) {
            cube([size[0] - 2 * frame_thickness,
                  size[1] - 2 * frame_thickness,
                  frame_thickness]);
        }
        translate([frame_thickness, 0, 0]) {
            cube([size[0] - 2 * frame_thickness , frame_thickness, frame_thickness]);
        }
    }
}
*/

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
    number_cells_x = floor(size_x / hex_radius);

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

arduino_row();
module arduino_row() {
    translate([10, 6.5, 3]) {
        arduino();
    }
    translate([70, 6.5, 3]) {
        arduino();
    }
    //translate([130, 6.5, 3]) {
    //   arduino();
    //}
    /*
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
    */
}
