
/*
measures based on:
https://www.reddit.com/r/3Dprinting/comments/5ruuxu/ikea_lack_table_dimensions_looking_for_the/ddac4qi
and corrected with some trial and error :D

Most of the variables here will be ok for ender3 or enycubic-i3-mega(-s)
*/

ikeaTableLegW = 49+2;
socksH = 15;//30;
perimetersW = 2.5;

distanceBetweenTables = 3;
legPlacementError = 3;



/*
the lack table top is 48.5w and the whole table is 447.5h
the ender3 and anycubic mega is ~470h
so we need to rise 447.5-48.5+r=470 where r is 470+48.5-447.5=71(-perimetersW) at minimum!
100 is a safe bet, it adds a little bit more air
*/
riser = 100;


render=0; //0 is all 1-5 is the objects one by one

if(render == 0) {
    socks();
    translate([2*ikeaTableLegW,0,0]) doubleSocks();
    translate([0, 2*ikeaTableLegW,0]) singleConnector(riser, legPlacementError, legPlacementError);
    translate([2*ikeaTableLegW, 2*ikeaTableLegW,0]) doubleConnector(riser, 0, legPlacementError);
    translate([0, 4*ikeaTableLegW,0]) triangleHanger();
} else {
    if(render == 1) socks();
    if(render == 2) translate([2*ikeaTableLegW,0,0]) doubleSocks();
    if(render == 3) translate([0, 2*ikeaTableLegW,0]) singleConnector(riser, legPlacementError, legPlacementError);
    if(render == 4) translate([2*ikeaTableLegW, 2*ikeaTableLegW,0]) doubleConnector(riser, 0, legPlacementError);
    if(render == 5) translate([0, 4*ikeaTableLegW,0]) triangleHanger();
}


cuttingHelper = 1;


module socks(xHelper = 0, yHelper = 0) {
    difference() {
        cube([ikeaTableLegW+2*perimetersW + xHelper, ikeaTableLegW+2*perimetersW + yHelper, socksH+perimetersW]);
        translate([perimetersW, perimetersW, perimetersW]) cube([ikeaTableLegW + xHelper, ikeaTableLegW + yHelper, socksH+cuttingHelper]);
    }
}

module doubleSocks() {
    socks();
    translate([ikeaTableLegW+2*perimetersW, 0, 0]) cube([distanceBetweenTables, ikeaTableLegW+2*perimetersW, socksH+perimetersW]);
    translate([ikeaTableLegW+2*perimetersW+distanceBetweenTables, 0, 0]) socks();
}

module singleConnector(w = 0, xHelper = 0, yHelper = 0) {
    translate([0,0,w+perimetersW+socksH]) socks(xHelper = xHelper, yHelper = yHelper);
    translate([0,0,perimetersW+socksH]) cube([ikeaTableLegW+2*perimetersW + xHelper, ikeaTableLegW+2*perimetersW + yHelper, w]);
    difference() {
        cube([ikeaTableLegW+2*perimetersW + xHelper, ikeaTableLegW+2*perimetersW + yHelper, socksH+perimetersW]);
        translate([perimetersW, perimetersW, 0-cuttingHelper]) cube([ikeaTableLegW+perimetersW+cuttingHelper + xHelper, ikeaTableLegW+perimetersW+cuttingHelper + yHelper, socksH+cuttingHelper]);
    }
}

module singleConnectorPartForDouble(w = 0, xHelper = 0, yHelper = 0) {
    translate([0,0,w+perimetersW+socksH]) socks(xHelper = xHelper, yHelper = yHelper);
    translate([0,0,perimetersW+socksH]) cube([ikeaTableLegW+2*perimetersW + xHelper, ikeaTableLegW+2*perimetersW + yHelper, w]);
    difference() {
        cube([ikeaTableLegW+2*perimetersW + xHelper, ikeaTableLegW+2*perimetersW + yHelper, socksH+perimetersW]);
        translate([0, perimetersW, 0-cuttingHelper]) cube([ikeaTableLegW+2*perimetersW+cuttingHelper + xHelper, ikeaTableLegW+perimetersW+cuttingHelper + yHelper, socksH+cuttingHelper]);
    }
}

module doubleConnector(w = 0, xHelper = 0, yHelper = 0) {
    translate([ikeaTableLegW+2*perimetersW, 0, 0]) mirror([1,0,0]) singleConnectorPartForDouble(w, xHelper, yHelper);
    translate([ikeaTableLegW+2*perimetersW, 0, 0]) cube([distanceBetweenTables, ikeaTableLegW+2*perimetersW + yHelper, w+2*socksH+2*perimetersW]);
    translate([ikeaTableLegW+2*perimetersW+distanceBetweenTables, 0, 0]) singleConnectorPartForDouble(w, xHelper, yHelper);
}

module triangleHanger() {
    triangleW= 15;
    
    cube([ikeaTableLegW*2+distanceBetweenTables,perimetersW, socksH]);
    translate([ikeaTableLegW,perimetersW,0])cube([distanceBetweenTables,ikeaTableLegW,socksH]);
    translate([0,perimetersW+ikeaTableLegW,0]) cube([ikeaTableLegW*2+distanceBetweenTables,perimetersW, socksH]);
    
    translate([ikeaTableLegW+0.5*distanceBetweenTables-triangleW*0.5,2*perimetersW+ikeaTableLegW,0]) {
        union(){
        translate([0,0,socksH/2])cube([triangleW, socksH/2, socksH/2]);
            difference(){
                rotate([45,0,0]) cube([triangleW, 2*socksH, 2*perimetersW]);
                translate([0,-socksH,0])cube([triangleW, socksH, 2*perimetersW]);
            }
        }
    }
        
}