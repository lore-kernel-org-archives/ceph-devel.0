Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175039891D
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566608; cv=none; b=Yj0FXfQc/ePNFsAFBGJD6Nza5mR5VYfKPKJiaRU70dZMf8Kj1UNqmknRma9p8cn4TPmrR3fjWsmNtXpe4PjbqA2icVdH/IpFLNf//rnberGkT7ckm+2Z2wd2WhQ/8TFhOsXynWwQsb+LbaHbWC/h06g6EAphWkhIAHwUJM0AE6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566608; c=relaxed/simple;
	bh=rWcD9UAVTx1Qu4X1tQhXaEYVpYkM9g/KFb6msHCmSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRUayS+jc8K4p8/8EZVifbuv4FFYzDg5rUwUOnlp40r7hEHuVXfh/Xao1Z+8avuj+oY15B72tpwXjeDSt3gcYsbAzmcYKRxN4zhg5hPDup2UfUWfY3eg6gC4CpkPfLkPsecJpcfYUDmltBqyIfp0CT1+louvGSFLN0xVr17dpH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hkE7Rw/U; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hkE7Rw/U"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1069030f8f.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566600; x=1787171400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iaBPZv5XdoOUADi4qlmlEchxRuZesTRRDOJ68FGWcG0=;
        b=hkE7Rw/UU12gk1Rds71jD9DarvLak7qJPVa+TCc0Qxi8yo+4qL8Vsmh5wrtuUX4Glc
         OmWbdBUxO7M3uWB0fV4dSkPjag40D50nBc6xqacsyknyu6uHh5giS8xJgC+hepPfm4iJ
         ow+KYOC09REHJFuawTk1YKw4VQxoSEEDrBDMcd9hmq76G2S1ZRXvy+7D6pNWjwWMwqQT
         yW8bfnLzR+IANn8s4ohH0d0g/FIZhoZdA/90WvR2BC02uTHizE3v4MQW12HjMz1my3oA
         8yWW+Jig92+HTPZZx59z5W7vDl6ECWT5XubEMjPbuYbdGlnGOmduOWcn2kDcYVoN7eBl
         d9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566600; x=1787171400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iaBPZv5XdoOUADi4qlmlEchxRuZesTRRDOJ68FGWcG0=;
        b=UAaRKZ3HevPDyiwK2orPYNy8iQUR8quMF7hw0RK2xEYcImLEXIs0uhah36B4bWoQ+j
         g82ao2PE5qAyOo6bBvuunIb2yUQ9pSWAnVT6gxYoWqOalI5eLK0biucbgGDBwzSMW/2v
         81fOH2cvCEZ8H4BEDQN6UkHF/TrPlD4kUMjE/Cgp3VwiCxwKgU0oAajyHR4/hLduJG6K
         utL0Cw9yWW+hJraaEKlDGenMjEwp1xhzpS48Ew9sRFOvM2fLso+IaKct3ky8WE3SqFYH
         RzQqFehfWKNQ1hKJIGjleq1GsRfmKSmeQAOGFq1FWUIgoAYN9EpiPuMUW0l86y2WBBrY
         8NwA==
X-Forwarded-Encrypted: i=1; AHgh+RoLOoLxIFJ7qEnN8sp9Iwb8OIq581cYJ18FIyGm/bPfSsIMp0X89JOeDLPzpVIYF1eLdOxDEZLsOd8K@vger.kernel.org
X-Gm-Message-State: AOJu0YwnruTJp06OWuCP0h/BHq1+UuqiMD2AJhAczNCH3k9ehKcvfjS0
	tVlTUgFvR+sec94fyK8ukkmyZ1w88R99JrNIXhSzdenzxUImFbHJL8NIoLtAKJ3VUr0=
X-Gm-Gg: AR+sD11+Y1JtkUkIn+o66s7BrsTwkB/bBOttyY6W+7e+h9VATGou576iPTYYBcLSv2I
	sKphCgpTaIGmKlubZnOA93bLuB52wcZgoDlURaxdLSBokJMqC7DBKiLayCKLs4bs58VDMxb2wne
	7y3nZEF6mvSnGDnDO5URKyUjLcbsrTiX/4zN8SMhtJ/Oj+R7XoaeVfwBMz3iNq+lf+kxm9lQlRU
	Rzu+6a34wHd66kAfvy26pH8ed1iiYhYkJT0i35IuXEprk4Caw3mAvSk8pNsoKVR6wXFmpMo+Sd0
	MRk5SZTFimRc1mQ2ZIMsWnvHLDsWkZDY1RjT/v0w8/Dqn4xJxDyBkhNHwbQO7gj1TImAlXcEGsh
	JsY/R3rjrWZaRU74pMm+InpbpujWHcN0zZIov3frHTTpJGNjdoCiUGJkHKmDj0z7WW63/NeYV39
	SrN1hrPEaujYQJTx/rQgpeFbt1/cRdliljnK75I9+/e7cmpgj8yAUJgjmLv5YBNdw4Vbg0y5rC0
	GdCNTgwCmdWxQnmsFhTrBOhacYuqu/PAJ1+udTcyI1nBe92bR5E0Uid+vI7rGgd
X-Received: by 2002:a05:6000:2304:b0:47f:81c4:36a5 with SMTP id ffacd0b85a97d-48159fe3877mr972832f8f.15.1786566600564;
        Wed, 12 Aug 2026 13:30:00 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:30:00 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 07/12] fs/ceph/super: reorder fields to eliminate padding holes
Date: Wed, 12 Aug 2026 22:29:44 +0200
Message-ID: <20260812202950.1800340-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812202950.1800340-1-max.kellermann@ionos.com>
References: <20260812202950.1800340-1-max.kellermann@ionos.com>
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

