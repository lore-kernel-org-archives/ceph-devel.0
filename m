From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] libceph: mark ceph_msgr_wq reentrant
Date: Tue, 09 Oct 2012 14:29:38 -0700
Message-ID: <50749742.2080104@inktank.com>
References: <50749701.8010208@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42075 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab2JIV3l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 17:29:41 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5639092pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 14:29:41 -0700 (PDT)
In-Reply-To: <50749701.8010208@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The ceph messenger workqueue is used to activate execution of the
messenger state machine loop con_work().  The work queue used is
allocated with flag WQ_NON_REENTRANT, which only allows a single
work item on the queue to execute at a time.

There is no need for this restriction, because each connection
maintains its own state and manipulation of each connection is
protected by the connection's mutex.

So drop the WQ_NON_REENTRANT flag when allocating this work queue.
This will allow different connections to be operated on at the same
time.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 159aa8b..28ed904 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -190,7 +190,7 @@ int ceph_msgr_init(void)
  	zero_page = ZERO_PAGE(0);
  	page_cache_get(zero_page);

-	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_NON_REENTRANT, 0);
+	ceph_msgr_wq = alloc_workqueue("ceph-msgr", 0, 0);
  	if (ceph_msgr_wq)
  		return 0;

-- 
1.7.9.5

