From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 10/12] ceph: convert inline data for memory mapped read
Date: Mon, 17 Nov 2014 15:57:04 +0800
Message-ID: <1416211026-11524-11-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42203 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbaKQH6Q (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:58:16 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

We can't use getattr to fetch inline data while holding Fr caps,
If there is no Fc cap, ceph_get_caps() does not bring inline data
to page cache neither. To simplify this case, just convert inline
data to normal data.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/addr.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 72336bd..1768919 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1215,7 +1215,7 @@ static int ceph_filemap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	struct page *pinned_page = NULL;
 	loff_t off = vmf->pgoff << PAGE_CACHE_SHIFT;
 	int want, got, ret;
-
+again:
 	dout("filemap_fault %p %llx.%llx %llu~%zd trying to get caps\n",
 	     inode, ceph_vinop(inode), off, (size_t)PAGE_CACHE_SIZE);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
@@ -1236,7 +1236,10 @@ static int ceph_filemap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	dout("filemap_fault %p %llu~%zd got cap refs on %s\n",
 	     inode, off, (size_t)PAGE_CACHE_SIZE, ceph_cap_string(got));
 
-	ret = filemap_fault(vma, vmf);
+	if ((got & want) || ci->i_inline_version == CEPH_INLINE_NONE)
+		ret = filemap_fault(vma, vmf);
+	else
+		ret = -EAGAIN; /* readpage() can't fetch inline data */
 
 	dout("filemap_fault %p %llu~%zd dropping cap refs on %s ret %d\n",
 	     inode, off, (size_t)PAGE_CACHE_SIZE, ceph_cap_string(got), ret);
@@ -1244,6 +1247,16 @@ static int ceph_filemap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 		page_cache_release(pinned_page);
 	ceph_put_cap_refs(ci, got);
 
+	if (ret == -EAGAIN) {
+		ret = ceph_uninline_data(vma->vm_file, NULL);
+		if (ret < 0)
+			return VM_FAULT_SIGBUS;
+		spin_lock(&ci->i_ceph_lock);
+		ci->i_inline_version = CEPH_INLINE_NONE;
+		spin_unlock(&ci->i_ceph_lock);
+		goto again;
+	}
+
 	return ret;
 }
 
-- 
1.9.3

