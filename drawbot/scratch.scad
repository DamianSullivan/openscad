    titlebar_size_x = titlebar_size[0];
    titlebar_size_y = titlebar_size[1];
    titlebar_size_z = titlebar_size[2];
    

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

//honeycombed_cube_with_margins([210, 55, 2], [5, 5], 4, 1);
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


    /*
    difference() {
    union() {
        difference() {
            cube([x,y,z]);
            translate([thickness,thickness,-thickness]) {
                cube([x-2*thickness,y-2*thickness,z-thickness]);
                
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
    translate([193,17,50]) {
        rotate([0,0,180]) {
            linear_extrude(3) {
    //            text(text="Drawbot", size=12, font="Abyssinica SIL:style=Italic");
            }
        }
    }
}
*/
