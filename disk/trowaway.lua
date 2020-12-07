-- wget https://raw.githubusercontent.com/Kollock5/cc/main/disk/trowaway.lua startup.lua

shell.run('cp disk/payload startup')
shell.run('rm disk/payload')
shell.run('rm disk/startup')
shell.run('reboot')
