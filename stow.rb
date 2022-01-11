#!/usr/bin/env ruby
require "fileutils"

def error(msg, code=1)
  STDERR.puts(msg)
  exit code
end

def usage
  STDERR.puts("usage: ./stow.rb [-h|--help] [-D]")
  STDERR.puts("\t-h|--help: display this message")
  STDERR.puts("\t-D: unstow (unlink files)")
end

def stow(args)
  cmd = "stow " + args
  STDERR.puts(cmd)
  system(cmd) or exit $?.exitstatus
end

if $PROGRAM_NAME != __FILE__
  return
end

if ARGV.include? "-h" or ARGV.include? "--help"
  usage
  exit
end

begin
  `stow --version`
rescue Error::ENOENT
  error "stow isn't installed", 127
end

git_root = `git rev-parse --show-toplevel`.strip
if not $?.success?
  error "not in a git repository"
end

Dir.chdir git_root
system("stow -v -D .")
if ARGV.include? "-D"
  exit
end

stow(%{
-v
--ignore=\\.git
--ignore=\\.gitignore
--ignore=\\.gitmodules
--ignore=\\.stowrc
--ignore=\\.config
--ignore=bin
--ignore=install.sh
--ignore=stow.rb
.}.gsub("\n", " "))

FileUtils.mkdir_p "#{git_root}/../.config"
Dir.chdir(git_root + "/.config")
stow("-v --target=\"#{git_root}/../.config\" --ignore=nixpkgs/lina-overlay --no-folding .")

FileUtils.mkdir_p "#{git_root}/../bin"
Dir.chdir(git_root + "/bin")
stow("-v --target=\"#{git_root}/../bin\" --no-folding .")
