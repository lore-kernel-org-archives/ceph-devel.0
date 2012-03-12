From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 4/5] ceph: use 64-bit math in ceph_calc_file_object_mapping()
Date: Mon, 12 Mar 2012 17:57:51 -0500
Message-ID: <4F5E7F6F.6060403@dreamhost.com>
References: <4F5E7DA5.4040802@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44874 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757699Ab2CLW5r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:57:47 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id D4450243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:58:21 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A7D7C2439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:58:21 -0700 (PDT)
In-Reply-To: <4F5E7DA5.4040802@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Convert ceph_calc_file_object_mapping() so it uses 64-bit variables
and divide operators.  This is in anticipation of the next patch,
to keep the the changes it incurs more focused.

I made most of the variable names more verbose, and because it now
uses do_div() some of the calculations get done in a different
order.  Net result is that the code does what it did before, but it
looks quite a bit different...

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/osdmap.c |  112 
+++++++++++++++++++++++++++++++++--------------------
  1 files changed, 70 insertions(+), 42 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index f5f6e41..26c30e7 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -933,59 +933,87 @@ bad:


  /*
- * calculate file layout from given offset, length.
- * fill in correct oid, logical length, and object extent
- * offset, length.
+ * calculate file layout from given offset, length.  fill in correct
+ * object number, logical length, and object extent offset and length.
   *
- * for now, we write only a single su, until we can
- * pass a stride back to the caller.
+ * for now, we write only a single stripe_unit, until we can pass a
+ * stride back to the caller.
   */
  void ceph_calc_file_object_mapping(struct ceph_file_layout *layout,
-				   u64 off, u64 *plen,
-				   u64 *ono,
-				   u64 *oxoff, u64 *oxlen)
+				   u64 off,
+				   u64 *plen,
+				   u64 *object_num,
+				   u64 *object_ext_off,
+				   u64 *object_ext_len)
  {
-	u32 osize = (u32) ceph_file_layout_object_size(layout);
-	u32 su = (u32) ceph_file_layout_stripe_unit(layout);
-	u32 sc = (u32) ceph_file_layout_stripe_count(layout);
-	u32 bl, stripeno, stripepos, objsetno;
-	u32 su_per_object;
-	u64 t, su_offset;
-
-	dout("mapping %llu~%llu  osize %u fl_su %u\n", off, *plen,
-	     osize, su);
-	su_per_object = osize / su;
-	dout("osize %u / su %u = su_per_object %u\n", osize, su,
-	     su_per_object);
-
-	BUG_ON((su & ~PAGE_MASK) != 0);
-	/* bl = *off / su; */
-	t = off;
-	do_div(t, su);
-	bl = t;
-	dout("off %llu / su %u = bl %u\n", off, su, bl);
-
-	stripeno = bl / sc;
-	stripepos = bl % sc;
-	objsetno = stripeno / su_per_object;
-
-	*ono = objsetno * sc + stripepos;
-	dout("objset %u * sc %u = ono %u\n", objsetno, sc, (unsigned)*ono);
-
-	/* *oxoff = *off % layout->fl_stripe_unit;  # offset in su */
-	t = off;
-	su_offset = do_div(t, su);
-	*oxoff = su_offset + (stripeno % su_per_object) * su;
+	u64 object_size = (u64) ceph_file_layout_object_size(layout);
+	u64 stripe_unit = (u64) ceph_file_layout_stripe_unit(layout);
+	u64 stripe_count = (u64) ceph_file_layout_stripe_count(layout);
+	u64 stripe_unit_per_object;
+	u64 stripe_unit_num;
+	u64 stripe_unit_offset;
+	u64 stripe_num;
+	u64 stripe_pos;			/* Which object within an object set */
+	u64 obj_set_num;
+	u64 obj_stripe_unit_num;	/* Which stripe_unit within object */
+
+	BUG_ON((stripe_unit & ~PAGE_MASK) != 0);
+
+	dout("mapping %llu~%llu  object_size %llu fl_stripe_unit %llu\n",
+		off, *plen, object_size, stripe_unit);
+
+	/* stripe_unit_per_object = object_size / stripe_unit; */
+	stripe_unit_per_object = object_size;
+	do_div(stripe_unit_per_object, stripe_unit);
+	dout("object_size %llu / stripe_unit %llu "
+			"= stripe_unit_per_object %llu\n",
+		object_size, stripe_unit, stripe_unit_per_object);
+
+	/*
+	 * stripe_unit_num = off / stripe_unit;
+	 * stripe_unit_offset = off % stripe_unit;
+	 */
+	stripe_unit_num = off;
+	stripe_unit_offset = do_div(stripe_unit_num, stripe_unit);
+	dout("off %llu / stripe_unit %llu = "
+			"stripe_unit_num %llu rem stripe_unit_offset = %llu\n",
+		off, stripe_unit, stripe_unit_num, stripe_unit_offset);
+
+	/*
+	 * stripe_num = stripe_unit_num / stripe_count;
+	 * stripe_pos = stripe_unit_num % stripe_count;
+	 */
+	stripe_num = stripe_unit_num;
+	stripe_pos = do_div(stripe_num, stripe_count);
+	dout("stripe_unit_num %llu / stripe_count %llu = "
+			"stripe_num %llu rem stripe_pos %llu\n",
+		stripe_unit_num, stripe_count, stripe_num, stripe_pos);
+
+	/*
+	 * obj_set_num = stripe_num / stripe_unit_per_object;
+	 * obj_stripe_unit_num = stripe_num % stripe_unit_per_object;
+	 */
+	obj_set_num = stripe_num;
+	obj_stripe_unit_num = do_div(obj_set_num, stripe_unit_per_object);
+
+	*object_num = obj_set_num * stripe_count + stripe_pos;
+	dout("obj_set_num %llu * stripe_count %llu = object_num %llu\n",
+		obj_set_num, stripe_count, *object_num);
+	*object_ext_off = stripe_unit * obj_stripe_unit_num
+				+ stripe_unit_offset;
+	dout("obj_stripe_unit_num %llu * stripe_unit %llu = "
+			"object_ext_off %llu\n",
+		obj_stripe_unit_num, stripe_unit, *object_ext_off);

  	/*
  	 * Calculate the length of the extent being written to the selected
  	 * object. This is the minimum of the full length requested (plen) or
  	 * the remainder of the current stripe being written to.
  	 */
-	*oxlen = min_t(u64, *plen, su - su_offset);
-	*plen = *oxlen;
+	*object_ext_len = min_t(u64, *plen, stripe_unit - stripe_unit_offset);
+	*plen = *object_ext_len;

-	dout(" obj extent %llu~%llu\n", *oxoff, *oxlen);
+	dout(" obj extent %llu~%llu\n", *object_ext_off, *object_ext_len);
  }
  EXPORT_SYMBOL(ceph_calc_file_object_mapping);

-- 
1.7.5.4

