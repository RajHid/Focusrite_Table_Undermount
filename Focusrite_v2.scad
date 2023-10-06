// * Discription what the *.scad is about ect.

// ==================================
// = Used Libraries =
// ==================================


// ==================================
// = Variables =
// ==================================

// sizing printing or print a small part to test the  fitting???
DesignStatus="sizing"; // ["sizing","fitting","printing"]
// Left to right
Focusrite_X=144.5;
// Heigt
Focusrite_Y=41.25;
// Depht
Focusrite_Z=82;
// Edge Radius
Focusrite_radius=3.5;
// == Frame dimiensions ==
// The Thicknes of the main Frame
FrameMargin=4.0;
// The widht of the inner lip that covers the aluminium frame
EdgecoverMargin=2;
// The thickness of that inner lip
EdgecoverMargin_H=1;
// The widht of the Frame 
Frame_H=18;
// The Screw head diameter
ScrewMount_D=15;
// The Height of the Screw head
Screw_Head_H=2.5;


// Causes a little space to avoid a to tight fit
FrameMarginToFit=0.1;

// Composed dimensions to make things work together
Fame_X=2*FrameMargin+Focusrite_X+FrameMarginToFit;
Fame_Y=2*FrameMargin+Focusrite_Y+FrameMarginToFit;
Fame_Z=Focusrite_Z+2*EdgecoverMargin_H+0.2;

// Center of Rubber Foot from Edge
Foot_Center=20;
// Height of rubber Foot
h=2.6;
// Diameter of Rubber Foot
a=22.0;

module __Customizer_Limit__ () {}  // This actually works
shown_by_customizer = false;
// === Facettes Numbers ===


FN_HexNut=6;


FN_Performance=36;

// Divisebile by 4 to align Cylinders whithout small intersections
FN_Rough=12;
FN_Medium=36;
FN_Fine=72;
FN_ExtraFine=144;


// ==================================
// = Tuning Variables =
// ==================================
// Variables for finetuning (The Slegehammer if something has to be made fit)

// ==================================
// = Test Stage =
// ==================================
module MirrorMirrorOnTheWall(Offset_X,Offset_Y){
    translate([-Offset_X,Offset_Y,0]){
        children();
        mirror([0,1,0]){
            children();
        }
    }
    translate([Offset_X,-Offset_Y,0]){
        mirror([1,0,0]){
            children();
            mirror([1,0,0]){
                children();
            }
        }
    }
}
//// For Testing and Development
if (DesignStatus=="printing"){
    translate([0,0,0]){    
        Frame_Base("ears","no");
        translate([0,Fame_Y+3,0]){
            Frame_Base("no ears","yes");
        }
    }
}
if(DesignStatus=="fitting"){
    intersection(){
        translate([0,0,0]){    
            Frame_Base("ears","no");
            translate([0,Fame_Y+3,0]){
                Frame_Base("no ears","yes");
            }
        }
        cube([Fame_X,Fame_Y,1]);    
    }
}
if (DesignStatus=="sizing"){
    see_me_half(){
        translate([0,0,0]){
            Frame_Base("ears","no_holes"); // no means no holes in the Frame
//            translate([Fame_X,0,0]){
//                mirror([1,0,0]){
//                    if(Partchooser=="Backplate"){
//                        Screw_Ears();
//                    }
//                }
//            }
        }
//        translate([0,0,0]){
//            if(Partchooser=="Backplate"){
//                //Screw_Ears();
//            }
//        }
    
//        translate([Fame_X,0,0]){
//            mirror([1,0,0]){
//                if(Partchooser=="Backplate"){
//                    //Screw_Ears();
//                }
//            }
//        }
        translate([0,0,Fame_Z]){
            mirror([0,0,1]){
                Frame_Base("no ears","yes");
            }
        }    
        union(){
             
        }
        translate([ FrameMargin+FrameMarginToFit/2,
                    FrameMargin+FrameMarginToFit/2,
                    EdgecoverMargin_H+FrameMarginToFit/2    ]){
            The_Focusrite_Case(Focusrite_X,Focusrite_Y,Focusrite_Z,Focusrite_radius);
        }
    }
}
module see_me_half(){
    //difference(){
        //union(){
          translate([0,0,0]){
            for(i=[0:1:$children-1]){
                a=255;
                b=50;
                k_farbabstand=((a-b)/$children);
                Farbe=((k_farbabstand*i)/255);
                SINUS_Foo=0.5+(sin(((360/(a-b))*k_farbabstand)*(i+1)))/2;
                COSIN_Foo=0.5+(cos(((360/(a-b))*k_farbabstand)*(i+1)))/2;
                color(c = [ SINUS_Foo,
                            1-(SINUS_Foo/2+COSIN_Foo/2),
                            COSIN_Foo],
                            alpha = 0.5){  
                    //MirrorMirrorOnTheWall(0){
                    difference(){
                        //MirrorMirrorOnTheWall(0){
                            render(convexity=20){children(i);}
                            //children(i);
                        //}
// Creates a Cutting to see a Sidesection cut of the objects
                            color(c = [ SINUS_Foo,
                                1-(SINUS_Foo/2+COSIN_Foo/2),
                                COSIN_Foo],
                                alpha = 0.2){
                                translate([70/2,0,0]){
                                    //cube([70,70,150],center=true);
                                }
                                translate([0,0,0]){
                                    //cube([30,30,200],center=true);
                                    }
                                }
                            }
                        }
                    }
                    //MAIN_AXIS_ARRANGEMENT();
                } // sin((2*PI*i)/$children)
            }

// == Testprints ==

Projection_Cutter(5){
//see_me_half();
}

//// == Cutes a slice of the Objekts
Intersection_Test_Cut("xy",1.5,16){
 //Intersection_Test_Cut( "xy",           // "Plaine xy yz xz", 
                       // 1,              // Slicethickness , 
                        //5,              // Distance from coordinate origin in plaine )
   // OBJECTMODULESHERE 
   //Frame_Base();
}

// ==================================
// = Modus =
// ==================================

 
// ==================================
// = Stage =
// ==================================
// Final module for Produktion


// ===============================================================================
// =--------------------------------- Enviroment Modules ------------------------=
// ===============================================================================
// Modules that resembles the Enviroment aka the helmet where to atach a camera mount

module The_Focusrite_Case(X=150,Y=25,Z=120,R=5){
    linear_extrude(height = Z){
        2D_Rounded_Square_Base_Shape(X,Y,R);
    }
}
// ===============================================================================
// =--------------------------------- Modules -----------------------------------=
// ===============================================================================

//Focusrite_X=150;
//Focusrite_Y=50;
//Focusrite_Z=120;
//Focusrite_radius=3;
//
//FrameMargin=5;
//
//Fame_X=2*FrameMargin+Focusrite_X;
//Fame_Y=2*FrameMargin+Focusrite_Y;
//Fame_Z=2*FrameMargin+Focusrite_Z;



//Frame_Base();
module Frame_Base(Ears="ears",Holes="yes"){
    difference(){
        translate([0,0,0]){
            Extr_Housing_Base(Fame_X,Fame_Y,Frame_H);
            translate([0,Fame_Y/2,0]){
                linear_extrude(height=Frame_H,){
                    square([Fame_X,Fame_Y/2]);
                }
            }
        }    
        //cube([Fame_X,Fame_Y,Focusrite_Z],center=true);
        translate([FrameMargin,FrameMargin,0]){
            translate([EdgecoverMargin,EdgecoverMargin,0]){
                Extr_Housing_Base( Focusrite_X-2*EdgecoverMargin,
                                    Focusrite_Y-2*EdgecoverMargin,
                                    Focusrite_Z);                       
            }
            translate([0,0,EdgecoverMargin_H]){
                Extr_Housing_Base( Focusrite_X,
                                   Focusrite_Y,
                                   Focusrite_Z);
                translate([0,-h,12]){
                    translate([Foot_Center,0,0]){
                        rotate([-90,0,0]){
                            hull(){
                                FootsSphere();
                                translate([0,-5,0]){
                                    FootsSphere();
                                }
                            }
                        }
                    }
                    translate([Focusrite_X-Foot_Center,0,0]){
                        rotate([-90,0,0]){
                            hull(){
                                FootsSphere();
                                translate([0,-5,0]){
                                    FootsSphere();
                                }
                            }
                        }
                    }
                }
            }
        }        
        translate([ Focusrite_X-3*FrameMargin,
                    Fame_Y-FrameMargin,
                    Frame_H/2]){
            rotate([90,0,0]){
                if(Holes=="yes"){
                    #Screwcutter();
                }
            }
        }
        translate([ Fame_X-Focusrite_X+3*FrameMargin,
                    Fame_Y-FrameMargin,
                    Frame_H/2]){
            rotate([90,0,0]){
                if(Holes=="yes"){
                    #Screwcutter();
                }
            }
        }
    }
    if(Ears=="ears"){
        translate([0,0,0]){
            Screw_Ears();
        }
        translate([Fame_X,0,0]){
            mirror([1,0,0]){
                Screw_Ears();
            }
        }
    }
}
//Screw_Ears();
module Screw_Ears(){
    translate([-Frame_H/2,Fame_Y,Frame_H/2]){
        rotate([90,0,0]){
            difference(){
                linear_extrude(height=Fame_Y/3){
                    circle(d=Frame_H);
                    translate([0,-Frame_H/2,0]){
                        square([Frame_H/2,Frame_H]);    
                    }
                }
                translate([0,0,+Screw_Head_H+Fame_Y/12]){
                    #Screwcutter();
                }
                translate([0.1,0,Fame_Y/3]){
                    rotate([90,0,0]){
                        cylinder(h=Frame_H,d=Frame_H,center=true,$fn=72);
                        translate([-Frame_H/2,0,0]){
                            cube([Frame_H,Frame_H,Frame_H],center=true);
                        }
                    }
                }
            }
        }
    }
}
// ===============================================================================
// ---------------------------------- Cutting Modules ----------------------------
// ===============================================================================
// === Half Cutter


//Screwcutter();
module Screwcutter(){
    translate([0,0,-Screw_Head_H]){
        cylinder(h=FrameMargin+Screw_Head_H,d=8,$fn=32);
    }
    translate([0,0,-2*FrameMargin-2]){
        cylinder(10,d=3.3,$fn=32);    
    }
    translate([0,0,0]){
        cylinder(h=200,d=5.2,$fn=32);
    }
}


//FootsSphere();
module FootsSphere(){
R=sqrt((h^2+a^2)/2);
    translate([0,0,+R]){
        difference(){
            sphere(r=R,$fn=72);
            translate([0,0,-R+h+0.1]){
                cylinder(h=2*R,d=2*R,$fn=72);
            }
        }
    }
}
//Bolt(25,3,8,3);
module Bolt(BOLTLENGTH,BOLTDIAMETER,HEADDIAMETER,HEADHEIGHT){
    cylinder(h=BOLTLENGTH,d=BOLTDIAMETER,center=false,$fn=FN_Performance);
    translate([0,0,-HEADHEIGHT/2]){
        cylinder(h=HEADHEIGHT,d=HEADDIAMETER,center=true,$fn=6);
        cylinder(h=HEADHEIGHT,d=HEADDIAMETER,center=true,$fn=6);
    }
}

module Projection_Cutter(Offset_z){    
    projection(cut = true){
        translate([0,0,Offset_z]){
            children();
        }
    }
}
// ===============================================================================
// ---------------------------------- Intersection Modules -----------------------
// ===============================================================================

module Intersection_Test_Cut(PLAIN,THICKNESS,OFFSET){
// ==== EXAMPLE ====
//    !Intersection_Test_Cut("xy",1,7/2){sphere(7);};
// ==== EXAMPLE ====
    if (PLAIN=="xz"){
        intersection(){
            children();
            translate([0,OFFSET,0]){
                cube([100,THICKNESS,100],center=true);
            }
        }
    }
    else if (PLAIN=="xy") {
        intersection(){
            children();
            translate([0,0,OFFSET]){
                cube([500,500,THICKNESS],center=true);
            }
        }
    }
    else if (PLAIN=="yz") {
        intersection(){
            children();
            translate([OFFSET,0,0]){
                cube([THICKNESS,100,100],center=true);
            }
        }   
    }
}
// ===============================================================================
// ---------------------------------- Linear Extrude Modules ---------------------
// ===============================================================================
//Extr_Housing_Base();



module Extr_Housing_Base(X,Y,HEIGHT){
    linear_extrude(height=HEIGHT){
        2D_Rounded_Square_Base_Shape(X,Y,Focusrite_radius);
    }
}
module Ring_Shaper(HEIGHT,OUTER,WALLTHICKNESS){
    linear_extrude(HEIGHT){
        2D_Shape_Ring(OUTER,WALLTHICKNESS);
    }
}

module Linear_Extruding(ExtrudeLength,ExrtudingDirektionInverter){
    Length=ExtrudeLength;
    translate([0,0,Length*ExrtudingDirektionInverter]){
        linear_extrude(height=ExtrudeLength){
            children();
        }
    }
}

// ===============================================================================
// ---------------------------------- Rotate Extrude Modules ---------------------
// ===============================================================================


//DONUT(1,20,1,7);
module DONUT(DIAMETER,DIAMETER_RING,SCAL_X,SCAL_Y){
//DIAMETER The dough part
//DIAMETER_RING The hole part
//SCAL_X, skales the x dimension
//SCAL_Y, skales the y dimension
    rotate_extrude(angle=360,convexity=3,$fn=FN_Fine){
        translate([DIAMETER_RING,0,0]){
            scale([SCAL_X,SCAL_Y,1]){
                circle(d=DIAMETER,$fn=FN_Fine);
            }
        }
    }
}
// ===============================================================================
// =--------------------------------- 2D-Shapes ---------------------------------=
// ===============================================================================




//2D_Ring_Shape(15,10);
module 2D_Ring_Shape(OUTER_D,Inner_D){
    difference(){
        circle(d=OUTER_D,$fn=FN_Fine);
        circle(d=Inner_D,$fn=FN_Fine);
    }
}
//2D_Rounded_Square_Base_Shape(10,20,3);
module 2D_Rounded_Square_Base_Shape(DIMENSION_X=10,DIMENSION_Y=20,RADIUS=2){
    translate([RADIUS,RADIUS,0]){
        minkowski(){
            square([DIMENSION_X-RADIUS*2,DIMENSION_Y-RADIUS*2]);
            circle(r=RADIUS,$fn=FN_Fine);
        }
    }
}
// ===============================================================================
// =--------------------------------- Textembossing -----------------------------=
// ===============================================================================


// ===============================================================================
// =--------------------------------- Smoothing ---------------------------------=
// ===============================================================================

2D_Smooth_r=1;
// Radius of a outer Tip Rounding 
2D_Fillet_r=1;
// Radius of a inner corner Ronding
2D_Chamfer_DELTA_INN=1;
2D_Chamfer_DELTA_OUT=2;

// a straigt line on edges and corners
2D_Chamfer_BOOLEAN=false;

    
module Smooth(r=3){
    //$fn=30;
    offset(r=r,$fn=30){
        offset(r=-r,$fn=30){
        children();
        }
    }
}
module Fillet(r=3){
    //$fn=30;
    offset(r=-r,$fn=30){
        offset(r=r,$fn=30){
            children();
        }
    }
}
module Chamfer_OUTWARD(DELTA_OUT=3){
    //$fn=30;
    offset(delta=DELTA_OUT,chamfer=true,$fn=30){
        offset(delta=-DELTA_OUT,chamfer=true, $fn=30){
            children();
        }
    }
}
module Chamfer_INWARD(DELTA_INN=3){
    //$fn=30;
    offset(delta=-DELTA_INN,chamfer=true,$fn=30){
        offset(delta=DELTA_INN,chamfer=true, $fn=30){
            children();
        }
    }
}

// ===============================================================================
// =--------------------------------- Ruthex --------------------------------=
// ===============================================================================
// Dimensions for Ruthex Tread inseerts

//RUTHEX_M3();
module RUTHEX_M3(){    
L=5.7+5.7*0.25; // Length + Margin
echo("RUTHEX",L);
D1=4.0;    
    translate([0,0,0]){
        rotate([0,0,0]){
            translate([0,0,0]){
                cylinder(h=L,d1=D1,d2=D1,$fn=FN_Performance);
            }
        }
    }
}

// ===============================================================================
// =--------------------------------- Import STL --------------------------------=
// ===============================================================================

module NAME_OF_IMPORT(){
    rotate([0,0,-90]){
        translate([-515,-100,-45]){
            import("PATH/TO/FILE.stl",convexity=3);
        }
    }
}