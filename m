From: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Subject: reads while 100% write
Date: Wed, 30 Mar 2016 02:35:09 +0000
Message-ID: <D320896C.C4F8%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0086.outbound.protection.outlook.com ([157.56.110.86]:30896
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751917AbcC3FIC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 01:08:02 -0400
Content-Language: en-US
Content-ID: <4543C1FE25C21041ABFF289FEECDEF06@namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

After pulling master branch on Friday I start seeing odd fio behavior, =
I
see a lot of reads while writing and very low performance no matter
whether it read or write workload.

Output from sequential 1M write:
Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq=
-sz
avgqu-sz   await r_await w_await  svctm  %util

sdd               0.00   409.00    0.00  364.00     0.00  3092.00    16=
=2E99
    0.28    0.78    0.00    0.78   0.76  27.60
sde               0.00   242.00  365.00  363.00  2436.00  9680.00    33=
=2E29
    0.18    0.24    0.42    0.07   0.23  16.80



block.db -> /dev/sdd
block -> /dev/sde

health HEALTH_OK
monmap e1: 1 mons at {a=3D127.0.0.1:6789/0}
       election epoch 3, quorum 0 a
osdmap e7: 1 osds: 1 up, 1 in
       flags sortbitwise
pgmap v24: 64 pgs, 1 pools, 577 MB data, 9152 objects
       8210 MB used, 178 GB / 186 GB avail
             64 active+clean
client io 1550 kB/s rd, 9559 kB/s wr, 645 op/s rd, 387 op/s wr


While on earlier revision(c1e41af) everything looks as expected:

Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq=
-sz
avgqu-sz   await r_await w_await  svctm  %util
sdd               0.00  4910.00    0.00  680.00     0.00 22416.00    65=
=2E93
    1.05    1.55    0.00    1.55   1.18  80.00
sde               0.00     0.00    0.00 3418.00     0.00 217612.00
127.33    63.78   18.18    0.00   18.18   0.25  86.40

Other observation, may be related to the issue, is that CPU load is
imbalanced. Single =B3tp_osd_tp=B2 thread is 100% busy, while the rest =
is idle.
Looks like all load goes to single thread pool shard, earlier CPU was w=
ell
balanced.


=8B
Evgeniy



PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
