



v = 100;
cutout = 30;
angle = 25;
err=0.2;

difference() {
    cube([v,v,v]);
    translate([v,-1,0])rotate([0,-angle,0]) cube([2*v,2*v,2*v]);
    translate([v-cutout,(v-cutout)/2-err,0]) rotate([0,-angle,0]) translate([0,0,-v])cube([2*v,cutout+2*err,3*v]);
}

translate([v, 0, 0])
difference() {
    cube([v,v,v]);
    difference() {
      translate([v,-1,0])rotate([0,180+90-angle,0]) cube([2*v,2*v,2*v]);
      translate([v,(v-cutout)/2,0]) rotate([0,180+90-angle,0]) cube([2*v,cutout-err,cutout-err]);
    };
}
