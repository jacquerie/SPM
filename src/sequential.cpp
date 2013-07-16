/*
 * File: sequential.cpp
 * --------------------
 * TODO
 */

#include <ctime>
#include <iostream>
#include <stdlib.h>
#include <vector>
#include <Magick++.h>

#include "job.h"

int main(int argc, char *argv[]) {
	int i, numberOfTasks, percentage;
	std::vector<Job> jobs;

	if (argc != 2) {
		std::cerr << "Usage: " << argv[0] << " numberOfTasks" << std::endl;
		return -1;
	} else {
		numberOfTasks = atoi(argv[1]);
	}

	srand(time(NULL));
	for (i = 0; i < numberOfTasks; i++) {
		percentage = rand() % 100;
		Job j(percentage);
		jobs.push_back(j);
	}

	std::clock_t begin = std::clock();

	for (i = 0; i < numberOfTasks; i++) {
		jobs[i].execute();
	}

	std::clock_t end = std::clock();

	std::cout << "Time elapsed for sequential: " << double(end - begin) / CLOCKS_PER_SEC << "s" << std::endl;

	for (i = 0; i < numberOfTasks; i++) {
		jobs[i].writeResult();
	}

	return 0;
}

