$fn=25;

skirt_w = 25;
skirt_d = 40 ;
skirt_h = 3;
skirt_r = 3;

translate ([0,-30,skirt_h/2])
minkowski()
{    
    difference()
    {
        cube([skirt_w, skirt_d, skirt_h], center=true);
        translate ([0,0,0])
        cube([skirt_w - 1, skirt_d - 1, skirt_h], center=true);  
    }
    
    sphere(r=skirt_r, h=1);
}

translate ([0,30,skirt_h/2])
minkowski()
{    
    difference()
    {
        cube([skirt_w, skirt_d, skirt_h], center=true);
        translate ([0,0,0])
        cube([skirt_w - 1, skirt_d - 1, skirt_h], center=true);  
    }
    
    sphere(r=skirt_r, h=1);
}

translate ([0,0,3])
minkowski()
{
    cube([1, 15, skirt_h], center=true);
    sphere(r=skirt_r, h=1);
}
