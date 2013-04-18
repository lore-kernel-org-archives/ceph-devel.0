From: Kuan Kai Chiu <big.chiu@bigtera.com>
Subject: [PATCH 1/2] mds: fix setting/removing xattrs on root
Date: Thu, 18 Apr 2013 14:43:25 +0800
Message-ID: <1366267406-1449-2-git-send-email-big.chiu@bigtera.com>
References: <y>
 <1366267406-1449-1-git-send-email-big.chiu@bigtera.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:62251 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965286Ab3DRGoh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 02:44:37 -0400
Received: by mail-pb0-f54.google.com with SMTP id xa7so3607pbc.27
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 23:44:36 -0700 (PDT)
In-Reply-To: <1366267406-1449-1-git-send-email-big.chiu@bigtera.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Kuan Kai Chiu <big.chiu@bigtera.com>

MDS crashes while journaling dirty root inode in handle_client_setxattr
and handle_client_removexattr. We should use journal_dirty_inode to
safely log root inode here.

Signed-off-by: Kuan Kai Chiu <big.chiu@bigtera.com>
---
 src/mds/Server.cc |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 11ab834..1e62dd2 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -3907,8 +3907,7 @@ void Server::handle_client_setxattr(MDRequest *mdr)
   mdlog->start_entry(le);
   le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
   mdcache->predirty_journal_parents(mdr, &le->metablob, cur, 0, PREDIRTY_PRIMARY, false);
-  mdcache->journal_cow_inode(mdr, &le->metablob, cur);
-  le->metablob.add_primary_dentry(cur->get_projected_parent_dn(), true, cur);
+  mdcache->journal_dirty_inode(mdr, &le->metablob, cur);
 
   journal_and_reply(mdr, cur, 0, le, new C_MDS_inode_update_finish(mds, mdr, cur));
 }
@@ -3964,8 +3963,7 @@ void Server::handle_client_removexattr(MDRequest *mdr)
   mdlog->start_entry(le);
   le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
   mdcache->predirty_journal_parents(mdr, &le->metablob, cur, 0, PREDIRTY_PRIMARY, false);
-  mdcache->journal_cow_inode(mdr, &le->metablob, cur);
-  le->metablob.add_primary_dentry(cur->get_projected_parent_dn(), true, cur);
+  mdcache->journal_dirty_inode(mdr, &le->metablob, cur);
 
   journal_and_reply(mdr, cur, 0, le, new C_MDS_inode_update_finish(mds, mdr, cur));
 }
-- 
1.7.9.5

