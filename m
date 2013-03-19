From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH] ceph: fix buffer pointer advance in ceph_sync_write
Date: Tue, 19 Mar 2013 09:46:26 +0800
Message-ID: <1363657586-9116-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:48314 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757492Ab3CSBqj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Mar 2013 21:46:39 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so2876826bkc.30
        for <ceph-devel@vger.kernel.org>; Mon, 18 Mar 2013 18:46:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We should advance the user data pointer by _len_ instead of _written_.
_len_ is the data length written in each iteration while _written_ is the
accumulated data length we have writtent out.

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 fs/ceph/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e51558f..4bcbcb6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -608,7 +608,7 @@ out:
 		pos += len;
 		written += len;
 		left -= len;
-		data += written;
+		data += len;
 		if (left)
 			goto more;
 
-- 
1.7.9.5

