From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/2] ceph: Update max_len with minimum required size
Date: Tue,  5 Oct 2010 16:03:42 +0530
Message-ID: <1286274822-27738-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1286274822-27738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:42196 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932895Ab0JEKdu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Oct 2010 06:33:50 -0400
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id o95AT6mU003412
	for <ceph-devel@vger.kernel.org>; Tue, 5 Oct 2010 21:29:06 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o95AXm5L1667118
	for <ceph-devel@vger.kernel.org>; Tue, 5 Oct 2010 21:33:48 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o95AXmQI006091
	for <ceph-devel@vger.kernel.org>; Tue, 5 Oct 2010 21:33:48 +1100
In-Reply-To: <1286274822-27738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@newdream.net
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

encode_fh on error should update max_len with minimum required
size, so that caller can redo the call with the reallocated buffer.
This is required with open by handle patch series

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 fs/ceph/export.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 387c582..e38423e 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -62,13 +62,16 @@ static int ceph_encode_fh(struct dentry *dentry, u32 *rawfh, int *max_len,
 		*max_len = connected_handle_length;
 		type = 2;
 	} else if (*max_len >= handle_length) {
-		if (connectable)
+		if (connectable) {
+			*max_len = connected_handle_length;
 			return 255;
+		}
 		dout("encode_fh %p\n", dentry);
 		fh->ino = ceph_ino(dentry->d_inode);
 		*max_len = handle_length;
 		type = 1;
 	} else {
+		*max_len = handle_length;
 		return 255;
 	}
 	return type;
-- 
1.7.0.4

