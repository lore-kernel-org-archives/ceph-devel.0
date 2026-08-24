Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F33876DE
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596936; cv=none; b=SYPOP/lWL/cYLmLn9C9ebuIY5lbYJv2d9PfOZc+GjfIRgG6FDf7qq+CPUq1oBRebmjDT1zJXD882EMUxnnzoS1M62m688hcOI05a0i3JDjZdxQXr7RdjRjE5XHckRJQkB48u46Ge/a3N1Don+hHGU+ECdhFOikG6aTQYzQCm7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596936; c=relaxed/simple;
	bh=rWcD9UAVTx1Qu4X1tQhXaEYVpYkM9g/KFb6msHCmSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfroOmRth3uFKLdadBXGKSeRVN1NyUlyYuLcdPMn4BgevHo0JoowapYlRERSbiw6G6797msFlU38lpoHzK0dbs92JMRbScbjopJJdiiMCQMu/I2aV/spMIGmiT01gararHGW7E95uJNYDYuO60PfB8EDwNUb8yEAgFCPdVEi/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OL++xASa; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OL++xASa"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1671ec8692so555302266b.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596933; x=1788201733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iaBPZv5XdoOUADi4qlmlEchxRuZesTRRDOJ68FGWcG0=;
        b=OL++xASaRsJeNhP9JCxMM91wsuH1Z+7Z4ImtK71Y4cNmyGCBFWCjJ17Ugvjm6flbBa
         EtfqnWcOvvchK6B36Nhi0miZSORmHT1SubiqXg1uZQbGTctOQO2DHQUH5rVXOZKt24+b
         W+18tRzbsbjmtqboGVu+Vwv3ouTs6CzkPEyWS2eimkb8HvYtyb3IaPbLYrmswXcbENyq
         u5XlLarjHHmwvi8IufqteRxVIwlArcfSIZlivdA+3mAmyIFY01/frbmpXyrrzbivekZx
         lIYkAtZhRpTOCwm/EVCYJqwFf51t+nDS7skTBMi19ebb9j0R9PXSeMPd0/awKKJRwCCE
         +E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596933; x=1788201733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iaBPZv5XdoOUADi4qlmlEchxRuZesTRRDOJ68FGWcG0=;
        b=DtfGyzd3KjfEfU+f4tUReXH5wOfFKjwyecnszzwkvQYxI4rOVGLT7OYjL7e+4FuiV7
         b9f+8gMrg9RIdaU651iSpds5DJBnriURwyzJl89eLOZY4hyPVXyD7PfMrsSs0RQAfj9A
         iUKlkgchYkK5evJYMzYUoSLAcnlN5jdlhmYHJHoreSukex3++OPWH2C3gQOY7wxeE+ko
         nzkpJ1tB9LR/bA7FClTmL0pinov0FYhtbCRlHgUTLWqguN196jTM+IL+0OOAhIo86+4B
         nVNzQBj04cfj0bfrig0W5dm3qDHYbRzj3LOuweaTNHatcXzaAEnEQ4jJVxKizDf8gSls
         ZBdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpz+wDba1MuxB+Jg8SdYlPEa4aNghcbsxpWDXWx7B726pzsqkHUNvyy50x0XuLDfzrDPo83wUWYz9vb@vger.kernel.org
X-Gm-Message-State: AFuF++lvRoywCejeneS52S0VSpYV3rAw9A7e8kB2N64r+bpInUCf6c/8
	U7gfbs95fCMQA1SG+j5khFBDgjhLo2+A2on49dN7duytOA9hQrUz4sRej9GPE8F/23U=
X-Gm-Gg: AR+sD12+1E+qeWkDX93MvoUsSed9EuV32FEz2Mf9uDiUBSLe0K9tHLPk4vXd3wTnWJa
	686QgLJcp/w+uieN25DcURjCTS0y0iAXkxAF2mYXr/3rIkvNeOWvvzPg4T5rLvDKLmcS/yb+DhN
	mZzphvHQtAV5JFxCNp6enGaXrmjeIHy06uWVvK4JdhZMq/bqxBSl4eA/83bRZ2+qI6I5ZpkLuAO
	cfCd7OoAY1kKeU/nBjfROLaW1WEgja7Jm1xO3q+aOc1gSvhvsOZt2aDwFOdDhaHZd2YCWx2JmKj
	8AvE3v2wrDfhNsMuv+dCwHNuQIGqhukAF4lC7vTc52m5oUylx3sukrC0lrIcEdco9XfjdoL0apb
	wdOfLAL1CeOflEr+/t1Ejn21AwaxHog6AwxQlFcwe1dnbr91pEY7Yk0C81gpPfD3WpxSQ5csKXi
	WLP2N44x+B2zWDHHazjmTG8jIPnm/7Cdt4eH7+jNUWC3YoeeeBZ8gxY5XgP2nPvFoKINPLHblip
	/KaQau756/Z+fSrgp94J5osaGmcwopaPiyYea9s6+Ru1OYwP+GBfgSrtIhjCO7p
X-Received: by 2002:a17:906:7316:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c2491cbca79mr2240592666b.9.1787596933001;
        Mon, 24 Aug 2026 11:42:13 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:12 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 06/11] fs/ceph/super: reorder fields to eliminate padding holes
Date: Mon, 24 Aug 2026 20:41:54 +0200
Message-ID: <20260824184159.240821-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824184159.240821-1-max.kellermann@ionos.com>
References: <20260824184159.240821-1-max.kellermann@ionos.com>
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

