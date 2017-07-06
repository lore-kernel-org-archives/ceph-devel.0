From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 2/2] ceph: fix race in concurrent readdir
Date: Thu,  6 Jul 2017 21:12:09 +0800
Message-ID: <20170706131209.31734-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbdGFNLn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Jul 2017 09:11:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1A844E33D
        for <ceph-devel@vger.kernel.org>; Thu,  6 Jul 2017 13:11:42 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com

For a large directory, program needs to issue multiple readdir
syscalls to get all dentries. When there are multiple programs
read the directory concurrently. Following sequence of events
can happen.

 - program calls readdir with pos = 2. ceph sends readdir request
   to mds. The reply contains N1 entries. ceph adds these N1 entries
   to readdir cache.
 - program calls readdir with pos = N1+2. The readdir is satisfied
   by the readdir cache, N2 entries are returned. (Other program
   calls readdir in the middle, which fills the cache)
 - program calls readdir with pos = N1+N2+2. ceph sends readdir
   request to mds. The reply contains N3 entries and it reaches
   directory end. ceph adds these N3 entries to the readdir cache
   and marks directory complete.

The second readdir call does not update fi->readdir_cache_idx.
ceph add the last N3 entries to wrong places.

Cc: stable@vger.kernel.org # v4.3+
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/dir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index e071d23..ef7240a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -271,6 +271,11 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 		if (ret < 0)
 			err = ret;
 		dput(last);
+		/* last_name no longer match cache index */
+		if (fi->readdir_cache_idx >= 0) {
+			fi->readdir_cache_idx = -1;
+			fi->dir_release_count = 0;
+		}
 	}
 	return err;
 }
-- 
2.9.4

