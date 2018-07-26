include </home/dsullivan/src/openscad/scroll/base_frame_joint.scad>
include </home/dsullivan/src/openscad/scroll/stepper_mount.scad>

base_support_joint();

translate([36, 73.5, -40]) {
    rotate([270, 0, 180]) {
        difference() {
            stepper_mount();
        }
    }
}

       