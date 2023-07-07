
task default: :list

desc "List tasks"
task :list do
  sh "rake -AT"
end

desc "Run specs"
task specs: %i[bundle] do
  sh "bin/rspec"
end

desc "Release a new version"
task release: %i[bump bundle]

desc "Bump the version"
task :bump do
  # If missing "bump", run: `cargo install --git https://github.com/broothie/bump`
  sh "bump lib/typeid/version.rb"
end

desc "Run bundle install"
task :bundle do
  sh "bundle install"
end
