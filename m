From: Sage Weil <sage@newdream.net>
Subject: Re: Why I try to run the "ceph" command line tool, it fails
Date: Tue, 9 Nov 2010 09:22:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011090921480.14309@cobra.newdream.net>
References: <E1PFrmt-0001IW-3c@tytso-glaptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35847 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0KIRS6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Nov 2010 12:18:58 -0500
In-Reply-To: <E1PFrmt-0001IW-3c@tytso-glaptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 9 Nov 2010, Theodore Ts'o wrote:
> ... with the error message:
> 
> "unable to find any monitors in conf".
> 
> What does this mean?  I assume it means that something must be wrong in
> my config file, but it's not at all obvious what *is* wrong.

Normally it means it can't find any 'mon addr' items in the [mon*] 
sections, but clearly you have them.  So either it's not finding the 
config (it's at /etc/ceph/ceph.conf?) or there is some parsing regression.  
What version are you running?  (`ceph -v`)

sage


> 
> Thanks, regards,
> 
> 							- Ted
> 
> ;
> ; This is the test ceph configuration file
> ;
> ; [tytso:20101007.0813EDT]
> ;
> ; This file defines cluster membership, the various locations
> ; that Ceph stores data, and any other runtime options.
> ;
> ; If a 'host' is defined for a daemon, the start/stop script will
> ; verify that it matches the hostname (or else ignore it).  If it is
> ; not defined, it is assumed that the daemon is intended to start on
> ; the current host (e.g., in a setup with a startup.conf on each
> ; node).
> 
> ; global
> [global]
> 	user = root
> 	pid file = /disk/sda3/tmp/ceph/$name.pid
> 	logger dir = /disk/sda3/tmp/ceph
> 	log dir = /disk/sda3/tmp/ceph
> 	chdir = /disk/sda3
> 
> ; monitors
> ;  You need at least one.  You need at least three if you want to
> ;  tolerate any node failures.  Always create an odd number.
> [mon]
> 	mon data = /disk/sda3/cephmon/data/mon$id
> 
> 	; logging, for debugging monitor crashes, in order of
> 	; their likelihood of being helpful :)
> 	;debug ms = 1
> 	;debug mon = 20
> 	;debug paxos = 20
> 	;debug auth = 20
> 
> [mon0]
> 	host = mach1
> 	mon addr = 1.2.3.4:6789
> 
> [mon1]
> 	host = mach2
> 	mon addr = 1.2.3.5:6789
> 
> [mon1]
> 	host = mach3
> 	mon addr = 1.2.3.6:6789
> 
> ; mds
> ;  You need at least one.  Define two to get a standby.
> [mds]
> 	; where the mds keeps it's secret encryption keys
> 	keyring = /data/keyring.$name
> 
> 	; mds logging to debug issues.
> 	;debug ms = 1
> 	;debug mds = 20
> 
> [mds.alpha]
> 	host = mach2
> 
> [mds.beta]
> 	host = mach3
> 
> [mds.gamma]
> 	host = mach1
> 
> ; osd
> ;  You need at least one.  Two if you want data to be replicated.
> ;  Define as many as you like.
> [osd]
> 	; osd logging to debug osd issues, in order of likelihood of being
> 	; helpful
> 	;debug ms = 1
> 	;debug osd = 20
> 	;debug filestore = 20
> 	;debug journal = 20
> 
> [osd0]
> 	host = mach10
> 	osd data = /disk/sdb3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdb3
> 
> [osd1]
> 	host = mach11
> 	osd data = /disk/sdb3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdb3
> 
> [osd2]
> 	host = mach12
> 	osd data = /disk/sdb3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdb3
> 
> [osd3]
> 	host = mach13
> 	osd data = /disk/sdb3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdb3
> 
> [osd4]
> 	host = mach14
> 	osd data = /disk/sdb3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdb3
> 
> [osd5]
> 	host = mach15
> 	osd data = /disk/sdb3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdb3
> 
> [osd6]
> 	host = mach16
> 	osd data = /disk/sdb3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdb3
> 
> [osd7]
> 	host = mach17
> 	osd data = /disk/sdb3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdb3
> 
> [osd8]
> 	host = mach18
> 	osd data = /disk/sdb3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdb3
> 
> [osd9]
> 	host = mach19
> 	osd data = /disk/sdb3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdb3
> 
> [osd10]
> 	host = mach10
> 	osd data = /disk/sdd3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdd3
> 
> [osd11]
> 	host = mach11
> 	osd data = /disk/sdd3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdd3
> 
> [osd12]
> 	host = mach12
> 	osd data = /disk/sdd3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdd3
> 
> [osd13]
> 	host = mach13
> 	osd data = /disk/sdd3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdd3
> 
> [osd14]
> 	host = mach14
> 	osd data = /disk/sdd3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdd3
> 
> [osd15]
> 	host = mach15
> 	osd data = /disk/sdd3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdd3
> 
> [osd16]
> 	host = mach16
> 	osd data = /disk/sdd3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdd3
> 
> [osd17]
> 	host = mach17
> 	osd data = /disk/sdd3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdd3
> 
> [osd18]
> 	host = mach18
> 	osd data = /disk/sdd3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdd3
> 
> [osd19]
> 	host = mach19
> 	osd data = /disk/sdd3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdd3
> 
> [osd20]
> 	host = mach10
> 	osd data = /disk/sde3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sde3
> 
> [osd21]
> 	host = mach11
> 	osd data = /disk/sde3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sde3
> 
> [osd22]
> 	host = mach12
> 	osd data = /disk/sde3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sde3
> 
> [osd23]
> 	host = mach13
> 	osd data = /disk/sde3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sde3
> 
> [osd24]
> 	host = mach14
> 	osd data = /disk/sde3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sde3
> 
> [osd25]
> 	host = mach15
> 	osd data = /disk/sde3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sde3
> 
> [osd26]
> 	host = mach16
> 	osd data = /disk/sde3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sde3
> 
> [osd27]
> 	host = mach17
> 	osd data = /disk/sde3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sde3
> 
> [osd28]
> 	host = mach18
> 	osd data = /disk/sde3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sde3
> 
> [osd29]
> 	host = mach19
> 	osd data = /disk/sde3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sde3
> 
> [osd30]
> 	host = mach10
> 	osd data = /disk/sdf3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdf3
> 
> [osd31]
> 	host = mach11
> 	osd data = /disk/sdf3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdf3
> 
> [osd32]
> 	host = mach12
> 	osd data = /disk/sdf3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdf3
> 
> [osd33]
> 	host = mach13
> 	osd data = /disk/sdf3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdf3
> 
> [osd34]
> 	host = mach14
> 	osd data = /disk/sdf3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdf3
> 
> [osd35]
> 	host = mach15
> 	osd data = /disk/sdf3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdf3
> 
> [osd36]
> 	host = mach16
> 	osd data = /disk/sdf3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdf3
> 
> [osd37]
> 	host = mach17
> 	osd data = /disk/sdf3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdf3
> 
> [osd38]
> 	host = mach18
> 	osd data = /disk/sdf3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdf3
> 
> [osd39]
> 	host = mach19
> 	osd data = /disk/sdf3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdf3
> 
> [osd40]
> 	host = mach10
> 	osd data = /disk/sdg3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdg3
> 
> [osd41]
> 	host = mach11
> 	osd data = /disk/sdg3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdg3
> 
> [osd42]
> 	host = mach12
> 	osd data = /disk/sdg3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdg3
> 
> [osd43]
> 	host = mach13
> 	osd data = /disk/sdg3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdg3
> 
> [osd44]
> 	host = mach14
> 	osd data = /disk/sdg3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdg3
> 
> [osd45]
> 	host = mach15
> 	osd data = /disk/sdg3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdg3
> 
> [osd46]
> 	host = mach16
> 	osd data = /disk/sdg3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdg3
> 
> [osd47]
> 	host = mach17
> 	osd data = /disk/sdg3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdg3
> 
> [osd48]
> 	host = mach18
> 	osd data = /disk/sdg3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdg3
> 
> [osd49]
> 	host = mach19
> 	osd data = /disk/sdg3/cephdata
> 	osd journal = /disk/sdc3/cephjnl.sdg3
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
