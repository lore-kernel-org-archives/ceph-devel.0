From: Kuan Kai Chiu <big.chiu@bigtera.com>
Subject: [PATCH] mds: fix setting/removing xattrs on root
Date: Mon, 15 Apr 2013 18:23:23 +0800
Message-ID: <1366021404-5812-2-git-send-email-big.chiu@bigtera.com>
References: <y>
 <1366021404-5812-1-git-send-email-big.chiu@bigtera.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:34256 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab3DOKXk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 06:23:40 -0400
Received: by mail-da0-f47.google.com with SMTP id s35so2013593dak.34
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 03:23:39 -0700 (PDT)
In-Reply-To: <1366021404-5812-1-git-send-email-big.chiu@bigtera.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: henry@bigtera.com, Kuan Kai Chiu <big.chiu@bigtera.com>

MDS crashes while journaling dirty root inode in handle_client_setxattr
and handle_client_removexattr. We should use journal_dirty_inode to
safely log root inode here.
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

