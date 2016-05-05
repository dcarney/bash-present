# bash-present
Bash script for giving CLI presentations, one line at a time, because who _doesn't_ love a good command-line demo?

### Overview

`bash-present` is a script for reading a text file containing shell commands, and executing them one-by-one.

Usage: `$ present.sh <commands-file>`

  where `<commands-file>` is a plain-text file containing shell commmands to execute, one per line.

When invoked as described, this script will:
  - read a line from the supplied text file that represents a command
  - echo the line to stdout (with colors!)
  - wait for any input on the tty (aka waitd for you to hit Enter)
  - run the command
  - repeat until the file is exhausted

### Example:
An example commands file (`example.txt`) would look like:

    cowsay "Hello World\!"
    date
    cowsay $(date)

Running `$ present.sh example.txt` would yield:

```
$ cowsay "hello world!"

 ______________
< hello world! >
 --------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

$ date

Wed May  4 21:28:04 PDT 2016

$ cowsay $(date)

 _____________________________
< Wed May 4 21:28:05 PDT 2016 >
 -----------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

In the above example, the script echoes each command to stdout, before
pausing to wait for the "Enter" key to be pressed.  Then, the _output
of running that command_ is sent to stdout.
