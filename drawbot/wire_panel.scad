// Controls
print_pins = true;

// Constants
PIN_SIZE = [.5, .5, 15];
BLOCK_SIZE = 2.5;

// wire_panel([30, 70, 1]);
module wire_panel(size) {
    union() {
        cube(size);
        translate([0, 0, 0]) {
            rotate([0, 0, 90]) {
                wire_shroud(4, 1);
            }
        }
    }
}

// wire_shroud(4, 1);
module wire_shroud(cols, rows) {
    cube([cols, rows, 10]);
}

prototype_board([70, 30, 1]);
module prototype_board(size) {
    rows = floor((size[0] / BLOCK_SIZE) - 2);
    cols = floor((size[1] / BLOCK_SIZE) - 2);
    echo("ROWS: ", rows, "COLS: ", cols);
    union() {
        color("Green") {
            cube(size);
        }
        translate([BLOCK_SIZE, BLOCK_SIZE, 0]) {
            circle_grid(rows, cols, 1);
        }
    }
}

// circle_grid(28, 12, 1);
module circle_grid(rows, cols, thickness) {
    for (i = [0 : 1: rows]) {
        for (j = [0 : 1 : cols]) {
            translate([i * BLOCK_SIZE, j * BLOCK_SIZE, 0]) {
                difference() {
                    color("Gray") {
                        cylinder(d = BLOCK_SIZE, h = thickness, $fn = 10, center = false);
                    }
                    cylinder(d = PIN_SIZE[0] + .1, h = thickness, $fn = 10, center = false);
                }
            }
        }
    }
}

// pins(4, 1);
module pins(cols, rows) {
    for (current_col = [0 : 1 : cols - 1]) {
        for (current_row = [0 : 1 : rows - 1]) {
            translate([current_col * BLOCK_SIZE, current_row * BLOCK_SIZE, 0]) {
                pin();
            }
        }
    }
}

// pin();
module pin() {
    union() {
        translate([(BLOCK_SIZE - PIN_SIZE[0]) / 2, (BLOCK_SIZE - PIN_SIZE[1]) / 2, 0]) {
            color("Gray") {
                cube(PIN_SIZE);
            }
        }
        translate([0, 0, (PIN_SIZE[2] - BLOCK_SIZE) / 2]) {
            color("Black") {
                cube(BLOCK_SIZE);
            }
        }
    }
}