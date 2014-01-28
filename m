From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] ceph: fix dout() compile warnings in ceph_filemap_fault()
Date: Tue, 28 Jan 2014 18:50:41 +0200
Message-ID: <1390927841-9515-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:49037 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbaA1Qvm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jan 2014 11:51:42 -0500
Received: by mail-lb0-f177.google.com with SMTP id z5so560721lbh.8
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jan 2014 08:51:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

PAGE_CACHE_SIZE is unsigned long on all architectures, however size_t
is either unsigned int or unsigned long.  Rather than change format
strings, cast PAGE_CACHE_SIZE to size_t to be in line with dout()s in
ceph_page_mkwrite().

Cc: Yan, Zheng <zheng.z.yan@intel.com>
Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 fs/ceph/addr.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 791a9a23fc60..b53278c9fd97 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1220,7 +1220,7 @@ static int ceph_filemap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	int want, got, ret;
 
 	dout("filemap_fault %p %llx.%llx %llu~%zd trying to get caps\n",
-	     inode, ceph_vinop(inode), off, PAGE_CACHE_SIZE);
+	     inode, ceph_vinop(inode), off, (size_t)PAGE_CACHE_SIZE);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
 	else
@@ -1236,12 +1236,12 @@ static int ceph_filemap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 		}
 	}
 	dout("filemap_fault %p %llu~%zd got cap refs on %s\n",
-	     inode, off, PAGE_CACHE_SIZE, ceph_cap_string(got));
+	     inode, off, (size_t)PAGE_CACHE_SIZE, ceph_cap_string(got));
 
 	ret = filemap_fault(vma, vmf);
 
 	dout("filemap_fault %p %llu~%zd dropping cap refs on %s ret %d\n",
-	     inode, off, PAGE_CACHE_SIZE, ceph_cap_string(got), ret);
+	     inode, off, (size_t)PAGE_CACHE_SIZE, ceph_cap_string(got), ret);
 	ceph_put_cap_refs(ci, got);
 
 	return ret;
-- 
1.7.10.4

