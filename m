From: Thomas Mueller <thomas@chaschperli.ch>
Subject: PATCH: extend man page mount.ceph.8 with available options
Date: Mon, 28 Jun 2010 05:51:21 +0000 (UTC)
Message-ID: <i09d8p$qic$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50048 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497Ab0F1Fvd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Jun 2010 01:51:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OT7Fj-00068T-34
	for ceph-devel@vger.kernel.org; Mon, 28 Jun 2010 07:51:31 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jun 2010 07:51:31 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jun 2010 07:51:31 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

i was searching the mount options in the code. i've extended
the man page of mount.ceph.8 with my findings.

* i've excludede fsidmajor and fsidminor as i really don't known 
what they do 

* excluded monport as it seems not to be use anywhere in the code.

* for dirstat and nodirstat i don't know which of the both
is enabled by default.

* rbytes/norbytes - same as for dirstat and I don't know what the
switch does.

* "don't share client with other sbs" - what does "sbs" mean? (found
this one in the code)



- Thomas



diff --git a/man/mount.ceph.8 b/man/mount.ceph.8
index 996d68e..771b293 100644
--- a/man/mount.ceph.8
+++ b/man/mount.ceph.8
@@ -29,10 +29,125 @@ the time of mount.
 .PP
 A subdirectory \fIsubdir\fP may be specified if a subset of the file system is to be
 mounted.
+
 .SH OPTIONS
+
+wsize
+.IP
+int, ?
+.PP
+
+rsize
+.IP
+int (bytes), max readahead, multiple of 1024, Default: 524288 (512*1024)
+.PP
+
+osdtimeout
+.IP
+int (seconds), Default: 60
+.PP
+
+osdkeepalivetimeout
+.IP
+int, Default: 5
+.PP
+
+mount_timeout
+.IP
+int (seconds), Default: 60
+.PP
+
+osd_idle_ttl
+.IP
+int (seconds), Default: 60
+.PP
+
+caps_wanted_delay_min
+.IP
+int, cap release delay, Default: 5
+.PP
+
+caps_wanted_delay_max
+.IP
+int, cap release delay, Default: 60
+.PP
+
+cap_release_safety
+.IP
+int, Default: calculated
+.PP
+
+readdir_max_entries
+.IP
+int, Default: 1024
+.PP
+
+readdir_max_bytes
+.IP
+int, Default: 524288 (512*1024)
+.PP
+
+write_congestion_kb
+.IP
+int (kb), max writeback in flight. scale with available memory. Default: calculated from available memory
+.PP
+
 snapdirname
 .IP
-set the name of the hidden snapdir. Default: .snap
+string, set the name of the hidden snapdir. Default: .snap
+.PP
+
+name
+.IP
+string, used with authx, Default: guest
+.PP
+
+secret
+.IP
+string, used with authx 
+.PP
+
+ip
+.IP
+my ip
+.PP
+
+noshare
+.IP
+don't share client with other sbs
+.PP
+
+dirstat
+.IP
+funky `cat dirname` for stats
+.PP
+
+nodirstat
+.IP
+no funky `cat dirname` for stats
+.PP
+
+rbytes
+.IP
+?
+.PP
+
+norbytes
+.IP
+?
+.PP
+
+nocrc
+.IP
+no data crc on writes
+.PP
+
+noasyncreaddir
+.IP
+no dcache readdir
+.PP
+
+
 .SH EXAMPLES
 Mount the full file system:
 .IP

