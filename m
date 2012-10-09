From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] libceph: mark ceph_msgr_wq unbounded
Date: Tue, 09 Oct 2012 14:29:46 -0700
Message-ID: <5074974A.3010000@inktank.com>
References: <50749701.8010208@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64213 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab2JIV3u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 17:29:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5688715pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 14:29:49 -0700 (PDT)
In-Reply-To: <50749701.8010208@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Andreas Bluemle observed an undesirable behavior in the ceph
messenger when using networking hardware that binds received data
handling to a single CPU.  The messenger uses a workqueue to process
message activity, and in this case all work was being queued on the
same per-cpu workqueue.  Consequently that CPU becomes a bottleneck,
forced to process all incoming messages.

Marking the workqueue UNBOUND allows any available CPU to process a
work item on the queue.  The concurrency of the workqueue will be
limited by the number of active connections.

Reported-by: Andreas Bluemle <andreas.bluemle@itxperts.de>
Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 28ed904..f9f65fe 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -190,7 +190,7 @@ int ceph_msgr_init(void)
  	zero_page = ZERO_PAGE(0);
  	page_cache_get(zero_page);

-	ceph_msgr_wq = alloc_workqueue("ceph-msgr", 0, 0);
+	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_UNBOUND, 0);
  	if (ceph_msgr_wq)
  		return 0;

-- 
1.7.9.5

