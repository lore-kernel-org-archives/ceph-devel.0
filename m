From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Question about PG::merge_log
Date: Thu, 10 Mar 2011 17:19:55 +0800
Message-ID: <AANLkTi=2gs+G+cd4SjVKFd5ZB7mwYQvk=DqoDPRneVp4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54125 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab1CJJT4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 04:19:56 -0500
Received: by gyh20 with SMTP id 20so566724gyh.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 01:19:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I was tracing the osd recovery code recently. I found that the
PG::merge_log function seems not working properly (see the logs in the
bottom).
The object 10000000fbf.0000046b should not be added to osd6's missing
list after osd6 merged osd3's log+backlog. I try to fix it as follows:

diff --git a/src/osd/PG.cc b/src/osd/PG.cc
index 2778591..671a37d 100644
--- a/src/osd/PG.cc
+++ b/src/osd/PG.cc
@@ -351,7 +351,8 @@ void PG::merge_log(ObjectStore::Transaction& t,
       if (p->version <= log.head) {
        dout(10) << "merge_log split point is " << *p << dendl;

-       if (p->version == log.head)
+       if (old_objects.find(p->soid) != old_objects.end() &&
+           old_objects[p->soid]->version == p->version)
          p++;       // move past the split point, if it also exists
in our old log...
        break;
       }

Is it a right fix for this issue? (I am running with the stable branch.)
-- 
Henry Chang


2011-03-08 16:18:44.765612 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 lcod 0'0
stray] my log = log(27'14,27'17]+backlog
2011-03-08 16:18:44.765629 25'1 (0'0) b 100000003f1.00000137/head by
client4111.1:1320 2011-03-08 12:41:45.787200 indexed
2011-03-08 16:18:44.765643 27'2 (0'0) b 100000003f1.00000471/head by
client4111.1:3885 2011-03-08 12:55:46.341185 indexed
2011-03-08 16:18:44.765657 27'3 (0'0) b 10000000bd4.00000017/head by
client4120.1:217 2011-03-08 15:21:10.475753 indexed
2011-03-08 16:18:44.765671 27'5 (0'0) b 10000000fbf.00000160/head by
client4113.1:3178 2011-03-08 15:22:59.209544 indexed
2011-03-08 16:18:44.765685 27'7 (0'0) b 10000000bd4.00000253/head by
client4120.1:5429 2011-03-08 15:24:03.796691 indexed
2011-03-08 16:18:44.765699 27'8 (0'0) b 10000000fbf.000002e5/head by
client4113.1:6680 2011-03-08 15:24:47.665824 indexed
2011-03-08 16:18:44.765712 27'9 (0'0) b 100000007dc.0000031a/head by
client4107.1:7232 2011-03-08 15:24:50.757166 indexed
2011-03-08 16:18:44.765726 27'10 (0'0) b 10000000bd4.00000304/head by
client4120.1:7054 2011-03-08 15:24:56.641569 indexed
2011-03-08 16:18:44.765740 27'11 (0'0) b 10000000fbf.0000046b/head by
client4113.1:10190 2011-03-08 15:26:43.835520 indexed
2011-03-08 16:18:44.765753 27'12 (27'4) b 10000000bd4.00000122/head by
client4120.1:16840 2011-03-08 16:05:30.061403 indexed
2011-03-08 16:18:44.765767 27'15 (27'14) m 10000000bd4.000001f9/head
by client4120.1:16882 2011-03-08 16:05:30.061403 indexed
2011-03-08 16:18:44.765781 27'16 (27'15) m 10000000bd4.000001f9/head
by client4120.1:17145 2011-03-08 16:06:08.641234 indexed
2011-03-08 16:18:44.765795 27'17 (27'16) m 10000000bd4.000001f9/head
by client4120.1:17146 2011-03-08 16:06:08.641234 indexed
2011-03-08 16:18:44.765805 2011-03-08 16:18:44.765822 g[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 lcod 0'0
stray] osd3 log = log(60'24,60'27]+backlog
2011-03-08 16:18:44.765837 25'1 (0'0) b 100000003f1.00000137/head by
client4111.1:1320 2011-03-08 12:41:45.787200
2011-03-08 16:18:44.765850 27'2 (0'0) b 100000003f1.00000471/head by
client4111.1:3885 2011-03-08 12:55:46.341185
2011-03-08 16:18:44.765863 27'3 (0'0) b 10000000bd4.00000017/head by
client4120.1:217 2011-03-08 15:21:10.475753
2011-03-08 16:18:44.765876 27'5 (0'0) b 10000000fbf.00000160/head by
client4113.1:3178 2011-03-08 15:22:59.209544
2011-03-08 16:18:44.765889 27'7 (0'0) b 10000000bd4.00000253/head by
client4120.1:5429 2011-03-08 15:24:03.796691
2011-03-08 16:18:44.765902 27'8 (0'0) b 10000000fbf.000002e5/head by
client4113.1:6680 2011-03-08 15:24:47.665824
2011-03-08 16:18:44.765915 27'9 (0'0) b 100000007dc.0000031a/head by
client4107.1:7232 2011-03-08 15:24:50.757166
2011-03-08 16:18:44.765928 27'10 (0'0) b 10000000bd4.00000304/head by
client4120.1:7054 2011-03-08 15:24:56.641569
2011-03-08 16:18:44.765941 27'11 (0'0) b 10000000fbf.0000046b/head by
client4113.1:10190 2011-03-08 15:26:43.835520
2011-03-08 16:18:44.765954 60'22 (27'12) b 10000000bd4.00000122/head
by client4107.1:17748 2011-03-08 16:14:46.795745
2011-03-08 16:18:44.765966 60'25 (60'24) m 10000000bd4.000001f9/head
by client4107.1:17789 2011-03-08 16:14:46.795745
2011-03-08 16:18:44.765980 60'26 (60'25) m 10000000bd4.000001f9/head
by client4107.1:18108 2011-03-08 16:15:19.394651
2011-03-08 16:18:44.765992 60'27 (60'26) m 10000000bd4.000001f9/head
by client4107.1:18109 2011-03-08 16:15:19.394651
2011-03-08 16:18:44.766002 2011-03-08 16:18:44.766029 7f74783d6710
osd6 75 pg[0.1b( v 27'17 (27'14,27'17]+backlog n=11 ec=2 les=73
61/67/6) [3,6] r=1 lcod 0'0 stray] merge_log log(60'24,60'27]+backlog
from osd3 into log(27'14,27'17]+backlog
2011-03-08 16:18:44.766094 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray] merge_log split point
is 27'11 (0'0) b 10000000fbf.0000046b/head by client4113.1:10190
2011-03-08 15:26:43.835520
2011-03-08 16:18:44.766127 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray] merge_log merging 27'11
(0'0) b 10000000fbf.0000046b/head by client4113.1:10190 2011-03-08
15:26:43.835520
2011-03-08 16:18:44.766160 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=1] merge_log merging
60'22 (27'12) b 10000000bd4.00000122/head by client4107.1:17748
2011-03-08 16:14:46.795745
2011-03-08 16:18:44.766191 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=2] merge_log merging
60'25 (60'24) m 10000000bd4.000001f9/head by client4107.1:17789
2011-03-08 16:14:46.795745
2011-03-08 16:18:44.766224 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_log merging
60'26 (60'25) m 10000000bd4.000001f9/head by client4107.1:18108
2011-03-08 16:15:19.394651
2011-03-08 16:18:44.766256 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_log merging
60'27 (60'26) m 10000000bd4.000001f9/head by client4107.1:18109
2011-03-08 16:15:19.394651
2011-03-08 16:18:44.766294 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 25'1 (0'0) b 100000003f1.00000137/head by client4111.1:1320
2011-03-08 12:41:45.787200 new 25'1 (0'0) b 100000003f1.00000137/head
by client4111.1:1320 2011-03-08 12:41:45.787200 : same
2011-03-08 16:18:44.766328 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 27'2 (0'0) b 100000003f1.00000471/head by client4111.1:3885
2011-03-08 12:55:46.341185 new 27'2 (0'0) b 100000003f1.00000471/head
by client4111.1:3885 2011-03-08 12:55:46.341185 : same
2011-03-08 16:18:44.766363 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 27'3 (0'0) b 10000000bd4.00000017/head by client4120.1:217
2011-03-08 15:21:10.475753 new 27'3 (0'0) b 10000000bd4.00000017/head
by client4120.1:217 2011-03-08 15:21:10.475753 : same
2011-03-08 16:18:44.766397 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 27'5 (0'0) b 10000000fbf.00000160/head by client4113.1:3178
2011-03-08 15:22:59.209544 new 27'5 (0'0) b 10000000fbf.00000160/head
by client4113.1:3178 2011-03-08 15:22:59.209544 : same
2011-03-08 16:18:44.766432 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 27'7 (0'0) b 10000000bd4.00000253/head by client4120.1:5429
2011-03-08 15:24:03.796691 new 27'7 (0'0) b 10000000bd4.00000253/head
by client4120.1:5429 2011-03-08 15:24:03.796691 : same
2011-03-08 16:18:44.766465 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 27'8 (0'0) b 10000000fbf.000002e5/head by client4113.1:6680
2011-03-08 15:24:47.665824 new 27'8 (0'0) b 10000000fbf.000002e5/head
by client4113.1:6680 2011-03-08 15:24:47.665824 : same
2011-03-08 16:18:44.766510 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 27'9 (0'0) b 100000007dc.0000031a/head by client4107.1:7232
2011-03-08 15:24:50.757166 new 27'9 (0'0) b 100000007dc.0000031a/head
by client4107.1:7232 2011-03-08 15:24:50.757166 : same
2011-03-08 16:18:44.766545 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 27'10 (0'0) b 10000000bd4.00000304/head by client4120.1:7054
2011-03-08 15:24:56.641569 new 27'10 (0'0) b 10000000bd4.00000304/head
by client4120.1:7054 2011-03-08 15:24:56.641569 : same
2011-03-08 16:18:44.766580 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 27'11 (0'0) b 10000000fbf.0000046b/head by client4113.1:10190
2011-03-08 15:26:43.835520 new 27'11 (0'0) b 10000000fbf.0000046b/head
by client4113.1:10190 2011-03-08 15:26:43.835520 : same
2011-03-08 16:18:44.766614 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 27'12 (27'4) b 10000000bd4.00000122/head by client4120.1:16840
2011-03-08 16:05:30.061403 new 60'22 (27'12) b
10000000bd4.00000122/head by client4107.1:17748 2011-03-08
16:14:46.795745 : older, missing
2011-03-08 16:18:44.766650 7f74783d6710 osd6 75 pg[0.1b( v 27'17
(27'14,27'17]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 (log bound
mismatch, actual=[25'1,60'27]) lcod 0'0 stray m=3] merge_old_entry
had 27'17 (27'16) m 10000000bd4.000001f9/head by client4120.1:17146
2011-03-08 16:06:08.641234 new 60'27 (60'26) m
10000000bd4.000001f9/head by client4107.1:18109 2011-03-08
16:15:19.394651 : older, missing
2011-03-08 16:18:44.766681 7f74783d6710 osd6 75 pg[0.1b( v 60'27 lc
27'17 (60'24,60'27]+backlog n=11 ec=2 les=73 61/67/6) [3,6] r=1 lcod
0'0 stray m=3] merge_log result log(60'24,60'27]+backlog missing(3)
changed=1
