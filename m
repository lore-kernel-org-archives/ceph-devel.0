From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH] msgr: Prevent unbounded use of bufferlist memory by
 throttling incoming messages.
Date: Thu,  3 Jun 2010 15:25:57 -0600
Message-ID: <1275600357-11367-1-git-send-email-jaschut@sandia.gov>
References: <16744_1275600306_o53LOfiY016748_1275600252.4800.13.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:37195 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab0FCV0m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jun 2010 17:26:42 -0400
In-Reply-To: <16744_1275600306_o53LOfiY016748_1275600252.4800.13.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@newdream.net, Jim Schutt <jaschut@sandia.gov>

Under some conditions it is possible for a daemon to accept new messages
faster than it can process them.  Since there is no limit on the number
of outstanding messages, if this condition persists the daemon will
consume all available memory/swap on the server.

Fix this by causing the message reader to monitor the bufferlist
memory use, and sleep for a bit if some threshold is exceeded.
Some more sophisticated technique that prevents more demanding clients
from starving less demanding clients may be needed.

Without this patch, for a filesystem with a single osd, I was able to
reliably cause the osd to be killed by the kernel oom-killer with a
large streaming write from a single client.  In my case the client
machine was several years newer than the server machine, and the
network was 10 Gb/s Ethernet with 9000B MTU, which configuration
probably contributes to the problem.

With this patch, the same test ran reliably, with the osd RSS staying
below a few hundred MiB.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/msg/SimpleMessenger.cc |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index a7fb18d..11163e3 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -1750,6 +1750,20 @@ Message *SimpleMessenger::Pipe::read_message()
   unsigned data_off = le32_to_cpu(header.data_off);
   if (data_len) {
     int left = data_len;
+    int throttled = 0;
+
+    while (buffer_total_alloc.read() + data_len > (64*1024*1024)) {
+      struct timespec sleepy_time = {0, (1000 * 1000)}; // 1 msec
+      if (!throttled)
+	dout(4) << " pipe reader paused" << "; buffer_total_alloc "
+		<< buffer_total_alloc.read() << dendl;
+      ::nanosleep(&sleepy_time, 0);
+      throttled++;
+    }
+    if (throttled)
+      dout(4) << " pipe reader unpaused; buffer_total_alloc "
+	       << buffer_total_alloc.read() << dendl;
+      
     if (data_off & ~PAGE_MASK) {
       // head
       int head = MIN(PAGE_SIZE - (data_off & ~PAGE_MASK),
-- 
1.6.6.1


