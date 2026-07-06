Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52D346FC0
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322716; cv=none; b=LtacAWNCTXLC7J/hR2B1hiMMu+aWenM+S1lMFz5bcvqlfxVFh+6yRs7vLBdVHotly36srMiXMLSqmPsEM/Kfssb/Jy6n3+5a5wpEwXrZzs9yLp/oUcyeoD/F4+iYwyybTuQx1g1zkROHmnLyJWSdZTQsXX+6dBo7IIb/nAG9Y08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322716; c=relaxed/simple;
	bh=gclgKBFuUxovdy8VLSzlHY5lDt/Dwqxz8rBFZfiiiiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kP5jJdvSGB3v6jUEHdxKlhdo3hz4O7RgXytPOVH7FtaBD72m3jELSdVwc01MA1dRnNBNnwczjR3tfJHwCPkpv2a16/hUep8vHe2VeXGZl2PzwSF9R2Afh+6iGkm6izlcvO/tFXOiJ0/Y17BPuX6h2hsXsAREd1/4M+vVxlwJRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Ug15ewdl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Ug15ewdl"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-46ed4f66256so2416558f8f.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322700; x=1783927500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j37e3qzNLxBbivBbZHFnVyvK3I6c2/ZeHCEFNM8OXPc=;
        b=Ug15ewdlGEn9IxQISCTdGsSUkGHCab175hM+FldH58tk/wNZv0Z69yHe6sov/zU+SC
         uDEMILgrMl8Ubw3jIGt+KPWrMUuG4kkzGzuzN5U/WZAzUxlJJ7y1T4tKAus9YXpGTZAD
         aAlTpO9tEMxwfImiGfUqlo3MNNsvSkoTiOa7gUgsHPsSHf+EKPLLb4/eL//c65J6gC2e
         rQHIi10bKLCoCe4sPQ3/nt2uu11wOjZo90BRQhLVcMyDn19b7qEkfQyef81B7O44Zv0Z
         a2XgyPB5UZM4/+eWC3agHVtUks+ZDjwZlNKqxlriozLVAu7muq/A+SNRMoHc3njtkcQ9
         BOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322700; x=1783927500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j37e3qzNLxBbivBbZHFnVyvK3I6c2/ZeHCEFNM8OXPc=;
        b=e4BjmVpOBPBa4lpUKSUkaz+UPzzwjHqDawVWSNs4GYnTifwYsmpnxtrFW+rSWISFch
         hx/n6xk46ooi0zHkY5Hl7M8i7qMkrUmmkgz5k18uTg4mHuKGJxIDB9374/7rzN6U8Wo6
         LMwzsxuaev+y6o5ohbwaMrXPPdEzpQn8vowj3ocMngLmWijKFy9AMlR6luMUR2WAtB3x
         eWaFbPuyxeiaPzKWfq431jtIhztVwMPpLlcLHHwlAUiyWHdvuuOtFCbKXGH5Lxy99wQk
         E02C0MzYVi89M2omS+I1jAprDZoCBikpvJV2VB5NciMD781z1qCaxn7TgWoASg1vpv6T
         +jdw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6/zjZCs7rJSBJoi4esKDz3M5YvdbU0GpSPOmvK7iQiQQ2MSqXsywSJB9/1J2nOpp/cqFHFkpm/9Xs@vger.kernel.org
X-Gm-Message-State: AOJu0YwovcwCM4NbzwOFCyJOhoGSXj6Vf5JFyVcsVgKDGE1I8RuzP5ws
	WGhc8aoMG7ElUOpT9vrWXf73XjXmxwQzmUEmuPfg7hHPES+9BR1Zmnk2WC82JP7m+RQ=
X-Gm-Gg: AfdE7cnj1CpHOUdqGfy31jhHViFR6tU8powQDcOY/ACzMbePgF/JR9bHc5/nWU7np4E
	gT45YErYu/CQ6CxIuFRuPUGrVQZuFrgU7egD2aXdLtfFSZw7VQ4uHFwTh4aNBH6yB8Hv5N29ArV
	O49JY3f8OtoG7ttC3A5dD81B1wLD4YjCHZnY2Tj+J2nO67/d19O3XjuJn8eoS4jBtWKbsn+R//+
	C0+Cw7q31IKSScD0QAD5mH4hymMcvXqOAT7MPC1PWmKmcmZdRq2Bbn3vRI3XgStfQbiZ2b0P5IK
	Hhe6bNJAz23V1MSdKds76+TxWcNrxChuEWEgBBPB4wLjySsOe1zJHx2fdnWyysxFplWBC/AhLth
	HIh6GchsNm3kkSH22ByGS/oWrnhdYlumTO61RR6QSbmvkf3CC5TAdHvkhIpd2gm+eJJcL6JrPTW
	gon8KtuEsWgkxJof6noaNeLDaxzihpKXkwe81QbWOmOqk6TaEkrZe6Q/0VRMkRoGkaZR5BSrlMK
	isCPY+5C8s1ajXl
X-Received: by 2002:adf:ec0b:0:b0:472:7ded:6aef with SMTP id ffacd0b85a97d-47aabb4d57emr8317069f8f.2.1783322699533;
        Mon, 06 Jul 2026 00:24:59 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:24:59 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 05/18] fs/ceph/super.h: convert ceph_cap_snap.writing fields to `bool`
Date: Mon,  6 Jul 2026 09:24:36 +0200
Message-ID: <20260706072450.3920010-6-max.kellermann@ionos.com>
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

This will allow better struct packing.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c  | 2 +-
 fs/ceph/snap.c  | 4 ++--
 fs/ceph/super.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 39dad1a528b5..372b239f6a36 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3291,7 +3291,7 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
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

