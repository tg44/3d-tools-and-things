
// this is the LH you want to print
layerHeight = 0.2;
// this is the minimum height of the bottom part
brightestHeight = 0.4;
// should be x*LH, you probably want to test your filament
brightStep = 2 * layerHeight;

//this controls the size of the lamp
smallHexR = 6;
wallThickness = 1.2;

//megic number
mn = 0.7;

//inner helpers 
f = sin(360/6);
newR = 7*smallHexR;


lamp();
//lid();

module lamp() {
  tileLayers();
  sixthLayer();

  difference() {
     outerWall();
      cylinder(
        r = newR, 
        h= 1000, 
        $fn=6
        );
      lidCut();
  }
}

module lid() {
    translate([-2*layerHeight,0,3.3*mn*newR-2*wallThickness])  {
        cylinder(
            r1 = newR+wallThickness/2-layerHeight/2,
            r2 = newR-(wallThickness+2*layerHeight),
            h= 2*wallThickness, 
            $fn=6
            );
        translate([1*wallThickness,0,0]) cylinder(
            r1 = newR+wallThickness/2-layerHeight/2,
            r2 = newR-(wallThickness+2*layerHeight),
            h= 2*wallThickness, 
            $fn=6
            );
    }
}


module lidCut() {
    translate([0,0,3.3*mn*newR-2*wallThickness])  {
        cylinder(
            r1 = newR+wallThickness/2,
            r2 = newR-wallThickness,
            h= 2*wallThickness, 
            $fn=6
            );
        translate([newR/4,0,0]) cylinder(
            r1 = newR+wallThickness/2,
            r2 = newR-wallThickness,
            h= 2*wallThickness, 
            $fn=6
            );
        
    }
}


module outerWall() {
  newWH = brightestHeight+8*brightStep;
  difference() {
      cylinder(
        r1 = newR, 
        r2 = 1.5*newR, 
        h= newR*mn, 
        $fn=6
        );
      translate([0,0,sqrt(2)*wallThickness]) cylinder(
        r1 = newR, 
        r2 = 1.5*newR, 
        h= newR*mn, 
        $fn=6
        );
  };

  translate([0,0, newR*mn]) 
  difference() {
      cylinder(
        r = 1.5*newR, 
        h= newR*1.3*mn, 
        $fn=6
        );
      cylinder(
        r = 1.5*newR-wallThickness, 
        h= newR*1.3*mn, 
        $fn=6
        );
  };

  translate([0,0,2.3*mn*newR]) 
  difference() {
      cylinder(
        r1 = 1.5*newR, 
        r2 = newR, 
        h=  newR*mn, 
        $fn=6
        );
      translate([0,0,-sqrt(2)*wallThickness]) cylinder(
        r1 = 1.5*newR, 
        r2 = newR, 
        h=  newR*mn, 
        $fn=6
        );
  }
}

module tileLayers() {
    firstLayer();
    secondLayer();
    thirdLayer();
    fourthLayer();
    fifthLayer();
}

module sixthLayer() {
  difference() {
      cylinder(r = 7*smallHexR, h=brightestHeight+5*brightStep, $fn=6);
      scale([1,1,1000])  tileLayers();
  }
}

module firstLayer() {
cylinder(r = smallHexR, h=brightestHeight, $fn=6);
}
module secondLayer() {
translate([1.5*smallHexR, f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+brightStep, $fn=6);
translate([1.5*smallHexR, -1*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+brightStep, $fn=6);

translate([-1.5*smallHexR, f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+brightStep, $fn=6);
translate([-1.5*smallHexR, -1*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+brightStep, $fn=6);

translate([0, 2*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+brightStep, $fn=6);
translate([0, -2*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+brightStep, $fn=6);
}
module thirdLayer() {
translate([3*smallHexR, 0, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([-3*smallHexR, 0, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([0, 4*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([0, -4*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([3*smallHexR, 2*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([-3*smallHexR, -2*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([3*smallHexR, -2*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([-3*smallHexR, 2*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([1.5*smallHexR, 3*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([-1.5*smallHexR, -3*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([1.5*smallHexR, -3*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
translate([-1.5*smallHexR, 3*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+2*brightStep, $fn=6);
}
module fourthLayer() {
translate([4.5*smallHexR, 1*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([4.5*smallHexR, -1*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([4.5*smallHexR, 3*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([4.5*smallHexR, -3*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([-4.5*smallHexR, 1*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([-4.5*smallHexR, -1*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([-4.5*smallHexR, 3*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([-4.5*smallHexR, -3*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);

translate([3*smallHexR, 4*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([-3*smallHexR, 4*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([3*smallHexR, -4*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([-3*smallHexR, -4*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);

translate([1.5*smallHexR, 5*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([-1.5*smallHexR, 5*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([1.5*smallHexR, -5*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([-1.5*smallHexR, -5*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);

translate([0, 6*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
translate([0, -6*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+3*brightStep, $fn=6);
}
module fifthLayer() {
translate([3*smallHexR, 6*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+4*brightStep, $fn=6);
translate([-3*smallHexR, 6*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+4*brightStep, $fn=6);
translate([3*smallHexR, -6*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+4*brightStep, $fn=6);
translate([-3*smallHexR, -6*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+4*brightStep, $fn=6);
translate([-6*smallHexR, 0*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+4*brightStep, $fn=6);
translate([6*smallHexR, 0*f*smallHexR, 0]) cylinder(r = smallHexR, h=brightestHeight+4*brightStep, $fn=6);
}
   