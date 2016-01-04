$fn = 20;

module Box (x, y, z) {
    BottoomWallThick = 4;
    
    translate ([0, 0, z / 2])
    minkowski () {
        cube ([x + BottoomWallThick, y + BottoomWallThick, z], center = true);
        cylinder (r = 3.5, h = 1);
    }
    
    translate([0, 0, 5])
    minkowski() {
        cube ([x, y, z*2], center = true);
        cylinder (r = 3.5, h = 1);
    }
}

module WallXZ (x, z, y,  hight, width, thickness, rotation) {
    if (rotation == 0) {
        translate([x, y, z])
        cube([width, thickness, hight], center = true);
    }
}

module Main () {
    difference () {
        Box (110, 92, 2);
        
        translate ([-29, -22, 0])
        cube ([10, 40, 20], center = true);
    }
    
    WallXZ (0, 1.5, -53, 3, 90, 5, 0);
    WallXZ (0, 1.5, 53, 3, 90, 5, 0);
}

Main ();