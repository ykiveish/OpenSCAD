$fn = 25;

Width   = 23;
Length  = 59;
Thick   = 1.5;

// Methods
module Post (x, y, h) {    
    translate ([x, y, 0])
    difference () {
		cylinder (r = 2.5, h = h);
		cylinder (r = 1.5, h = h + 1);
	}
}

Post ( (Width / 2 - 2),  (Length / 2 - 2), Thick + 5);
Post ( (Width / 2 - 2), -(Length / 2 - 2), Thick + 5);
Post (-(Width / 2 - 2),  (Length / 2 - 2), Thick + 5);
Post (-(Width / 2 - 2), -(Length / 2 - 2), Thick + 5);

difference() {
    translate([0, 0, 0]) 
    cube ([Width + 2, Length + 2, Thick], center = true);
}
