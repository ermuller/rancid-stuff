# vdxrancid
This is a slightly updated version of VDXrancid, forked from 
[buraglio/vdxrancid](https://github.com/buraglio/vdxrancid) and incorporating
a few updates, fixes, and cleanups.
My goal is to get this cleaned up and submitted back into mainline rancid.
This code is copyleft per the standard rancid license terms.

I've tested this successfully on a handful of VDX6720s on NOS 4.0.0 and 4.0.1,
but not much else.

Please note that this is a work in progress, and is not intended for long-term
support.  If you're using this code from this source, you're doing so at
your own risk (it works for me, but is likely to become outdated quickly,
and it hasn't been widely tested).  But if you do use it, I'd appreciate
feedback.


# Aerohive Rancid
Also, basic aerohive support is added here via the "ahlogin" and "ahrancid"
scripts.
These are based on clogin/rancid from 2.3.8.
login diffs are mainly just to send "console page 0" and to handle the
"config changed, save?" prompts.

This has been running in production for several years, though only
on a single deployment of AP170s - other models should work, but have
not been tested.  Likewise, aerohive switches should be supported, but are
untested.

# Alcatel-Lucent Rancid
Also based on [Nick Buraglio's earlier work](https://github.com/buraglio/alurancid),
this provides some basic support for Nokia-Alcatel-Lucent TiMOS/SROS.
It's not super-polished yet, but should be functional and stable.
This has been tested on a handful of 7750s on 12.0R6, but should work on
7750, 7950, 7450, and other similar boxes in that family.

