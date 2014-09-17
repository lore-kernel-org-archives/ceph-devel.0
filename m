From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: remove redundant io_iter_advance()
Date: Wed, 17 Sep 2014 15:13:16 +0800
Message-ID: <1410937996-13013-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54480 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbaIQHNc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Sep 2014 03:13:32 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8H7DWT1017757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 17 Sep 2014 03:13:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

ceph_sync_read and generic_file_read_iter() have already advanced the
IO iterator.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 1c1df08..d7e0da8 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -850,7 +850,6 @@ again:
 			     ", reading more\n", iocb->ki_pos,
 			     inode->i_size);
 
-			iov_iter_advance(to, ret);
 			read += ret;
 			len -= ret;
 			checkeof = 0;
-- 
1.9.3

