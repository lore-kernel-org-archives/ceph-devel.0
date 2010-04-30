From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH] ceph: fix shadows sparse warning
Date: Fri, 30 Apr 2010 09:56:00 -0400
Message-ID: <1272635760-9917-1-git-send-email-wfp5p@virginia.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46093 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933370Ab0D3SLJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Apr 2010 14:11:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Fix sparse warning:

fs/ceph/auth_x.c:152:20: warning: symbol 'struct_v' shadows an earlier one

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 fs/ceph/auth_x.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/auth_x.c b/fs/ceph/auth_x.c
index d9001a4..abd4127 100644
--- a/fs/ceph/auth_x.c
+++ b/fs/ceph/auth_x.c
@@ -149,7 +149,6 @@ static int ceph_x_proc_ticket_reply(struct ceph_auth_client *ac,
 	dout("%d tickets\n", num);
 	while (num--) {
 		int type;
-		u8 struct_v;
 		struct ceph_x_ticket_handler *th;
 		void *dp, *dend;
 		int dlen;
-- 
1.7.0.6

