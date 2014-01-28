From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] ceph: cast PAGE_SIZE to size_t in ceph_sync_write()
Date: Tue, 28 Jan 2014 19:28:40 +0200
Message-ID: <1390930120-9863-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:37538 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbaA1R3l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jan 2014 12:29:41 -0500
Received: by mail-lb0-f170.google.com with SMTP id u14so631822lbd.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jan 2014 09:29:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com, Jianpeng Ma <majianpeng@gmail.com>

Use min_t(size_t, ...) instead of plain min(), which does strict type
checking, to avoid compile warning on i386.

Cc: Jianpeng Ma <majianpeng@gmail.com>
Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 fs/ceph/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d10510a4733d..dfd2ce3419f8 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -734,7 +734,7 @@ static ssize_t ceph_sync_write(struct kiocb *iocb, const struct iovec *iov,
 
 		left = len;
 		for (n = 0; n < num_pages; n++) {
-			size_t plen = min(left, PAGE_SIZE);
+			size_t plen = min_t(size_t, left, PAGE_SIZE);
 			ret = iov_iter_copy_from_user(pages[n], &i, 0, plen);
 			if (ret != plen) {
 				ret = -EFAULT;
-- 
1.7.10.4

