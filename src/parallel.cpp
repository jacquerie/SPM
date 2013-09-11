/*
 * File: parallel.cpp
 * ------------------
 * A parallel program computing histogram thresholding
 * for numberOfJobs images. Each job is abstracted in the
 * Job class.
 */

#include <cstdlib>
#include <ctime>
#include <sketo/list_skeletons.h>
#include "job.h"

// Function object generating a job.
struct generate_t : public sketo::functions::base<Job(size_t)> {
	Job operator()(size_t) const {
		int percentage = rand() % 100;
		return Job(percentage);
	}
} generate;

// Function object executing a job.
struct execute_t : public sketo::functions::base<Job(Job)> {
	Job operator()(Job j) const {
		return j.execute();
	}
} execute;

// Function object writing a job result to disk.
struct write_result_t : public sketo::functions::base<Job(Job)> {
	Job operator()(Job j) const {
		return j.writeResult();
	}
} write_result;

int sketo::main(int argc, char *argv[]) {
	size_t numberOfJobs;

	// Very simple argument parsing.
	if (argc != 2) {
		// Using sketo::cout because Sketo has no cerr stream.
		sketo::cout << "Usage: " << argv[0] << " numberOfTasks" << std::endl;
		return -1;
	} else {
		numberOfJobs = atoi(argv[1]);
	}

	// Job initialization.
	sketo::dist_list<Job> jobs = sketo::list_skeletons::generate(numberOfJobs, generate);

	// The actual computation.
	std::clock_t begin = std::clock();
	jobs = sketo::list_skeletons::map(execute, jobs);
	std::clock_t end = std::clock();

	// Writing the results to disk.
	jobs = sketo::list_skeletons::map(write_result, jobs);

	// Logging to stdout the computation time.
	sketo::cout << numberOfJobs << " " << double(end - begin) / CLOCKS_PER_SEC << std::endl;

	return 0;
}
