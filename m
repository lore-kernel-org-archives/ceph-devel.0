Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4E439F89
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076724; cv=none; b=ehViItoQdKKcqq+0JP9hGGJETtsvdmZhBM+pS/JKjgo16cxMft+UgKVUJ+lYEHUijLoYtQHXrocDpJLryCh7SLhCEy0OFnRPAWrR9bP2ZSmWAaWx8M14ONzUi9lA2j+wAl2912QmNdS7+hCh1co7H4T+zoaD8T2XAcx3N27sNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076724; c=relaxed/simple;
	bh=rWcD9UAVTx1Qu4X1tQhXaEYVpYkM9g/KFb6msHCmSJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmwYyyjhVOVDPFmjtaR7yzeLPihrCJHXm3rfLPCX5yWuNfVc7xuuaSEfafueWGwH7GEB/7hN47xVrcIFWe7t4eH7YfJd3+pu3urYRGVFsmzvFNshnPc7yoyKn6YlD2aNxAGLPLeyR/EgFpvUj8vEMahmkkHOZUZoaSFrCsRRJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QbPlUWcN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QbPlUWcN"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47fd4531020so46621f8f.3
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076713; x=1787681513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iaBPZv5XdoOUADi4qlmlEchxRuZesTRRDOJ68FGWcG0=;
        b=QbPlUWcNGUEJLGUoJSEPAMiBLpv/2oWlKA8B1JPOW3ipAXHtM2tYVJodMtHDWWpuEj
         +f2eokrqvSy/boGusHLxQ53BVMiwdPYxrLpBjNwvnCdYn9vS120wIiv1RS6nldM0nez5
         oMXWubtlp3MJaY7IKP/SmGpRFgpURT029S9eHfoP26Euv8QYsDvPz7xR4xCuM2KsC2VG
         j9xpsbsy+nmFECPipy+kgKyhVDPdKJ/ag6z2wrBc6+vTMiOq8LMXByjZCqDsxQZOe4z5
         elRWFJ5CnhN7QrYZgCIvsCOm9jLqJVUW7v9LPjl5jr1MMjtjMgrx4iOlQvL2CFT/5qtv
         c9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076713; x=1787681513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iaBPZv5XdoOUADi4qlmlEchxRuZesTRRDOJ68FGWcG0=;
        b=FIP2CSOeLbRrRGOo8k7AGyGPBzXogftO8MOyNH5yvCMhd+IGRI6EH42cXdoq5YMZQG
         CbMzOziWql3/Ti/SiRtbep33QtScOGQtsI7UJR04ErFYN8qYXDYJgAx+3AJOkpApTCe3
         XBWgM5q7ddbTwNhxBUOSRj7a0VGODfaXgRuA4Iqhmv5Xjbyj3xCaw9mBNe/5tHr1QkKY
         suPZ9W7/7J6aKrJsj1jFK1q2KpePqfplQq1dZy4RyrZhBh/16yzIrE1v1wzD9ZVAFBbm
         FEM9DhDuH+ZMD+Ob1EDvH+5q4xudLFfmP6xGhxlr3YEKFtG/cBtkm+YJ7bqF4wvRq0nk
         wxsA==
X-Forwarded-Encrypted: i=1; AHgh+RprLwSQdrznRfcJWCIys4ecLkOE3uQH+LN67dXcyt7fXEoYUPRJ34f1bj7f4R5R9vdq+x/GdLoMPJtk@vger.kernel.org
X-Gm-Message-State: AOJu0YwVxddvfiv6dNUsQuNYxI8dx9uMGJ2dldq64pYiLH3+XkSINwib
	4K1btRbv80a8UW80ojz/weygGYU/2E7In54qakwZaLUcvyEmQQIOzNVLtwRsgHrI4a4s6U6fnNA
	GU3sVYQE=
X-Gm-Gg: AR+sD13stVEk3zxyHmI5yYGN6lkoyUBwiOrkfXkE9JgXnDSKFKOW0mhLjUmBN6vKf1f
	eeTEh8WHfg7MqVAWGt0vF9MFTI4rgveGwlUFje38Mq0Ep9tnHAJ1tLyeLvysG0ecijgAxnMW8xM
	/QnsLdHEoIUi4SAccSD91oT9PgCvpFuEIfsZG7h7mxIodtBSoLdr06E9N+9MJu2qqUMNOZghpID
	t8u0y6OxZzSm6zvooU0AzHgvqeZdGDhB698GphkC3/plhWj/uEKsW7TXa+g9Ztn4/mwRY6NfW5C
	B5cxxu4N2k4OwR8SYA19CeoBU/x4cR6iIkbLIwvgFe+7zPDxBahg2Nc5qqzrODrTK9+GzJ/HSQZ
	EaLyZIjuGOWu/5tmzxFjwkMSuO0uOE1ykZch6i7C1NrohEUrWEZLQrI5+AI7sZI8BRc3vJckqwD
	UT9VLjFfylNyNdXXgyO0IBYjZG+kWQamCnn5kiy+WeRBVpcWl2cYGOkxtI/t73wzHnu1moXkv90
	KenmxNCiHf4V2f4z5ck+3SqXd7LdR4fSNAom/d4RAqjqhCzaevSAjPhjQS20iDd
X-Received: by 2002:a05:6000:2891:b0:482:a909:53d3 with SMTP id ffacd0b85a97d-482a90953f4mr16828977f8f.2.1787076713574;
        Tue, 18 Aug 2026 11:11:53 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:53 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 07/12] fs/ceph/super: reorder fields to eliminate padding holes
Date: Tue, 18 Aug 2026 20:11:39 +0200
Message-ID: <20260818181144.3541770-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818181144.3541770-1-max.kellermann@ionos.com>
References: <20260818181144.3541770-1-max.kellermann@ionos.com>
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

