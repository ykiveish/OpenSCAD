$fn = 20;

Width = 32;

// Methods
module Holes (x, y) {    
    translate ([x, y, 1.5])
    cylinder (r = 4, h = 2.5);
    
    translate ([x, y, 0])
	cylinder (r = 2, h = 5 + 1);
}

//Post (0, 0, 50);

difference() {
    translate([0, 0, 1.5]) 
    cube ([Width, 112, 3], center = true);

    Holes ( 10, 0);
    Holes (-10, 0);
}

translate([-(Width / 2), -58, 0]) 
cube ([Width, 2, 8.5]);

translate([-(Width / 2), -58, 6.5]) 
cube ([Width, 4, 2]);

translate([-(Width / 2), 56, 0]) 
cube ([Width, 2, 8.5]);

translate([-(Width / 2), 54, 6.5]) 
cube ([Width, 3, 2]);
