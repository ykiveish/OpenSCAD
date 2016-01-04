$fn=15;
wall = 2.5;
bw = 110+ wall*2 ;
bd = 131 + wall*2;
bh = 50;
base_thick=2.5;
base_h_offset =0;

tile_w = 20;
tile_h = 20;
tile_edge_r = wall/4;

head_h=40;
head_w=130;
head_wall=1.5;

skirt_w = 140 +wall*2;
skirt_d = 146 ;
skirt_h = 90;
skirt_wr = 10;
skirt_dr = 10;
skirt_rh = 10;
skirt_r = 10;
skirt_wall_sides = 1.5;
skirt_wall_top = 2;



module pyramid(side=10, height=-1, square=false, centerHorizontal=true, centerVertical=false){
// creates a 3 or 4 sided pyramid.  -1 height= tetrahedron or Johnson's Solid square pyramid
	mHeight= height!=-1 ? height:
		square == true ? (1/sqrt(2))*side:		//square
			sqrt(6)/3*side;						//tetra
	vert= centerVertical!=true ? [0,0,0]:
		square==false ? [0,0,-mHeight/4] :	 //inscribes a tetra inside a sphere, not 1/2 ht
			[0,0,-mHeight/2];	//for squares, center=false inscribes, so true is just 1/2 ht
	horiz= centerHorizontal!= true ? [0,0,0] :
		square == true ? [-side/2, -side/2, 0] : 	//square
			[-side/2,-sqrt(3)*side/6 ,0];			//tetra
	translate(vert+horiz){
		if (square == true){
			polyhedron (	points = [[0,0,0],[0,side,0],[side,side,0],
								[side,0,0],[side/2,side/2,mHeight]], 
						faces = [[1,0,2], [2,0,3], [0,4,3], 
								[3,4,2], [2,4,1], [1,4,0]]);
		}
		if (square != true){
			polyhedron (	points = [[0,0,0],[side,0,0],[side/2,sqrt(3)*side/2,0],
								[side/2,sqrt(3)*side/6,mHeight]], 
						faces = [[0,1,2], [1,0,3], [2,1,3],[2,3,0]]);			
		}
}	}

module tile(){
    cube([tile_w,wall+0.03,tile_h],center=true);
    translate([0,0,0])
    {
        minkowski()
        {
            cube([tile_w,0.1,tile_h],center=true);
            sphere(r=tile_edge_r);
        }
    }
    translate ([-tile_w/2-tile_edge_r/2,0,-tile_h/2+tile_edge_r*2])
        sphere(r=tile_edge_r);

    translate ([tile_w/2+tile_edge_r/2,0,-tile_h/2+tile_edge_r*2])
        sphere(r=tile_edge_r);
    
}


module tiles(){
    for (x=[-2:2:3])    
    {    
        translate([x*tile_w,bd/2-wall/2,bh/2+tile_h/2])
        tile();   
        translate([x*tile_w,-bd/2+wall/2,bh/2+tile_h/2])
        tile();   
        
        translate([-bw/2+wall/2,x*tile_w,bh/2+tile_h/2])
        rotate([0,0,90])
        tile();   
        translate([bw/2-wall/2,x*tile_w,bh/2+tile_h/2])
        rotate([0,0,90])
        tile();     
    } 
}

module top(){
    
    difference()
    {
        cube ([bw,bd,bh+tile_h],center=true);
        translate([0,0,-wall])
        cube ([bw-wall*2,bd-wall*2,bh+tile_h],center=true);
        translate([0,0,-bh-tile_h/2])
        tiles();
    }   
    
}


module bottom(){
    difference()
    {
        cube ([bw,bd,bh],center=true);
        translate([0,0,bh/2+base_thick/2+base_h_offset])
        cube ([bw-wall*2,bd-wall*2,bh],center=true);
        translate([0,0,-bh/2-base_thick/2+base_h_offset])
        cube ([bw-wall*2,bd-wall*2,bh],center=true);
    }
    
    tiles();
   
}


d = 55; //31 - 45
module body(){
    translate([0,0,120])
    head(); 
    
    translate([0,0,d])
    top();

    translate([0,0,-d])
    bottom();    
}

module head(){   
difference()
{    
    minkowski()
    {
        
        cube([head_w,head_w,head_h],center=true);  
       sphere(r=10,h=1); 
   // translate([wall,wall,wall])
    //cube([bw-head_wall*2,bd-head_wall*2,head_h-head_wall*2],center=true); 
    }
}
}
module _skirt(){   
   // translate([0,0,80])
   // cube([skirt_w,skirt_d,3],center=true);
resize(newsize=[skirt_w,skirt_d,skirt_h])    
    minkowski()
    {    
        difference()
        {
            cube([skirt_w,skirt_d,skirt_h],center=true);   
            
            translate([skirt_w/2,0,-75])
            rotate ([0,-30,0])
            cube([150,skirt_d,skirt_h],center=true);   
            translate([-skirt_w/2,0,-75])
            rotate ([0,30,0])
            cube([150,skirt_d,skirt_h],center=true);   
        }
        
        sphere(r=skirt_r,h=1);

    }
}

module skirt(){
    
    // vertical stoppers
    translate([0,0,-7]){   
        translate([30,-30,0])
        cylinder(r=2,h=50);
        translate([30,30,0])
        cylinder(r=2,h=50);        
    }
    
    translate([0,0,46])
    cylinder (r=40,h=3,center=true);
    difference()
    {
        _skirt();
        
        translate([0,0,-skirt_wall_top])    
        resize(newsize=[skirt_w-skirt_wall_sides*2,skirt_d-skirt_wall_sides*2,skirt_h]) 
        _skirt();
        
        //132,50,18.5
        // window for battery
        translate([-skirt_w/2,0,32-1]) 
        cube([5,51,19.5],center=true);
        

        
//translate([0,0,skirt_h/2-skirt_wall_top])       
       // _turrent();
        // expose profile
        //translate([0,-skirt_d/2,0])    
        //cube([200,10,200],center=true);    
    }
    
    battcorners();    
}

module _turrent(){
    difference()
    {
        pyramid(skirt_w-10,70,true);
        translate([0,0,31])
        cube([skirt_w,skirt_w,60],center=true);
    }
}

module turrent(){
    difference()
    {
        //translate([0,0,18])
        _turrent();
        translate([0,0,-2])
        _turrent();
        //translate([0,0,-skirt_wall_top])
        //_turrent();
    }
}

module track(){    
translate([0,0.5,0])   
resize(newsize=[133,20,44])        
    minkowski()
    {    
        cube([133,20,44],center=true);
        rotate([90,0,0])
        cylinder(r=55,h=1);
    }

    translate([0,13,0])    
    cube([113.5,7,7.5],center=true); 
}
module tracks(){
    translate([0,-42-20/2,0])
    rotate([180,0,0])
    track();
    
    translate([0,42+20/2,0])    
    track();
}
module engine(){
    cube([110,40,43],center=true);
}
module engines(){    
    translate([0,-20.5,0])
    engine();
    
    translate([0,20.5,0])
    engine();
    
}
module simulate_enginetacks(){
    translate ([-5,0,-23])
    tracks();
    engines();
    
    // battery
    translate([-5,0,32])
    cube([132,50,18.5],center=true);
}

module battcorner(){    
    difference(){
        cube([15,10,10],center=true);
        translate([0,2,2])
        cube([18,10,10],center=true);
    }
}

module battcorners(){
    //132,50,18.5
    translate([skirt_w/2-7.5,-23,22])
    battcorner();
    translate([-skirt_w/2+7.5,-23,22])
    battcorner();
    
    rotate([0,0,180])
    translate([skirt_w/2-8,-23,22])
    battcorner();
    rotate([0,0,180])    
    translate([-skirt_w/2+8,-23,22])
    battcorner();
}


module _torso()
{
    // just to check size
    //translate([75,0,65])
    //cylinder(r=3,h=130,center=true);
    
    translate([0,0,-80],center=true)
    difference ()
    {
        rotate([0,180,0])
        { 
            minkowski()
            {
                pyramid(130,400,true,true,true);
                sphere(r=10);               
            }
        }
        translate([0,0,-70])
        cube([400,400,300],center=true);
    }    
}


module torso()
{   
    difference(){
    _torso();
    
    resize(newsize=[140,140,120]) 
   _torso();
    }   
}


module hands(){
    translate([0,67,140])
    rotate([0,0,90])
    hand();
    translate([0,-67,140])
    rotate([0,0,-90])
    hand(); 
}
module hand(){
    // sholder
    cube([20,15,30],center=true);
        
    // arm
    translate([15,0,-50])
    {
        minkowski(){
            cylinder(r=3,h=50);
            sphere(r=2);
        }
 
    }
}

module base_body(){
//translate([5,0,-3])
//simulate_enginetacks();

    difference(){    
    //turrent();
        //translate([0,0,skirt_h/2])
        skirt();
        
        // 90 deg wire hole on top of skirt
        translate([0,0,40]){
            minkowski(){
                difference (){
                    cylinder(r=30,h=5);
                    cylinder(r=29,h=5);  
                        translate([15,0,0])
                    cube([30,100,10],center=true);    
                        
                    translate([-10,30,0])
                    rotate([0,0,45])
                    cube([30,60,10],center=true);    
                    translate([-10,-30,0])
                    rotate([0,0,-45])
                    cube([30,60,10],center=true);     
                }
                cylinder(r=5,h=5);
            }
       }
    }


//translate([0,0,215])
//head();
    
//translate([0,0,50])    
//torso();
    
//hands();    
}





difference(){
    base_body(); // entire body
    // slice the skirt
    //translate([0,-60,0])
    //cube([200,40,200],center=true);
}