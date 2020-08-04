From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] ceph: handle zero-length feature mask in session messages
Date: Tue,  4 Aug 2020 12:31:56 -0400
Message-ID: <20200804163156.314711-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgHDQcA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:32:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, edward6@linux.ibm.com, pdonnell@redhat.com

Most session messages contain a feature mask, but the MDS will routinely
send a REJECT message with one that is zero-length.

Commit 0fa8263367db (ceph: fix endianness bug when handling MDS session
feature bits) fixed the decoding of the feature mask, but failed to
account for the MDS sending a zero-length feature mask. This causes
REJECT message decoding to fail.

Skip trying to decode a feature mask if the word count is zero.

Cc: stable@vger.kernel.org # v5.7.x: 0fa8263367db: ceph: fix endianness bug when handling MDS session feature bits
Fixes: 0fa8263367db (ceph: fix endianness bug when handling MDS session feature bits)
URL: https://tracker.ceph.com/issues/46823
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1095802ad9bd..4a26862d7667 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3358,8 +3358,10 @@ static void handle_session(struct ceph_mds_session *session,
 			goto bad;
 		/* version >= 3, feature bits */
 		ceph_decode_32_safe(&p, end, len, bad);
-		ceph_decode_64_safe(&p, end, features, bad);
-		p += len - sizeof(features);
+		if (len) {
+			ceph_decode_64_safe(&p, end, features, bad);
+			p += len - sizeof(features);
+		}
 	}
 
 	mutex_lock(&mdsc->mutex);
-- 
2.26.2
