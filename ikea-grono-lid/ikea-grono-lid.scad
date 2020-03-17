use <list-comprehension-demos/sweep.scad>
use <scad-utils/transformations.scad>

baseD = 100;


assembly();

module lid() {
    h = 1.6;
    longwallSize = 70;
    wall = 1.6;
    //wemos x, y, z
    innerSizeX = 26.70;
    innerSizeY = 35.5;
    innerSizeZ = 7;
    
    slidingS = 1;
    wallZ = innerSizeZ+slidingS;
    
    wallD = 4.4;
    
    minkowski() {
        r = 5;
        cube([baseD-2*r, baseD-2*r, h/2]);
        translate([r, r, 0]) 
            cylinder(r = r, h = h/2);
    }
    translate([(baseD-longwallSize)/2, wallD, h]) cube([longwallSize, wall, wallZ]);
    translate([(baseD-longwallSize)/2, baseD-wallD-wall, h]) cube([longwallSize, wall, wallZ]);
    translate([wallD, (baseD-longwallSize)/2, h]) cube([wall, longwallSize, wallZ]);
    translate([baseD-wallD-wall, (baseD-longwallSize)/2, h]) cube([wall, longwallSize, wallZ]);
    
    
    translate([(baseD-longwallSize)/2+wallD, wallD, h]) {
        cube([innerSizeY,wall,innerSizeZ]);
        translate([0,0,innerSizeZ]) difference(){
            cube([innerSizeY,wall+ slidingS, slidingS]);
            rotate([45,0,0])cube([innerSizeY+2,innerSizeY+2, innerSizeY+2]);
            translate([0,wall,0])rotate([-45,0,0])cube([innerSizeY+2,innerSizeY+2, innerSizeY+2]);
            translate([10,0,0]) cube([90,wall+ slidingS+2, slidingS+2]);
        }
        
        translate([-(baseD-longwallSize)/2,innerSizeX+0.5,0]) cube([10,wall,innerSizeZ]);
        translate([-(baseD-longwallSize)/2,innerSizeX-slidingS+0.5,innerSizeZ]) difference(){
            cube([10,wall+ slidingS, slidingS]);
            translate([0,wall+slidingS,0])rotate([45,0,0])cube([innerSizeY+2,innerSizeY+2, innerSizeY+2]);
            translate([0,slidingS,0])rotate([3*45,0,0])cube([innerSizeY+2,innerSizeY+2, innerSizeY+2]);
            translate([10,0,0]) cube([90,wall+ slidingS+2, slidingS+2]);
        }
    }
}

module pole() {
    d = 26;
    
    $fn=100;

    wall = 1.6;
    nuteW = 1.6;
    nuteH = 15;
    h = 205;
    R = d/2;
    r = R-nuteW;
    rotations = 5;
    pitch = 205/rotations;
    axis_r = r-wall;

    // Vertical profile where you control everything
    profile = [
        [ axis_r, 0 ],
        [ R, 0 ],
        [ r, nuteW ],
        [ r, nuteW+nuteH ],
        [ R, 2*nuteW+nuteH ],
        [ R, pitch-0.001 ],
        [ axis_r, pitch-0.001 ]
    ];

    // Uncomment the following line to make up your profile
    // You draw in XY plane and it will be set vertically on XZ
    // polygon(profile);

    // Transformations list that draw the spiral
    path_transforms_spiral = [
        for (i=[0:1/$fn:rotations+1])
            translation([0,0,i*pitch])*rotation([90,0,i*360])
    ];

    intersection () {
        translate( [0,0,-pitch] )
            sweep( profile, path_transforms_spiral );

        translate( [-2*R,-2*R,0] )
            cube ( [ 4*R, 4*R, h ] ) ;
    }
    
}

module assembly() {
    union(){
        lid();
        difference() {
            cutW = 30;
            translate([baseD/2, baseD/2,0.001]) 
                rotate([0,0,250]) pole();
        
            translate([baseD/2+3,baseD/2+3,-sqrt(2*cutW*cutW)/2]) rotate([45,0,45]) cube([cutW,cutW,cutW]);
        }
    }
}


