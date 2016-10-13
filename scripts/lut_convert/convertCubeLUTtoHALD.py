#######################################################################################
#
#	file		:	convertCubLUTtoHALD.py
#	date		:	13/10/2016
#	version		:	0.1 - Initial Version
#	requires	:	pylut, pillow
#	copyright	:	(c) st599 MMXVI
#
#######################################################################################

import sys
from pylut import *
from PIL import Image


def applyLUT(lut, vanillaHald):
	print("Applying LUT")
	
	inIm = vanillaHald.load()
	
	outputImage = Image.new(vanillaHald.mode, vanillaHald.size, None)
	outIm = outputImage.load()
	
	width,height = vanillaHald.size
	print(width,height)
	
	for w in range(0, width):
		for h in range(0, height):
			r,g,b = inIm[w,h]
			rf = r/255.0
			gf = g/255.0
			bf = b/255.0
			outC = lut.ColorFromColor(Color(rf,gf,bf))
			r1,g1,b1 = outC.ToRGBIntegerArray(8)
			outIm[w,h] = r1,g1,b1
	
	return outputImage

if __name__ == '__main__':
	
	
	print("Creates a HALD CLUT from a 3D Cube File")
	
	if len(sys.argv) != 3:
		
		print("usage:")
		print("  python convertCubeLuttoHALD.py <Cube Input Filename> <HALD Output Filename>")
		
	else:
		print("Cube Filename: ", sys.argv[1])
		print("HALD Filename: ", sys.argv[2])
		
		print("Opening LUT File")
		lut = LUT.FromCubeFile(sys.argv[1])
	
		print("Opening Vanilla HALD File")
		inputImage = Image.open("vanilla_hald16.png")
		
		outputImage =  applyLUT(lut, inputImage)
		
		print("Opening Output HALD File")
		
		outputImage.save(sys.argv[2])
	