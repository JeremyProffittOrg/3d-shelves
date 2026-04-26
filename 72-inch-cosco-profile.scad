// 72-inch Cosco shelf profile.
//
// Overrides the bar / front-lip dimensions in bar_shelf.scad to fit a
// 72-inch Cosco shelving rail. Include this BEFORE bar_shelf.scad in any
// wrapper that should use the Cosco profile.
border_ridge_override     = 25.4;    // 1"
border_depth_override     = 19.05;   // 3/4"
border_height_override    = 9.525;   // 3/8"
rear_wall_height_override = 5;       // shorter rear lip than 77-inch industrial
