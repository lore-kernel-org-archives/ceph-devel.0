From: Sage Weil <sage@newdream.net>
Subject: Re: OOM's on the Ceph client machine
Date: Wed, 13 Oct 2010 10:42:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010131029480.7988@cobra.newdream.net>
References: <E1P5pFk-0001oE-Mv@tytso-glaptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60194 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab0JMRjo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Oct 2010 13:39:44 -0400
In-Reply-To: <E1P5pFk-0001oE-Mv@tytso-glaptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: ceph-devel@vger.kernel.org, mrubin@google.com

Hi Ted,

On Tue, 12 Oct 2010, Theodore Ts'o wrote:
> P.S.  In case people are curious, here are the results of the "boxacle"
> (http://btrfs.boxacle.net) FFSB workloads that I ran.  The results are
> fairly stable, except very often the 8 thread random_write workload is a
> little hard to reproduce because it very often OOM's.  I've never gotten
> a 32 thread random_write workload measurement, since it very reliably
> OOM's on my client machine.  
> 
> Do these results look reasonable to you?  I confess I'm a little
> disappointed with the sequential and random read numbers in particular.
> And given 10 servers and fifty spindles, even the large_file_create
> numbers seems surprising slow.
> 
> (Also, given the we are using gigabit ethernet in this evaluation
> cluster, the 1GB/sec seems ridiculously high, which suggests to me that
> the fsync request wasn't honored -- FFSB includes the fsync time when
> calculating write bandwidth -- and it may explain why we are OOM'ing in
> the random_write workload.)
> 
>                     1 thread           8 threads            32 threads 
> large_file_create   101 MB/sec         102 MB/sec           101 MB/sec 

These may be a bit below the ceiling imposed by the gigabit ethernet 
because of the combined journaling disk; effectively all writes for the 
whole host were going to the same spindle.  Please try distributing the 
journals across the spindles.

> sequential_reads     35 MB/sec         113 MB/sec           114 MB/sec 

These are mostly reasonable.  The single thread performance is primarily 
governed by the MM readahead behavior.  There is a mount option tunable to 
adjust the max readahead on the BDI: rsize=<bytes> (the default is only 
512KB, IIRC).  Some users have reported improved read performance with a 
larger rsize, but it's not something we've had time to tune ourselves.

> random_reads          1.48 MB/sec        5.44 MB/sec        11.7 MB/sec 

This one looks way too slow.  I'm going to run this locally and see what 
is going on.

> random_writes      923 MB/sec           1.09 GB/sec             (*) 

And there is definitely something wrong here with the client.  :)  Let's 
see what happens with the latest mainline!

sage


> 
> For comparison, here are the FFSB numbers on a single local ext4 disk
> with no journal:
> 
>                     1 thread           8 threads            32 threads 
> large_file_create   75.5 MB/sec        72.2 MB/sec	    74.2 MB/sec
> sequential_reads    77.2 MB/sec	       69.2 MB/sec	    70.3 MB/sec
> random_reads        734 K/sec	       537 K/sec	    537 K/sec
> random_writes       44.5 MB/sec	       41.5 MB/sec	    41.6 MB/sec
> 
> It's very possible that I may have done something wrong, so I've
> enclosed the ceph.conf file I used for doing this test run....  please
> let me know if there's something I've screwed up.
> 
> ---------------------------- random_write.32.ffsb
> # Large file random writes.
> # 1024 files, 100MB per file.
> 
> time=300  # 5 min
> alignio=1
> 
> [filesystem0]
> 	location=/mnt/ffsb1
> 	num_files=1024
> 	min_filesize=104857600  # 100 MB
> 	max_filesize=104857600
> 	reuse=1
> [end0]
> 
> [threadgroup0]
> 	num_threads=32
> 
> 	write_random=1
> 	write_weight=1
> 
> 	write_size=5242880  # 5 MB
> 	write_blocksize=4096
> 
> 	[stats]
> 		enable_stats=1
> 		enable_range=1
> 
> 		msec_range    0.00      0.01
> 		msec_range    0.01      0.02
> 		msec_range    0.02      0.05
> 		msec_range    0.05      0.10
> 		msec_range    0.10      0.20
> 		msec_range    0.20      0.50
> 		msec_range    0.50      1.00
> 		msec_range    1.00      2.00
> 		msec_range    2.00      5.00
> 		msec_range    5.00     10.00
> 		msec_range   10.00     20.00
> 		msec_range   20.00     50.00
> 		msec_range   50.00    100.00
> 		msec_range  100.00    200.00
> 		msec_range  200.00    500.00
> 		msec_range  500.00   1000.00
> 		msec_range 1000.00   2000.00
> 		msec_range 2000.00   5000.00
> 		msec_range 5000.00  10000.00
> 	[end]
> [end0]
> ------------------------------------------------ My ceph.conf file
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
