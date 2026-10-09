Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEAE4E433C
	for <ceph-devel@vger.kernel.org>; Fri,  9 Oct 2026 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564177; cv=none; b=eh3U98/5zoLpWvoIAHAV7RYfH7eK/PjblsQdngcyQcXa3tQuqVMfjYr9Mq1mdXkoe9AaVdTjM7/HBlWmKHUlbv+LoKRsHyCayjToHuAbfLb3LGXUrpTXXTV41IqIL78KJGcujhTIMBDs0sjViSsowFjIlkXNg8s+Z3V6kBe2Pfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564177; c=relaxed/simple;
	bh=BtSays9GtExN5mo0dGMlPiwL8ZODEWfE7Unz2bban9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQb6aWoKHCs/Tb5UMgtXT2IR5TPNN7/x029Y5jJ+Ova7CNAcSx9HxEeT9nfuuqhksVz/c9IlxI3FztyRkpgJpxay+GUDx5OiR5jl6q13kKMm1M4ki72fAIBTrCtF6RUoDYCZtuboa6uUbrxNCV0JuJzYBfOBvwEbl02OVtXL5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQM5kwQi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSIpP0y2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQM5kwQi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSIpP0y2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791564174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TAsepFGOiwWl1PAowytqGXYrcK/ABGW1yd8rsS4+Hs=;
	b=LQM5kwQil3tFGQ7UR/T720W/ngko2FUpHMRSOVul3nJNs+DjwM5w4d27ip0RIb1eMZpLRw
	94qlMkPy3Vlog3HNXXZzlpLbrtduGrQ2CZwS/7J4EUXuSsx2IHiTsTGpUfUZxUo5shgdU/
	XXIy/BOmvSaQIjCR7P21hUY346X7AGg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-hMi2ZalnM7KbnegwAt0Wlg-1; Fri, 9 Oct 2026 16:42:53 +0000
X-MC-Unique: hMi2ZalnM7KbnegwAt0Wlg-1
X-Mimecast-MFC-AGG-ID: hMi2ZalnM7KbnegwAt0Wlg_1791564172
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2e315271c1so5166866b.0
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791564172; x=1792168972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0TAsepFGOiwWl1PAowytqGXYrcK/ABGW1yd8rsS4+Hs=;
        b=DSIpP0y2fzLyML6NgV6mSptjqRbbiHHp/gNhh2qM7XiYJ11fZPWXbOSAGkT6BzI5gM
         ENG2tFvMw76jFRBBWXCr5iTLWMU0+k/vzYKaxSzw3N5ZUI1ZMI6TkTfli65S3Fsr0Xtj
         Lyd12gzBHF6fg/fpks7fE5JdnO04bsKPCbyJZSKWufJiyRd3xvXKsH3aca1wH69/kko2
         PG710ZYZIK06pGyfu6KkH0RcFNTyplthfyq2QV9e5Y2ppqQNjF1gyXweACQGPZhf60So
         zt6b7CzJvQOtlme0df7KfItktbfnYCHZdq+EqxszRH+xF+qgD07+FzdYRvCq1HetjOzG
         xJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564172; x=1792168972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0TAsepFGOiwWl1PAowytqGXYrcK/ABGW1yd8rsS4+Hs=;
        b=C8iidAfDe/ZNRazJDLHuRgaInn8ZP6GTalVmzMouK6eTAt3YyNAf4A3Eq+u14JJ8na
         LUd5xrC46uUKZkHLLrm0AcHVDx/QGp8c5zyEYXKHMCh/ejLjjDW/xg8Eg2NTs4I3Nh8S
         oZ9MimxSl/iaEBEffYYdz5tTCnNWkHCblZPT0cGeAcTABstfZxQ7QoPENzRC5/P4Y0k6
         IO9Lt448LE5ZM10Fxk7QQ+A7BbkIZPhX/BsOgw2hxMtvovyqn1jmBOGolVhCJjhZarES
         qb4PDWBVDwXWC3CaDGj+lMrUa+zFXvmtDlG14q27y0ZUWhmS2efJc0bKzOYWPrd2hq3Y
         6fTw==
X-Gm-Message-State: AFq9FYL5NvJBmVtKCQItLWi8Iio/NquJCDVAKRxnyYFaqiO8UFF5GEJS
	YPXAs2IIIeMNftajRaSvJX47/lVnyp1T1jr7DOORSMFOEXOzIQzSJ3V/mV7rgVUJYVj62ERNj0S
	ClSIoSTJwSCYDwW7aaUkIjetpmyEKFNsTnxMMiCUGAKVpgYphkgXqXQFZM9vkTblzeIg39V+JAJ
	4n+FzXzEWiKGx7VOubkLzW1WJpPxoETsHaQJHL+Q4Kdr89gQzTxQ==
X-Gm-Gg: AYBFou2J+9m2DOLsoK8QfiSN7qG5PMsA/VSQQZ0k01KOaLIrBkg5RO920+TgfbSATjj
	YiqncP58iMnO8EAFLGgM0ojPGePEKCI6sBL3oQWcscOh94wFW4wxbvhEmaOkN3nCraNZf9e21yJ
	3cbpH5FYKIzGGh30ecA4oJoa6bZ4YlRGjtgZ/HMYMgcg0Ix2djeS6YAEcDpyZ473PUj0uienzAn
	2+QyT8p+brLxw5akG4liuGiJP3zDXzILGMkc3Tc+CNzpjux6/yhHTUvxnTB4BEcsDYS1/8nVBt4
	D9wjf2X7FJne6xMh1omafJxAQ2dIjBByZBNDMk71ymXRAQTGxxlW+E2or/bGOBHpLSHz4vHJQE1
	XpaXgNAArhuiAMdKt+azu7ywzKIbGsTdZ7xC7tCuS6Ev6uDOiY5EjnzlZ4F/EPrdFvVPxHI0S0a
	i1isYgbeIfzuZebg==
X-Received: by 2002:a17:907:940e:b0:c29:4915:83cb with SMTP id a640c23a62f3a-c31aa0b4563mr252804666b.39.1791564172328;
        Fri, 09 Oct 2026 09:42:52 -0700 (PDT)
X-Received: by 2002:a17:907:940e:b0:c29:4915:83cb with SMTP id a640c23a62f3a-c31aa0b4563mr252798366b.39.1791564170870;
        Fri, 09 Oct 2026 09:42:50 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa8511sm120683666b.59.2026.10.09.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:42:48 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 2/3] ceph: record subvolume quarantine from MDS cap updates
Date: Fri,  9 Oct 2026 16:42:44 +0000
Message-Id: <20261009164245.2483933-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009164245.2483933-1-amarkuze@redhat.com>
References: <20261009164245.2483933-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MClientCaps version 14 appends a signed oserrno after subvolume_id.
-CEPH_EQUARANTINED marks the inode. A later grant of more than PIN
with a clear errno drops the sticky flag. A PIN-only update may zero
the stored errno while leaving the flag set, matching the userspace
client's optmetadata handling.

CEPH_MSG_CLIENT_QUARANTINE_DISABLE clears both and wakes cap waiters.
Children that have not received their own cap message are covered by
walking dentry parents up to the mount root.

The feature bit is not advertised yet, and nothing consults the flag,
so client behavior is unchanged.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c       | 98 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/inode.c      | 50 ++++++++++++++++++++++
 fs/ceph/mds_client.c |  3 ++
 fs/ceph/super.h      | 14 +++++++
 4 files changed, 165 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b27bcdc24d29..84238da4d75c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3729,6 +3729,9 @@ struct cap_extra_info {
 	u8 *fscrypt_auth;
 	u32 fscrypt_auth_len;
 	u64 fscrypt_file_size;
+	/* MClientCaps v14 oserrno; valid only when oserrno_valid is set */
+	s32 oserrno;
+	bool oserrno_valid;
 };
 
 /*
@@ -3757,6 +3760,38 @@ static int parse_inline_data(void **p, void *end,
 	return -EIO;
 }
 
+/*
+ * Record quarantine state carried by an MClientCaps oserrno.
+ * Caller holds i_ceph_lock. Returns true when waiters should be woken
+ * because the inode entered or left quarantine.
+ *
+ * Matches the userspace client: -EQUARANTINED sets the sticky flag,
+ * a later grant of more than PIN with errno 0 clears it, and a PIN-only
+ * update may zero qtine_errno while leaving the flag set.
+ */
+static bool ceph_apply_quarantine(struct ceph_inode_info *ci, int newcaps,
+				  int oserrno)
+{
+	bool was, now;
+
+	was = READ_ONCE(ci->i_qtine_errno) == -CEPH_EQUARANTINED ||
+	      test_bit(CEPH_I_QUARANTINE_BIT, &ci->i_ceph_flags);
+
+	if (newcaps != CEPH_CAP_PIN && was && oserrno == 0)
+		clear_bit(CEPH_I_QUARANTINE_BIT, &ci->i_ceph_flags);
+
+	if (oserrno == -CEPH_EQUARANTINED)
+		set_bit(CEPH_I_QUARANTINE_BIT, &ci->i_ceph_flags);
+
+	if (newcaps || was ||
+	    test_bit(CEPH_I_QUARANTINE_BIT, &ci->i_ceph_flags))
+		WRITE_ONCE(ci->i_qtine_errno, oserrno);
+
+	now = READ_ONCE(ci->i_qtine_errno) == -CEPH_EQUARANTINED ||
+	      test_bit(CEPH_I_QUARANTINE_BIT, &ci->i_ceph_flags);
+	return was || now;
+}
+
 /*
  * Handle a cap GRANT message from the MDS.  (Note that a GRANT may
  * actually be a revocation if it specifies a smaller cap set.)
@@ -4128,6 +4163,14 @@ static void handle_cap_grant(struct inode *inode,
 			fill_inline = true;
 	}
 
+	if (extra_info->oserrno_valid &&
+	    ceph_apply_quarantine(ci, newcaps, extra_info->oserrno)) {
+		boutc(cl, "quarantine oserrno %d caps %s %llx.%llx\n",
+		      extra_info->oserrno, ceph_cap_string(newcaps),
+		      ceph_vinop(inode));
+		wake = true;
+	}
+
 	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT) {
 		if (ci->i_auth_cap == cap) {
 			if (newcaps & ~extra_info->issued)
@@ -4826,6 +4869,20 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 			goto bad;
 	}
 
+	if (msg_version >= 13) {
+		/* v13: subvolume_id. The inode id is learned from replies. */
+		ceph_decode_skip_64(&p, end, bad);
+	}
+
+	if (msg_version >= 14) {
+		u32 raw_errno;
+
+		/* v14: signed oserrno, -CEPH_EQUARANTINED when quarantined */
+		ceph_decode_32_safe(&p, end, raw_errno, bad);
+		extra_info.oserrno = (s32)raw_errno;
+		extra_info.oserrno_valid = true;
+	}
+
 	/* lookup ino */
 	inode = ceph_find_inode(mdsc->fsc->sb, vino);
 	boutc(cl, " caps mds%d op %s ino %llx.%llx inode %p seq %u iseq %u mseq %u\n",
@@ -4981,6 +5038,47 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	goto out;
 }
 
+void ceph_handle_quarantine_disable(struct ceph_mds_client *mdsc,
+				    struct ceph_mds_session *session,
+				    struct ceph_msg *msg)
+{
+	struct super_block *sb = mdsc->fsc->sb;
+	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_mds_quarantine_disable *h = msg->front.iov_base;
+	struct ceph_vino vino;
+	struct inode *inode;
+	struct ceph_inode_info *ci;
+
+	if (!ceph_inc_mds_stopping_blocker(mdsc, session))
+		return;
+
+	if (msg->front.iov_len < sizeof(*h)) {
+		pr_err_client(cl, "corrupt quarantine_disable mds%d len %d\n",
+			      session->s_mds, (int)msg->front.iov_len);
+		ceph_msg_dump(msg);
+		goto out;
+	}
+
+	vino.ino = le64_to_cpu(h->ino);
+	vino.snap = CEPH_NOSNAP;
+	inode = ceph_find_inode(sb, vino);
+	if (!inode) {
+		doutc(cl, "quarantine disable ino %llx not cached\n", vino.ino);
+		goto out;
+	}
+
+	ci = ceph_inode(inode);
+	spin_lock(&ci->i_ceph_lock);
+	WRITE_ONCE(ci->i_qtine_errno, 0);
+	clear_bit(CEPH_I_QUARANTINE_BIT, &ci->i_ceph_flags);
+	spin_unlock(&ci->i_ceph_lock);
+	wake_up_all(&ci->i_cap_wq);
+	doutc(cl, "quarantine disable ino %llx\n", vino.ino);
+	iput(inode);
+out:
+	ceph_dec_mds_stopping_blocker(mdsc);
+}
+
 /*
  * Process the expired end of one delayed cap list, whose entries were
  * queued @hold jiffies before they expire.
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 94f5215f8eed..994a0c4f2f4c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -648,6 +648,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_max_bytes = 0;
 	ci->i_max_files = 0;
 	ci->i_subvolume_id = CEPH_SUBVOLUME_ID_NONE;
+	ci->i_qtine_errno = 0;
 
 	memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
 	memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
@@ -730,6 +731,55 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	return &ci->netfs.inode;
 }
 
+/*
+ * True when this inode or an ancestor was marked quarantined by an MDS
+ * cap update. Ancestors cover children that have not yet received their
+ * own cap message. The walk stops at the mount root.
+ */
+bool ceph_inode_is_under_quarantine(struct inode *inode)
+{
+	struct inode *cur;
+	unsigned int depth = 0;
+
+	if (!inode)
+		return false;
+
+	cur = igrab(inode);
+	while (cur && depth++ < 256) {
+		struct ceph_inode_info *ci = ceph_inode(cur);
+		struct dentry *alias, *parent_dn;
+		struct inode *parent_inode;
+
+		if (READ_ONCE(ci->i_qtine_errno) == -CEPH_EQUARANTINED ||
+		    test_bit(CEPH_I_QUARANTINE_BIT, &ci->i_ceph_flags)) {
+			iput(cur);
+			return true;
+		}
+
+		alias = d_find_any_alias(cur);
+		if (!alias || IS_ROOT(alias)) {
+			dput(alias);
+			iput(cur);
+			return false;
+		}
+
+		parent_dn = dget_parent(alias);
+		dput(alias);
+		parent_inode = d_inode(parent_dn) ? igrab(d_inode(parent_dn))
+						  : NULL;
+		dput(parent_dn);
+		if (!parent_inode || parent_inode == cur) {
+			iput(parent_inode);
+			iput(cur);
+			return false;
+		}
+		iput(cur);
+		cur = parent_inode;
+	}
+	iput(cur);
+	return false;
+}
+
 void ceph_free_inode(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7cb6afb6eb09..97a0ce4709ca 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -7364,6 +7364,9 @@ static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 	case CEPH_MSG_CLIENT_QUOTA:
 		ceph_handle_quota(mdsc, s, msg);
 		break;
+	case CEPH_MSG_CLIENT_QUARANTINE_DISABLE:
+		ceph_handle_quarantine_disable(mdsc, s, msg);
+		break;
 
 	default:
 		pr_err_client(cl, "received unknown message type %d %s\n",
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 458fd63dd79f..9429d2fa925b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -444,6 +444,14 @@ struct ceph_inode_info {
 #define CEPH_SUBVOLUME_ID_NONE 0
 	u64 i_subvolume_id;
 
+	/*
+	 * Cap oserrno from the MDS. -CEPH_EQUARANTINED means this inode
+	 * was revoked because its subvolume is quarantined. Paired with
+	 * CEPH_I_QUARANTINE, which stays set when a later PIN-only update
+	 * clears the errno.
+	 */
+	int i_qtine_errno;
+
 	s32 i_dir_pin;
 
 	int i_fragtree_nsplits;
@@ -773,6 +781,7 @@ static inline u64 ceph_get_truncate_pagecache_size(const struct ceph_inode_info
 					      * the deferred work completes
 					      */
 #define CEPH_I_EVICT_ON_FINAL_IPUT_BIT	(16) /* evict at the final iput() */
+#define CEPH_I_QUARANTINE_BIT		(17) /* subvolume quarantine opt set */
 
 #define CEPH_I_DIR_ORDERED		(1 << CEPH_I_DIR_ORDERED_BIT)
 #define CEPH_I_FLUSH			(1 << CEPH_I_FLUSH_BIT)
@@ -1259,6 +1268,11 @@ extern int ceph_getattr(struct mnt_idmap *idmap,
 			u32 request_mask, unsigned int flags);
 void ceph_inode_shutdown(struct inode *inode);
 
+bool ceph_inode_is_under_quarantine(struct inode *inode);
+void ceph_handle_quarantine_disable(struct ceph_mds_client *mdsc,
+				    struct ceph_mds_session *session,
+				    struct ceph_msg *msg);
+
 static inline bool ceph_inode_is_shutdown(const struct inode *inode)
 {
 	unsigned long flags = READ_ONCE(ceph_inode(inode)->i_ceph_flags);
-- 
2.34.1

