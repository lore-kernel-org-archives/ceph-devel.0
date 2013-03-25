From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: initialize data fields on last msg put
Date: Mon, 25 Mar 2013 11:56:48 -0500
Message-ID: <515081D0.4080405@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:43741 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932751Ab3CYQ4q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 12:56:46 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so5182997ieb.23
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 09:56:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(This patch is available in branch "review/wip-4540" of the
ceph-client git repository, which is based on the current
"testing" branch.)

When the last reference to a ceph message is dropped,
ceph_msg_last_put() is called to clean things up.  For "normal"
messages (allocated via ceph_msg_new() rather than being allocated
from a memory pool) it's sufficient to just release resources.  But
for a mempool-allocated message we actually have to re-initialize
the data fields in the message back to initial state so they're
ready to go in the event the message gets reused.

Some of this was already done; this fleshes it out so it's done
more completely.

This resolves:
    http://tracker.ceph.com/issues/4540

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 997dacc..2ccbd189 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3299,12 +3299,17 @@ void ceph_msg_last_put(struct kref *kref)
 	if (ceph_msg_has_pages(m)) {
 		m->p.length = 0;
 		m->p.pages = NULL;
+		m->p.type = CEPH_OSD_DATA_TYPE_NONE;
 	}
-
 	if (ceph_msg_has_pagelist(m)) {
 		ceph_pagelist_release(m->l.pagelist);
 		kfree(m->l.pagelist);
 		m->l.pagelist = NULL;
+		m->l.type = CEPH_OSD_DATA_TYPE_NONE;
+	}
+	if (ceph_msg_has_bio(m)) {
+		m->b.bio = NULL;
+		m->b.type = CEPH_OSD_DATA_TYPE_NONE;
 	}

 	if (m->pool)
-- 
1.7.9.5

