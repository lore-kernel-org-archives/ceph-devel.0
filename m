From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 2/3] Ceph fscache: Update object store limit after file writing
Date: Thu, 26 Dec 2013 06:29:27 -0800
Message-ID: <60624625dc3bf53737dabf368a23ca7151c9a616.1388066937.git.liwang@ubuntukylin.com>
References: <cover.1388066937.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:56476 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3LZOav (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Dec 2013 09:30:51 -0500
In-Reply-To: <cover.1388066937.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1388066937.git.liwang@ubuntukylin.com>
References: <cover.1388066937.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Milosz Tanski <milosz@adfin.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Min Chen <minchen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

From: Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Synchronize object->store_limit[_l] with new inode->i_size after file writing.

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/ceph/file.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3de8982..b6df7ab 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -786,6 +786,7 @@ retry_snap:
 			goto retry_snap;
 		}
 	} else {
+		loff_t old_size = inode->i_size;
 		/*
 		 * No need to acquire the i_truncate_mutex. Because
 		 * the MDS revokes Fwb caps before sending truncate
@@ -796,6 +797,8 @@ retry_snap:
 		written = generic_file_buffered_write(iocb, iov, nr_segs,
 						      pos, &iocb->ki_pos,
 						      count, 0);
+		if (inode->i_size > old_size)
+			ceph_fscache_update_objectsize(inode);
 		mutex_unlock(&inode->i_mutex);
 	}
 
-- 
1.7.9.5

