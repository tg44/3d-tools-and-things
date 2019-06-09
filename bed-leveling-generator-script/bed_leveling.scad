/**
 * This file originated from:
 * https://www.thingiverse.com/thing:34558
 *
 * Some modifications are made!
 *
 * It is currently suitable for Ender3.
 *
 * Print designed to check that you bed is level
 *
 * print four small squares in each corner to ensure even print quality and good adhesion.
 */


X_MAX_LENGTH = 220;
Y_MAX_LENGTH = 220;

THICKNESS = 0.1; //Square / outline thickness
SIZE = 20; //Square width / height
GAP = 0.5; //Width of border between square and parameter
OUTLINE_WIDTH = 1; //Width of parameter around square
OFFSET = 25; //Offset from limits in each axis

translate([-X_MAX_LENGTH/2, -Y_MAX_LENGTH/2], 0) {
    if(top || row) {
        if(left || col)
            translate([OFFSET, OFFSET, 0]) square(); //Top Left
        if(mid || col)
            translate([(X_MAX_LENGTH / 2) - (SIZE / 2), OFFSET, 0]) square(); //Top Middle
        if(right || col)
            translate([X_MAX_LENGTH - OFFSET - SIZE, OFFSET, 0]) square(); //Top Right
    }
    if(middle || row){
        if(left || col)
            translate([OFFSET, (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Left
        if(mid || col)
            translate([(X_MAX_LENGTH / 2) - (SIZE / 2), (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Middle
         if(right || col)
            translate([X_MAX_LENGTH - OFFSET - SIZE, (Y_MAX_LENGTH / 2) - (SIZE / 2), 0]) square(); //Middle Right
    }
    if(bottom || row){
        if(left || col)
            translate([OFFSET, Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Bottom Left
        if(mid || col)
            translate([(X_MAX_LENGTH / 2) - (SIZE / 2), Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Bottom Middle
         if(right || col)
            translate([X_MAX_LENGTH - OFFSET - SIZE, Y_MAX_LENGTH - OFFSET - SIZE, 0]) square(); //Bottom Right
    }
}
module square() {
	//Center square
	translate([
				OUTLINE_WIDTH + GAP,
				OUTLINE_WIDTH + GAP,
				0
			])
		cube([SIZE, SIZE, THICKNESS]);

	//Parameter
    if(param){
        difference() {
            //Outer square
            cube([
                    SIZE + (2 * (GAP + OUTLINE_WIDTH)),
                    SIZE + (2 * (GAP + OUTLINE_WIDTH)),
                    THICKNESS
                ]);

            //Inner square
            translate([OUTLINE_WIDTH, OUTLINE_WIDTH, -5])
                cube([SIZE + (2 * GAP), SIZE + (2 * GAP), 10]);
        }
    }
}
