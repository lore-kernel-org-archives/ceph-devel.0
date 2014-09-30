From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] libceph: remove redundant declaration
Date: Tue, 30 Sep 2014 22:07:50 +0200
Message-ID: <1412107670-4888-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

ceph_release_page_vector was defined twice in libceph.h

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 include/linux/ceph/libceph.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 279b0af..07bc359 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -211,7 +211,6 @@ extern struct page **ceph_get_direct_page_vector(const void __user *data,
 						 bool write_page);
 extern void ceph_put_page_vector(struct page **pages, int num_pages,
 				 bool dirty);
-extern void ceph_release_page_vector(struct page **pages, int num_pages);
 extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
 extern int ceph_copy_user_to_page_vector(struct page **pages,
 					 const void __user *data,
-- 
1.9.3
