struct generate_t : public sketo::functions::base<Job(size_t)> {
	Job operator()(size_t) const {
		int percentage = rand() % 100;
		return Job(percentage);
	}
} generate;

