Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20BE405C4C
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283144; cv=none; b=Y0E9jC813l53qwABmOacX6EnqCrC/dJubJlz3Wcff0FIBqjAZxUGDN9BloPTSqWXEHrhKSu7Y6ZKEJbQENbiH0O/1Y75SjzHMZZZM7QhsJrQRheoQBjzR3NsWlRumqiIVD9E7aCOdHUW9NAawdYmuTGgCXq6tFd8wHGKnXEdYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283144; c=relaxed/simple;
	bh=q9H1mYPKwqzAq/5JPtl09GfxSnFUg8n7v+ujwgeR4XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1f0tQQs2Nw5yBPiQlVH1nJff5OWPTX4o64fKkhasRJS4NxnA6aqng5n9LDta+Rj4t8ePeQkZgcjTzLWxQb4Ou4W2egccWoKsX8MYnZLaDiza5JRFQffkqYJzSHRWTFRSSclONXNDOE/KcIUrqh3HRyv/TjZXF6ciUHkh9eOWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VCVCIGgU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VCVCIGgU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so842312f8f.0
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283141; x=1781887941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g28n3FwE1lgT3amxjdZSA+3B3Wc75t5R34RM1+xg8nI=;
        b=VCVCIGgUfU6VRVYnDqj3sw/SscuYkxgdvF35dEtrN3gAHzEMSh1y5WWba/azwhHyoR
         aLksk0xC/NiRKLJqxUtXWtDDRofWFMGqi5yrV7nPWCZ9Z52UOXxePke9lG1qH7grmuOf
         Ko0vEp8rXr5WUZCoi0fiBhG1aWPEGESS3eDAT3aDZu5MunNfSXkOHiQfSJ6qzXJONFsC
         8j02m6QA2yb9ZIj1TVVtB7D84sLHdU6xvT3ovITQQCkQ8r1GC6m3tpt5aN0TGOLwJoqZ
         +YvC/tQEMkSHJWSh2JQsUfJn2bhXqRCNfNgOBen6HbkDYiAVharqsrciqdMnWjxyrK13
         xazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283141; x=1781887941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g28n3FwE1lgT3amxjdZSA+3B3Wc75t5R34RM1+xg8nI=;
        b=TuVCokzLeiUoqwsNDe2jgLrpwbqEgiK89n9vqY/BoqyQfKL8kHKY7iZjSRhOzX6UT2
         7nRGwhx1Xcnj318dUapjoUKUCdeLPNqFeVykyCtjV6eMEFjRXhho4SMa3vgbBRIsvqMu
         KSiQfSiS/PsHlWCb0IqLwhfttx1uFWgzyk8+qJVKqQJHY2BCAZHw1ciThVVjnp83ptgB
         PIjLS94WLG+JN4ZYt5wBYkGLmj3Pg4GOjdbZJc7R//LvqK3Tp2ekRwdiwOmPlPB4BTbz
         yaVzCWjNssoZ+LHlGbSRnwWFkHxsToWCOhbyyaqnN/6STEFoJSFS0nE4FTGaWpHKyEFk
         aexQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QfZQTXxlqcZiMVJ8MGd+XFqsc0MLdE98VpnLxPKG+0VKKAbE6TXSnMnurGe7FGt29PYWEmvScgVI+@vger.kernel.org
X-Gm-Message-State: AOJu0YxhA8PFt5fc8/0pzBcooJwIK0wNNBFO618ou3ATsEsHNknIUXSh
	LLTWSR4IkVLQbPbmBz7shR4V/GRaDG09qb3viGH2jT0SxE9Qux4Jz3ueznM0YNM090W4soJp5B1
	ZSDR4QhI=
X-Gm-Gg: Acq92OGISdTle+xk1ziMBJ7wJMzMurbpuMfM/1yYHqS+EJuOOWk0vhx5Lfzc/HgsraA
	Hlx4Dps/ekxvpXD4LpnKotRBrtYPoB5bZiIxibGSvWPwlX3RVOjBkSoPKKGjsVpCMXjje++4Owg
	oq/HT8P6FhXg2l/ADoYgxPq7dk5CwrsBEgIGzo+q7Lj+/xRNvBMjdjwoOUcnEtqauma+GomDGFz
	xYDIY0E/Y1ft5LXaw6nHTdexDUwFA3qf6jm/exhe/uU8dpJtuLrHNvBUmQDjEa/2MaP0fAyIISN
	1d3J9D4sogXJRcHV7TxcZ/qpv5b9g8E6moEkSGZgN6Xm9MC43A9nJBLZFm2u+qqWCcZlJCZuoLr
	PjnTh+Qd3sDFcomCTH4+gzFIyfaM1xmcGtVZPpLJchQz0hxHFnhZ1hryRo0plY1cxYYw/6OK+EH
	QxAEGvRXZqfJBDeF1yBD+4b62n5D4fmmY7EJJCRTc9KWIamgieskeSz61LUJGewp2W+IncyqB56
	5ivbUCPEUlnjwZW/3Kxxu11uhY=
X-Received: by 2002:a05:6000:2508:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-46074b84f9bmr10602f8f.33.1781283141468;
        Fri, 12 Jun 2026 09:52:21 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:21 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 07/12] fs/ceph/super: reorder fields to eliminate padding holes
Date: Fri, 12 Jun 2026 18:51:59 +0200
Message-ID: <20260612165204.86137-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165204.86137-1-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reduces the size of `struct ceph_inode_info` by 32 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 9b5119b1d0a9..646ebc03d263 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -248,6 +248,9 @@ struct ceph_cap_flush {
  */
 struct ceph_cap_snap {
 	refcount_t nref;
+
+	umode_t mode;
+
 	struct list_head ci_item;
 
 	struct ceph_cap_flush cap_flush;
@@ -256,7 +259,6 @@ struct ceph_cap_snap {
 	int issued, dirty;
 	struct ceph_snap_context *context;
 
-	umode_t mode;
 	kuid_t uid;
 	kgid_t gid;
 
@@ -266,11 +268,12 @@ struct ceph_cap_snap {
 	u64 size;
 	u64 change_attr;
 	struct timespec64 mtime, atime, ctime, btime;
-	u32 time_warp_seq;
 	u64 truncate_size;
 	u32 truncate_seq;
-	bool writing;   /* a sync write is still in progress */
+	u32 time_warp_seq;
 	int dirty_pages;     /* dirty pages awaiting writeback */
+
+	bool writing;   /* a sync write is still in progress */
 	bool inline_data;
 	bool need_flush;
 };
@@ -315,8 +318,8 @@ struct ceph_inode_xattr {
 	struct rb_node node;
 
 	const char *name;
-	int name_len;
 	const char *val;
+	int name_len;
 	int val_len;
 	bool dirty;
 
@@ -377,9 +380,9 @@ struct ceph_inode_info {
 
 	spinlock_t i_ceph_lock;
 
+	u32 i_time_warp_seq;
 	u64 i_version;
 	u64 i_inline_version;
-	u32 i_time_warp_seq;
 
 	unsigned long i_ceph_flags;
 	atomic64_t i_release_count;
@@ -410,8 +413,8 @@ struct ceph_inode_info {
 
 	s32 i_dir_pin;
 
-	struct rb_root i_fragtree;
 	int i_fragtree_nsplits;
+	struct rb_root i_fragtree;
 	struct mutex i_fragtree_mutex;
 
 	struct ceph_inode_xattrs_info i_xattrs;
@@ -451,15 +454,14 @@ struct ceph_inode_info {
 	struct list_head i_cap_snaps;   /* snapped state pending flush to mds */
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
-	unsigned i_snap_caps;           /* cap bits for snapped files */
 
 	unsigned long i_last_rd;
 	unsigned long i_last_wr;
 	int i_nr_by_mode[CEPH_FILE_MODE_BITS];  /* open file counts */
 
 	struct mutex i_truncate_mutex;
-	u32 i_truncate_seq;        /* last truncate to smaller size */
 	u64 i_truncate_size;       /*  and the size we last truncated down to */
+	u32 i_truncate_seq;        /* last truncate to smaller size */
 	int i_truncate_pending;    /*  still need to call vmtruncate */
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -488,6 +490,8 @@ struct ceph_inode_info {
 	struct list_head i_unsafe_iops;   /* uncommitted mds inode ops */
 	spinlock_t i_unsafe_lock;
 
+	unsigned int i_snap_caps;           /* cap bits for snapped files */
+
 	union {
 		struct ceph_snap_realm *i_snap_realm; /* snap realm (if caps) */
 		struct ceph_snapid_map *i_snapid_map; /* snapid -> dev_t */
-- 
2.47.3

