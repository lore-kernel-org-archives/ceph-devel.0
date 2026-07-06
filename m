Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE553CBE66
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323512; cv=none; b=o77kMGNzz9+3hvfhwXvBNDWmIgvyFu96oq5qV4c7htEMYMV0c0MZuxcVlIKz+r6A8JuTzEil3jWlsKej2rUrW9Me5lRp3PEg8zgc9gCO46731jsAAisNmhysxyNvXQmEKOmsz8zL6HrbDhktTlj45BGQg6Iv25xaFTKyDIImN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323512; c=relaxed/simple;
	bh=//9INOUyId/+PPFxxtXrJzDvur4wS+IohNr1lhtQ5yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+b0MgXMnO+a19JZd7o1qWsp78uRufAu5BmgVYd64CS5Fp17iWdMH7LSICp954DUOLSgec+S1UZov0Ktd54ZQ2nbSoGMlfIiYCuCxGKhzD7LszCvwWQizSLAuFIPp1K/zSGhIUM1yU3bI/OK8aIHaVx9duvvsUPIV0rjWSnRj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LYREI+Eq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LYREI+Eq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c00f74baso16012055e9.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783323499; x=1783928299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvcSBVkDeekMxZktZrVpq5f8h+SlgzRvVSJMEvcqoJ4=;
        b=LYREI+EqGYU9fzqJJpLAkkEEvFRc25USPFPVWwmewWJEhzbLoZu948lNBZAZNksrom
         6EUTXgJSvPP/9bLPiDz3166hilEh+mTdNOfPHPjeqBE0SNTaD3Dr/GEE1jZ1O9nfQg7T
         ZEUs62iW8+2dTZnzWxh4Iz/rXtBpwg2VT8E1StoG/iiNkESuPS4LyWI0qCV7JDZ68HQ2
         Zo9GoIfK7kW7zkdOlbMiyFRk6B5K4dF5J9Wr3gzjJ04TqTI5t4/OoNpVa2VBu2XDC96L
         Jd+WyKYnWFu5nJhrsYHDfOq3L+pGipFqCKaBavGe22bbEBYFZSvfzAaHkDtSpmrByWTd
         BfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783323499; x=1783928299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mvcSBVkDeekMxZktZrVpq5f8h+SlgzRvVSJMEvcqoJ4=;
        b=eBtlU/g45BZpUba5BI6jXAkOs8VvTK3/kp/5tuU5kyJbfNSlou6mjTqRvPcnpdj8Z9
         3a6JOrVJdUdtiX8bIQX03ZUL/TDBa/C0tRcKS2jTlkOV2xB2uXSvn0gonqiPz6pofINq
         EBveMnWB0K/+oMdknBKOXwV5VXGgrxWLzO3zOtKW2yM7DKc9IOFbk6Iq9T2XmoYM50Sm
         Cj8QDmD5Mn2ipeF9U9qH+k+pD/HZ3Fb/7809NzdvBNL/KNkJxFVRaDDBC5V72EyRTuct
         5zfCFzgxiCZYz9eRKkNA9jCypjGnejvMZSVUUcHQdGg40EzDM8jzm+dQD2EXnvaYszet
         mPmA==
X-Forwarded-Encrypted: i=1; AHgh+RoWAnGmm08A1EYRqX5rsOIAe2xSXIe1+QNbE7paz5k35YQYVVkJdj3WEVfGPsg8XiiTgK5mkcQpyyOn@vger.kernel.org
X-Gm-Message-State: AOJu0YyFrw8m+XKn2LX8blp4hKiQ9EZWMn+nQa8rzfnJas7nf+32LUX1
	812Lt7KFR416sxU0f3fkhD98WHGz9r5jtMdzo9dCNV9UZptfAsW9KQsqv/FsvW2FrtfzlVf9uSU
	x3yj+IDg=
X-Gm-Gg: AfdE7cnZWyx88xdiO/jcfVW3db1edkzrVa4XuAkqUE8OBpXLm8J4W8J4nWmFjCGCt71
	315Dy2M9uSPLOTf20BbP1i4fIcSjh/pPDFMqa+xJm3r1WmeURNLaHdLiTegRmsH2GCpdOsaYGRu
	iwctyq1LuuR+qYdj5/JoWnOkbokN1h57cWMeXDU5icdXiNVWp323X3SJ8nefg4gibMijangTxKP
	y9eAGZXp9FmLoBXSuhb9IHlVs0KNWZ3WsisQD+eVYN0w0dxkcnkxxU0k1VFnvxfRkvYQVwSr0dC
	KPQdx2KBzte/nCf8mP9Gq+KBoMfjXS3GI6SxRR0cbqAjx/SD1TRXS/qEU85IyTp5cWw3CRx9uBm
	af1vTpMYRgjIguM4bSkeORoHoqLNSXBX64R6SpYa0cBvcVV/xenTMvP5fAeJxSk5CJ6aMQtDcYI
	RnWmN051dWXc/UWHTvv/VglO97+qWR3qVoB116Vb1VCiOMyftVLCPlvzpau+9ma2hJmq5a1UgeD
	3pDuJrqdZPEUHTH
X-Received: by 2002:a05:600c:3551:b0:493:adc3:cced with SMTP id 5b1f17b1804b1-493d1204c63mr98802825e9.34.1783323499459;
        Mon, 06 Jul 2026 00:38:19 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm22248585f8f.3.2026.07.06.00.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:38:19 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 4/4] fs/ceph/cap: pass inode pointer around instead of reloading from RAM
Date: Mon,  6 Jul 2026 09:38:12 +0200
Message-ID: <20260706073812.3922732-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706073812.3922732-1-max.kellermann@ionos.com>
References: <20260706073812.3922732-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All these functions already have a ceph_inode_info pointer, so let's
use that instead of letting every function reload it from RAM
(i.e. `ceph_cap.ci`).  This eliminates several memory accesses.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c       | 56 +++++++++++++++++++++-----------------------
 fs/ceph/mds_client.c |  2 +-
 fs/ceph/super.h      |  1 +
 3 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index a6a59bc91b79..4b59df7f31e9 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -785,9 +785,9 @@ void ceph_add_cap(struct inode *inode,
  * generation of the MDS session (i.e. has not gone 'stale' due to
  * us losing touch with the mds).
  */
-static int __cap_is_valid(struct ceph_cap *cap)
+static int __cap_is_valid(struct ceph_inode_info *ci, struct ceph_cap *cap)
 {
-	struct inode *inode = &cap->ci->netfs.inode;
+	struct inode *inode = &ci->netfs.inode;
 	struct ceph_client *cl = cap->session->s_mdsc->fsc->client;
 	unsigned long ttl;
 	u32 gen;
@@ -822,7 +822,7 @@ int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented)
 		*implemented = 0;
 	for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
 		cap = rb_entry(p, struct ceph_cap, ci_node);
-		if (!__cap_is_valid(cap))
+		if (!__cap_is_valid(ci, cap))
 			continue;
 		doutc(cl, "%p %llx.%llx cap %p issued %s\n", inode,
 		      ceph_vinop(inode), cap, ceph_cap_string(cap->issued));
@@ -855,7 +855,7 @@ int __ceph_caps_issued_other(struct ceph_inode_info *ci, struct ceph_cap *ocap)
 		cap = rb_entry(p, struct ceph_cap, ci_node);
 		if (cap == ocap)
 			continue;
-		if (!__cap_is_valid(cap))
+		if (!__cap_is_valid(ci, cap))
 			continue;
 		have |= cap->issued;
 	}
@@ -866,9 +866,9 @@ int __ceph_caps_issued_other(struct ceph_inode_info *ci, struct ceph_cap *ocap)
  * Move a cap to the end of the LRU (oldest caps at list head, newest
  * at list tail).
  */
-static void __touch_cap(struct ceph_cap *cap)
+static void __touch_cap(struct ceph_inode_info *ci, struct ceph_cap *cap)
 {
-	struct inode *inode = &cap->ci->netfs.inode;
+	struct inode *inode = &ci->netfs.inode;
 	struct ceph_mds_session *s = cap->session;
 	struct ceph_client *cl = s->s_mdsc->fsc->client;
 
@@ -906,7 +906,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 
 	for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
 		cap = rb_entry(p, struct ceph_cap, ci_node);
-		if (!__cap_is_valid(cap))
+		if (!__cap_is_valid(ci, cap))
 			continue;
 		if ((cap->issued & mask) == mask) {
 			doutc(cl, "mask %p %llx.%llx cap %p issued %s (mask %s)\n",
@@ -914,7 +914,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 			      ceph_cap_string(cap->issued),
 			      ceph_cap_string(mask));
 			if (touch)
-				__touch_cap(cap);
+				__touch_cap(ci, cap);
 			return 1;
 		}
 
@@ -929,15 +929,15 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 				struct rb_node *q;
 
 				/* touch this + preceding caps */
-				__touch_cap(cap);
+				__touch_cap(ci, cap);
 				for (q = rb_first(&ci->i_caps); q != p;
 				     q = rb_next(q)) {
 					cap = rb_entry(q, struct ceph_cap,
 						       ci_node);
-					if (!__cap_is_valid(cap))
+					if (!__cap_is_valid(ci, cap))
 						continue;
 					if (cap->issued & mask)
-						__touch_cap(cap);
+						__touch_cap(ci, cap);
 				}
 			}
 			return 1;
@@ -1091,7 +1091,7 @@ int __ceph_caps_mds_wanted(struct ceph_inode_info *ci, bool check)
 
 	for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
 		cap = rb_entry(p, struct ceph_cap, ci_node);
-		if (check && !__cap_is_valid(cap))
+		if (check && !__cap_is_valid(ci, cap))
 			continue;
 		if (cap == ci->i_auth_cap)
 			mds_wanted |= cap->mds_wanted;
@@ -1119,11 +1119,10 @@ int ceph_is_any_caps(struct inode *inode)
  * caller should hold i_ceph_lock.
  * caller will not hold session s_mutex if called from destroy_inode.
  */
-static void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
+static void __ceph_remove_cap(struct ceph_inode_info *ci, struct ceph_cap *cap, bool queue_release)
 {
 	struct ceph_mds_session *session = cap->session;
 	struct ceph_client *cl = session->s_mdsc->fsc->client;
-	struct ceph_inode_info *ci = cap->ci;
 	struct inode *inode = &ci->netfs.inode;
 	struct ceph_mds_client *mdsc;
 	int removed = 0;
@@ -1198,9 +1197,9 @@ static void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 }
 
 void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
+		     struct ceph_inode_info *ci,
 		     bool queue_release)
 {
-	struct ceph_inode_info *ci = cap->ci;
 	struct ceph_fs_client *fsc;
 
 	if (ceph_cap_is_removed(cap)) {
@@ -1216,7 +1215,7 @@ void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 		     !fsc->blocklisted &&
 		     !ceph_inode_is_shutdown(&ci->netfs.inode));
 
-	__ceph_remove_cap(cap, queue_release);
+	__ceph_remove_cap(ci, cap, queue_release);
 }
 
 struct cap_msg_args {
@@ -1376,7 +1375,7 @@ void __ceph_remove_caps(struct ceph_inode_info *ci)
 	while (p) {
 		struct ceph_cap *cap = rb_entry(p, struct ceph_cap, ci_node);
 		p = rb_next(p);
-		ceph_remove_cap(mdsc, cap, true);
+		ceph_remove_cap(mdsc, cap, ci, true);
 	}
 	spin_unlock(&ci->i_ceph_lock);
 }
@@ -1389,11 +1388,10 @@ void __ceph_remove_caps(struct ceph_inode_info *ci)
  * Make note of max_size reported/requested from mds, revoked caps
  * that have now been implemented.
  */
-static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
+static void __prep_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci, struct ceph_cap *cap,
 		       int op, int flags, int used, int want, int retain,
 		       int flushing, u64 flush_tid, u64 oldest_flush_tid)
 {
-	struct ceph_inode_info *ci = cap->ci;
 	struct inode *inode = &ci->netfs.inode;
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int held, revoking;
@@ -2211,7 +2209,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 		if (want & ~cap->mds_wanted) {
 			if (want & ~(cap->mds_wanted | cap->issued))
 				goto ack;
-			if (!__cap_is_valid(cap))
+			if (!__cap_is_valid(ci, cap))
 				goto ack;
 		}
 
@@ -2253,7 +2251,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 
 		mds = cap->mds;  /* remember mds, so we don't repeat */
 
-		__prep_cap(&arg, cap, CEPH_CAP_OP_UPDATE, mflags, cap_used,
+		__prep_cap(&arg, ci, cap, CEPH_CAP_OP_UPDATE, mflags, cap_used,
 			   want, retain, flushing, flush_tid, oldest_flush_tid);
 
 		spin_unlock(&ci->i_ceph_lock);
@@ -2315,7 +2313,7 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
 		flush_tid = __mark_caps_flushing(inode, session, true,
 						 &oldest_flush_tid);
 
-		__prep_cap(&arg, cap, CEPH_CAP_OP_FLUSH, CEPH_CLIENT_CAPS_SYNC,
+		__prep_cap(&arg, ci, cap, CEPH_CAP_OP_FLUSH, CEPH_CLIENT_CAPS_SYNC,
 			   __ceph_caps_used(ci), __ceph_caps_wanted(ci),
 			   (cap->issued | cap->implemented),
 			   flushing, flush_tid, oldest_flush_tid);
@@ -2609,7 +2607,7 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 			doutc(cl, "%p %llx.%llx cap %p tid %llu %s\n",
 			      inode, ceph_vinop(inode), cap, cf->tid,
 			      ceph_cap_string(cf->caps));
-			__prep_cap(&arg, cap, CEPH_CAP_OP_FLUSH,
+			__prep_cap(&arg, ci, cap, CEPH_CAP_OP_FLUSH,
 					 (cf->tid < last_snap_flush ?
 					  CEPH_CLIENT_CAPS_PENDING_CAPSNAP : 0),
 					  __ceph_caps_used(ci),
@@ -4107,7 +4105,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		goto out_unlock;
 
 	if (target < 0) {
-		ceph_remove_cap(mdsc, cap, false);
+		ceph_remove_cap(mdsc, cap, ci, false);
 		goto out_unlock;
 	}
 
@@ -4144,7 +4142,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 				change_auth_cap_ses(ci, tcap->session);
 			}
 		}
-		ceph_remove_cap(mdsc, cap, false);
+		ceph_remove_cap(mdsc, cap, ci, false);
 		goto out_unlock;
 	} else if (tsession) {
 		/* add placeholder for the export target */
@@ -4161,7 +4159,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 			spin_unlock(&mdsc->cap_dirty_lock);
 		}
 
-		ceph_remove_cap(mdsc, cap, false);
+		ceph_remove_cap(mdsc, cap, ci, false);
 		goto out_unlock;
 	}
 
@@ -4277,7 +4275,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 					inode, ceph_vinop(inode), peer,
 					ocap->seq, ocap->mseq, mds, piseq, pmseq);
 		}
-		ceph_remove_cap(mdsc, ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
+		ceph_remove_cap(mdsc, ocap, ci, (ph->flags & CEPH_CAP_FLAG_RELEASE));
 	}
 
 	*old_issued = issued;
@@ -4874,7 +4872,7 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 	drop &= ~(used | dirty);
 
 	cap = __get_cap_for_mds(ci, mds);
-	if (cap && __cap_is_valid(cap)) {
+	if (cap && __cap_is_valid(ci, cap)) {
 		unless &= cap->issued;
 		if (unless) {
 			if (unless & CEPH_CAP_AUTH_EXCL)
@@ -5033,7 +5031,7 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 	      cap, ci, inode, ceph_vinop(inode));
 
 	is_auth = (cap == ci->i_auth_cap);
-	__ceph_remove_cap(cap, false);
+	__ceph_remove_cap(ci, cap, false);
 	if (is_auth) {
 		struct ceph_cap_flush *cf;
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 019f5e60ff82..dfe9ce1c9264 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2258,7 +2258,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 
 	if (oissued) {
 		/* we aren't the only cap.. just remove us */
-		ceph_remove_cap(mdsc, cap, true);
+		ceph_remove_cap(mdsc, cap, ci, true);
 		(*remaining)--;
 	} else {
 		struct dentry *dentry;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 509839c1db0b..77909ee8deff 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1296,6 +1296,7 @@ static inline bool ceph_cap_is_removed(const struct ceph_cap *cap)
 }
 
 extern void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
+			    struct ceph_inode_info *ci,
 			    bool queue_release);
 extern void __ceph_remove_caps(struct ceph_inode_info *ci);
 extern void ceph_put_cap(struct ceph_mds_client *mdsc,
-- 
2.47.3

