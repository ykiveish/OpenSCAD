$fn = 25;

Width   = 35;
Length  = 130;
Thick   = 2;

// Methods
module Post (x, y, h) {    
    translate ([x, y, 0])
    difference () {
		cylinder (r = 2.5, h = h);
		cylinder (r = 1.5, h = h + 1);
	}
}

difference() {
    translate([0, 0, 0]) 
    cube ([Width + 2, Length + 2, Thick], center = true);
    
    translate([18, 65, 0])
    rotate([0,0,45])
    cube ([20, 30, Thick], center = true);
    
    translate([18, -65, 0])
    rotate([0,0,315])
    cube ([20, 30, Thick], center = true);
}
