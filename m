From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ceph: use msecs_to_jiffies for time conversion
Date: Fri,  6 Feb 2015 06:52:17 -0500
Message-ID: <1423223537-23277-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: ceph-devel.vger.kernel.org

This is only an API consolidation and should make things more readable
it replaces var * HZ / 1000 by msecs_to_jiffies(var).

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was only compile tested with x86_64_defconfig + CONFIG_CEPH_FS=m

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 fs/ceph/mds_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5f62fb7..ced7503 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3070,7 +3070,7 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 		    di->lease_renew_from &&
 		    di->lease_renew_after == 0) {
 			unsigned long duration =
-				le32_to_cpu(h->duration_ms) * HZ / 1000;
+				msecs_to_jiffies(le32_to_cpu(h->duration_ms));
 
 			di->lease_seq = seq;
 			dentry->d_time = di->lease_renew_from + duration;
-- 
1.7.10.4
