bearing_out_dia = 15;
bearing_wall = 4.6;
bearing_length = 24;

difference() {
    union() {
        difference() {
            cylinder(d=bearing_out_dia+2*bearing_wall, h=bearing_length, $fn=100);
            translate([0, 0, -1]) cylinder(d=bearing_out_dia, h=bearing_length+2, $fn=100);
            translate([0, bearing_out_dia/2+bearing_wall/2-1, bearing_length/2]) cube(size=[9, bearing_wall+2, bearing_length+2], center=true);
        }
        
        translate([0, bearing_out_dia/-2-5, bearing_length/2]) cube(size=[40, 5, bearing_length], center=true);
        translate([0, bearing_out_dia/-2-2.5, bearing_length/2]) cube(size=[bearing_out_dia+bearing_wall, 5, bearing_length], center=true);
        translate([bearing_out_dia/-2-1, bearing_out_dia/-2, bearing_length/2]) cube(size=[bearing_wall, 5, bearing_length], center=true);
        translate([bearing_out_dia/2+1, bearing_out_dia/-2, bearing_length/2]) cube(size=[bearing_wall, 5, bearing_length], center=true);
        
        translate([-7.5, 3+bearing_out_dia/2, bearing_length/2]) cube(size=[6, 9, bearing_length], center=true);
        translate([7.5, 3+bearing_out_dia/2, bearing_length/2]) cube(size=[6, 9, bearing_length], center=true);
    }
    
    translate([-15, 0, bearing_length/2]) rotate(a=[90, 0, 0]) cylinder(d=3.5, h=100, $fn=100);
    translate([15, 0, bearing_length/2]) rotate(a=[90, 0, 0]) cylinder(d=3.5, h=100, $fn=100);
    
    translate([-30, bearing_out_dia/2+3.5, bearing_length/2+7]) rotate(a=[0, 90, 0]) cylinder(d=3.5, h=100, $fn=100);
    translate([-30, bearing_out_dia/2+3.5, bearing_length/2-7]) rotate(a=[0, 90, 0]) cylinder(d=3.5, h=100, $fn=100);
    
    translate([-3-4.5-4, bearing_out_dia/2+3.5, bearing_length/2+7]) rotate(a=[0, 90, 0]) cylinder(d=7, h=3, $fn=100);
    translate([-3-4.5-4, bearing_out_dia/2+3.5, bearing_length/2-7]) rotate(a=[0, 90, 0]) cylinder(d=7, h=3, $fn=100);
    
    translate([4.5+4, bearing_out_dia/2+3.5, bearing_length/2+7]) rotate(a=[0, 90, 0]) cylinder(d=6.5, h=3, $fn=6);
    translate([4.5+4, bearing_out_dia/2+3.5, bearing_length/2-7]) rotate(a=[0, 90, 0]) cylinder(d=6.5, h=3, $fn=6);
}




