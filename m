From: Chris Dunlop <chris@onthe.net.au>
Subject: Mon losing touch with OSDs
Date: Fri, 15 Feb 2013 14:29:39 +1100
Message-ID: <20130215032939.GA25578@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:53309 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322Ab3BOD3o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 22:29:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id D8FB260E5B
	for <ceph-devel@vger.kernel.org>; Fri, 15 Feb 2013 14:29:42 +1100 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U5UwhhZTkaEH for <ceph-devel@vger.kernel.org>;
	Fri, 15 Feb 2013 14:29:41 +1100 (EST)
Received: from o1.office.otn.net.au (unknown [180.148.179.26])
	by smtp1.onthe.net.au (Postfix) with ESMTP id B719660E10
	for <ceph-devel@vger.kernel.org>; Fri, 15 Feb 2013 14:29:39 +1100 (EST)
Received: from achates.office.onthe.net.au (achates.office.onthe.net.au [10.1.32.53])
	by o1.office.otn.net.au (Postfix) with ESMTP id 0EC1B2AB072
	for <ceph-devel@vger.kernel.org>; Fri, 15 Feb 2013 14:30:25 +1100 (EST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

G'day,

In an otherwise seemingly healthy cluster (ceph 0.56.2), what might cause the
mons to lose touch with the osds?

I imagine a network glitch could cause it, but I can't see any issues in any
other system logs on any of the machines on the network.

Having (mostly?) resolved my previous "slow requests" issue
(http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/13076) at around
13:45, there were no problems until the mon lost osd.0 at 20:26 and lost osd.1
5 seconds later:

ceph-mon.b2.log:
2013-02-14 20:11:19.892060 7fa48d4f8700  0 log [INF] : pgmap v2822096: 576 pgs: 576 active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail
2013-02-14 20:11:21.719513 7fa48d4f8700  0 log [INF] : pgmap v2822097: 576 pgs: 576 active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail
2013-02-14 20:26:20.656162 7fa48dcf9700 -1 mon.b2@0(leader).osd e768 no osd or pg stats from osd.0 since 2013-02-14 20:11:19.720812, 900.935345 seconds ago.  marking down
2013-02-14 20:26:20.780244 7fa48d4f8700  1 mon.b2@0(leader).osd e769 e769: 2 osds: 1 up, 2 in
2013-02-14 20:26:20.837123 7fa48d4f8700  0 log [INF] : osdmap e769: 2 osds: 1 up, 2 in
2013-02-14 20:26:20.947523 7fa48d4f8700  0 log [INF] : pgmap v2822098: 576 pgs: 304 active+clean, 272 stale+active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail
2013-02-14 20:26:25.709341 7fa48dcf9700 -1 mon.b2@0(leader).osd e769 no osd or pg stats from osd.1 since 2013-02-14 20:11:21.523741, 904.185596 seconds ago.  marking down
2013-02-14 20:26:25.822773 7fa48d4f8700  1 mon.b2@0(leader).osd e770 e770: 2 osds: 0 up, 2 in
2013-02-14 20:26:25.863493 7fa48d4f8700  0 log [INF] : osdmap e770: 2 osds: 0 up, 2 in
2013-02-14 20:26:25.954799 7fa48d4f8700  0 log [INF] : pgmap v2822099: 576 pgs: 576 stale+active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail
2013-02-14 20:31:30.772360 7fa48dcf9700  0 log [INF] : osd.1 out (down for 304.933403)
2013-02-14 20:31:30.893521 7fa48d4f8700  1 mon.b2@0(leader).osd e771 e771: 2 osds: 0 up, 1 in
2013-02-14 20:31:30.933439 7fa48d4f8700  0 log [INF] : osdmap e771: 2 osds: 0 up, 1 in
2013-02-14 20:31:31.055408 7fa48d4f8700  0 log [INF] : pgmap v2822100: 576 pgs: 576 stale+active+clean; 407 GB data, 417 GB used, 1444 GB / 1862 GB avail
2013-02-14 20:35:05.831221 7fa48dcf9700  0 log [INF] : osd.0 out (down for 525.033581)
2013-02-14 20:35:05.989724 7fa48d4f8700  1 mon.b2@0(leader).osd e772 e772: 2 osds: 0 up, 0 in
2013-02-14 20:35:06.031409 7fa48d4f8700  0 log [INF] : osdmap e772: 2 osds: 0 up, 0 in
2013-02-14 20:35:06.129046 7fa48d4f8700  0 log [INF] : pgmap v2822101: 576 pgs: 576 stale+active+clean; 407 GB data, 0 KB used, 0 KB / 0 KB avail

The other 2 mons both have messages like this in their logs, starting at around 20:12:

2013-02-14 20:12:26.534977 7f2092b86700  0 -- 10.200.63.133:6789/0 >> 10.200.63.133:6800/6466 pipe(0xade76500 sd=22 :6789 s=0 pgs=0 cs=0 l=1).accept replacing existing (lossy) channel (new one lossy=1)
2013-02-14 20:13:24.741092 7f2092d88700  0 -- 10.200.63.133:6789/0 >> 10.200.63.132:6800/2456 pipe(0x9f8b7180 sd=28 :6789 s=0 pgs=0 cs=0 l=1).accept replacing existing (lossy) channel (new one lossy=1)
2013-02-14 20:13:56.551908 7f2090560700  0 -- 10.200.63.133:6789/0 >> 10.200.63.133:6800/6466 pipe(0x9f8b6000 sd=41 :6789 s=0 pgs=0 cs=0 l=1).accept replacing existing (lossy) channel (new one lossy=1)
2013-02-14 20:14:24.752356 7f209035e700  0 -- 10.200.63.133:6789/0 >> 10.200.63.132:6800/2456 pipe(0x9f8b6500 sd=42 :6789 s=0 pgs=0 cs=0 l=1).accept replacing existing (lossy) channel (new one lossy=1)

(10.200.63.132 is mon.b4/osd.0, 10.200.63.133 is mon.b5/osd.1)

...although Greg Farnum indicates these messages are "normal":

http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/5989/focus=5993

Osd.0 doesn't show any signs of distress at all:

ceph-osd.0.log:
2013-02-14 20:00:10.280601 7ffceb012700  0 log [INF] : 2.7e scrub ok
2013-02-14 20:14:19.923490 7ffceb012700  0 log [INF] : 2.5b scrub ok
2013-02-14 20:14:50.571980 7ffceb012700  0 log [INF] : 2.7b scrub ok
2013-02-14 20:17:48.475129 7ffceb012700  0 log [INF] : 2.7d scrub ok
2013-02-14 20:28:22.601594 7ffceb012700  0 log [INF] : 2.91 scrub ok
2013-02-14 20:28:32.839278 7ffceb012700  0 log [INF] : 2.92 scrub ok
2013-02-14 20:28:46.992226 7ffceb012700  0 log [INF] : 2.93 scrub ok
2013-02-14 20:29:12.330668 7ffceb012700  0 log [INF] : 2.95 scrub ok

...although osd.1 started seeing problems around this time:

ceph-osd.1.log:
2013-02-14 20:03:11.413352 7fd1d8f0a700  0 log [INF] : 2.23 scrub ok
2013-02-14 20:26:51.601425 7fd1e6f26700  0 log [WRN] : 6 slow requests, 6 included below; oldest blocked for > 30.750063 secs
2013-02-14 20:26:51.601432 7fd1e6f26700  0 log [WRN] : slow request 30.750063 seconds old, received at 2013-02-14 20:26:20.851304: osd_op(client.9983.0:28173 xxx.rbd [watch 1~0] 2.10089424) v4 currently wait for new map
2013-02-14 20:26:51.601437 7fd1e6f26700  0 log [WRN] : slow request 30.749947 seconds old, received at 2013-02-14 20:26:20.851420: osd_op(client.10001.0:618473 yyyyyy.rbd [watch 1~0] 2.3854277a) v4 currently wait for new map
2013-02-14 20:26:51.601440 7fd1e6f26700  0 log [WRN] : slow request 30.749938 seconds old, received at 2013-02-14 20:26:20.851429: osd_op(client.9998.0:39716 zzzzzz.rbd [watch 1~0] 2.71731007) v4 currently wait for new map
2013-02-14 20:26:51.601442 7fd1e6f26700  0 log [WRN] : slow request 30.749907 seconds old, received at 2013-02-14 20:26:20.851460: osd_op(client.10007.0:59572 aaaaaa.rbd [watch 1~0] 2.320eebb8) v4 currently wait for new map
2013-02-14 20:26:51.601445 7fd1e6f26700  0 log [WRN] : slow request 30.749630 seconds old, received at 2013-02-14 20:26:20.851737: osd_op(client.9980.0:86883 bbbbbb.rbd [watch 1~0] 2.ab9b579f) v4 currently wait for new map

Perhaps the mon lost osd.1 because it was too slow, but that hadn't happened in
any of the many previous "slow requests" intances, and the timing doesn't look
quite right: the mon complains it hasn't heard from osd.0 since 20:11:19, but
the osd.0 log shows nothing problems at all, then the mon complains about not
having heard from osd.1 since 20:11:21, whereas the first indication of trouble
on osd.1 was the request from 20:26:20 not being processed in a timely fashion.

No knowing enough about how the various pieces of ceph talk to each other
makes it difficult to distinguish cause and effect!

Trying to manually set the osds in (e.g. ceph osd in 0) didn't help, nor did
restarting the osds ('service ceph restart osd' on each osd host).

The immediate issue was resolved by restarting ceph completely on one of the
mon/osd hosts (service ceph restart). Possibly a restart of just the mon would
have been sufficient.

Cheers,

Chris
