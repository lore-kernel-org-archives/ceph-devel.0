From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [trivial] fs: ceph: Fix typo in xattr.c
Date: Tue, 23 Oct 2012 01:06:38 +0900
Message-ID: <1350921998-7661-1-git-send-email-standby24x7@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35948 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440Ab2JVQGn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 12:06:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, trivial@kernel.org, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>

Correct spelling typo in debug message

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 fs/ceph/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 2c2ae5b..f4b2c0e 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -813,7 +813,7 @@ retry:
 		struct ceph_buffer *blob;
 
 		spin_unlock(&ci->i_ceph_lock);
-		dout(" preaallocating new blob size=%d\n", required_blob_size);
+		dout(" preallocating new blob size=%d\n", required_blob_size);
 		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
 		if (!blob)
 			goto out;
@@ -909,7 +909,7 @@ retry:
 		struct ceph_buffer *blob;
 
 		spin_unlock(&ci->i_ceph_lock);
-		dout(" preaallocating new blob size=%d\n", required_blob_size);
+		dout(" preallocating new blob size=%d\n", required_blob_size);
 		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
 		if (!blob)
 			goto out;
-- 
1.8.0.rc3.16.g8ead1bf

