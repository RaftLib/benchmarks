
#include "JPEGfilewriter.x"
#include "HuffmanEncodingS32ArrayU64.x"
#include "genColor.x"
#include "LevelShiftS32F32Array.x"
#include "DctIIF32Array.x"
#include "QuantizationF32S32Array.x"
#include "DCCodingS32Array.x"
#include "ZigzagS32Array.x"
#include "JPEGRGBtoYCbCr.x"
#include "genPictureFromFile.x"

block JPEGY{
	input array<signed32>[ARRAYSIZE] x0;
	output array<unsigned64>[ARRAYSIZE] y0;


	LevelShiftS32F32Array ls;
	DctIIF32Array dcii;
	QuantizationF32S32Array quan;
	DCCodingS32Array dcc;
	ZigzagS32Array zigzag;
	HuffmanEncodingS32ArrayU64 huff;

e1:	x0->ls;
e2:	ls->dcii;
e3:	dcii->quan;
e4:	quan->dcc;
e5:	dcc->zigzag;
e6:	zigzag->huff;
e7:	huff->y0;

};

block JPEGC{
        input array<signed32>[ARRAYSIZE] x0;
        output array<unsigned64>[ARRAYSIZE] y0;


        LevelShiftS32F32Array ls;
        DctIIF32Array dcii;
        QuantizationF32S32Array quan(q_table = 2);
        DCCodingS32Array dcc;
        ZigzagS32Array zigzag;
        HuffmanEncodingS32ArrayU64 huff(huff_table = 2);

e1:     x0->ls;
e2:     ls->dcii;
e3:     dcii->quan;
e4:     quan->dcc;
e5:     dcc->zigzag;
e6:     zigzag->huff;
e7:     huff->y0;

};

block top{

//	genColor gen(iterations = NUMFRAME, array_length=ARRAYSIZE);
	genPictureFromFile gen;
	JPEGRGBtoYCbCr color;
	JPEGY luminance;
	JPEGC chrominanceB;
	JPEGC chrominanceR;
	JPEGfilewriter fw;

e1:	gen->color;
e2:	color.y0->luminance;
e3:	color.y1->chrominanceB;
e4:	color.y2->chrominanceR;
e5:	luminance->fw.x0;
e6:	chrominanceB->fw.x1;
e7:	chrominanceR->fw.x2;

};

use top app;
