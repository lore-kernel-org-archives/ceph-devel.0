From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] ceph: fix three bugs, two in ceph_vxattrcb_file_layout()
Date: Mon, 12 Mar 2012 17:42:27 -0500
Message-ID: <4F5E7BD3.6030308@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54498 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757716Ab2CLWmY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:42:24 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3E00B243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:42:58 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 104B52439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:42:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In ceph_vxattrcb_file_layout(), there is a check to determine
whether a preferred PG should be formatted into the output buffer.
That check assumes that a preferred PG number of 0 indicates "no
preference," but that is wrong.  No preference is indicated by a
negative (specifically, -1) PG number.

In addition, if that condition yields true, the preferred value
is formatted into a sized buffer, but the size consumed by the
earlier snprintf() call is not accounted for, opening up the
possibilty of a buffer overrun.

Finally, in ceph_vxattrcb_dir_rctime() where the nanoseconds part of
the time displayed did not include leading 0's, which led to
erroneous (sub-second portion of) time values being shown.

This fixes these three issues:
     http://tracker.newdream.net/issues/2155
     http://tracker.newdream.net/issues/2156
     http://tracker.newdream.net/issues/2157

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/xattr.c |   11 ++++++++---
  1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 18df51e..715cfc6 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -79,7 +79,7 @@ static size_t ceph_vxattrcb_dir_rbytes(struct 
ceph_inode_info *ci, char *val,
  static size_t ceph_vxattrcb_dir_rctime(struct ceph_inode_info *ci, 
char *val,
  				       size_t size)
  {
-	return snprintf(val, size, "%ld.%ld", (long)ci->i_rctime.tv_sec,
+	return snprintf(val, size, "%ld.09%ld", (long)ci->i_rctime.tv_sec,
  			(long)ci->i_rctime.tv_nsec);
  }

@@ -118,10 +118,15 @@ static size_t ceph_vxattrcb_file_layout(struct 
ceph_inode_info *ci, char *val,
  		(unsigned long long)ceph_file_layout_su(ci->i_layout),
  		(unsigned long long)ceph_file_layout_stripe_count(ci->i_layout),
  		(unsigned long long)ceph_file_layout_object_size(ci->i_layout));
-	if (ceph_file_layout_pg_preferred(ci->i_layout))
-		ret += snprintf(val + ret, size, "preferred_osd=%lld\n",
+
+	if (ceph_file_layout_pg_preferred(ci->i_layout) >= 0) {
+		val += ret;
+		size -= ret;
+		ret += snprintf(val, size, "preferred_osd=%lld\n",
  			    (unsigned long long)ceph_file_layout_pg_preferred(
  				    ci->i_layout));
+	}
+
  	return ret;
  }

-- 
1.7.5.4

