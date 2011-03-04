From: "Jim Schutt" <jaschut@sandia.gov>
Subject: monitor dispatch queue seems backed up?
Date: Fri, 4 Mar 2011 10:14:13 -0700
Message-ID: <1299258853.4750.191.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:39732 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759768Ab1CDRO0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 12:14:26 -0500
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1984B529423
	for <ceph-devel@vger.kernel.org>; Fri,  4 Mar 2011 10:14:21 -0700 (MST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'm continuing my testing of the master branch
(commit 1ed2d8c587) against 96 osds.

I'm having trouble getting a new filesystem to
start up.  FWIW this size filesystem starts up
in a minute or two at most under the stable branch.

I'm using the attached patch to log message
queue wait times.  I'm seeing excessive queuing times,
and the message dispatch queue is really backed up as
a result:

2011-03-04 10:03:47.144090 7fd7849ea940 -- 172.17.40.34:6789/0 dispatch_throttle_release 52 to dispatch throttler 104760196/104857600
2011-03-04 10:03:47.147846 7fd7849ea940 -- 172.17.40.34:6789/0 >> 172.17.40.21:6812/28404 pipe(0x7fd768586d30 sd=73 pgs=89 cs=1 l=1).reader wants 52 from dispatch throttler 104760144/104857600
2011-03-04 10:03:47.250609 7fd77a6a6940 -- 172.17.40.34:6789/0 dispatch_throttle_release 53 to dispatch throttler 104760196/104857600
2011-03-04 10:03:47.254636 7fd77a6a6940 -- 172.17.40.34:6789/0 >> 172.17.40.29:6818/26733 pipe(0x7fd7685870f0 sd=7 pgs=110 cs=1 l=1).reader wants 53 from dispatch throttler 104760143/104857600
2011-03-04 10:03:47.291575 7fd787b0d940 mon.an14@0(leader) e1 ms_dispatch existing session MonSession: osd78 172.17.40.31:6818/30346 is open for osd78 172.17.40.31:6818/30346
2011-03-04 10:03:47.327148 7fd787b0d940 -- 172.17.40.34:6789/0 dispatch_throttle_release 270286 to dispatch throttler 104760196/104857600
2011-03-04 10:03:47.327186 7fd787b0d940 -- 172.17.40.34:6789/0 dispatch_entry done with 0x2767540 que_et 694.609439 op_et 18.173758 tot_et 712.783197
2011-03-04 10:03:47.334681 7fd787b0d940 mon.an14@0(leader) e1 ms_dispatch existing session MonSession: osd22 172.17.40.23:6818/25413 is open for osd22 172.17.40.23:6818/25413
2011-03-04 10:03:47.340074 7fd779f9f940 -- 172.17.40.34:6789/0 >> 172.17.40.33:6815/10175 pipe(0x7fd7806f94e0 sd=53 pgs=29 cs=1 l=1).reader wants 22 from dispatch throttler 104705742/104857600
2011-03-04 10:03:47.340586 7fd779f9f940 -- 172.17.40.34:6789/0 >> 172.17.40.33:6815/10175 pipe(0x7fd7806f94e0 sd=53 pgs=29 cs=1 l=1).reader wants 215832 from dispatch throttler 104705764/104857600
2011-03-04 10:03:47.369077 7fd73fdfd940 -- 172.17.40.34:6789/0 dispatch_throttle_release 53 to dispatch throttler 104705764/104857600
2011-03-04 10:03:47.373492 7fd73fdfd940 -- 172.17.40.34:6789/0 >> 172.17.40.31:6821/30438 pipe(0x7fd76858a430 sd=75 pgs=93 cs=1 l=1).reader wants 53 from dispatch throttler 104705711/104857600
2011-03-04 10:03:47.379362 7fd787b0d940 -- 172.17.40.34:6789/0 dispatch_throttle_release 326202 to dispatch throttler 104705764/104857600
2011-03-04 10:03:47.379401 7fd787b0d940 -- 172.17.40.34:6789/0 dispatch_entry done with 0x7fd75d9d2cb0 que_et 714.277852 op_et 0.044714 tot_et 714.322566
2011-03-04 10:03:47.395951 7fd77e0e0940 -- 172.17.40.34:6789/0 >> 172.17.40.29:6800/26109 pipe(0x7fd7806decb0 sd=41 pgs=30 cs=1 l=1).reader wants 22 from dispatch throttler 104644280/104857600
2011-03-04 10:03:47.396294 7fd77e0e0940 -- 172.17.40.34:6789/0 >> 172.17.40.29:6800/26109 pipe(0x7fd7806decb0 sd=41 pgs=30 cs=1 l=1).reader wants 184 from dispatch throttler 104644302/104857600
2011-03-04 10:03:47.396818 7fd77e0e0940 -- 172.17.40.34:6789/0 >> 172.17.40.29:6800/26109 pipe(0x7fd7806decb0 sd=41 pgs=30 cs=1 l=1).reader wants 184 from dispatch throttler 104644486/104857600
2011-03-04 10:03:47.397276 7fd77e0e0940 -- 172.17.40.34:6789/0 >> 172.17.40.29:6800/26109 pipe(0x7fd7806decb0 sd=41 pgs=30 cs=1 l=1).reader wants 184 from dispatch throttler 104644670/104857600
2011-03-04 10:03:47.397499 7fd77e0e0940 -- 172.17.40.34:6789/0 >> 172.17.40.29:6800/26109 pipe(0x7fd7806decb0 sd=41 pgs=30 cs=1 l=1).reader wants 184 from dispatch throttler 104644854/104857600
2011-03-04 10:03:47.397698 7fd77e0e0940 -- 172.17.40.34:6789/0 >> 172.17.40.29:6800/26109 pipe(0x7fd7806decb0 sd=41 pgs=30 cs=1 l=1).reader wants 184 from dispatch throttler 104645038/104857600
2011-03-04 10:03:47.397954 7fd77e0e0940 -- 172.17.40.34:6789/0 >> 172.17.40.29:6800/26109 pipe(0x7fd7806decb0 sd=41 pgs=30 cs=1 l=1).reader wants 184 from dispatch throttler 104645222/104857600


I'm still digging to see if I can isolate what's happening;
I've got full logs available on request, and can reproduce 
with more debugging as needed.

-- Jim

From 8eb5f27bdc3bee7ab8c7af58717fad9f313dca42 Mon Sep 17 00:00:00 2001
From: Jim Schutt <jaschut@sandia.gov>
Date: Thu, 24 Feb 2011 16:42:50 -0700
Subject: [PATCH] Refine debug printing for handling message dispatch.


Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/msg/SimpleMessenger.cc |   17 ++++++++++++++---
 src/osd/OSD.cc             |    3 +++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index 23e6b29..96e74e9 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -352,17 +352,26 @@ void SimpleMessenger::dispatch_entry()
 		  << " " << m->get_footer().data_crc << ")"
 		  << " " << m << " con " << m->get_connection()
 		  << dendl;
+	  utime_t recv_stamp = m->get_recv_stamp();
+	  utime_t disp_stamp = g_clock.now();
 	  ms_deliver_dispatch(m);
 
 	  dispatch_throttle_release(msize);
 
-	  dout(20) << "done calling dispatch on " << m << dendl;
+	  utime_t done_stamp = g_clock.now();
+	  dout(20) << "dispatch_entry done with " << m
+		   << " que_et " << disp_stamp - recv_stamp
+		   << " op_et " << done_stamp - disp_stamp
+		   << " tot_et " << done_stamp - recv_stamp << dendl;
 	}
       }
       dispatch_queue.lock.Lock();
     }
-    if (!dispatch_queue.stop)
+    if (!dispatch_queue.stop) {
+      dout(20) << " Waiting for new work on SimpleMessenger dispatch queue" << dendl;
       dispatch_queue.cond.Wait(dispatch_queue.lock); //wait for something to be put on queue
+      dout(20) << " Got new work on SimpleMessenger dispatch queue" << dendl;
+    }
   }
   dispatch_queue.lock.Unlock();
 
@@ -553,8 +562,10 @@ void SimpleMessenger::Pipe::queue_received(Message *m, int priority)
       dout(20) << "queue_received queuing pipe" << dendl;
       if (!queue_items.count(priority)) 
 	queue_items[priority] = new xlist<Pipe *>::item(this);
-      if (messenger->dispatch_queue.queued_pipes.empty())
+      if (messenger->dispatch_queue.queued_pipes.empty()) {
+	dout(20) << " Waking up SimpleMessenger dispatch queue" << dendl;
 	messenger->dispatch_queue.cond.Signal();
+      }
       messenger->dispatch_queue.queued_pipes[priority].push_back(queue_items[priority]);
     }
 
-- 
1.6.6




