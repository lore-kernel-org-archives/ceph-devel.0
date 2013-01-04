From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 2/6] libceph: pass length to ceph_calc_file_object_mapping()
Date: Fri, 04 Jan 2013 08:33:29 -0600
Message-ID: <50E6E839.9080708@inktank.com>
References: <50E6E7C2.2020604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:58975 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab3ADOdb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:33:31 -0500
Received: by mail-ia0-f179.google.com with SMTP id o25so13701815iad.38
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:33:30 -0800 (PST)
In-Reply-To: <50E6E7C2.2020604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

ceph_calc_file_object_mapping() takes (among other things) a "file"
offset and length, and based on the layout, determines the object
number ("bno") backing the affected portion of the file's data and
the offset into that object where the desired range begins.  It also
computes the size that should be used for the request--either the
amount requested or something less if that would exceed the end of
the object.

This patch changes the input length parameter in this function so it
is used only for input.  That is, the argument will be passed by
value rather than by address, so the value provided won't get
updated by the function.

The value would only get updated if the length would surpass the
current object, and in that case the value it got updated to would
be exactly that returned in *oxlen.

Only one of the two callers is affected by this change.  Update
ceph_calc_raw_layout() so it records any updated value.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/ioctl.c             |    2 +-
 include/linux/ceph/osdmap.h |    2 +-
 net/ceph/osd_client.c       |    6 ++++--
 net/ceph/osdmap.c           |    9 ++++-----
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 36549a4..3b22150 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -194,7 +194,7 @@ static long ceph_ioctl_get_dataloc(struct file
*file, void __user *arg)
 		return -EFAULT;

 	down_read(&osdc->map_sem);
-	r = ceph_calc_file_object_mapping(&ci->i_layout, dl.file_offset, &len,
+	r = ceph_calc_file_object_mapping(&ci->i_layout, dl.file_offset, len,
 					  &dl.object_no, &dl.object_offset,
 					  &olen);
 	if (r < 0)
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 5ea57ba..1f653e2 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -110,7 +110,7 @@ extern void ceph_osdmap_destroy(struct ceph_osdmap
*map);

 /* calculate mapping of a file extent to an object */
 extern int ceph_calc_file_object_mapping(struct ceph_file_layout *layout,
-					 u64 off, u64 *plen,
+					 u64 off, u64 len,
 					 u64 *bno, u64 *oxoff, u64 *oxlen);

 /* calculate mapping of object to a placement group */
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index cdf40c6..65b7d11 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -53,13 +53,15 @@ int ceph_calc_raw_layout(struct ceph_osd_client *osdc,
 	reqhead->snapid = cpu_to_le64(snapid);

 	/* object extent? */
-	r = ceph_calc_file_object_mapping(layout, off, plen, bno,
+	r = ceph_calc_file_object_mapping(layout, off, orig_len, bno,
 					  &objoff, &objlen);
 	if (r < 0)
 		return r;
-	if (*plen < orig_len)
+	if (objlen < orig_len) {
+		*plen = objlen;
 		dout(" skipping last %llu, final file extent %llu~%llu\n",
 		     orig_len - *plen, off, *plen);
+	}

 	if (op_has_extent(op->op)) {
 		op->extent.offset = objoff;
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index de73214..9dded22 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1010,7 +1010,7 @@ bad:
  * pass a stride back to the caller.
  */
 int ceph_calc_file_object_mapping(struct ceph_file_layout *layout,
-				   u64 off, u64 *plen,
+				   u64 off, u64 len,
 				   u64 *ono,
 				   u64 *oxoff, u64 *oxlen)
 {
@@ -1021,7 +1021,7 @@ int ceph_calc_file_object_mapping(struct
ceph_file_layout *layout,
 	u32 su_per_object;
 	u64 t, su_offset;

-	dout("mapping %llu~%llu  osize %u fl_su %u\n", off, *plen,
+	dout("mapping %llu~%llu  osize %u fl_su %u\n", off, len,
 	     osize, su);
 	if (su == 0 || sc == 0)
 		goto invalid;
@@ -1054,11 +1054,10 @@ int ceph_calc_file_object_mapping(struct
ceph_file_layout *layout,

 	/*
 	 * Calculate the length of the extent being written to the selected
-	 * object. This is the minimum of the full length requested (plen) or
+	 * object. This is the minimum of the full length requested (len) or
 	 * the remainder of the current stripe being written to.
 	 */
-	*oxlen = min_t(u64, *plen, su - su_offset);
-	*plen = *oxlen;
+	*oxlen = min_t(u64, len, su - su_offset);

 	dout(" obj extent %llu~%llu\n", *oxoff, *oxlen);
 	return 0;
-- 
1.7.9.5

