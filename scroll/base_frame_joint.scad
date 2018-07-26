thickness = 3;
extrusion_size = 20;
half_extrusion = extrusion_size / 2;
joint_height = 83;
joint_width = 56;
$fn=100;

base_support_joint();
translate([0, 0, extrusion_size]) {
    mirror([0, 0, 1]) {
//        base_support_joint();
    }
}
module base_support_joint() {
    difference() {
        base_support_box();
        screw_holes();
    }
}

module base_support_box() {

    // base
    translate([0, 0, 0]) {
        cube([joint_height, joint_width + thickness, thickness]);
    }

    // top
    translate([0, 0, thickness]) {
        cube([thickness, joint_width + thickness, half_extrusion]);
    }
    
    // left side
    translate([0, 0, thickness]) {
        cube([joint_height, thickness, half_extrusion]);
    }
    
    // right side
    translate([thickness + extrusion_size, joint_width, thickness]) {
        cube([joint_height - extrusion_size - thickness, thickness, half_extrusion]);
    }
    
    // inside left side
    translate([thickness + extrusion_size, extrusion_size + thickness, thickness]) {
        cube([joint_height - extrusion_size - thickness, thickness, half_extrusion]);
    }
    
    // inside right side
    translate([thickness + extrusion_size, joint_width - thickness - extrusion_size, thickness]) {
        cube([joint_height - extrusion_size - thickness, thickness, half_extrusion]);
    }
    
    // inside top
    translate([thickness + extrusion_size, thickness + extrusion_size, thickness]) {
        cube([thickness, joint_width - thickness - 2 * extrusion_size, half_extrusion]);
    }
}

module screw_holes() {
    
    // long bar support screw hole left
    translate([thickness + half_extrusion, thickness + half_extrusion, 0]) {
        cylinder(h=thickness, r=2.5, center=false);
    }
 
    // long bar support screw hole right
    translate([thickness + half_extrusion, thickness + joint_width - thickness - half_extrusion, 0]) {
        cylinder(h=thickness, r=2.5, center=false);
    }
    
    // left bar support screw hole top
    translate([thickness + 1.5 * extrusion_size, thickness + half_extrusion, 0]) {
        cylinder(h=thickness, r=2.5, center=false);
    }
    
    // right bar support screw hole top
    translate([thickness + 1.5 * extrusion_size, thickness + joint_width - thickness - half_extrusion, 0]) {
        cylinder(h=thickness, r=2.5, center=false);
    }
    
    // left bar support screw hole top
    translate([joint_height - half_extrusion, thickness + half_extrusion, 0]) {
        cylinder(h=thickness, r=2.5, center=false);
    }
 
    // right bar support screw hole bottom
    translate([joint_height - half_extrusion, thickness + joint_width - thickness - half_extrusion, 0]) {
        cylinder(h=thickness, r=2.5, center=false);
    }
}