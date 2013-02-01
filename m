From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: fix messenger CONFIG_BLOCK dependencies
Date: Thu, 31 Jan 2013 23:31:13 -0600
Message-ID: <510B5321.9020000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33049 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab3BAFbI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 00:31:08 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so3092025ieb.20
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 21:31:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The ceph messenger has a few spots that are only used when
bio messages are supported, and that's only when CONFIG_BLOCK
is defined.  This surrounds a couple of spots with #ifdef's
that would cause a problem if CONFIG_BLOCK were not present
in the kernel configuration.

This resolves:
    http://tracker.ceph.com/issues/3976

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    2 ++
 net/ceph/messenger.c           |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 14ba5ee..60903e0 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -83,9 +83,11 @@ struct ceph_msg {
 	struct list_head list_head;

 	struct kref kref;
+#ifdef CONFIG_BLOCK
 	struct bio  *bio;		/* instead of pages/pagelist */
 	struct bio  *bio_iter;		/* bio iterator */
 	int bio_seg;			/* current bio segment */
+#endif /* CONFIG_BLOCK */
 	struct ceph_pagelist *trail;	/* the trailing part of the data */
 	bool front_is_vmalloc;
 	bool more_to_follow;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5ccf87e..8a62a55 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -9,8 +9,9 @@
 #include <linux/slab.h>
 #include <linux/socket.h>
 #include <linux/string.h>
+#ifdef	CONFIG_BLOCK
 #include <linux/bio.h>
-#include <linux/blkdev.h>
+#endif	/* CONFIG_BLOCK */
 #include <linux/dns_resolver.h>
 #include <net/tcp.h>

@@ -2651,9 +2652,11 @@ struct ceph_msg *ceph_msg_new(int type, int
front_len, gfp_t flags,
 	m->page_alignment = 0;
 	m->pages = NULL;
 	m->pagelist = NULL;
+#ifdef	CONFIG_BLOCK
 	m->bio = NULL;
 	m->bio_iter = NULL;
 	m->bio_seg = 0;
+#endif	/* CONFIG_BLOCK */
 	m->trail = NULL;

 	/* front */
-- 
1.7.9.5

