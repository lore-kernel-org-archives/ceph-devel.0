From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH] mds: issue caps on file update finish if no client cap specified
Date: Wed, 11 May 2011 03:44:56 -0700
Message-ID: <1305110696-2688-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36593 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670Ab1EKQUY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 12:20:24 -0400
Received: by pzk9 with SMTP id 9so309077pzk.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 09:20:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry.cy.chang@gmail.com>

Fix the following scenario that happens occasionally when running
blogbench:

client released caps on one inode. Then, the inode's ifile was wrlocked
during updating client range. Before the update had finished, client
re-opened the file again for reading. Since ifile was wrlocked, the client
was not given the Fr cap and was blocked on reading forever.

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 src/mds/Locker.cc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 3c7c190..36da98e 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -1242,7 +1242,7 @@ void Locker::file_update_finish(CInode *in, Mutation *mut, bool share, client_t
     if (gather)
       eval_cap_gather(in);
   } else {
-    if (cap && (cap->wanted() & ~cap->pending())) {
+    if (!cap || (cap && (cap->wanted() & ~cap->pending()))) {
       issue_caps(in, cap);
     }
   
-- 
1.7.4.1

