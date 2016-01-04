$fn = 20;

// Methods
module Holes (x, y) {    
    translate ([x, y, 1.5])
    cylinder (r = 4, h = 2.5);
    
    translate ([x, y, 0])
	cylinder (r = 2, h = 5 + 1);
}

difference() {
    translate([0, 0, 1.5]) 
    cube ([25, 25, 25], center = true);
}



difference() {
    translate ([0, 0, 21.2])
    rotate([0, 270, 0])
    cylinder(25, 14.5, 14.5, $fn=3, center = true);
    
    translate([0, -7, 23])
    rotate([330, 0, 0])
    cube ([27, 3, 19], center = true);
}