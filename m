Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC5333730
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322726; cv=none; b=Ho/SBH8USfLZpjQIb3vuLQ3ap2umsGe30EkIUcTJdglI/UeahMu9jkoFraKO5fx+fDc/1DyXHNhfkCTGtRkCUzwfEk6bWXMq/3Hzcy49xy8hWz+qtY9TrT4o2MpVsvzwDTJWEKTeQuv63Smg1LmiN6W4oG8MuM4tjWr6YvDsXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322726; c=relaxed/simple;
	bh=rWcD9UAVTx1Qu4X1tQhXaEYVpYkM9g/KFb6msHCmSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZV5eOtBVpAelofZ8JYcQ5RSdkZ7GENC0RUUf0f/RxyLZko19bwdfwtH4sWfoXzslIVe1E7Fmd9IvtreBPu4jqpKwsuhbja5yQ/6HXWKLBuSSAlfa/7L81CwvAymIcQn4ZgSjKuAVRtDT02MtUvB+mlx4vlRIaiYx3cMY7Oqj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=evmLZpy+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="evmLZpy+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-474303f3c72so1522049f8f.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322701; x=1783927501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaBPZv5XdoOUADi4qlmlEchxRuZesTRRDOJ68FGWcG0=;
        b=evmLZpy+jl0/xhHmiHVWCss9UBXf666QuI+N3p9LVBJDS6icgD56XWrBtu61V5F0Vx
         6c1tXxnPo3LUmytXJIfwO8Pw4r9X2UOYJbHsZU4lGauYYqPGCFKY8UyGae5oug8EU/VW
         TnkGY57YenN0XUwPhxI58Mgdda1W87Ww2tRJFu0bBW0aqkMaAflgdrVJbdss2aD1sl1q
         QYkAZrocAEIXHJmEHQ84gv+G7nxvxKFoaAZwTfnLZ+mozGPhxjkT71cdADBk0UxFhQQf
         qOQUMMjRDNTWFFh+7hAJ0MZSUTVYLl9WaOFzXcu3+4hqj+0fuI45MT//fJNBs5pdFRoB
         ORHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322701; x=1783927501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iaBPZv5XdoOUADi4qlmlEchxRuZesTRRDOJ68FGWcG0=;
        b=ZsJTiIpcszdf1b8Fs74KPG3Az+f7S630dTd73ZvRnvGG4adIhWrLfaZlKv7tMMmurl
         2Uqg8r95R0MVUv9rclejGqFkLvGMA0ls9H3ElnethdGOLAbkIh5eOegpiUDo+4oRWk/G
         9RSnXM9fbc+/hd/D+9pKj9cFkDLSJ3fyd/1TUKNYKZ/6xKE1MmPvSHIbIQ2kfVTKqTXH
         +hbT51ycV6nrnTZcmRr4g7G6Sy+qE8/veLpsZA75kwDJz+CvuLWXzRmUSqDjzSUvRwab
         y2se/hKbhh/GJJkDaHE83lZlK1Ul+Qb9Z8rXdRIGVE1zUdQ90qivajRZlrhWjViF+rtm
         DIzA==
X-Forwarded-Encrypted: i=1; AHgh+RqYqpwrB1BcOAdEflvrvYxVvzBCttZjWasFRF6YwJJ2FehHsgB4Wtlyi+LHvSTGp80mqrFXPwdvLBXS@vger.kernel.org
X-Gm-Message-State: AOJu0YzK04Tgg3x5LCaOLfmyp+5pPiSqWEGjBx3jVRduSJQmC/5cfh8I
	+UOgRh8xtgmmJefSZHZE3SKU+ozhY8OFCQr/4VMAoj5NSJLGKWxFptRKKRl/mem87y0=
X-Gm-Gg: AfdE7cmfz6Sr78/m7Su8I/K/JUNuKeGXZDCEZlcGzz6OPj1V13O99dEol/KSufFtma1
	Vl6pecYkyh6OKsfEU/iyhIFLhd++jrofUzE1JoOUMe8aegNkOF5f0/9/srier8wDfIrV6TCr4H7
	vxRH6J5f/W2xtVyaAh5muh7hSSf44fUBHcjUO/DdCt+leKKHz/FK9hCs+wuNzWhwR4wq68L+Ze0
	cRazKAjUjGFpAeinkiyPBDjTW7G1UwVquNGobMltVDCckkLjueHuVMCGEhWTUHRQyGgxIiUpw0h
	zxhI2OF6RSu2N4ndQz3pgDT3zKoef1UF8lsWyNj2GCdtejI0iEgZncIm0qwNRMwIDkUdTk8QOsp
	/KA+0FZWvIfrcTgxmaXWk5OFwNKBC8qZ3twEfD+srH2HP9pEch3OSNZojJEjP/gJE5gqbrMWLnT
	f6Rr2GoOCnJ98BTr6jzEFj39XYoUpDilYfSETordhp+TJ7uKUCbiIx8mMM18Y53QEdiHPmOaEtH
	k9ykzPL+dqioGk4
X-Received: by 2002:a5d:584e:0:b0:471:9fd4:73e with SMTP id ffacd0b85a97d-47aab676bb9mr11051217f8f.44.1783322700876;
        Mon, 06 Jul 2026 00:25:00 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:00 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 07/18] fs/ceph/super: reorder fields to eliminate padding holes
Date: Mon,  6 Jul 2026 09:24:38 +0200
Message-ID: <20260706072450.3920010-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706072450.3920010-1-max.kellermann@ionos.com>
References: <20260706072450.3920010-1-max.kellermann@ionos.com>
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
index 67411a5d8b91..05452bc7eac1 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -250,6 +250,9 @@ struct ceph_cap_flush {
  */
 struct ceph_cap_snap {
 	refcount_t nref;
+
+	umode_t mode;
+
 	struct list_head ci_item;
 
 	struct ceph_cap_flush cap_flush;
@@ -258,7 +261,6 @@ struct ceph_cap_snap {
 	int issued, dirty;
 	struct ceph_snap_context *context;
 
-	umode_t mode;
 	kuid_t uid;
 	kgid_t gid;
 
@@ -268,11 +270,12 @@ struct ceph_cap_snap {
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
@@ -317,8 +320,8 @@ struct ceph_inode_xattr {
 	struct rb_node node;
 
 	const char *name;
-	int name_len;
 	const char *val;
+	int name_len;
 	int val_len;
 	bool dirty;
 
@@ -379,9 +382,9 @@ struct ceph_inode_info {
 
 	spinlock_t i_ceph_lock;
 
+	u32 i_time_warp_seq;
 	u64 i_version;
 	u64 i_inline_version;
-	u32 i_time_warp_seq;
 
 	unsigned long i_ceph_flags;
 	atomic64_t i_release_count;
@@ -412,8 +415,8 @@ struct ceph_inode_info {
 
 	s32 i_dir_pin;
 
-	struct rb_root i_fragtree;
 	int i_fragtree_nsplits;
+	struct rb_root i_fragtree;
 	struct mutex i_fragtree_mutex;
 
 	struct ceph_inode_xattrs_info i_xattrs;
@@ -453,7 +456,6 @@ struct ceph_inode_info {
 	struct list_head i_cap_snaps;   /* snapped state pending flush to mds */
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
-	unsigned i_snap_caps;           /* cap bits for snapped files */
 	/*
 	 * Written under i_ceph_lock, read via READ_ONCE()
 	 * from diagnostic paths.
@@ -465,8 +467,8 @@ struct ceph_inode_info {
 	int i_nr_by_mode[CEPH_FILE_MODE_BITS];  /* open file counts */
 
 	struct mutex i_truncate_mutex;
-	u32 i_truncate_seq;        /* last truncate to smaller size */
 	u64 i_truncate_size;       /*  and the size we last truncated down to */
+	u32 i_truncate_seq;        /* last truncate to smaller size */
 	int i_truncate_pending;    /*  still need to call vmtruncate */
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -495,6 +497,8 @@ struct ceph_inode_info {
 	struct list_head i_unsafe_iops;   /* uncommitted mds inode ops */
 	spinlock_t i_unsafe_lock;
 
+	unsigned int i_snap_caps;           /* cap bits for snapped files */
+
 	union {
 		struct ceph_snap_realm *i_snap_realm; /* snap realm (if caps) */
 		struct ceph_snapid_map *i_snapid_map; /* snapid -> dev_t */
-- 
2.47.3

