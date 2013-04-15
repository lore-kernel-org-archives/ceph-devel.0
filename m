From: Alex Elder <elder@inktank.com>
Subject: [PATCH] ceph: let osd client clean up for interrupted request
Date: Mon, 15 Apr 2013 11:18:01 -0500
Message-ID: <516C2839.7050705@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:39562 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472Ab3DOQSE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 12:18:04 -0400
Received: by mail-ie0-f181.google.com with SMTP id as1so1553125iec.26
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 09:18:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

In ceph_sync_write(), if a safe callback is supplied with a request,
and an error is returned by ceph_osdc_wait_request(), a block of
code is executed to remove the request from the unsafe writes list
and drop references to capabilities acquired just prior to a call to
ceph_osdc_wait_request().

The only function used for this callback is sync_write_commit(),
and it does *exactly* what that block of error handling code does.

Now in ceph_osdc_wait_request(), if an error occurs (due to an
interupt during a wait_for_completion_interruptible() call),
complete_request() gets called, and that calls the request's
safe_callback method if it's defined.

So this means that this cleanup activity gets called twice in this
case, which is erroneous (and in fact leads to a crash).

Fix this by just letting the osd client handle the cleanup in
the event of an interrupt.

This resolves one problem mentioned in:
    http://tracker.ceph.com/issues/4706

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/file.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b7e6caa..1d8d430 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -595,12 +595,6 @@ more:
 		}
 		
 		ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
-		if (ret < 0 && req->r_safe_callback) {
-			spin_lock(&ci->i_unsafe_lock);
-			list_del_init(&req->r_unsafe_item);
-			spin_unlock(&ci->i_unsafe_lock);
-			ceph_put_cap_refs(ci, CEPH_CAP_FILE_WR);
-		}
 	}

 	if (file->f_flags & O_DIRECT)
-- 
1.7.9.5

