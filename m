From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 2/2] ceph: request expedited service on session's last cap flush
Date: Mon,  6 Apr 2020 15:42:28 -0400
Message-ID: <20200406194228.52418-3-jlayton@kernel.org>
References: <20200406194228.52418-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgDFTmd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:42:33 -0400
In-Reply-To: <20200406194228.52418-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ukernel@gmail.com, idryomov@gmail.com, sage@redhat.com, jfajerski@suse.com, lhenriques@suse.com, gfarnum@redhat.com

When flushing a lot of caps to the MDS's at once (e.g. for syncfs),
we can end up waiting a substantial amount of time for MDS replies, due
to the fact that it may delay some of them so that it can batch them up
together in a single journal transaction. This can lead to stalls when
calling sync or syncfs.

What we'd really like to do is request expedited service on the _last_
cap we're flushing back to the server. If the CHECK_CAPS_FLUSH flag is
set on the request and the current inode was the last one on the
session->s_cap_dirty list, then mark the request with
CEPH_CLIENT_CAPS_SYNC.

Note that this heuristic is not perfect. New inodes can race onto the
list after we've started flushing, but it does seem to fix some common
use cases.

URL: https://tracker.ceph.com/issues/44744
Reported-by: Jan Fajerski <jfajerski@suse.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b27bca0e9651..8ba7d78029f0 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1998,6 +1998,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 	}
 
 	for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
+		int mflags = 0;
 		struct cap_msg_args arg;
 
 		cap = rb_entry(p, struct ceph_cap, ci_node);
@@ -2129,6 +2130,9 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 			flushing = ci->i_dirty_caps;
 			flush_tid = __mark_caps_flushing(inode, session, false,
 							 &oldest_flush_tid);
+			if (flags & CHECK_CAPS_FLUSH &&
+			    list_empty(&session->s_cap_dirty))
+				mflags |= CEPH_CLIENT_CAPS_SYNC;
 		} else {
 			flushing = 0;
 			flush_tid = 0;
@@ -2139,8 +2143,8 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 
 		mds = cap->mds;  /* remember mds, so we don't repeat */
 
-		__prep_cap(&arg, cap, CEPH_CAP_OP_UPDATE, 0, cap_used, want,
-			   retain, flushing, flush_tid, oldest_flush_tid);
+		__prep_cap(&arg, cap, CEPH_CAP_OP_UPDATE, mflags, cap_used,
+			   want, retain, flushing, flush_tid, oldest_flush_tid);
 		spin_unlock(&ci->i_ceph_lock);
 
 		__send_cap(mdsc, &arg, ci);
-- 
2.25.1
