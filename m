From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH] ceph: convert comma to semicolon
Date: Wed, 23 Jul 2014 20:11:11 +0530
Message-ID: <20140723144111.GA3190@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: ceph-devel.vger.kernel.org

Replace a comma between expression statements by a semicolon. This changes
the semantics of the code, but given the current indentation appears to be
what is intended.

A simplified version of the Coccinelle semantic patch that performs this
transformation is as follows:
// <smpl>
@r@
expression e1,e2;
@@

 e1
-,
+;
 e2;
// </smpl>

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 1fde164..6d1cd45 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3277,7 +3277,7 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 			rel->ino = cpu_to_le64(ceph_ino(inode));
 			rel->cap_id = cpu_to_le64(cap->cap_id);
 			rel->seq = cpu_to_le32(cap->seq);
-			rel->issue_seq = cpu_to_le32(cap->issue_seq),
+			rel->issue_seq = cpu_to_le32(cap->issue_seq);
 			rel->mseq = cpu_to_le32(cap->mseq);
 			rel->caps = cpu_to_le32(cap->implemented);
 			rel->wanted = cpu_to_le32(cap->mds_wanted);
-- 
1.9.1
