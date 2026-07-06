Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA70627F728
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346602; cv=none; b=ONNsX9SefjUJONQLQe5qhVe/jHQY5iJwlOiR2yJb8NoOPMFH0DIsT74W/A3NWz2xuj6ecBlYpow9zTS1LWGsKYpVnbdVximL9Xu4yERj3/OqpSatIlkTxnBDCqq/E0Wdcz2WkkxCYI0RK0DD2BsWoCUzYGzhqIYi6YEykVscJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346602; c=relaxed/simple;
	bh=4l+bbMkykzHgwZUpt3/huIQg0j424FtATF2zrSYyYq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=anhb518g6/t5z2eEcRaRGULtmDMEKlf8KdSeLlOwGCpHncruwvjgiJm5oV/5ZT9HyOqZ5CaDtH58drKtrMDyR4cFarF4Z8tPWnMo3za0U9Es2dXoVQ+NQuQM3rSOF2zsVeAyQyTaDBketsVUNOKZwYCV84lZsMH7ypnO8Muwn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpRwSxAi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr1S4IR0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpRwSxAi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr1S4IR0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783346600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fqSbFkmSbonmArr6wmiJt/y10HcMy0ch93ySeQpyoFc=;
	b=IpRwSxAiQUaZqB4ym4WkRhWThJPN/ZqT3QYxI5XCKzdO8wq4M8GhOBiH9rmBM5eHHPVAga
	y88ZS3RwqLnrbyc33J901w6ZH/ryyj9+8dfXxarAiyXz8wlHEtJC7cQNQSdLCYYTWqetkl
	3UlFjeGgB/4XU6l7yIoVybnUEAl5IEg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-GlxjQPJoOamiOf9nYcH_FA-1; Mon, 06 Jul 2026 10:03:17 -0400
X-MC-Unique: GlxjQPJoOamiOf9nYcH_FA-1
X-Mimecast-MFC-AGG-ID: GlxjQPJoOamiOf9nYcH_FA_1783346596
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e9a2b95b5so478381585a.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783346596; x=1783951396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fqSbFkmSbonmArr6wmiJt/y10HcMy0ch93ySeQpyoFc=;
        b=Xr1S4IR0uvA6WQ5PXBAOBr03+YlcgyLujOOInaIOuHJjdlmKpVoCqWfudwkdLXCDQn
         SxZ6wiIY8HwlQUmg58eOj5rx6f91skVLwFB4G8F3Objt98bQffvHXBuR1EJjbePDAeLB
         PWVTP0rE8nlDTEQ+1sYkpAaNPK4vYRIbacgISffql4bFZh1ikMmhWsG/YZrxZE+hABX/
         uJ/OWZ0nKnJcfFytoM/R3K77PFjPiz3kER81aMIPKvMwdmx7T3m2qqnPKO03oSkZb7oL
         2CTq51LMYqIuIWhtWi65cavDDK6pIJPJO+Vy7k/ZXtLzS81dfn3tFAn0mOhUdQfR7/O7
         r01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346596; x=1783951396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fqSbFkmSbonmArr6wmiJt/y10HcMy0ch93ySeQpyoFc=;
        b=OGCufKWf7UHZT/utMP+1QlABbQoL+xkm2yfPPikcTVz/fuROkLQqBptaoFoSpucIIo
         ABAaxXE1x+6MyTlZVEkaHDVsKZQDweKYkG1VPUKbiGx7sFcLAW1dj/n7Tm8zh3T8iuX4
         MRYTtt8P92LkG6G7hHZ++0bzskuja8IUq+83pz4FyOIDhRV1ckqW6zWWEc5f5elWInOw
         mYfB7hUYm9BKlGxe0/zMu/9erCbXr4znFWzJBS+79k7bJgCSu2ZSOa1nODtW9v10mBvR
         sHRYUshGem6Q5s+MB7zAuClKnhX+yVfCofUJZQuICKGlH/lgQoVsFbMLZeOKHb7ZgO5B
         EjWg==
X-Gm-Message-State: AOJu0YwCcVvmL882U2/T2tDKiezKh0zzDdTsyAOdgwStv+W1tTlPq8HT
	1RrWXAs1q/v7kImxfODphb/G3t3Sf5JPufzQhJhHie4i5233+dRKRfAvOOjq50sqw/0gTEIVgQQ
	BL3XbgVCwEiN2B4UsSKhliIKb89JY3WjQWTLNbwm/YAvpZk2yMcZJW8ZlJIRVSD5ylOlDTdQd3E
	mkSZPhsKvdinG/d7OGtCCAs1Ib5R776v28W6OL6nCedkpgXdqdzw==
X-Gm-Gg: AfdE7ckWzY1TBnKzt+MSQIscbxIpL6nT7Uu9y2gK+xIegRwJkBgxXej2ViWq/0QZebV
	8xOWY24nYpgcvzSbV2rIVGVKE7rrEiPTHHSBsGj5fm6cVj2F31kQq/qFe/0hQ+9Uwk//Qhydpso
	BJApSYHRy4p+vqToJTmUbUyVLCVp5e5fSD+G7hXCaHOCrj/Ez49xFuDCBztEcDtGKn/Q1q7vAL7
	PktGC2hoCOkIbOf7NUeTg/RslWnDLk7rR+uOI0t2fwoJxpBta/LKy7WujUM9gz9vyOUUNFEkSzE
	gpTZX1LfPMdpTDsp78g2jrBDV3aT8GDG5fKyIY1akjaG3eCTvje1TWJ8qUvfHCSRzQ5EDB9enwF
	8+zZvEG5p0Tr6YmeHRto6iqPtUS2RHnLTRMQbBJLQVEMQ
X-Received: by 2002:a05:620a:2991:b0:912:1206:ddd1 with SMTP id af79cd13be357-92ebb52fb00mr95302785a.1.1783346595110;
        Mon, 06 Jul 2026 07:03:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2991:b0:912:1206:ddd1 with SMTP id af79cd13be357-92ebb52fb00mr95293185a.1.1783346594060;
        Mon, 06 Jul 2026 07:03:14 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e9c0f7de9sm711123785a.26.2026.07.06.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:03:13 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubli@redhat.com,
	jlayton@kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH] ceph: make nearfull sync writes opt-in
Date: Mon,  6 Jul 2026 14:03:09 +0000
Message-Id: <20260706140309.1907928-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel CephFS client has historically treated a cluster or pool
NEARFULL condition as a request to force successful writes through
generic_write_sync().  That effectively turns otherwise buffered writes
into synchronous writes and can cause a severe throughput drop as soon
as a single OSD or the file data pool crosses the nearfull threshold.

On modern large clusters, NEARFULL is primarily an operator health
signal rather than an immediate client-side capacity failure.  Operators
can still have substantial usable capacity while a cluster is
rebalancing, splitting PGs, or expanding onto new devices.  RBD, RGW and
the userspace CephFS client do not impose this extra client-side
sync-write throttle, so the kernel client behavior is surprising and
operationally painful.

Change the default behavior so NEARFULL no longer changes normal
write-sync semantics.  FULL and pool FULL still fail with -ENOSPC, and
explicitly synchronous writes continue to be synced by
generic_write_sync().

Add a nearfull_sync mount option for deployments that want the legacy
backpressure behavior.  When this option is set, successful writes are
promoted to IOCB_DSYNC if the cluster or file data pool is marked
NEARFULL, preserving the old behavior for conservative deployments.

Link: https://tracker.ceph.com/issues/74849
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 Documentation/filesystems/ceph.rst |  6 ++++++
 fs/ceph/file.c                     |  8 +++++---
 fs/ceph/super.c                    | 10 ++++++++++
 fs/ceph/super.h                    |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/ceph.rst b/Documentation/filesystems/ceph.rst
index 6d2276a87a5a..ee2ca0c0c654 100644
--- a/Documentation/filesystems/ceph.rst
+++ b/Documentation/filesystems/ceph.rst
@@ -194,6 +194,12 @@ Mount Options
         copies.  Currently, it's only used in copy_file_range, which will revert
         to the default VFS implementation if this option is used.
 
+  nearfull_sync
+	Force written data to stable storage when the cluster or file data pool is
+	marked NEARFULL. This restores the legacy client-side backpressure
+	behavior. By default, CephFS writes are not forced synchronous solely
+	because of NEARFULL.
+
   recover_session=<no|clean>
 	Set auto reconnect mode in the case where the client is blocklisted. The
 	available modes are "no" and "clean". The default is "no".
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3823671ab95a..0ae9f09aa233 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2400,7 +2400,8 @@ static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
  * dropping our cap refs and allowing the pending snap to logically
  * complete _before_ this write occurs.
  *
- * If we are near ENOSPC, write synchronously.
+ * If requested, nearfull writes are synced to preserve the legacy
+ * client-side backpressure behavior.
  */
 static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
@@ -2568,8 +2569,9 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	if (written >= 0) {
-		if ((map_flags & CEPH_OSDMAP_NEARFULL) ||
-		    (pool_flags & CEPH_POOL_FLAG_NEARFULL))
+		if (ceph_test_mount_opt(fsc, NEARFULL_SYNC) &&
+		    ((map_flags & CEPH_OSDMAP_NEARFULL) ||
+		     (pool_flags & CEPH_POOL_FLAG_NEARFULL)))
 			iocb->ki_flags |= IOCB_DSYNC;
 		written = generic_write_sync(iocb, written);
 	}
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 0bbd38933f0e..4d129483e345 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -178,6 +178,7 @@ enum {
 	Opt_pagecache,
 	Opt_sparseread,
 	Opt_lazyio,
+	Opt_nearfull_sync,
 };
 
 enum ceph_recover_session_mode {
@@ -207,6 +208,7 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
 	fsparam_flag_no	("lazyio",			Opt_lazyio),
 	fsparam_string	("mds_namespace",		Opt_mds_namespace),
 	fsparam_string	("mon_addr",			Opt_mon_addr),
+	fsparam_flag_no	("nearfull_sync",		Opt_nearfull_sync),
 	fsparam_flag_no ("poolperm",			Opt_poolperm),
 	fsparam_flag_no ("quotadf",			Opt_quotadf),
 	fsparam_u32	("rasize",			Opt_rasize),
@@ -601,6 +603,12 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 		else
 			fsopt->flags |= CEPH_MOUNT_OPT_LAZYIO;
 		break;
+	case Opt_nearfull_sync:
+		if (result.negated)
+			fsopt->flags &= ~CEPH_MOUNT_OPT_NEARFULL_SYNC;
+		else
+			fsopt->flags |= CEPH_MOUNT_OPT_NEARFULL_SYNC;
+		break;
 	case Opt_test_dummy_encryption:
 #ifdef CONFIG_FS_ENCRYPTION
 		fscrypt_free_dummy_policy(&fsopt->dummy_enc_policy);
@@ -759,6 +767,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",sparseread");
 	if (fsopt->flags & CEPH_MOUNT_OPT_LAZYIO)
 		seq_puts(m, ",lazyio");
+	if (fsopt->flags & CEPH_MOUNT_OPT_NEARFULL_SYNC)
+		seq_puts(m, ",nearfull_sync");
 
 	fscrypt_show_test_dummy_encryption(m, ',', root->d_sb);
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3737ea7ed88b..632ffb1b401e 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -46,6 +46,7 @@
 #define CEPH_MOUNT_OPT_NOPAGECACHE     (1<<16) /* bypass pagecache altogether */
 #define CEPH_MOUNT_OPT_SPARSEREAD      (1<<17) /* always do sparse reads */
 #define CEPH_MOUNT_OPT_LAZYIO          (1<<18) /* force lazyio for all file opens */
+#define CEPH_MOUNT_OPT_NEARFULL_SYNC   (1<<19) /* sync writes when nearfull */
 
 #define CEPH_MOUNT_OPT_DEFAULT			\
 	(CEPH_MOUNT_OPT_DCACHE |		\
-- 
2.34.1

