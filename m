Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9A386566
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596935; cv=none; b=pfwJSUVwoN2Rhjqqq+cugLyT7+hYL7wwfQ+dRPjicnOTd28WJ1l7hdCPvGpZCPQ8QIYhYs3WbnUxBGS80xSaKhg5UEoiAbo+Go6vmi9xSNccJzX5t8p5XZHaDf6c/r9ZoscTcOZ4t5h6dnMTkDjQpqDTFzv5ipCEY204IJqGe94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596935; c=relaxed/simple;
	bh=PjYmrfLVvUBP+hJPWHcHP1Yl0S8esm3P4bwPD1D8xIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVTySkdqBlFxXiO2Ty00n2JulfzdP5QxSbJTXNYTe2pfbCsDczPhkFuNVWc2JAuopQGV7TM25oQnUFsBgQgBL2R0EqBJgNAuFG4GwZM0M/t77tYuv9QK5Okxv4lt/AkeEkCtNbcg50C9NgoJRnKW8bq2fSEbjescBW5QvolOrM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CK5tgKsE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CK5tgKsE"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c207cb16cf5so610976266b.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596932; x=1788201732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMHV6Hk2N+WQQfLCucQHiHvg+yo3kZaqddjw6yoje2M=;
        b=CK5tgKsECcRrb3gxRmOkVe9ja80HUiUDOU+grMIZ6B72UQ+lXokGcWwCHJk7V6SwoM
         n8j1yNeB43MuvoIMryTtXIKyKTE7h8JM38SNQpvp4GOzkTtz2Jz/MNwX1CAZFQS8+yF1
         N7RusOkToi+XIPXCHcEjcMbjcYNnuWYC9HQHglF0vhiV40dEcxhuhd9bogYIvPipCHV1
         v5Kd30LoRfemgpRZq6S7PDmp0SWUUIM5W7ZayKseMHIOKe1U/rFCXKuPobok/EGYIzvq
         iJBSnPpVLCAgT9se5OAA0R5CVuQd2ALobBc7jRdr+sHx9+ge9TrWHDl49yVZjfHrKGMD
         7eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596932; x=1788201732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZMHV6Hk2N+WQQfLCucQHiHvg+yo3kZaqddjw6yoje2M=;
        b=BgmpQZFBCsGDcpJL1+2Cj99PVpgZpMqIjgSrFq4BJA+Mgn8e73/7NZCrLwqWIi72I0
         I0CQmRFneFCgWC9BvqdAM6MKSsUGkEEp39rcHpKgSG+v1UnUeaZFKrYROrHIegyzgB7j
         HDg6FzRu70ULMD6Gb2jv5EiBAVwuikeiHYTWsIff3ZoT9/3c1STO3oCLnRt1S3wbQ20p
         9rbY1+PulMC5JOoJLATRoKtLzfIKSl+nouHkZHfZHW9hKv97os41/7F5fcX2ZFELLjYH
         OYGe2+ZcVwyG1fuFRsJh3LlkMbZMjVQFteuFPJj71RAF8y+xv8/um3l5oNZw+Is5tCkm
         5Dnw==
X-Forwarded-Encrypted: i=1; AHgh+RrrxDoDRHMiX5X4i6FWE04XoT5dMMzvkLqX0qWuHSERLFLPIsRuRnd8i1mjbeN16YBK+I1U539eWMjP@vger.kernel.org
X-Gm-Message-State: AFuF++l2tuzDoaxp4Hdka2hoTu3vgSfgzkhaNiC2hum68kLrurvQiZaQ
	uzkAXLhv0ze5LN5EBDn1BaMsgmp5zV2Kon0YP294pp7pHd1hu0fzjRc25ZfDSqeZimY=
X-Gm-Gg: AR+sD12mCbqpjYecRCK7hwPdcY7//Me+ZKe+hBV+2Ty9ZGWpV1Qna3YfPk13BselrJy
	Zv6+/qWmDnUONVnOPlHYO4EY75/2c0h1ZSN50AL1Gj15l5p4UzMRlawPbj2x6CPFTClgpHLwWhg
	tCUfYTsCWc1QCUgrSLkKQDaWymVSnensjOwcsNxa67WhS/Y/0GhGeVjEBpx5jcSeygXMCwow1ua
	BGrmnQvILWNX+HSpk7jcet5DZ3C14wZQBaOM65qitNDz4+/mHf2b+Hws7Lt0Qfq8Ut/5Wq1vpvI
	zSTKsMBJMcofC7Ow5yVaeqS1TKUpBaFHfRsaDtqHefyXzGIgZE6DNQFMTisnhsVkFK9K90fF10A
	Slh1f0NyodFoNZA2hkTAt37l3zoXCETOf79goPyLSRY7/fFabDut0X50HLAS6Rvs8CAa5NJ1wPd
	VlNDJFOe80Es+ztq+1cAJhTPRORGDhPoDNeh6oKF1klHbA7wsiK4Zzydg8xOXrf0woLK01mccGc
	UXy8L8G5R2xsR86lFGsDSnOJVWWRokotcdFNkksbJkzXHa42Ngoijq0v0ZkFgyH
X-Received: by 2002:a17:906:fd83:b0:c12:5a0e:3e0 with SMTP id a640c23a62f3a-c246a651b90mr3141091166b.19.1787596931658;
        Mon, 24 Aug 2026 11:42:11 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:11 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 04/11] fs/ceph/super.h: convert ceph_cap_snap.writing fields to `bool`
Date: Mon, 24 Aug 2026 20:41:52 +0200
Message-ID: <20260824184159.240821-5-max.kellermann@ionos.com>
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

This will allow better struct packing.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c  | 2 +-
 fs/ceph/snap.c  | 4 ++--
 fs/ceph/super.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d7283fb54cec..554343d612f7 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3304,7 +3304,7 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 					struct ceph_cap_snap,
 					ci_item);
 
-		capsnap->writing = 0;
+		capsnap->writing = false;
 		if (ceph_try_drop_cap_snap(ci, capsnap))
 			/* put the ref held by ceph_queue_cap_snap() */
 			put++;
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 9b79a5eaca93..94964e0952bd 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -521,7 +521,7 @@ static bool has_new_snaps(struct ceph_snap_context *o,
  * However, if a (sync) write is currently in-progress when we apply
  * the snapshot, we have to wait until the write succeeds or fails
  * (and a final size/mtime is known).  In this case the
- * cap_snap->writing = 1, and is said to be "pending."  When the write
+ * cap_snap->writing = true, and is said to be "pending."  When the write
  * finishes, we __ceph_finish_cap_snap().
  *
  * Caller must hold snap_rwsem for read (i.e., the realm topology won't
@@ -627,7 +627,7 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 		doutc(cl, "%p %llx.%llx cap_snap %p snapc %p seq %llu used WR,"
 		      " now pending\n", inode, ceph_vinop(inode), capsnap,
 		      old_snapc, old_snapc->seq);
-		capsnap->writing = 1;
+		capsnap->writing = true;
 	} else {
 		/* note mtime, size NOW. */
 		__ceph_finish_cap_snap(ci, capsnap);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a3dae2c0bbee..0d3363b0a33b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -271,7 +271,7 @@ struct ceph_cap_snap {
 	u64 time_warp_seq;
 	u64 truncate_size;
 	u32 truncate_seq;
-	int writing;   /* a sync write is still in progress */
+	bool writing;   /* a sync write is still in progress */
 	int dirty_pages;     /* dirty pages awaiting writeback */
 	bool inline_data;
 	bool need_flush;
-- 
2.47.3

