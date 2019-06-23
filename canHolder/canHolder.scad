


//0.25l hell 53.3, 134
//0.33 coke 66.3, 115.2
//0.5l beer 66.2, 168
//wine bottle 75, 292 the neck is 29.5
spaceBetweenCans = 3;
smallCanDia = 53.3;
bigCanDia = 66.2;

//connector specific settings
connectorLength = 26;
connectorWidth = 10;
connectorThickness = 1.4;
connectorConnectLength = connectorLength/4; 
connectorsDistanceFromWalls = 6;

//the distance between the connector and the object in each connecting faces
//advised to set close to your nozzle-size
error = 0.4;

//modify it to 20ish if you want to work with the file quickly 
//the value this high will result a big stl, but your slicer have a chance to make it as round as your printer settings are capable of
$fn = 200; 

module beerCan() {
    //this has some crazy magic numbers...
    h = 168;
    d = bigCanDia;
    translate([0,h/2-16,d/2-2]) rotate([88,0,0]) cylinder(h=h, d=d);
}
module energyDrinkCan() {
    h = 134;
    d = smallCanDia;
    translate([h/2,0,d/2]) rotate([0,-88,0]) cylinder(h=h, d=d);
}

module wineBottleNeck() {
    h=292;
    d=42;
    neckLength = 80;
    bottleD = 75;
    translate([0,0,0]) rotate([-11,0,0]) translate([0,0,-h+40]) {
        union() {
            cylinder(h=h, d=d);
            cylinder(h=h-neckLength, d=bottleD);
        }
    }
}


module canProfiles() {
    beerCan();
    translate([0,-smallCanDia/2,0]){
        translate([0,-smallCanDia/2-spaceBetweenCans/2, 0]) energyDrinkCan();
        translate([0,smallCanDia/2+spaceBetweenCans/2, 0]) energyDrinkCan();
    }
}

module canHolder()  {
    x = bigCanDia + spaceBetweenCans;
    y = smallCanDia*2 + spaceBetweenCans*2;
    difference() {
        translate([0, -y/2 + smallCanDia + spaceBetweenCans , 0]) cube([x,y,smallCanDia/3]);
        translate([x/2, smallCanDia*1.5 + spaceBetweenCans*2 , 0]) canProfiles();
        translate([bigCanDia/2 + spaceBetweenCans/2,smallCanDia*1.5 + spaceBetweenCans*1.5,0]) wineBottleNeck();
        
        union(){
            translate([connectorsDistanceFromWalls,-connectorLength/2,0]) connector(error);
            translate([x-connectorWidth-connectorsDistanceFromWalls,-connectorLength/2,0]) connector(error);
            rotate([0,0,90]) translate([connectorsDistanceFromWalls,-connectorLength/2,0]) connector(error);
            rotate([0,0,90]) translate([x-connectorWidth-connectorsDistanceFromWalls,-connectorLength/2,0]) connector(error);
            translate([connectorsDistanceFromWalls,y-connectorLength/2,0]) connector(error);
            translate([x-connectorWidth-connectorsDistanceFromWalls,y-connectorLength/2,0]) connector(error);
            rotate([0,0,90]) translate([connectorsDistanceFromWalls,-x-connectorLength/2,0]) connector(error);
            rotate([0,0,90]) translate([x-connectorWidth-connectorsDistanceFromWalls,-x-connectorLength/2,0]) connector(error);
        }
    }
}

module connector(error = 0) {
    cube([connectorWidth + 2*error,connectorLength + 2*error,connectorThickness+error]);
    cube([connectorWidth + 2*error,connectorConnectLength + 2*error,2*connectorThickness + error]);
    translate([0, connectorLength - connectorConnectLength, 0]) cube([connectorWidth + 2*error,connectorConnectLength+ 2*error,2*connectorThickness+error]);
}
//wineBottleNeck();
canHolder();
translate([0, -1*connectorLength-5, 0]) connector();
//translate([bigCanDia+spaceBetweenCans, 0, 0]) canHolder();
//translate([0, -smallCanDia*2-spaceBetweenCans*2, 0]) canHolder();
//translate([0, 0, 0]) rotate([0,0,90]) canHolder();

//canProfiles();
//translate([bigCanDia + spaceBetweenCans, 0, 0]) beerCan();
