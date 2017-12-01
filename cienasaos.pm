package cienasaos;
##
## $Id: wavesvros.pm.in 3242 2016-01-27 20:14:23Z heas $
##
## @PACKAGE@ @VERSION@
@copyright@
#
#  RANCID - Really Awesome New Cisco confIg Differ
#
#  wavesvros.pm - Ciena Waveserver rancid procedures
#

use 5.010;
use strict 'vars';
use warnings;
require(Exporter);
our @ISA = qw(Exporter);
$Exporter::Verbose=1;

use rancid 3.3.0;

@ISA = qw(Exporter rancid main);
#our @EXPORT = qw($VERSION)

# load-time initialization
sub import {
    $timeo = 120;			# jlogin timeout in seconds

    0;
}

# post-open(collection file) initialization
sub init {
    # add content lines and separators
    ProcessHistory("","","","!RANCID-CONTENT-TYPE: $devtype\n!\n");

    # flag for SAOS
    $wavesvros::saos = 0;

    0;
}

# main loop of input of device output
sub inloop {
    my($INPUT, $OUTPUT) = @_;
    my($cmd, $rval);

TOP: while (<$INPUT>) {
	tr/\015//d;
	s/^(\x1b\x5b.)//;
	if (/^Error:/) {
	    print STDOUT ("$host hlogin error: $_");
	    print STDERR ("$host hlogin error: $_") if ($debug);
	    $clean_run=0;
	    last;
	}
	if (/System shutdown message/) {
	    print STDOUT ("$host shutdown msg: $_");
	    print STDERR ("$host shutdown msg: $_") if ($debug);
	    $clean_run = 0;
	    last;
	}
	if (/error: cli version does not match Managment Daemon/i) {
	    print STDOUT ("$host mgd version mismatch: $_");
	    print STDERR ("$host mgd version mismatch: $_") if ($debug);
	    $clean_run = 0;
	    last;
	}
	while (/>\s*($cmds_regexp)\s*$/) {
	    $cmd = $1;
	    if (!defined($prompt)) {
		$prompt = ($_ =~ /^([^>]+>)/)[0];
		$prompt =~ s/([][}{)(\\])/\\$1/g;
		# prompt changes when config is unsaved - "foo*> "
		$prompt =~ s/\*/\\\*/;
		print STDERR ("PROMPT MATCH: $prompt\n") if ($debug);
	    }
	    print STDERR ("HIT COMMAND:$_") if ($debug);
	    if (! defined($commands{$cmd})) {
		print STDERR "$host: found unexpected command - \"$cmd\"\n";
		$clean_run = 0;
		last TOP;
	    }
	    if (! defined(&{$commands{$cmd}})) {
		printf(STDERR "$host: undefined function - \"%s\"\n",  
		       $commands{$cmd});
		$clean_run = 0;
		last TOP;
	    }
	    $rval = &{$commands{$cmd}}($INPUT, $OUTPUT, $cmd);
	    delete($commands{$cmd});
	    if ($rval == -1) {
		$clean_run = 0;
		last TOP;
	    }
	}
	if (/>\s*exit/) {
	    $clean_run=1;
	    last;
	}
    }
}

# This routine parses "chassis show"
sub ShowChassis {
    my($INPUT, $OUTPUT, $cmd) = @_;
    print STDERR "    In ShowChassis: $_" if ($debug);

    # include the command
    s/^[a-z]+@//; s/^([^ ]+)\*>/$1>/;
    ProcessHistory("","","","! $_");
    while (<$INPUT>) {
	tr/\015//d;
	s/^(\x1b\x5b.)//;
# because why not embed ansi control seqs in your output, inline with prompt?
	last if (/^$prompt/);
#if (/$prompt/) { print STDERR "saw prompt and ignored it? [".hexdump($_)."]\n";}
	/no matching entry found/ && return(-1);	# unknown cmd

	# skip fan status
	if (/(CFU FAN|FAN SPEED|TEMPERATURE) STATUS/) {
	    while (<$INPUT>) {
		tr/\015//d;
		return(-1) if (/^$prompt/);
		last if (/^\s*$/);
	    }
	    return(-1) if (/^$prompt/);
	}

	ProcessHistory("","","","! $_");
    }
    return(0);
}


# This routine parses "software show"
sub ShowVersion {
    my($INPUT, $OUTPUT, $cmd) = @_;
    print STDERR "    In ShowVersion: $_" if ($debug);

    # include the command
    s/^[a-z]+@//; s/^([^ ]+)\*>/$1>/;
    ProcessHistory("","","","! $_");
    if (0) {
	#TODO: WaveServer stuff here should be updated to match something
	# specific if this is to be compatible with both Wave and SAOS
	# Skipping this for now as this breaks SAOS parsing.
	# skip software state info
	while (<$INPUT>) {
	    tr/\015//d;
	    return(0) if (/^$prompt/);
	    /no matching entry found/ && return(-1);        # unknown cmd

	    last if (/^\s*$/);
	}
    }
    while (<$INPUT>) {
	tr/\015//d;
	s/^(\x1b\x5b.)//;

	last if (/^$prompt/);
	$wavesvros::saos = 1 if (/Running Package *: saos-/);

	if (/Bank status\s+:\s+.*\s+/) {
	    s/(\(validated\s+\d+hr\s+\d+min\s+\d+sec ago\))/" " x length($1)/e;
	}

	ProcessHistory("","","","! $_");
    }
    ProcessHistory("","","","!\n");

    return(0);
}

# This routine parses "configuration show"
sub WriteTerm {
    my($INPUT, $OUTPUT, $cmd) = @_;
    my($linecnt) = 0;
    my($snmp) = 0;
    print STDERR "    In ShowConfiguration: $_" if ($debug);

    # include the command
    s/^[a-z]+@//; s/^([^ ]+)\*>/$1>/;
    ProcessHistory("","","","! $_");
    while (<$INPUT>) {
	tr/\015//d;
	s/^(\x1b\x5b.)//;
	last if (/^$prompt/);
	/no matching entry found/ && return(-1);	# unknown cmd

	next if (/^! created( by)?: /i);
	next if (/^! on terminal: /i);
	next if (/^! defaults: /i);

#	# filter snmp community, when in snmp { stanza }
#	/^snmp/ && $snmp++;
#	/^}/ && ($snmp = 0);
#	if ($snmp && /^(\s*)(community|trap-group) [^ ;]+(\s?[;{])$/) {
#		if ($filter_commstr) {
#		    $_ = "$1$2 \"<removed>\"$3\n";
#		}
#	}
#	if (/(\s*authentication-key )[^ ;]+/ && $filter_pwds >= 1) {
#	    ProcessHistory("","","","#$1<removed>$'");
#	    next;
#	}
	if (/(user create user \S+ access-level \S+ secret) / &&
	    $filter_pwds >= 1) {
	    ProcessHistory("","","","!$1<removed>\n");
	    next;
	}
#	if (/(\s*hello-authentication-key )[^ ;]+/ && $filter_pwds >= 1) {
#	    ProcessHistory("","","","#$1<removed>$'");
#	    next;
#	}
#	# don't filter this one - there is no secret here.
#	if (/^\s*permissions .* secret /) {
#	    ProcessHistory("","","","$_");
#	    next;
#	}
#	if (/^(.*\s(secret|simple-password) )[^ ;]+/ && $filter_pwds >= 1) {
#	    ProcessHistory("","","","#$1<removed>$'");
#	    next;
#	}
#	if (/(\s+encrypted-password )[^ ;]+/ && $filter_pwds >= 2) {
#	    ProcessHistory("","","","#$1<removed>$'");
#	    next;
#	}
#	if (/(\s+ssh-(rsa|dsa) )\"/ && $filter_pwds >= 2) {
#	    ProcessHistory("","","","#$1<removed>;\n");
#	    next;
#	}
#	if (/^(\s+(pre-shared-|)key (ascii-text|hexadecimal) )[^ ;]+/ && $filter_pwds >= 1) {
#	    ProcessHistory("","","","#$1<removed>$'");
#	    next;
#	}
	if (/^! END OF CONFIG:/) {
	    $found_end = 1;
	}
	ProcessHistory("","","","$_");
	$linecnt++;
    }
    if ($wavesvros::saos) {
	# SAOS cienas lack a definitive "end of config" marker.
	if ($linecnt > 5) {
	    $found_end = 1;
	    return(1);
	}
    }

    return(0);
}

1;
