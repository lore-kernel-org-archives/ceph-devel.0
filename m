From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 09/12] ceph: remove call to bdi_unregister
Date: Thu,  8 Jan 2015 18:45:30 +0100
Message-ID: <1420739133-27514-10-git-send-email-hch@lst.de>
References: <1420739133-27514-1-git-send-email-hch@lst.de>
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420739133-27514-1-git-send-email-hch-jcswGhMUV9g@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>
Cc: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

bdi_destroy already does all the work, and if we delay freeing the
anon bdev we can get away with just that single call.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 fs/ceph/super.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 50f06cd..e350cc1 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -40,17 +40,6 @@ static void ceph_put_super(struct super_block *s)
 
 	dout("put_super\n");
 	ceph_mdsc_close_sessions(fsc->mdsc);
-
-	/*
-	 * ensure we release the bdi before put_anon_super releases
-	 * the device name.
-	 */
-	if (s->s_bdi == &fsc->backing_dev_info) {
-		bdi_unregister(&fsc->backing_dev_info);
-		s->s_bdi = NULL;
-	}
-
-	return;
 }
 
 static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
@@ -1002,11 +991,16 @@ out_final:
 static void ceph_kill_sb(struct super_block *s)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
+	dev_t dev = s->s_dev;
+
 	dout("kill_sb %p\n", s);
+
 	ceph_mdsc_pre_umount(fsc->mdsc);
-	kill_anon_super(s);    /* will call put_super after sb is r/o */
+	generic_shutdown_super(s);
 	ceph_mdsc_destroy(fsc);
+
 	destroy_fs_client(fsc);
+	free_anon_bdev(dev);
 }
 
 static struct file_system_type ceph_fs_type = {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
