From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] libceph: drop return value from page vector copy routines
Date: Fri, 08 Feb 2013 10:33:35 -0600
Message-ID: <511528DF.4030200@inktank.com>
References: <51152847.2030305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:40800 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946710Ab3BHQdj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:33:39 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so4489420iab.9
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 08:33:39 -0800 (PST)
In-Reply-To: <51152847.2030305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The return values provided for ceph_copy_to_page_vector() and
ceph_copy_from_page_vector() serve no purpose, so get rid of them.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c          |    5 ++---
 include/linux/ceph/libceph.h |    4 ++--
 net/ceph/pagevec.c           |   14 ++++++--------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 958e733..4242cb8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1890,8 +1890,7 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 	if (ret < 0)
 		goto out;
 	ret = 0;
-	(void) ceph_copy_from_page_vector(pages, inbound, 0,
-					obj_request->xferred);
+	ceph_copy_from_page_vector(pages, inbound, 0, obj_request->xferred);
 	if (version)
 		*version = obj_request->version;
 out:
@@ -2089,7 +2088,7 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,

 	rbd_assert(obj_request->xferred <= (u64) SIZE_MAX);
 	size = (size_t) obj_request->xferred;
-	(void) ceph_copy_from_page_vector(pages, buf, 0, size);
+	ceph_copy_from_page_vector(pages, buf, 0, size);
 	rbd_assert(size <= (size_t) INT_MAX);
 	ret = (int) size;
 	if (version)
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 2250f8b..29818fc 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -232,10 +232,10 @@ extern struct page **ceph_alloc_page_vector(int
num_pages, gfp_t flags);
 extern int ceph_copy_user_to_page_vector(struct page **pages,
 					 const void __user *data,
 					 loff_t off, size_t len);
-extern int ceph_copy_to_page_vector(struct page **pages,
+extern void ceph_copy_to_page_vector(struct page **pages,
 				    const void *data,
 				    loff_t off, size_t len);
-extern int ceph_copy_from_page_vector(struct page **pages,
+extern void ceph_copy_from_page_vector(struct page **pages,
 				    void *data,
 				    loff_t off, size_t len);
 extern int ceph_copy_page_vector_to_user(struct page **pages, void
__user *data,
diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index 5b20be9..815a224 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -118,17 +118,17 @@ int ceph_copy_user_to_page_vector(struct page **pages,
 }
 EXPORT_SYMBOL(ceph_copy_user_to_page_vector);

-int ceph_copy_to_page_vector(struct page **pages,
+void ceph_copy_to_page_vector(struct page **pages,
 				    const void *data,
 				    loff_t off, size_t len)
 {
 	int i = 0;
 	size_t po = off & ~PAGE_CACHE_MASK;
 	size_t left = len;
-	size_t l;

 	while (left > 0) {
-		l = min_t(size_t, PAGE_CACHE_SIZE-po, left);
+		size_t l = min_t(size_t, PAGE_CACHE_SIZE-po, left);
+
 		memcpy(page_address(pages[i]) + po, data, l);
 		data += l;
 		left -= l;
@@ -138,21 +138,20 @@ int ceph_copy_to_page_vector(struct page **pages,
 			i++;
 		}
 	}
-	return len;
 }
 EXPORT_SYMBOL(ceph_copy_to_page_vector);

-int ceph_copy_from_page_vector(struct page **pages,
+void ceph_copy_from_page_vector(struct page **pages,
 				    void *data,
 				    loff_t off, size_t len)
 {
 	int i = 0;
 	size_t po = off & ~PAGE_CACHE_MASK;
 	size_t left = len;
-	size_t l;

 	while (left > 0) {
-		l = min_t(size_t, PAGE_CACHE_SIZE-po, left);
+		size_t l = min_t(size_t, PAGE_CACHE_SIZE-po, left);
+
 		memcpy(data, page_address(pages[i]) + po, l);
 		data += l;
 		left -= l;
@@ -162,7 +161,6 @@ int ceph_copy_from_page_vector(struct page **pages,
 			i++;
 		}
 	}
-	return len;
 }
 EXPORT_SYMBOL(ceph_copy_from_page_vector);

-- 
1.7.9.5

