From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 06/11] libceph: CEPH_OSD_FLAG_* enum update
Date: Mon, 27 Jan 2014 17:58:48 +0200
Message-ID: <1390838333-32266-7-git-send-email-ilya.dryomov@inktank.com>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:53333 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbaA0QAF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 11:00:05 -0500
Received: by mail-la0-f52.google.com with SMTP id c6so4601888lan.39
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 08:00:04 -0800 (PST)
In-Reply-To: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Update CEPH_OSD_FLAG_* enum.  (We need CEPH_OSD_FLAG_IGNORE_OVERLAY to
support tiering).

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/rados.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 68c96a508ac2..96292df4041b 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -344,6 +344,10 @@ enum {
 	CEPH_OSD_FLAG_EXEC_PUBLIC =    0x1000,  /* DEPRECATED op may exec (public) */
 	CEPH_OSD_FLAG_LOCALIZE_READS = 0x2000,  /* read from nearby replica, if any */
 	CEPH_OSD_FLAG_RWORDERED =      0x4000,  /* order wrt concurrent reads */
+	CEPH_OSD_FLAG_IGNORE_CACHE =   0x8000,  /* ignore cache logic */
+	CEPH_OSD_FLAG_SKIPRWLOCKS =   0x10000,  /* skip rw locks */
+	CEPH_OSD_FLAG_IGNORE_OVERLAY = 0x20000, /* ignore pool overlay */
+	CEPH_OSD_FLAG_FLUSH =         0x40000,  /* this is part of flush */
 };
 
 enum {
-- 
1.7.10.4

