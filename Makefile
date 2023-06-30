
# Run specs
specs: bundle
	bin/rspec

# Release a new version
release: bump bundle

# Bump the version
bump:
	# If missing "bump", run: `cargo install --git https://github.com/broothie/bump`
	bump lib/typeid/version.rb

# Run bundle install
bundle:
	bundle install
