{print} = require "util"
{spawn, exec} = require "child_process"

split = (str) -> str.split " "
echo = (child) ->
  child.stderr.pipe process.stderr
  child.stdout.pipe process.stdout

d = __dirname

queue = [
  "jade -O #{d}/page/ -wP #{d}/src/index.jade"
  "stylus -o #{d}/page/ -w #{d}/src/"
  "coffee -o #{d}/page/ -wbc #{d}/src/"
  "doodle #{d}/page/"
]

task "dev", "watch and convert files", (callback) ->
  queue.map(split).forEach (array) ->
    cmd = array[0]
    args = array[1..]
    echo spawn cmd, args