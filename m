From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] rbd: kill rbd_image_header->snap_seq
Date: Thu, 19 Jul 2012 12:11:52 -0500
Message-ID: <50083FD8.7060009@inktank.com>
References: <50083F65.5030104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:58965 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab2GSRLy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 13:11:54 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so3011822ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 10:11:54 -0700 (PDT)
In-Reply-To: <50083F65.5030104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The snap_seq field in an rbd_image_header structure held the value
from the rbd image header when it was last refreshed.  We now
maintain this value in the snapc->seq field.  So get rid of the
other one.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c299a55..6df8c62 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -82,7 +82,6 @@ struct rbd_image_header {
 	__u8 comp_type;
 	struct ceph_snap_context *snapc;
 	size_t snap_names_len;
-	u64 snap_seq;
 	u32 total_snaps;

 	char *snap_names;
@@ -536,7 +535,6 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 	header->comp_type = ondisk->options.comp_type;

 	atomic_set(&header->snapc->nref, 1);
-	header->snap_seq = le64_to_cpu(ondisk->snap_seq);
 	header->snapc->seq = le64_to_cpu(ondisk->snap_seq);
 	header->snapc->num_snaps = snap_count;
 	header->total_snaps = snap_count;
-- 
1.7.5.4

