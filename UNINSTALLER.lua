shell = require("shell")
shell.execute("move -f /home/.shrc /home/.shrc.old")
shell.execute("move -f /argon/.autorun /home/.shrc")
shell.execute("rm -rf /argon")
