$fn = 50;

/*
    (width, height)
    (99mm, 74mm) - PCB.
    (92mm, 66mm - Distance between two posts.
    (17mm, 14mm) - Ethernet.
    (7mm, 4mm) - Micro HDMI.
    (10mm, 12mm) - 5V Power.
    (17mm, 7mm) - SATA.
    (33mm, 6mm) - GPIO.
    (11mm, 6mm) - 8 PIN connector.
    (16mm, 4mm) - UART (10mm height from PCB)
    (15mm, 16mm) - USB.
    (14mm, 3mm) - SDCard.
 */

PostHight               = 15;

PCBThick                = 1.5;
PCBWidthY               = 99;
PCBWidthX               = 74;
PCBWidthZ               = PostHight + PCBThick;

// Ethernet
EthernetWidth           = 17;
EthernetHeight          = 14;

// Micro HDMI
MicroHDMIWidth          = 7;
MicroHDMIHeight         = 4;

// Power 5v
PowerWidth              = 10;
PowerHeight             = 12;

// USB
USBWidth                = 17;
USBHeight               = 16;

// SDCARD
SDCARDWidth             = 14;
SDCARDHeight            = 3;

// Crack
CrackWidth              = 5;
CrackHeight             = 15;

// Hard Drive
HDWidth                 = 100;
HDHeight                = 69;

// Methods
module Post (x, y, h) {    
    translate ([x, y, 0])
    difference () {
		cylinder (r = 2.5, h = h);
		cylinder (r = 1.5, h = h + 1);
	}
}

module Box (x, y, z) {
    BottoomWallThick = 4;
    
    translate ([0, 0, z / 2])
    difference() {
        minkowski () {
            cube ([x + BottoomWallThick, y + BottoomWallThick, z], center = true);
            cylinder (r = 3.5, h = 1);
        }
        
        translate([0, 0, BottoomWallThick])
        minkowski() {
            cube ([x, y, z + 3], center = true);
            cylinder (r = 3.5, h = z);
        }
    }
}

module Window (x, y, z, width, height, thick) {
    translate([x, y, z]) 
    cube([width, height, thick], center = true);
}

module Ethernet (x, y, z) {
    Window (x, y, z, EthernetWidth + 1, 5, EthernetHeight + 1);
}

module MicroHDMI (x, y, z) {
    Window (x, y, z, MicroHDMIWidth + 1, 5, MicroHDMIHeight + 1);
}

module Power (x, y, z) {
    Window (x, y, z, PowerWidth + 1, 5, PowerHeight + 1);
}

module USB (x, y, z) {
    Window (x, y, z, USBWidth, 5, USBHeight + 1);
}

module SDCard (x, y, z) {
    Window (x, y, z, SDCARDWidth, 5, SDCARDHeight + 1);
}

module Crack (x, y, z) {
    Window (x, y, z, 5, CrackWidth, CrackHeight);
}

module AngleWallXY (x, y, hight, rotation) {
    if (rotation == 0) {
        translate([x + (10 / 2) - 1, y, hight / 2]) 
        cube([10, 2, hight], center = true);
        
        translate([x, y - (10 / 2) + 1, hight / 2]) 
        cube([2, 10, hight], center = true);
    } else if (rotation == 1) {
        translate([x + (10 / 2) - 1, y, hight / 2]) 
        cube([10, 2, hight], center = true);
        
        translate([x, y + (10 / 2) - 1, hight / 2]) 
        cube([2, 10, hight], center = true);
    } else if (rotation == 2) {
        translate([x - (10 / 2) + 1, y, hight / 2]) 
        cube([10, 2, hight], center = true);
        
        translate([x, y + (10 / 2) - 1, hight / 2]) 
        cube([2, 10, hight], center = true);
    } else if (rotation == 3) {
        translate([x - (10 / 2) + 1, y, hight / 2]) 
        cube([10, 2, hight], center = true);
        
        translate([x, y - (10 / 2) + 1, hight / 2]) 
        cube([2, 10, hight], center = true);
    }
}

module WallXY (x, y, hight, width, thickness, rotation) {
    if (rotation == 0) {
        translate([x + (width / 2) - 1, y, hight / 2]) 
        cube([width, thickness, hight], center = true);
    } else if (rotation == 1) {
        translate([x + (width / 2) - 1, y, hight / 2]) 
        cube([width, thickness, hight], center = true);
    } else if (rotation == 2) {
        translate([x - (width / 2) + 1, y, hight / 2]) 
        cube([width, thickness, hight], center = true);
    } else if (rotation == 3) {
        translate([x - (width / 2) + 1, y, hight / 2]) 
        cube([width, thickness, hight], center = true);
    }
}

module WallXZ (x, z, y,  hight, width, thickness, rotation) {
    if (rotation == 0) {
        translate([x, y, z])
        cube([width, thickness, hight], center = true);
    }
}

module Main () {
    AngleWallXY ( 51 - 5 - 1,  35.5 + 0.5, 9, 3);
    AngleWallXY ( 51 - 5 - 1, -35.5 - 0.5, 9, 2);
    WallXY (-51 - 5 - 2,  35.5 + 0.5, 9, 10, 2, 0);
    WallXY (-51 - 5 - 2, -35.5 - 0.5, 9, 10, 2, 1);
    
    WallXZ (0, 1.5, -53, 3, 90, 5, 0);
    WallXZ (0, 1.5, 53, 3, 90, 5, 0);
    
    difference () {
        Box (110, 92, 35);
        
        // 22mm - Distance from upper right pcb corner to ethernet right side.
        xLocationEth = (PCBWidthX / 2) - (EthernetWidth / 2) - 22;
        Ethernet (xLocationEth, (PCBWidthY / 2) + 1, PCBThick + PostHight + (EthernetHeight / 2));

        // 8.5mm - Distance from upper right pcb corner to microHDMI right side.
        xLocationHDMI = (PCBWidthX / 2) - (MicroHDMIWidth / 2) - 8.5;
        MicroHDMI (xLocationHDMI, (PCBWidthY / 2) + 1, PCBThick + PostHight + (MicroHDMIHeight / 2));

        // 56mm - Distance from upper right pcb corner to Power 5v right side.
        xLocationPower = (PCBWidthX / 2) - (PowerWidth / 2) - 56;
        Power (xLocationPower, (PCBWidthY / 2) + 1, PCBThick + PostHight + (PowerHeight / 2));

        // 25mm - Distance from upper right pcb corner to USB right side.
        xLocationUSB = (PCBWidthX / 2) - (USBWidth / 2) - 26;
        USB (xLocationUSB, -((PCBWidthY / 2) + 1), PCBThick + PostHight + (USBHeight / 2));

        // 9mm - Distance from upper right pcb corner to SDCard right side.
        xLocationSDCard = (PCBWidthX / 2) - (SDCARDWidth / 2) - 8;
        SDCard (xLocationSDCard, -((PCBWidthY / 2) + 1), PCBThick + PostHight + (SDCARDHeight / 2));
        
        for (inx = [0 : 2]) {
            Crack ((120 / 2), (PCBWidthY / 2) - 65 + (inx * 16), (CrackHeight / 2) + 12);
        }  
    }

    Post ( 33,  46, PostHight);
    Post (-33,  46, PostHight);
    Post ( 33, -46, PostHight);
    Post (-33, -46, PostHight);
}

Main ();

// resize (newsize = [BottomWidth, BottomHeight, BottomZ])

