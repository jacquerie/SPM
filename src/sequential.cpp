/*
 * File: sequential.cpp
 * --------------------
 * A sequential program computing histogram thresholding
 * for numberOfJobs images. Each job is abstracted in the
 * Job class.
 */

#include <ctime>
#include <iostream>
#include <list>
#include <stdlib.h>
#include <Magick++.h>

#include "job.h"

int main(int argc, char *argv[]) {
	int percentage;
	size_t i, numberOfJobs;
	std::list<Job> jobs;

	// Very simple argument parsing.
	if (argc != 2) {
		std::cerr << "Usage: " << argv[0] << " numberOfJobs" << std::endl;
		return -1;
	} else {
		numberOfJobs = atoi(argv[1]);
	}

	// Job initialization.
	srand(time(NULL));
	for (i = 0; i < numberOfJobs; i++) {
		percentage = rand() % 100;
		Job j(percentage);
		jobs.push_back(j);
	}

	// The actual computation.
	std::clock_t begin = std::clock();
	std::list<Job>::iterator j_it, j_end;
	for (j_it = jobs.begin(), j_end = jobs.end(); j_it != j_end; j_it++) {
		j_it->execute();
	}
	std::clock_t end = std::clock();

	// Writing the results to disk.
	for (j_it = jobs.begin(), j_end = jobs.end(); j_it != j_end; j_it++) {
		j_it->writeResult();
	}

	// Logging to stdout the computation time.
	std::cout << numberOfJobs << "\t" << double(end - begin) / CLOCKS_PER_SEC << std::endl;

	return 0;
}

