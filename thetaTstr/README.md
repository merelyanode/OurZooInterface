<img width="201" alt="thetatester_3d" src="https://cloud.githubusercontent.com/assets/1186477/18337857/43d4d034-7562-11e6-8be3-2fabcbba9618.png">

This is a 2d workshop that illustrates how to randomise 2d polar coordinates  in the manner that will be applied to 3d spherical coordinates for the final visualization.

 [This link](http://mathinsight.org/polar_coordinates)  holds my favorite explanation for using/calculating polar coordinates.
 
 To make the three clusters of object-circles (circles that represent a submitted word or phrase) required for the Zoo Cloud visualizaton, I create three sets of object-circles. For each set, the positions of each object-circle is defined by placing it on the circumference of an unseen, semi-randomly generated circle ("semi" because the circles are relegated to three cluster zones disperesed within the all-enclosing parent circle . The exact coordinate position of an object-circle is defined by the semi-random radius (r) of it's unseen host circle and it's assigned theta (θ) angle --> x = rcosθ, y =rsinθ. Processing's *map* function is used to convert those xy values to actual pixel coordinates and an object-circle is then drawn at those coordinates.
