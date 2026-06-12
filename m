Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9F403E97
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283947; cv=none; b=JP/pkAhZZuSqs4bXEetwJeWWWnCTv3cbM4FmGPlgkr2ZKsqDFWtyuc7pGJqvtDAC+eZ4UxnhOYE8UmWLQFYehAiX5MgZ/6Uub+FbjJ+2GrrR4YrHUowTnZdHlRMBIlaXsT+PrLNbGVPs54WEpmY8QM+dxKBU+GTl6DVJG9EmxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283947; c=relaxed/simple;
	bh=lAW7v5o6BkHHkWbqPyCr65lbebgRni3u6WzmITVNVVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jooLMxMuw5uT63st03q2XdQilCmPZ6vN1d5gwgR+LUzXTSmLpb4V2NvOf/Mga8K8xBObCgZkgsIC4jF4tBudBZDZgwztZtwCDtE4xkhr2nYkfZqePP3Z8Dv0v82VgL379Zsg59vZLCe0G4khlKUfNSljWgvKQLhVppi4kPo11Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QL80EANA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QL80EANA"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-460662fcb4eso827410f8f.0
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283943; x=1781888743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkgN0mta02MEr8Z1QcjPxi4YMjhDvPL4HJTVKXhSCDQ=;
        b=QL80EANAVJcqZqRrgpLUUGoRUkC86IPiNqIUYkQR0WiZJihO1RX907vqdlm4HHtHn4
         hvKjEOPkuCBIcajqg2cJzkwIH9I6q+Y+4Ud3bu0c6LgCiHNgsGD8NP2fYf9a86L5sIAF
         pQdFkx7zJ0VKTd4yIgenJ23I/PzJzdGMKV3Uh2iUOIVEAAI4dexHP47Zl7FG8RTapkZS
         jMda93kDNgecm/eWrrTORvYvHGyezFaNGnSz/xD4X5kuaMkO4J1SeZj3ryG6saCY89D6
         5hEoe7BS31cszCT0MqFMzCO262MUvxBXcNpamay4/5S/Ew5ayXK46zrX7YHFMyoV/DPO
         N/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283943; x=1781888743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkgN0mta02MEr8Z1QcjPxi4YMjhDvPL4HJTVKXhSCDQ=;
        b=fBQM7xNAoenUPks6ppeIf0OI+ZICr5SmZiXXGqxdcHl+W1FCfigCeWJaWlC5eVBsGf
         kxO32ZwzI+WvZhAAun5OPwitTZn0ZZcghf+jGSEKPmPzQxtPO1R7O08wgJJNN6DHS5cZ
         4ddMVar6ojrwiNpNnOTzW9CCYFyvKKAmMCKBrhA6pkKqpCFSeKMvGa+vNfA7bglfSUwG
         dYYFCIM0nBEmaVnvrSDRHt4ZbO9kJsgFTNgbya6AV4Klu5FvVu+KNd35Yh9ru5UqTTn+
         +/4/Nm0B3ucIOe7CinwrUEbA4gQKECQVVUFBpqOkEhRtUUDGdxAaysSPWAn+D5zTrxSV
         kYcA==
X-Forwarded-Encrypted: i=1; AFNElJ90+gsoQ5SVXhlb6xSy16SSrBvL93ZWpSD1nZCe8Qs3N180gGe0MXvrTPU4SbDsLEv0AIFO+Vw3l3Kz@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQJ/SUuA2xI49tPN78E/OD7INDwkB599G7LkXDcAA/C/Wn//c
	NFenlLR4obHAGf0lav+EXB0lVDCIV/7269pqeFsfuD5cRhFCk41YttZyNjB82eaUWlw=
X-Gm-Gg: Acq92OFWYopOi4zu3r2zoyBCsf0jmMSzk3ndeWFUL++I4XhGQnfHh6jBxRTh4qZm5+d
	cC8EQ48s6vexGmUHI7zmjbflxZYo/JhnWWeCzBYmBMpnQSBdubzUAOlaSt12rYumIIgniCsjzEZ
	ud8IHM14mmkhRKIVdEq2JnTrNRH+wVUlbexFwKNEaZoVyoG23xp7N75lNW7skGPXzPrZeUaAY+a
	RryDjuTHIsieDjilwfHxXNgnEX2jgWzTJ6wKJAQqV+oHJRYjQoXLaoKwUxx645q5F/XwIsqX/lV
	FHaumNgb3bojdrm2LqY41LPKLj/BeIo7byld7A8mZo55GPtx1yKPLNF3U1AGCIzF558pguZBdnI
	HemsMtA+38vDiW3FnnJ+/NARz6ZX7HNIXB2QGNSQiinGzzIAaZwK+DzE/2n/NIzDuZya6UkrzSf
	ARzN7f9b8rVVNdLxy5iGSwkHlWM8I9JDd8hRTYFpwconoM6IW82RJHlnR47RiGNfAYbmzr+hbw9
	1e8A9Q8ojlLUZ6CBCzSFdaKCWU=
X-Received: by 2002:a5d:584a:0:b0:45e:de42:6e90 with SMTP id ffacd0b85a97d-4606dbde120mr5282896f8f.37.1781283943021;
        Fri, 12 Jun 2026 10:05:43 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c10sm7541814f8f.21.2026.06.12.10.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:05:42 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 3/3] fs/ceph/cap: pass inode pointer around instead of reloading from RAM
Date: Fri, 12 Jun 2026 19:05:37 +0200
Message-ID: <20260612170537.92970-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612170537.92970-1-max.kellermann@ionos.com>
References: <20260612170537.92970-1-max.kellermann@ionos.com>
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
index 9e7c76a66624..ef167118efdf 100644
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
@@ -1195,9 +1194,9 @@ static void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 }
 
 void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
+		     struct ceph_inode_info *ci,
 		     bool queue_release)
 {
-	struct ceph_inode_info *ci = cap->ci;
 	struct ceph_fs_client *fsc;
 
 	if (RB_EMPTY_NODE(&cap->ci_node)) {
@@ -1214,7 +1213,7 @@ void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 		     !fsc->blocklisted &&
 		     !ceph_inode_is_shutdown(&ci->netfs.inode));
 
-	__ceph_remove_cap(cap, queue_release);
+	__ceph_remove_cap(ci, cap, queue_release);
 }
 
 struct cap_msg_args {
@@ -1374,7 +1373,7 @@ void __ceph_remove_caps(struct ceph_inode_info *ci)
 	while (p) {
 		struct ceph_cap *cap = rb_entry(p, struct ceph_cap, ci_node);
 		p = rb_next(p);
-		ceph_remove_cap(mdsc, cap, true);
+		ceph_remove_cap(mdsc, cap, ci, true);
 	}
 	spin_unlock(&ci->i_ceph_lock);
 }
@@ -1387,11 +1386,10 @@ void __ceph_remove_caps(struct ceph_inode_info *ci)
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
@@ -2206,7 +2204,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 		if (want & ~cap->mds_wanted) {
 			if (want & ~(cap->mds_wanted | cap->issued))
 				goto ack;
-			if (!__cap_is_valid(cap))
+			if (!__cap_is_valid(ci, cap))
 				goto ack;
 		}
 
@@ -2248,7 +2246,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 
 		mds = cap->mds;  /* remember mds, so we don't repeat */
 
-		__prep_cap(&arg, cap, CEPH_CAP_OP_UPDATE, mflags, cap_used,
+		__prep_cap(&arg, ci, cap, CEPH_CAP_OP_UPDATE, mflags, cap_used,
 			   want, retain, flushing, flush_tid, oldest_flush_tid);
 
 		spin_unlock(&ci->i_ceph_lock);
@@ -2310,7 +2308,7 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
 		flush_tid = __mark_caps_flushing(inode, session, true,
 						 &oldest_flush_tid);
 
-		__prep_cap(&arg, cap, CEPH_CAP_OP_FLUSH, CEPH_CLIENT_CAPS_SYNC,
+		__prep_cap(&arg, ci, cap, CEPH_CAP_OP_FLUSH, CEPH_CLIENT_CAPS_SYNC,
 			   __ceph_caps_used(ci), __ceph_caps_wanted(ci),
 			   (cap->issued | cap->implemented),
 			   flushing, flush_tid, oldest_flush_tid);
@@ -2604,7 +2602,7 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 			doutc(cl, "%p %llx.%llx cap %p tid %llu %s\n",
 			      inode, ceph_vinop(inode), cap, cf->tid,
 			      ceph_cap_string(cf->caps));
-			__prep_cap(&arg, cap, CEPH_CAP_OP_FLUSH,
+			__prep_cap(&arg, ci, cap, CEPH_CAP_OP_FLUSH,
 					 (cf->tid < last_snap_flush ?
 					  CEPH_CLIENT_CAPS_PENDING_CAPSNAP : 0),
 					  __ceph_caps_used(ci),
@@ -4095,7 +4093,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		goto out_unlock;
 
 	if (target < 0) {
-		ceph_remove_cap(mdsc, cap, false);
+		ceph_remove_cap(mdsc, cap, ci, false);
 		goto out_unlock;
 	}
 
@@ -4132,7 +4130,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 				change_auth_cap_ses(ci, tcap->session);
 			}
 		}
-		ceph_remove_cap(mdsc, cap, false);
+		ceph_remove_cap(mdsc, cap, ci, false);
 		goto out_unlock;
 	} else if (tsession) {
 		/* add placeholder for the export target */
@@ -4149,7 +4147,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 			spin_unlock(&mdsc->cap_dirty_lock);
 		}
 
-		ceph_remove_cap(mdsc, cap, false);
+		ceph_remove_cap(mdsc, cap, ci, false);
 		goto out_unlock;
 	}
 
@@ -4265,7 +4263,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 					inode, ceph_vinop(inode), peer,
 					ocap->seq, ocap->mseq, mds, piseq, pmseq);
 		}
-		ceph_remove_cap(mdsc, ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
+		ceph_remove_cap(mdsc, ocap, ci, (ph->flags & CEPH_CAP_FLAG_RELEASE));
 	}
 
 	*old_issued = issued;
@@ -4862,7 +4860,7 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 	drop &= ~(used | dirty);
 
 	cap = __get_cap_for_mds(ci, mds);
-	if (cap && __cap_is_valid(cap)) {
+	if (cap && __cap_is_valid(ci, cap)) {
 		unless &= cap->issued;
 		if (unless) {
 			if (unless & CEPH_CAP_AUTH_EXCL)
@@ -5021,7 +5019,7 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 	      cap, ci, inode, ceph_vinop(inode));
 
 	is_auth = (cap == ci->i_auth_cap);
-	__ceph_remove_cap(cap, false);
+	__ceph_remove_cap(ci, cap, false);
 	if (is_auth) {
 		struct ceph_cap_flush *cf;
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f092960953a8..5b17d7412eef 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2256,7 +2256,7 @@ static int trim_caps_cb(struct inode *inode, int mds, void *arg)
 
 	if (oissued) {
 		/* we aren't the only cap.. just remove us */
-		ceph_remove_cap(mdsc, cap, true);
+		ceph_remove_cap(mdsc, cap, ci, true);
 		(*remaining)--;
 	} else {
 		struct dentry *dentry;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 76b946116613..3b07b071dba4 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1262,6 +1262,7 @@ extern void ceph_add_cap(struct inode *inode,
 			 unsigned cap, unsigned seq, u64 realmino, int flags,
 			 struct ceph_cap **new_cap);
 extern void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
+			    struct ceph_inode_info *ci,
 			    bool queue_release);
 extern void __ceph_remove_caps(struct ceph_inode_info *ci);
 extern void ceph_put_cap(struct ceph_mds_client *mdsc,
-- 
2.47.3

