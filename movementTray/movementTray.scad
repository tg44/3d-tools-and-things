
//can be simple, threeSized, twoSized, twoSizedv1, twoSizedv2 and 25, 32, 40
//for the possible combinations see below but simple-25, simple-32, simple-40, twoSized-32 and threeSized-40 are the mainstream
trayType = "simple-25"; 

wallSize = 1; //1mm walls
error = 0.8; //0.8mm in dia for space to move the figures bases

/*
    Uncomment the needed line, and modify the params!
    See the "hidden" options below in the code!
*/
//twoSizedTray(25, 32);
//threeSizedTray();
//tray("twoSizedv1-40");
//singleLineTray(3, trayType);
//twoLineTray(5, trayType);
//threeLineTray(7, trayType, 0); //works with n=1+3*k where k >= 0 integer
arrowFormationFull(4, trayType);
//bossDoubleTray("simple-25", "twoSized-32", 0);
//bossWithNMinionsTray(4, "simple-25", "simple-32"); //pls use bigger than 0 distance, with 0 there will be a slight overlap and your figures will not fit


/*
    Helper functions
*/
function len3(v) = sqrt(pow(v.x, 2) + pow(v.y, 2));

function size(trayType) = len(search("-40", trayType))>2 ? 40 : (len(search("-32", trayType))>2 ? 32 : 25);
function fullCircle(trayType1, trayType2) = size(trayType2) == 32 ? 7 : (size(trayType1) == 32 ? 7 : 8);

module tray(trayType = "simple-25") {
    if(len(search("-40", trayType))>2){
        if(len(search("threeSized", trayType))>9) {
            threeSizedTray(25, 32, 40);
        } else if(len(search("twoSizedv1", trayType))>9) {
            twoSizedTray(32, 40);
        } else if(len(search("twoSizedv2", trayType))>9) {
            twoSizedTray(25, 40);
        } else {
            simpleTray(40);
        }
    } else if(len(search("-32", trayType))>2){
        if(len(search("twoSized", trayType))>2) {
            twoSizedTray(25, 32);
        } else {
            simpleTray(32);
        }
    } else {
        simpleTray(25);
    }
}

/*
    Tray primitives
*/
module simpleTray(size = 25) {
    difference() {
        cylinder(d=size+error+2*wallSize, h=3*wallSize);
        translate([0,0,wallSize]) cylinder(d=size+error, h=3*wallSize);
    }
}

module twoSizedTray(size1 = 25, size2 = 32) {
    difference() {
        cylinder(d=size2+error+2*wallSize, h=5*wallSize);
        translate([0,0,wallSize]) cylinder(d=size1+error, h=3*wallSize);
        translate([0,0,3*wallSize]) cylinder(d=size2+error, h=3*wallSize);
    }
}

module threeSizedTray(size1 = 25, size2 = 32, size3 = 40) {
    difference() {
        cylinder(d=size3+error+2*wallSize, h=7*wallSize);
        translate([0,0,wallSize]) cylinder(d=size1+error, h=3*wallSize);
        translate([0,0,3*wallSize]) cylinder(d=size2+error, h=3*wallSize);
        translate([0,0,5*wallSize]) cylinder(d=size3+error, h=3*wallSize);
    }
}

module spaceBetweenTrays(first = [0,0,25], second = [30, 2*25, 25]) {
    difference() {
    hull(){
        translate([first.x, first.y, 0]) cylinder(d=first.z, h=wallSize);
        translate([second.x, second.y, 0]) cylinder(d=second.z, h=wallSize);
    }
    
    angle = acos((second.x/2 - first.x/2)/len3(second-[(second.x-first.x)/2,(second.y-first.y)/2]));
    distance = len3(second-first);
    translate([(second.x-first.x)/2,(second.y-first.y)/2,0])
      rotate([0,0,angle]) {
        translate([0,distance/2,-wallSize/2]) cylinder(d=distance-8*wallSize, h=wallSize*2);
        translate([0,-distance/2,-wallSize/2]) cylinder(d=distance-8*wallSize, h=wallSize*2);  
      }
  }
}

/*
    DoubleTrays for later compose
*/

module doubleTray(trayType="simple-25", additionalDistance=12) {
    trayRealD = size(trayType)+error+2*wallSize;
    tray(trayType);
    translate([0,size(trayType)+additionalDistance+wallSize+error, 0]) tray(trayType);
    spaceBetweenTrays([0,0,size(trayType)], [0, trayRealD+additionalDistance,size(trayType)]);
}

module bossDoubleTray(trayType1="simple-25", trayType2="simple-32", additionalDistance=10) {
    trayRealD = size(trayType1)/2 + size(trayType2)/2 + error + 2*wallSize;
    tray(trayType2);
    translate([0,size(trayType1)/2 + size(trayType2)/2 + additionalDistance + wallSize + error, 0]) tray(trayType1);
    #spaceBetweenTrays([0,0,size(trayType2)], [0, trayRealD+additionalDistance,size(trayType1)]);
}

/*
  Patterns
*/

module singleLineTray(n=3, trayType="simple-25", additionalDistance=0) {
    singleLineTrayPattern(n-1, trayType, additionalDistance);
}

module singleLineTrayPattern(n, trayType, additionalDistance) {
    if(n>0){
        doubleTray(trayType,additionalDistance);
        translate([0,size(trayType)+additionalDistance+wallSize+error, 0]) {
            singleLineTrayPattern(n-1, trayType, additionalDistance);
        }
    }
}

module twoLineTray(n=3, trayType="simple-25", additionalDistance=0) {
    linePatternTray(n-1, trayType, additionalDistance, 1);
}

module linePatternTray(n, trayType="simple-25", additionalDistance, dir){
    if(n>0){
        doubleTray(trayType,additionalDistance);
        translate([0,size(trayType)+additionalDistance+wallSize+error, 0]) {
            rotate([0,0,dir*120]) {
                linePatternTray(n-1, trayType, additionalDistance, dir*-1);
            }
        }
    }
}

module threeLineTray(n=7, trayType="simple-25", additionalDistance=0) {
    m = n/3*2;
    twoLineTray(m, trayType, additionalDistance);
    mirror([0,1,0]) rotate([0,0,60]) twoLineTray(m, trayType, additionalDistance);
}

module arrowFormationFull(l=3, trayType="simple-25", additionalDistance=0) {
    lines = l-1;
    arrowFormationFullPattern(lines,trayType,additionalDistance);
}

module arrowFormationFullPattern(l, trayType, additionalDistance) {
    if(l>0) {
        twoLineTray(3, trayType, additionalDistance);
        translate([0,size(trayType)+additionalDistance+wallSize+error, 0]) {
            arrowFormationFullPattern(l-1,trayType,additionalDistance);
        }
        rotate([0,0,60]) {
             translate([0,size(trayType)+additionalDistance+wallSize+error, 0]) {
                 rotate([0,0,-60]) {
                    arrowFormationFullPattern(l-1,trayType,additionalDistance);
                 }
             }
        }
    }
}


//fullcircle is 7 between 25/32 and 32/40, 8 between 25/40
module bossWithNMinionsTray(n=7, trayType1 = "simple-25", trayType2 = "simple-32", additionalDistance=wallSize/2) {
    for (i = [0:1:n-1]) {
        rotate([0,0,i*(360/fullCircle(trayType1, trayType2))]){
            bossDoubleTray(trayType1, trayType2, additionalDistance);
        }
    }
    
}