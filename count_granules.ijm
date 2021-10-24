title = File.nameWithoutExtension;
//dirOrig = getDirectory("Select a Directory")
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", "outer");
setBackgroundColor(255, 255, 255);
run("Clear Outside");
setForegroundColor(0, 0, 0);
run("Fill", "slice");
run("Set Measurements...", "area centroid redirect=None decimal=2");
rename("cell");
run("Analyze Particles...", "size=0-Infinity summarize");
X = getResult("X");
Y = getResult("Y");
for (i = 1; i < 4; i++) {
	j = 10*i;
	run("Options...", "iterations=10 count=1 do=Erode");
	roiManager("Show None");
	doWand(X, Y);
	roiManager("Add");
	roiManager("Select", i);
	roiManager("Rename", "inner "+j);
}
close();
setAutoThreshold("Mean");
setOption("BlackBackground", false);
run("Convert to Mask");
run("Fill Holes");
roiManager("Select", 0);
run("Set Measurements...", "  redirect=None decimal=2");
rename("total_granules");
run("Analyze Particles...", "size=10-500 summarize");
roiManager("Select", 0);
run("Clear Outside");
for (i = 3; i > 0; i-= 1) {
	roiManager("Select", i);
	run("Clear", "slice");
	roiManager("Select", 0);
	rename("docked_granules_" + i*10);
	run("Analyze Particles...", "size=10-500 summarize");
}
close();
//roiManager("Save", dirOrig+title+"_ROIs.zip");
//saveAs("Results", dirOrig+title+"_results.csv");
//close("Summary")
//close("ROI Manager")