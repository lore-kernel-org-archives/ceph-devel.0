Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F439792B
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566607; cv=none; b=irBCwpgkooyb7OCkwzFOZAGvSVX4Mt5tLANPz0RPwmTSG7DLzaqGEVDwiMttKWpfJOWm0kbwIf4FA9Z3kTgdsHJ19a3n6lEkaI72puc/wTvOMjeSRNQCiQxveQ5aRG/SowN329eUQrqhngAs9MPpvcPoW+rc8ZimftnP2XDoDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566607; c=relaxed/simple;
	bh=PNsEuMwh6x9U7wnGeQD0+2aN3K+WtwxzV9yJyPU6bqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bi0bB9OXA1N7FXv7Ba9E0fTZx0OUUUXmnk3i1jlR4ynhwYMdFMBsebw88b21eFWEtNNO5mXB4GDDlRb7s/MTNLOGl+ndD5Ks6rH6ml9W1jPENijPyBMINfp1EAqbJ5JCbN08yqYGbpGRLeyBqzygqIF5eSNXbGR2omKlxVyVTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=N5az5wGJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="N5az5wGJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4957eefd361so10573945e9.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566599; x=1787171399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Pp8eRbtdJC1ybFAuB0ihbgIaBXGaMzvJfeMNRLq26k=;
        b=N5az5wGJiBrX/fOcXkIsOFiPFj0WKwzYSdFxQOvklQTl/V2jy2l9SFnmPl+X0dhGsZ
         8gc9UAMWC0dU+0/GsiXVU4UTEP9QejpAur+uyjy+NuVKABh1vwiqBbEnx/7h7aOTviB9
         nntsXrUCnnf0Oq0oP14dXd/FdA8M58Rw4TCW8S9niDEKiEuDS+LbdHUSEA/JnMZozE/3
         ONbNKi3MWjnGAzrNuaT20dYpaJ/Cre8DKAL+5jEPUnxxGgR8ZLBWxlMdzEDVyAXFGZlB
         xVTzccAF6kywX65fhnh1ymw3gEkkoQSai3h3YmIPtSeXxhU7Wm4xhQ4BllkWU2Ls0lkG
         unrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566599; x=1787171399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Pp8eRbtdJC1ybFAuB0ihbgIaBXGaMzvJfeMNRLq26k=;
        b=FJTgBUav0VYjr/Pk1PrLjT3ZS0TYfz7x1B6IkEzm3ybvSbneNYuMnL8T20Bea5BASY
         dwe/r3rrH9+A8HqhjuF7QJ4fncVEczJKWbCui/QA4F+/IO5/fCcmoVI5MK4ZZz8sgYu6
         1VuIiUJCy4mMB78NMIUvgIyZS8H705HyXwXA/w490ZFpm30JbFxzfwf0I5Wfxdb5v1L8
         6EQoKMk8xDNwiG6fLKhTrLQTNEJ+/LdVxFoDbFxFtC7YwYIBYKLiIWyyZWoqr5iQ+oEY
         rVsfrmbiUbSTv5aYjvklwOzJ8zgLOrmyLg6PjASBD28CGtjdzDQkBGJv0APzI7svs8ML
         ++pQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIkDPbmxM+rAYPi5i6O659yeHKF/0tilFKaYLCNF8KP0Wo6d6ej9gcSEtbi/6bN8T6sSsrqACjAmWM@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIFrBmaUIy5kqsfseYtIeconv4n5Bfm/XKH1bCt1wloF1lUX5
	rhRWgjzfmJtCBkU3KHKP+6kpzXzRJ/ndzNgQdAhoG/fmvj/ReAcz81S0jv3Pzc6YuNgAN4zmT/2
	3ozcOhho=
X-Gm-Gg: AR+sD12gqMfS22Eti9uKdbvGtkL37k+QUFCc3xkZynTeUAE3cGniBtx+3FkHSlM4StX
	CMQnHfct/3FFcrIK++YSnCChc4yWe5BTp7n6IBy9ikeHdsAphnSceiZK1jl+18KMl+stgGxutpp
	wAEdw6YWe81kOMaaE7c4BsfUAXZyRlOCbR8D/+nJNpKwvwyyVYcM+X5Ww/9p+FZrmxBvbOV2iHu
	52hWj8gasWv1jZQUUnMmWzRaPQl2GGsLn1znSBeyslURp9W5FhVyVAgrwipY4K6YpHS/xhgwRQG
	DvRoE+dpORkLeQY2ywsKB+lsaBuxECPoMvI2b9ZyNJhwqhLYJJ8NB1WgU8XYaeikcAjzI/NhxYJ
	8b3IOEuyaL/YP9vywR27Hr/zBgFRIhsYFJaxKUncrUBwbbc4h6jTdfZJa9TR1nJ0aO4vJpX3IyG
	lU77sjRChNBqFm2NNrt1q9aQ91UkCS/IuyGAH4pXvBu+zBluFylouv9jhhjmwaaAl6f2p5R/ED+
	FhuA15fqrrB1VSHH4xgzbcAD+SedquWjsAEQx7iPLS6H4C419G+DZsR2AyhPDwC
X-Received: by 2002:a05:600c:8519:b0:499:8177:2a0b with SMTP id 5b1f17b1804b1-4998218ee5cmr4170485e9.9.1786566599311;
        Wed, 12 Aug 2026 13:29:59 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:29:59 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 05/12] fs/ceph/super.h: convert ceph_cap_snap.writing fields to `bool`
Date: Wed, 12 Aug 2026 22:29:42 +0200
Message-ID: <20260812202950.1800340-6-max.kellermann@ionos.com>
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

This will allow better struct packing.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c  | 2 +-
 fs/ceph/snap.c  | 4 ++--
 fs/ceph/super.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 1b904089b56f..51ed5aee193f 100644
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

