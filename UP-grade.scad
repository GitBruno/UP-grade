// UP-grade is a customisable roll holder for the UP mini 3D printer
// so this small printer can carry big filament rolls
// https://www.up3d.com/?r=mini

// Written for OpenScad by Bruno Herfst 2016
// http://www.openscad.org

// Roll Spec
rollWidth = 70;

// Holder spec
holderDepth        = 10;
holderLever        = 15;
bevelWidth         = 5;
hLipTickness       = 3;
hDiameter          = 30;
backWallThickness  = 5;
frontWallThickness = 3;

// Printer Spec
pHoleWidth = 22; // 24 Actual
pHoleHeiht = 10; // 12 Actual
pWall      = 2;  //  1 Actual

// Short cuts
hDepth   = holderDepth/2;
rWidth   = rollWidth + bevelWidth;
// Backwall
bwWidth  = hDiameter + holderDepth;
bwHeight = hDiameter + (holderDepth*2) + holderLever;

module prism(l, w, h){
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

union() { 
    // Create lip
    translate([-(pHoleWidth/2),-(pWall+hLipTickness),0]) {
        cube([pHoleWidth,hLipTickness,pHoleHeiht]);
        translate([0,0,pHoleHeiht-hLipTickness]) {
            cube([pHoleWidth,hLipTickness+pWall,hLipTickness]);
        }
    }

    // Create backWall
    translate([-bwWidth/2,0,-(bwHeight-pHoleHeiht)+hDepth]){
        cube([bwWidth,backWallThickness,bwHeight]);
    }

    // Create holder
    translate([0,rWidth/2+backWallThickness,pHoleHeiht-hDepth-(hDiameter/2)]){
        rotate([90,0,0])
        cylinder(  rWidth, d=hDiameter, center=true);
    }

    // Create holder finish
    translate([0,rWidth+backWallThickness+(bevelWidth/2)-bevelWidth,pHoleHeiht-hDepth-(hDiameter/2)]){
        rotate([90,0,0])
        cylinder(  bevelWidth, d1=hDiameter+holderDepth, d2=hDiameter, center=true);
    }
    translate([0,rWidth+backWallThickness,pHoleHeiht-hDepth-(hDiameter/2)]){
        rotate([90,0,0])
        cylinder(  frontWallThickness, d=hDiameter+holderDepth, center=true);
    }
}
