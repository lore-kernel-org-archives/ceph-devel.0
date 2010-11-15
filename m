From: Joe Perches <joe@perches.com>
Subject: [PATCH 33/44] fs/ceph: Remove unnecessary semicolons
Date: Sun, 14 Nov 2010 19:04:52 -0800
Message-ID: <e01252afc842668a94fb0549e2d1833d77a6411f.1289789605.git.joe@perches.com>
References: <cover.1289789604.git.joe@perches.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:1231 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932849Ab0KODF5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 14 Nov 2010 22:05:57 -0500
In-Reply-To: <cover.1289789604.git.joe@perches.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jiri Kosina <trivial@kernel.org>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/ceph/mds_client.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3142b15..931124c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2023,7 +2023,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 		} else  {
 			struct ceph_inode_info *ci = ceph_inode(req->r_inode);
 			struct ceph_cap *cap =
-				ceph_get_cap_for_mds(ci, req->r_mds);;
+				ceph_get_cap_for_mds(ci, req->r_mds);
 
 			dout("already using auth");
 			if ((!cap || cap != ci->i_auth_cap) ||
-- 
1.7.3.1.g432b3.dirty

