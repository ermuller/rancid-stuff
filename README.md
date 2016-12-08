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


## Aerohive Rancid
Also, basic aerohive support is added here via the "ahlogin" and "ahrancid"
scripts.
These are based on clogin/rancid from 2.3.8.
The login diffs are mainly just to send "console page 0" and to handle the
"config changed, save?" prompts.

This has been running in production for several years, though only
on a single deployment of AP170s - other models should work, but have
not been tested.  Likewise, aerohive switches should be supported, but are
untested.

## Nokia/Alcatel-Lucent Rancid
SROS 7750 alcatel support stuff can be found in ermuller/alurancid

## Ciena SAOS
This platform looks a lot like the Waveserver stuff (wavesvros), but seems
to be not quite the same.  This module _should_ support SAOS while being
backward-compatible with the waveserver stuff.  Without access to the other
to test though, I'm keeping this separate for now.
Tested with a number of 3942s on 6.14
