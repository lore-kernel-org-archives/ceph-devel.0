From: Thomas Mueller <thomas@chaschperli.ch>
Subject: mds crash on snaptest-2
Date: Mon, 19 Jul 2010 14:57:56 +0000 (UTC)
Message-ID: <i21p5k$fma$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46020 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935663Ab0GSO6I (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Jul 2010 10:58:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OarnB-0004aY-Q8
	for ceph-devel@vger.kernel.org; Mon, 19 Jul 2010 16:58:05 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jul 2010 16:58:05 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jul 2010 16:58:05 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

the ceph.git/unstable cmds gets killed by my snaptest-2 (http://
github.com/vinzent/ceph-testsuite/blob/master/tests/snaptest-2) with ceph-
client-standalone/unstable-backport on kernel 2.6.34.1. I can reproduce 
the behaviour.

it somewhere happens on the "Delete the snapshots..." phase.


kernel log:
[ 2024.315441] ceph: client4102 fsid ab2d5e45-9f53-7764-c958-c099f5be6e33
[ 2024.316111] ceph: mon0 127.0.0.1:6789 session established
[ 3753.964099] ceph:  tid 11109 timed out on osd0, will reset osd
[ 4054.056374] ceph:  tid 15029 timed out on osd0, will reset osd
[ 4098.646013] ceph: mds0 127.0.0.1:6802 socket closed
[ 4099.804937] ceph: mds0 127.0.0.1:6802 connection failed
[ 4100.804629] ceph: mds0 127.0.0.1:6802 connection failed
[ 4101.804638] ceph: mds0 127.0.0.1:6802 connection failed
[ 4103.804636] ceph: mds0 127.0.0.1:6802 connection failed
[ 4107.804381] ceph: mds0 127.0.0.1:6802 connection failed
[ 4115.804644] ceph: mds0 127.0.0.1:6802 connection failed
[ 4131.804387] ceph: mds0 127.0.0.1:6802 connection failed
[ 4144.804343] ceph: mds0 caps stale
[ 4159.806936] ceph: mds0 caps stale
[ 4163.804149] ceph: mds0 127.0.0.1:6802 connection failed

there is no cmds segfault message, but cmds process has gone.

- Thomas

