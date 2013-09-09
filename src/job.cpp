/*
 * File: job.cpp
 * -------------
 * This file implements the Job class.
 */

#include <algorithm>
#include <sstream>
#include <string>
#include <vector>

#include <Magick++.h>
#include "job.h"

Job::Job() {
	Magick::Image originalImage("lena.png");

	this->originalImage = originalImage;
	this->percentage = 50;
}

Job::Job(int percentage) {
	Magick::Image originalImage("lena.png");

	this->originalImage = originalImage;
	this->percentage = percentage;
}

Job Job::execute() {
	int width = this->originalImage.columns();
	int height = this->originalImage.rows();
	std::vector<double> luminosities;

	int i, j;
	for (i = 0; i < width; i++) {
		for (j = 0; j < height; j++) {
			Magick::ColorHSL pixelColor = originalImage.pixelColor(i, j);
			double pixelLuminosity = pixelColor.luminosity();
			luminosities.push_back(pixelLuminosity);
		}
	}

	std::sort(luminosities.begin(), luminosities.end());
	int cutoff = (int) (width * height * percentage) / 100;
	double threshold = luminosities[cutoff];

	Magick::Image processedImage(Magick::Geometry(width, height), "white");
	this->processedImage = processedImage;
	for (i = 0; i < width; i++) {
		for (j = 0; j < height; j++) {
			Magick::ColorHSL pixelColor = originalImage.pixelColor(i, j);
			double pixelLuminosity = pixelColor.luminosity();
			this->processedImage.pixelColor(i, j, Magick::ColorMono(pixelLuminosity > threshold));
		}
	}

	return *this;
}

Job Job::writeResult() {
	std::string fileName;
	std::stringstream result;

	if (this->percentage < 10) {
		result << "img/lena-threshold-0" << this->percentage << ".png";
	} else {
		result << "img/lena-threshold-" << this->percentage << ".png";
	}
	fileName = result.str();

	this->processedImage.write(fileName);

	return *this;
}

