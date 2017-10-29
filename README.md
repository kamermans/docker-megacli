# docker-megacli
Docker container for running MegaCLI and StorCLI on Debian / Ubuntu / RedHat / CentOS / SUSE

## Using MegaCLI
MegaCLI is a very complicated tool that requires you to enter case-sensitive arguments
that seem to have no rhyme or reason.  It is virually impossible to guess a command,
and even the executable `MegaCli` can be found spelled in many different cases.  To add
to the madness, there is abysmal support for Debian-based distros like Ubuntu.  Since
this container runs CentOS inside a Docker container, it can run seemlessly on Ubuntu
from the CentOS runtime and RPM package.

> Note: There is a similar command called StorCLI, also made by LSI.  This command is
> also included as `storcli` inside this container.

### Running the container
You can run this container without installing anything except Docker:

    docker run --rm -ti --privileged kamermans/docker-megacli


> Note that the `--rm` will delete the container for you when you exit it, and
> `privileged` mode is required so the container can talk directly to the hardware.

Once you start the container, you will find yourself at a bash prompt:

```
steve@steve-hq:~$ docker run --rm -ti --privileged kamermans/docker-megacli

      MegaCLI SAS RAID Management Tool  Ver 8.07.14 Dec 16, 2013
      Storage Command Line Tool  Ver 1.03.11 Jan 30, 2013

[root@ed2f45d425f2 megacli]#
```

You are dropped into the `/megacli` directory, which has lots of helpful scripts in it
to get you going:

```
[root@ed2f45d425f2 megacli]# ls -1
list_adapters
list_drive_summary
list_enclosures
list_logical_drives
list_physical_drives
list_physical_drives_summary
lsi.sh
show_battery_status
show_cheat_sheet_urls
show_event_log
show_full_config
show_summary
show_system_info
silence_alarm
start_bbu_learn
update_time_from_system
```

> Note: All of the scripts are non-destructive, they simply show you information about
> your RAID Controller or perform non-destructive actions (setting the date/time, starting
> a BBU learn cycle, silencing alarms, etc).

This directory (`/megacli`) is in your `PATH`, so you can run those commands from anywhere.
You should probably start by taking a look at the controller summary:

```
[root@ed2f45d425f2 megacli]# show_summary

System
        Operating System:  Linux version 3.16.0-49-generic
        Driver Version: 06.803.01.00-rc1
        CLI Version: 8.07.14

Hardware
        Controller
                 ProductName       : PERC H700 Integrated(Bus 0, Dev 0)
                 SAS Address       : 5782bcb0204ea700
                 FW Package Version: 12.3.0-0032
                 Status            : Need Attention
        BBU
                 BBU Type          : BBU
                 Status            : Replace Battery pack        PD
```

Well, it seems my battery (BBU) is dead, great.

Let's see how this script works:

```
[root@ed2f45d425f2 megacli]# cat show_summary
#!/bin/sh -e

MegaCli -ShowSummary -aALL
```

As you can see, these scripts are mostly one-liners that you could also run manually.

You can get a full list of the MegaCLI commands with `man megacli`.  It is a huge,
virtually-uncommented list of commands, so you probably want to check out a cheat
sheet for more information, so try `show_cheat_sheet_urls`:

```
[root@ed2f45d425f2 megacli]# show_cheat_sheet_urls
https://calomel.org/megacli_lsi_commands.html
http://erikimh.com/megacli-cheatsheet/
https://things.maths.cam.ac.uk/computing/docs/public/megacli_raid_lsi.html
http://www.vmwareadmins.com/megacli-working-examples-cheat-sheet/
http://hwraid.le-vert.net/wiki/LSIMegaRAIDSAS
```

### The lsi.sh script
There is a script included called `lsi.sh`, which comes from [calomel.org](https://calomel.org/megacli_lsi_commands.html) and can be used for some more advanced things.

You can run `./lsi.sh` with no arguments to see the options available:
```
            OBPG  .:.  lsi.sh
-----------------------------------------------------
status        = Status of Virtual drives (volumes)
drives        = Status of hard drives
ident $slot   = Blink light on drive (need slot number)
good $slot    = Simply makes the slot "Unconfigured(good)" (need slot number)
replace $slot = Replace "Unconfigured(bad)" drive (need slot number)
progress      = Status of drive rebuild
errors        = Show drive errors which are non-zero
bat           = Battery health and capacity
batrelearn    = Force BBU re-learn cycle
logs          = Print card logs
checkNemail   = Check volume(s) and send email on raid errors
allinfo       = Print out all settings and information about the card
settime       = Set the raid card's time to the current system time
setdefaults   = Set preferred default settings for new raid setup
```

> Note: `lsi.sh` is maintained by calomel.org.  Since I didn't write it or code-review it, it may be capable of destructive actions!

## Updating the container
You can update this container with `docker pull`:

    docker pull kamermans/docker-megacli

