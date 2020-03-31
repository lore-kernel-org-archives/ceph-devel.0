From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] ceph: request expedited service when flushing caps
Date: Tue, 31 Mar 2020 06:52:23 -0400
Message-ID: <20200331105223.9610-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbgCaKwZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:52:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com, jfajerski@suse.com

Jan noticed some long stalls when flushing caps using sync() after
doing small file creates. For instance, running this:

    $ time for i in $(seq -w 11 30); do echo "Hello World" > hello-$i.txt; sync -f ./hello-$i.txt; done

Could take more than 90s in some cases. The sync() will flush out caps,
but doesn't tell the MDS that it's waiting synchronously on the
replies.

When ceph_check_caps finds that CHECK_CAPS_FLUSH is set, then set the
CEPH_CLIENT_CAPS_SYNC bit in the cap update request. This clues the MDS
into that fact and it can then expedite the reply.

URL: https://tracker.ceph.com/issues/44744
Reported-and-Tested-by: Jan Fajerski <jfajerski@suse.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 61808793e0c0..6403178f2376 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2111,8 +2111,11 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 
 		mds = cap->mds;  /* remember mds, so we don't repeat */
 
-		__prep_cap(&arg, cap, CEPH_CAP_OP_UPDATE, 0, cap_used, want,
-			   retain, flushing, flush_tid, oldest_flush_tid);
+		__prep_cap(&arg, cap, CEPH_CAP_OP_UPDATE,
+			   (flags & CHECK_CAPS_FLUSH) ?
+			    CEPH_CLIENT_CAPS_SYNC : 0,
+			   cap_used, want, retain, flushing, flush_tid,
+			   oldest_flush_tid);
 		spin_unlock(&ci->i_ceph_lock);
 
 		__send_cap(mdsc, &arg, ci);
-- 
2.25.1
