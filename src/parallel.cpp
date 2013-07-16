/*
 * File: parallel.cpp
 * ------------------
 * TODO
 */

#include <cstdlib>
#include <ctime>
#include <sketo/list_skeletons.h>
#include "job.h"

struct generate_t : public sketo::functions::base<Job(int)> {
	Job operator()(int) const {
		int percentage = rand() % 100;
		return Job(percentage);
	}
} generate;

struct execute_t : public sketo::functions::base<Job(Job)> {
	Job operator()(Job j) const {
		return j.execute();
	}
} execute;

struct write_result_t : public sketo::functions::base<Job(Job)> {
	Job operator()(Job j) const {
		return j.writeResult();
	}
} write_result;

int sketo::main(int argc, char *argv[]) {
	int i, numberOfTasks;

	if (argc != 2) {
		// Using sketo::cout because Sketo has no cerr stream.
		sketo::cout << "Usage: " << argv[0] << " numberOfTasks" << std::endl;
		return -1;
	} else {
		numberOfTasks = atoi(argv[1]);
	}

	sketo::dist_list<Job> jobs = sketo::list_skeletons::generate(numberOfTasks, generate);
	
	std::clock_t begin = std::clock();
	jobs = sketo::list_skeletons::map(execute, jobs);
	std::clock_t end = std::clock();

	jobs = sketo::list_skeletons::map(write_result, jobs);

	sketo::cout << "Time elapsed for parallel: " << double(end - begin) / CLOCKS_PER_SEC << "s" << std::endl;

	return 0;
}

