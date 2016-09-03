size(300,300);
//radius of the large parent circle
//float r = 35.0;
//float theta = 3.14;
//counters for iterations
int num; int num2; int num3;
//radius of the unseen circle to which each object-circle adheres
float r1; 
float r2;
float r3; 
noStroke();
fill(75);
ellipse(150,150,270,270);

for(num = 0; num < 6; num++){
  
fill(220,75,0, 100);
//radian position of each small circle
float theta = random(2.5,3.5);


//randomizes how close each object-circle is positioned to the center of the parent circle
r1 = random(12,42);
  //println("a = " +a);
//cartesian coordinates for the center of each object-circle
float x = cos(theta)* r1;
float y = sin(theta)* r1; 
println("initial x is " +x);
println("initial y is " +y);
//maps the cartesian coordinates onto pixels
float w = map(x, -35, 35, 60, 205);
float h = map(y, -35, 35,60, 205);
float d1 = random (15,26);
ellipse(w,h,d1,d1);
//println("w is "+w);
//println("h is " +h);
//println("theta is " +theta);
//println("x is " +cos(theta)* r);

}

for(num2 = 0; num2 < 10; num2++){
  fill(0,200,0,100);
  //radian position of each small circle
float theta = random(2.6,4.2); //radian position of each object-circle
//randomizes how close each object-circle is positioned to the center of the parent circle
r2 = random(15,38);
//float x = cos(theta)* random(5,35);
//float y = sin(theta)* random(5,35); 
float x = cos(theta)* r2;
float y = sin(theta)* r2; 
//float x = 0.1;
//float y = 0.1;
//println("initial x is " +x);
//println("initial y is " +y);
//maps the cartesian coordinates onto pixels(did not update the values from the smaller sketch 'cause these work fine
float w = map(x, -35, 35, 115, 185);
float h = map(y, -35, 35, 115, 185);
float d2 = random(9,14);
ellipse(w,h,d2,d2);
}

for(num3 = 0; num3 < 15; num3++){
  fill(0,200,0,100);
float theta = random(-.5,.5); //radian position of each object-circle
//randomizes how close each object-circle is positioned to the center of the parent circle
r3 = random(25,100);
//float x = cos(theta)* random(5,35);
//float y = sin(theta)* random(5,35); 
float x = cos(theta)* r3;
float y = sin(theta)* r3; 
//float x = 0.1;
//float y = 0.1;
println("initial x is " +x);
println("initial y is " +y);
//maps the cartesian coordinates onto pixels
float w = map(x, -35, 35, 115, 185);
float h = map(y, -35, 35, 115, 185);
int d3 = 8;
ellipse(w,h,d3,d3);
}

