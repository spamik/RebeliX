// PRUSA iteration3
// X end prototype
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org



use <bearing.scad>
rod_distance = 45;

bearing_diameter = 15;
thinwall = 3;
bearing_size = bearing_diameter + 2 * thinwall;

height = 58;
width = 21;

nut_classic = 0;

module nut(nut_diameter=6.6,nut_height=3){
	cylinder(r=nut_diameter/2,h=2*nut_height,$fn=6,center=true);
}

module bearing_tighter(nuthead=false) {
    difference() {
        cube(size=[13, 5, height], center=true);
        translate([2.5, -1.4, height/2-height/8]) rotate(a=[90, 0, 0]) cylinder(d=3.3, h=5*2, $fn=16, center=true);
        translate([2.5, -1.4, height/2-3*height/8]) rotate(a=[90, 0, 0]) cylinder(d=3.3, h=5*2, $fn=16, center=true);
        translate([2.5, -1.4, height/2-5*height/8]) rotate(a=[90, 0, 0]) cylinder(d=3.3, h=5*2, $fn=16, center=true);
        translate([2.5, -1.4, height/2-7*height/8]) rotate(a=[90, 0, 0]) cylinder(d=3.3, h=5*2, $fn=16, center=true);
        
        if(nuthead) {
            translate([2.5, -2.4, height/2-height/8]) rotate(a=[90, 30, 0]) nut(6.6, 1.4);
            translate([2.5, -2.4, height/2-3*height/8]) rotate(a=[90, 30, 0]) nut(6.6, 1.4);
            translate([2.5, -2.4, height/2-5*height/8]) rotate(a=[90, 30, 0]) nut(6.6, 1.4);
            translate([2.5, -2.4, height/2-7*height/8]) rotate(a=[90, 30, 0]) nut(6.6, 1.4);
            
        } else {
            translate([2.5, 3, height/2-height/8]) rotate(a=[90, 0, 0]) cylinder(d=7, h=5, $fn=32, center=true);
            translate([2.5, 3, height/2-3*height/8]) rotate(a=[90, 0, 0]) cylinder(d=7, h=5, $fn=32, center=true);
            translate([2.5, 3, height/2-5*height/8]) rotate(a=[90, 0, 0]) cylinder(d=7, h=5, $fn=32, center=true);
            translate([2.5, 3, height/2-7*height/8]) rotate(a=[90, 0, 0]) cylinder(d=7, h=5, $fn=32, center=true);
        }
        
    }
 
}

module x_end_base(){
  // Hlavni blok
  translate([-12,-20,height/2]) cube([width,25,height], center = true);	
  // Drzak loziska
  translate([-12,0,0]) rotate([0,0,90]) vertical_bearing_base();
  // Hexagon
  if(nut_classic){
    // Osmihran
    translate(v=[-4,-17,0]) rotate([0,0,30]) cylinder(h = 3+5, r=12, $fn = 6);    
  } else{   
    translate(v=[-4,-17,0]) rotate([0,0,30]) cylinder(h = 3+4+3, r=12, $fn = 6);
  }
  // packy s dirama pro stazeni pouzdra okolo lozisek
  translate([0, -4, height/2]) bearing_tighter(nuthead=true);
  translate([0, 4, height/2]) bearing_tighter();
  }

module x_end_holes(){
  translate([-12,0,0]) rotate([0,0,90]) vertical_bearing_holes();
  // Vyrez pro remen
  translate([2,0,0]){
  difference(){
	difference(){
	  union(){
        translate([-5.5-10+1.5,-34,30]) cube(size = [11,20,28], center = true);
	    translate([-5.5-10+1.5,-24,30]) rotate([0,90,0]) cylinder(r=14,h=11,$fn=80,center=true);
	  }	
	}  
	// Nice edges
	translate([-5.5-10+1.5,-10,30+23]) rotate([0,45,0]) cube(size = [10,46,28], center = true);
	translate([-5.5-10+1.5,-10,30+23]) rotate([0,-45,0]) cube(size = [10,46,28], center = true);
	translate([-5.5-10+1.5,-10,30-23]) rotate([0,45,0]) cube(size = [10,46,28], center = true);
	translate([-5.5-10+1.5,-10,30-23]) rotate([0,-45,0]) cube(size = [10,46,28], center = true);
  }
}

  // Bottom pushfit rod
  translate([-12,-41.5,6]) rotate(a=[-90,0,0]) pushfit_rod(8.1,31);
  // Top pushfit rod
  translate([-12,-41.5,rod_distance+6]) rotate(a=[-90,0,0]) pushfit_rod(8.1,31);
  if(nut_classic){
    // Klasicky zapustena matka
    translate(v=[0,-17,-0.5]) cylinder(h = 4, r=3, $fn=25);
    translate(v=[0,-17,3]) rotate([0,0,30]) cylinder(h = 10, r=4.5, $fn = 6);
    // Rezerva pro pruznou spojku
    translate([0,-17,3+5]) cylinder(h = height, r=4.8, $fn=42);
  } else {
    // Otvor na matku
    translate([0,-17,-0.1]) cylinder(h = 4, r=3.3, $fn=25);
    translate([0,-17,3+4.1+0.3]) cylinder(h = 4, r=3.3, $fn=25);
    translate([-0.5,-17,3]) rotate([0,0,0]) cylinder(h = 4.1, r=4.6, $fn = 6);
    translate([0,-17-cos(30)*4.6,3]) cube([10,2*cos(30)*4.6,4.1]);
    // Rezerva pro pruznou spojku
    translate([0,-17,3+4+3]) cylinder(h = height, r=4.8, $fn=42);    
  }    
}


// Final prototype
module x_end_plain(){
 difference(){
  x_end_base();
  x_end_holes();
 }
}

x_end_plain();

module pushfit_rod(diameter,length){
 cylinder(h = length, r=diameter/2, $fn=30);
 difference(){
 	translate([0,-diameter/2.85,length/2]) rotate([0,0,45]) cube(size = [diameter/2,diameter/2,length], center = true);
 	translate([0,-diameter/4-diameter/2-0.4,length/2]) rotate([0,0,0]) cube(size = [diameter,diameter/2,length], center = true);
 }
 //translate(v=[0,-diameter/2-2,length/2]) cube(size = [diameter,1,length], center = true);
}

