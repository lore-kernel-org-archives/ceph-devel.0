Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314E2FC89C
	for <ceph-devel@vger.kernel.org>; Wed,  1 Apr 2026 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021486; cv=none; b=Daw4h7dCdNI8C5oI46FoHIyo0evuqo2c+0BikR7R+aF9Vcc78KSHDEGyod2tBSKZ3HwzNkefwApGdGsXJwrxmMttYERUtHZ92WpUQpZKNKo9f1WFafLu8VdrZ/kRB+x2osVQQqwQ5GRb0XrApCYewyLRUiiKeS4rqfK8+ZlkYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021486; c=relaxed/simple;
	bh=1acFv9UcJq9+zgv/G5mvLf3RsrhjHmkaCp5DZNmUp3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TwHtvSBNNjsLjtOL4Bo1G2HpAdnvSBZJjI8bu11Mxz/imS+BC0nv28y60p/LhXxGmhysv+fuybDvR1FijOwViNlhH6Q9KDBHvA7qiThmzLr5BQUIrZ08rn7668MDP8VMePNls/KYpOFWKQhIEdWabGpXIWPWoZrHs+Mg3jOOYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QVDyLSbY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QVDyLSbY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfb723698so2487821f8f.3
        for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2026 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1775021482; x=1775626282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d53g2GmJS96aqelgbC9uJM1PvtU82NHOHG7LQJxQEik=;
        b=QVDyLSbYyGKm7NOOv2gdoWePoyh+G+Jk3ot9s+osvMHTNW6vAih4sEzRaIxFDt+SUr
         0cytTUymg5QxYnzoOwpBTCvaMR6taQCp2BXFP0yM0DVxhphOKjvZGMZ5cpaXqs8MAFln
         ijPaIK0IdbZ1+cCjeoM8NNXPJfStSoSvDLU7g9INpamaFLwURaxls16MMy7NTo6Om29b
         Z2WeZp25NG5gICe1+MBTiMGMUXb0MyQTO9Fhvlvpa1dz5zogpJO3SzYThsrY0UCP1d92
         mN8hyo3vbez1c7ZvAWx4zkfmcD3+AljrQtgUCjJloLCsP4n5SFfPI9OEyrCVTp5dRqkW
         Owlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021482; x=1775626282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d53g2GmJS96aqelgbC9uJM1PvtU82NHOHG7LQJxQEik=;
        b=NZYb7qm7Ipy+yIWXj7eLcjOL9XfmJyXk0sKSODIps48GhqsYkwTDBVXgQQDfvJ0X/B
         +oqFqyGvKOmVz0WU14Y9Dj40wvX6ej3mkMW+YUU8JtB9yOw0tguaHGeNrEuQaZ663JhF
         rzUh0/3287JrD8sunt7ZcBVFiByG+Yab1YeMkunBYYtavgYeSm8CGTGBIK4SWYgFbqv1
         3LPt5Selt5vYqS3iyvQ8dK3vWWl0Kj27NELoe+nz6AbD9/tR/3GC1DPcPYJZj68Em8uF
         bPtpEI7qlrMS90hhfEA9qi1KrRPKS5WCqOhKElzAdjTBii9LsE/T4WlfI3Fr0nbr27dM
         bH3w==
X-Forwarded-Encrypted: i=1; AJvYcCWQiYOLjT7ud57VOu7FDOzsfbJnAzqc77o3nYEJ48RkNxI1M548jiJgKh/bPJIYP2wvDczcPJayidzK@vger.kernel.org
X-Gm-Message-State: AOJu0YxOq+HORqOoUr9F/6jhZQ6ywlQB4Nc8Doy7zWIf1rKzb4ad58l7
	yn9cjMHltYabkCmvnCi7WSuvRqNAr9WFzB2Qvb02/IfXvy/b0UpQlu98mIMqNCedEDw=
X-Gm-Gg: ATEYQzxMPquZgoll+llHof5FiZuf5HP3cI5WZB3mmFn5IpWOAj+r5wE0pLw9T06ncN7
	PWjczxzHbqkxcdVH/ggbu93pmvrzRiGKZVWRlWYZWB6MuUjqlGSyWYxavaduL81zN6fmjVYtyJc
	r6395sayC8JvQes/jdKK+frxH1GRUjFJzgq6ryQKCHsGDhEdyXVecMppFQ96bSJK0096CMN21bk
	16n7/IOROwHvH9Ht/7SSpRi54Js5L2PyH7WO8z6jnkaQ8aNudC5pY69t4MCTAiGidW5xJ/8bI2l
	Dv5+p80RWGYH9UzJWgr8h0P3bBnTeJTXHYIyHsp1PVSOiuIvkDGCnl260IzzPdIt/I3XMjf2mGN
	0nF7tkXayDwTJvhl0TZ11d97ksEnPSu0t1WaRKmSYD4JiLO186xKyB0OvTXUzhOYbcrjen4nBDb
	rQ/j3ok+bidfXUfZ7/6IZ5PPCDTM7yRwNqRVX9zNQpOZ1JtF1X8XCWEWng5djUvVUjGZRAWR4Kr
	UtEByTTJ/QT7fKz2+JxXMhn2+Y=
X-Received: by 2002:a05:6000:4201:b0:43c:f66e:f2d with SMTP id ffacd0b85a97d-43d150c14camr4102944f8f.27.1775021482478;
        Tue, 31 Mar 2026 22:31:22 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f2b4400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2b:4400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e9e24sm31410655f8f.10.2026.03.31.22.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 22:31:22 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	pc@manguebit.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] ceph: support RWF_DONTCACHE
Date: Wed,  1 Apr 2026 07:31:09 +0200
Message-ID: <20260401053109.1861724-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to commit 902893e39076 ("NFS: Enable use of the RWF_DONTCACHE
flag on the NFS client").

The Ceph client now supports RWF_DONTCACHE for buffered file IO, but
it needs preserve the IOCB_DONTCACHE state through
netfs_write_begin().

Unlike NFS, Ceph does not need to defer drop-behind until after a
separate COMMIT step.  Ceph's buffered writeback completes when the
OSD write completes, so the existing folio_end_writeback() handling is
sufficient.

This patch changes netfs because Ceph does not get its write_begin
folio directly.  ceph_write_begin() is a wrapper around
netfs_write_begin(), and that helper was calling
__filemap_get_folio(FGP_WRITEBEGIN, ...) without access to the kiocb.
As a result, the per-IO IOCB_DONTCACHE flag was lost before folio
allocation.

Fix this by passing the kiocb into netfs_write_begin() and switching
it to write_begin_get_folio(iocb, ...), so IOCB_DONTCACHE is
translated into FGP_DONTCACHE when appropriate.  Then set
FOP_DONTCACHE on ceph_file_fops so the VFS will accept RWF_DONTCACHE
for files on Ceph.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c           | 3 ++-
 fs/ceph/file.c           | 1 +
 fs/netfs/buffered_read.c | 6 +++---
 include/linux/netfs.h    | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2090fc78529c..b4ea3ba8211e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1865,7 +1865,8 @@ static int ceph_write_begin(const struct kiocb *iocb,
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int r;
 
-	r = netfs_write_begin(&ci->netfs, file, inode->i_mapping, pos, len, foliop, NULL);
+	r = netfs_write_begin(iocb, &ci->netfs, file, inode->i_mapping, pos,
+			      len, foliop, NULL);
 	if (r < 0)
 		return r;
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5e7c73a29aa3..341589ef32cd 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -3191,4 +3191,5 @@ const struct file_operations ceph_file_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fallocate	= ceph_fallocate,
 	.copy_file_range = ceph_copy_file_range,
+	.fop_flags = FOP_DONTCACHE,
 };
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index a8c0d86118c5..6ec7c2459d8a 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -589,6 +589,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 
 /**
  * netfs_write_begin - Helper to prepare for writing [DEPRECATED]
+ * @iocb: The kiocb describing the write request
  * @ctx: The netfs context
  * @file: The file to read from
  * @mapping: The mapping to read from
@@ -620,7 +621,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
  * Note that this should be considered deprecated and netfs_perform_write()
  * used instead.
  */
-int netfs_write_begin(struct netfs_inode *ctx,
+int netfs_write_begin(const struct kiocb *iocb, struct netfs_inode *ctx,
 		      struct file *file, struct address_space *mapping,
 		      loff_t pos, unsigned int len, struct folio **_folio,
 		      void **_fsdata)
@@ -631,8 +632,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	int ret;
 
 retry:
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
-				    mapping_gfp_mask(mapping));
+	folio = write_begin_get_folio(iocb, mapping, index, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index ba17ac5bf356..d58c614e32fd 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -414,7 +414,8 @@ int netfs_writeback_single(struct address_space *mapping,
 struct readahead_control;
 void netfs_readahead(struct readahead_control *);
 int netfs_read_folio(struct file *, struct folio *);
-int netfs_write_begin(struct netfs_inode *, struct file *,
+int netfs_write_begin(const struct kiocb *iocb,
+		      struct netfs_inode *ctx, struct file *file,
 		      struct address_space *, loff_t pos, unsigned int len,
 		      struct folio **, void **fsdata);
 int netfs_writepages(struct address_space *mapping,
-- 
2.47.3

