From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] libceph: do not dereference a NULL bio pointer
Date: Wed,  5 Feb 2014 15:47:43 +0200
Message-ID: <1391608063-5744-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:46031 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbaBENrs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Feb 2014 08:47:48 -0500
Received: by mail-la0-f46.google.com with SMTP id b8so331328lan.33
        for <ceph-devel@vger.kernel.org>; Wed, 05 Feb 2014 05:47:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Kent Overstreet <kmo@daterainc.com>

Commit f38a5181d9f3 ("ceph: Convert to immutable biovecs") introduced
a NULL pointer dereference, which broke rbd in -rc1.  Fix it.

Cc: Kent Overstreet <kmo@daterainc.com>
Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/messenger.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 0e478a0f4204..30efc5c18622 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -840,9 +840,13 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
 
 	if (!cursor->bvec_iter.bi_size) {
 		bio = bio->bi_next;
-		cursor->bvec_iter = bio->bi_iter;
+		cursor->bio = bio;
+		if (bio)
+			cursor->bvec_iter = bio->bi_iter;
+		else
+			memset(&cursor->bvec_iter, 0,
+			       sizeof(cursor->bvec_iter));
 	}
-	cursor->bio = bio;
 
 	if (!cursor->last_piece) {
 		BUG_ON(!cursor->resid);
-- 
1.7.10.4

