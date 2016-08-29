size(350,350);
//radius of the large parent circle
float r = 35.0;
//float theta = 3.14;
//counters for iterations
int num; int num2; int num3;
//radius of the unseen circle to which each small circle adheres
float r1; 
float r2;
float r3; 
noStroke();
fill(255);
ellipse(175,175,300,300);

for(num = 0; num <10; num++){
  fill(200,0,0);
float theta = random(2.6,3.2); //radian position of each small circle
//randomizes how close each small circle is positioned to the center of the parent circle
r1 = random(20,30);
//float x = cos(theta)* random(5,35);
//float y = sin(theta)* random(5,35); 
float x = cos(theta)* r1;
float y = sin(theta)* r1; 
//float x = 0.1;
//float y = 0.1;
println("initial x is " +x);
println("initial y is " +y);
//maps the cartesian coordinates onto pixels
float w = map(x, -35, 35, 115, 185);
float h = map(y, -35, 35, 115, 185);
ellipse(w,h,3,3);
println("w is "+w);
println("h is " +h);
println("theta is " +theta);
//println("x is " +cos(theta)* r);
}
for(num2 = 0; num2 <20; num2++){
  fill(0,200,0);
float theta = random(2.6,3.2); //radian position of each small circle
//randomizes how close each small circle is positioned to the center of the parent circle
r2 = random(12,20);
//float x = cos(theta)* random(5,35);
//float y = sin(theta)* random(5,35); 
float x = cos(theta)* r2;
float y = sin(theta)* r2; 
//float x = 0.1;
//float y = 0.1;
println("initial x is " +x);
println("initial y is " +y);
//maps the cartesian coordinates onto pixels
float w = map(x, -35, 35, 115, 185);
float h = map(y, -35, 35, 115, 185);
ellipse(w,h,3,3);
}

for(num3 = 0; num3 <30; num3++){
  fill(0,0,200);
float theta = random(2.6,3.2); //radian position of each small circle
//randomizes how close each small circle is positioned to the center of the parent circle
r3 = random(3,12);
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
ellipse(w,h,3,3);
}



//map(x, -1, 1, 115, 185);
//map(y, -1, 1, 115, 185);

//x range = 115 - 185; y range = 115 - 185;

