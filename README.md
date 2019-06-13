# Some Rancid stuff
This repo has a few tweaks or enhancements to [rancid](http://shrubbery.net/rancid) that aren't in the main
distribution.  Hopefully they will be someday.  They should all work in 2.3.8 or 3.x,
unless otherwise noted.  Sample tweaks to rancid-fe and rancid.types.conf are here, 
but I can't provide much more support than that on how to use/integrate (ie,
if you don't know how to use this, it's probably not right for you).

Please note that this is a work in progress, and is not intended for long-term
support.  If you're using this code from this source, you're doing so at
your own risk (it works for me, but is likely to become outdated quickly,
and it hasn't been widely tested).  But if you do use it, I'd really
appreciate any feedback.
My goal is to get this all cleaned up and submitted back into mainline rancid.
This code is copyleft per the standard rancid license terms.

## vdxrancid
This is a slightly updated version of VDXrancid, forked from 
[buraglio/vdxrancid](https://github.com/buraglio/vdxrancid) and incorporating
a few updates, fixes, and cleanups.  It should work with an unmodified clogin.

I've tested this successfully on a handful of VDX6720s on NOS 4.0.0 and 4.0.1,
but not much else.

## Ciena SAOS
This platform looks a lot like the Waveserver stuff (wavesvros), but seems
to be not quite the same.  This module _should_ support SAOS while being
backward-compatible with the waveserver stuff.  Without access to the other
to test though, I'm keeping this separate for now.
Tested with a number of 3904/3942s on 6.14.

## MRV updates
MRV OptiDrivers have a nice simple cisco-style config system... except that
it's incomplete.  Some settings such as amplifier gain or channel assignments
on tunable optics are applied as normal config changes, but are only stored
in nvram on the affected module, with no record in the master config.  I've
added some port parsing so there's at least a record of what these stealth
config items are set to.  "show ports" gives channel ID for tunables, and
EDFA gain settings.  "show plugins" provides requested tx power on tunables.
And mrvlogin gets an update to handle the wider screens needed for these.
Production tested on OD v5.12.
Note that rancid user needs at least super perms to collect running config.

## MRV LX support
MRV's LX devices run a totally different OS than the other families.  This
adds basic support for them via a new "mrvlx" platform, with separate
mrvlxlogin and mrvlxrancid scripts (login can probably be merged with
mrvlogin, but the pager and prompt differences are annoying enough that
I didn't want to mess with it this week).  mrvlxrancid grabs the basic
hardware info you'd expect, as well as a copy of the internal config file
it uses - it's editable, readable, and restorable, but not copy-n-pasteable.
Production tested on LX-40xx 6.2.1

## FXOS stuff
Cisco FXOS is a terrible thing.  Avoid it.
But sometimes you can't avoid it.  With FPR2100 appliances, running FTD code,
initial support is provided in mainline rancid 3.9.  FPR2100s running ASA
code are, of course, totally different.  Some beta support for those is here.
Note that the ASA component still looks pretty much like a classic ASA, it's
just the FPR platform support via the fxos manager that's missing, and added
in here.  For these devices, you'll have two separate devices being monitored:
the ASA, and the FXOS underlay.
Other FPR platforms (4xxx,9xxx) are still more different, and are not yet
supported.


# Deprecated stuff
These bits are no longer maintained, and either supplanted by official
support, or it's been so long since I've used/tested them that I can't
give any sort of confident suggestion that they should work. 

## Aerohive Rancid
*Note* - this is old and you probably don't want to use it - I no longer have
access to any Aerohive environment for further development or testing.
You should probably check out [inphobia/rancid-aerohive-support](https://github.com/inphobia/rancid-aerohive-support) instead.

Basic aerohive support is added here via the "ahlogin" and "ahrancid"
scripts.
These are based on clogin/rancid from 2.3.8.
The login diffs are mainly just to send "console page 0" and to handle the
"config changed, save?" prompts.

This has been running in production for several years, though only
on a single deployment of AP170s - other models should work, but have
not been tested.  Likewise, aerohive switches should be supported, but are
untested.

## Nokia/Alcatel-Lucent Rancid
Old SROS 7750 alcatel support stuff can be found in ermuller/alurancid.  (This is deprecated and replaced/merged with official RANCID support in 3.7)

