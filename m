From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: don't bother calculating file mapping
Date: Wed, 14 Nov 2012 12:34:18 -0600
Message-ID: <50A3E42A.4000704@inktank.com>
References: <50A3E373.4090006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53762 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423150Ab2KNSeW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 13:34:22 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so1024826iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 10:34:22 -0800 (PST)
In-Reply-To: <50A3E373.4090006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When rbd_do_request() has a request to process it initializes a ceph
file layout structure and uses it to compute offsets and limits for
the range of the request using ceph_calc_file_object_mapping().

The layout used is fixed, and is based on RBD_MAX_OBJ_ORDER (30).
It sets the layout's object size and stripe unit to be 1 GB (2^30),
and sets the stripe count to be 1.

The job of ceph_calc_file_object_mapping() is to determine which
of a sequence of objects will contain data covered by range, and
within that object, at what offset the range starts.  It also
truncates the length of the range at the end of the selected object
if necessary.

This is needed for ceph fs, but for rbd it really serves no purpose.
It does its own blocking of images into objects, echo of which is
(1 << obj_order) in size, and as a result it ignores the "bno"
value returned by ceph_calc_file_object_mapping().  In addition,
by the point a request has reached this function, it is already
destined for a single rbd object, and its length will not exceed
that object's extent.  Because of this, and because the mapping will
result in blocking up the range using an integer multiple of the
image's object order, ceph_calc_file_object_mapping() will never
change the offset or length values defined by the request.

In other words, this call is a big no-op for rbd data requests.

There is one exception.  We read the header object using this
function, and in that case we will not have already limited the
request size.  However, the header is a single object (not a file or
rbd image), and should not be broken into pieces anyway.  So in fact
we should *not* be calling ceph_calc_file_object_mapping() when
operating on the header object.

So...

Don't call ceph_calc_file_object_mapping() in rbd_do_request(),
because useless for image data and incorrect to do sofor the image
header.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1afe51f..30a73ae 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1125,9 +1125,6 @@ static int rbd_do_request(struct request *rq,
 {
 	struct ceph_osd_request *osd_req;
 	int ret;
-	u64 bno;
-	u64 obj_off = 0;
-	u64 obj_len = 0;
 	struct timespec mtime = CURRENT_TIME;
 	struct rbd_request *rbd_req;
 	struct ceph_osd_client *osdc;
@@ -1171,19 +1168,12 @@ static int rbd_do_request(struct request *rq,
 	osd_req->r_oid_len = strlen(osd_req->r_oid);

 	rbd_layout_init(&osd_req->r_file_layout, rbd_dev->spec->pool_id);
-	ret = ceph_calc_file_object_mapping(&osd_req->r_file_layout, ofs, len,
-						&bno, &obj_off, &obj_len);
-	rbd_assert(ret == 0);
-	if (obj_len < len) {
-		dout(" skipping last %llu, final file extent %llu~%llu\n",
-		     len - obj_len, ofs, obj_len);
-		len = obj_len;
-	}
+
 	if (op->op == CEPH_OSD_OP_READ || op->op == CEPH_OSD_OP_WRITE) {
-		op->extent.offset = obj_off;
-		op->extent.length = obj_len;
+		op->extent.offset = ofs;
+		op->extent.length = len;
 		if (op->op == CEPH_OSD_OP_WRITE)
-			op->payload_len = obj_len;
+			op->payload_len = len;
 	}
 	osd_req->r_num_pages = calc_pages_for(ofs, len);
 	osd_req->r_page_alignment = ofs & ~PAGE_MASK;
-- 
1.7.9.5

