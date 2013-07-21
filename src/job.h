/*
 * File: job.h
 * -----------
 * This interface exports a class for representing jobs
 * computing histogram thresholding on a single image.
 */

#ifndef _job_h
#define _job_h

#include "Magick++.h"

class Job {

public:

/*
 * Constructor: Job
 * Usage: Job j;
 *        Job j(percentage);
 * -------------------------
 * Creates a Job object. The default constructor creates a job with
 * percentage set to 50%. The percentage can be passed explicitly
 * to the constructor.
 */

	Job();
	Job(int);

/*
 * Method: execute()
 * Usage: j.execute();
 * -------------------
 * Performs histogram thresholding. Returns itself so that this
 * method can be chained or used in a sketo::map.
 */

	Job execute();

/*
 * Method: writeResult();
 * Usage: j.writeResult();
 * -----------------------
 * Writes the result to disk. Returns itself so that this method
 * can be chained or used in a sketo::map.
 */

	Job writeResult();

private:

	Magick::Image originalImage;
	Magick::Image processedImage;
	int percentage;

};

#endif

