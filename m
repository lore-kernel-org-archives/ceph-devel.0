From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: define zero_pages()
Date: Fri, 19 Apr 2013 17:50:17 -0500
Message-ID: <5171CA29.7000500@inktank.com>
References: <5171C963.2050402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:40786 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964846Ab3DSWuT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 18:50:19 -0400
Received: by mail-ie0-f180.google.com with SMTP id to1so610047ieb.25
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 15:50:19 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ie7sm4954655igb.1.2013.04.19.15.50.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 15:50:18 -0700 (PDT)
In-Reply-To: <5171C963.2050402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Define a new function zero_pages() that zeroes a range of memory
defined by a page array, along the lines of zero_bio_chain().  It
saves and the irq flags like bvec_kmap_irq() does, though I'm not
sure at this point that it's necessary.

Update rbd_img_obj_request_read_callback() to use the new function
if the object request contains page rather than bio data.

For the moment, only bio data is used for osd READ ops.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   55
+++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 894af4f..ac9abab 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -971,6 +971,37 @@ static void zero_bio_chain(struct bio *chain, int
start_ofs)
 }

 /*
+ * similar to zero_bio_chain(), zeros data defined by a page array,
+ * starting at the given byte offset from the start of the array and
+ * continuing up to the given end offset.  The pages array is
+ * assumed to be big enough to hold all bytes up to the end.
+ */
+static void zero_pages(struct page **pages, u64 offset, u64 end)
+{
+	struct page **page = &pages[offset >> PAGE_SHIFT];
+
+	rbd_assert(end > offset);
+	rbd_assert(end - offset <= (u64)SIZE_MAX);
+	while (offset < end) {
+		size_t page_offset;
+		size_t length;
+		unsigned long flags;
+		void *kaddr;
+
+		page_offset = (size_t)(offset & ~PAGE_MASK);
+		length = min(PAGE_SIZE - page_offset, (size_t)(end - offset));
+		local_irq_save(flags);
+		kaddr = kmap_atomic(*page);
+		memset(kaddr + page_offset, 0, length);
+		kunmap_atomic(kaddr);
+		local_irq_restore(flags);
+
+		offset += length;
+		page++;
+	}
+}
+
+/*
  * Clone a portion of a bio, starting at the given byte offset
  * and continuing for the number of bytes indicated.
  */
@@ -1352,9 +1383,12 @@ static bool img_request_layered_test(struct
rbd_img_request *img_request)
 static void
 rbd_img_obj_request_read_callback(struct rbd_obj_request *obj_request)
 {
+	u64 xferred = obj_request->xferred;
+	u64 length = obj_request->length;
+
 	dout("%s: obj %p img %p result %d %llu/%llu\n", __func__,
 		obj_request, obj_request->img_request, obj_request->result,
-		obj_request->xferred, obj_request->length);
+		xferred, length);
 	/*
 	 * ENOENT means a hole in the image.  We zero-fill the
 	 * entire length of the request.  A short read also implies
@@ -1362,15 +1396,20 @@ rbd_img_obj_request_read_callback(struct
rbd_obj_request *obj_request)
 	 * update the xferred count to indicate the whole request
 	 * was satisfied.
 	 */
-	BUG_ON(obj_request->type != OBJ_REQUEST_BIO);
+	rbd_assert(obj_request->type != OBJ_REQUEST_NODATA);
 	if (obj_request->result == -ENOENT) {
-		zero_bio_chain(obj_request->bio_list, 0);
+		if (obj_request->type == OBJ_REQUEST_BIO)
+			zero_bio_chain(obj_request->bio_list, 0);
+		else
+			zero_pages(obj_request->pages, 0, length);
 		obj_request->result = 0;
-		obj_request->xferred = obj_request->length;
-	} else if (obj_request->xferred < obj_request->length &&
-			!obj_request->result) {
-		zero_bio_chain(obj_request->bio_list, obj_request->xferred);
-		obj_request->xferred = obj_request->length;
+		obj_request->xferred = length;
+	} else if (xferred < length && !obj_request->result) {
+		if (obj_request->type == OBJ_REQUEST_BIO)
+			zero_bio_chain(obj_request->bio_list, xferred);
+		else
+			zero_pages(obj_request->pages, xferred, length);
+		obj_request->xferred = length;
 	}
 	obj_request_done_set(obj_request);
 }
-- 
1.7.9.5

