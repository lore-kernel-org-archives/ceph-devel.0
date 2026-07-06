Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984B03C98BE
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322727; cv=none; b=e1D53Rxs939G5CoD08mUOYO++1uKWBEbvanHuNOxHbGtH1kfJ8NDa7hlPzJFgOzGoBSas8aLHbAnoxzHTadyNIpRB+Wem0nIQsV8SQw2e4nk0F3CLAKJohr2oCnZTudktBbJdd1L7/PaWeJV95w7sFfqK/TgKJqcjJPFZGeNQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322727; c=relaxed/simple;
	bh=LRt/dVRgKYa54b6wDopJgfpmaI/xtRPgitTxM7EtsS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=papt7sbFOxfUQNnBE3cE25WBSCgpUWCP6sAiDOdxQ+qpfec+l5KdAL99JLq3bo8KmGc0KAkmADEu3y6m+vURW1NO013OaMViW577VG7sZcG/+pd2J9W7XRW/R/7MgemEggC5oWrHXaVXSFFhNAceuMCjoHbe6zkS1xA2lPUWL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fp598Tei; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fp598Tei"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so16325145e9.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322708; x=1783927508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c18EdRs11M62SU89f52/ibYLpC3nTNs83pWibb8NkL0=;
        b=fp598TeiiqLhOX7DdLX1ZrlGZkZ+wpUKwyeshRDJlGu36wtDByPqGGwfdoA5P1qBAW
         aX/LssP0ZbzdkfnHkZAMxgVqnJfW1yNwNwZrLIsAgIkl47Y1Do0sex7as4bfpxcHx312
         EYvLj7P9fNm25h8zJ8LGcGauGFHuKUOMmc0YSalXcS/PCE99r51gEObsN3A5Ju7WMcBM
         tegXtg0nycYf+x4XYUTgxid4fLApL5iAtNp+Au0et5ToqbW14hdtVrys4aaY/zoM7crZ
         k2Jdwi7ImU1DJaxhG8frL4l/OEJCwXeyTT+Kq8nnMarr3F6tG/PwFwegQdoWlp6Yu2XV
         NPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322708; x=1783927508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c18EdRs11M62SU89f52/ibYLpC3nTNs83pWibb8NkL0=;
        b=gacokYVRx08B2FDoUtVhEH8kOCVO36qGyaUrXvYJOA6FaZSsUuVIymdJpk8YpUgFmH
         4Zya4krIsUYpyMV0Z3+j+sqyYowtwVHuxKuQfI813cLqZv2b+9R2wBm2ZQXVNu5hOurb
         g9zfgGxsFmGWnyYJor8VJixDUpFEO7EMBDsJhCA7lai21EDuf2Kb3Mj9om+8h0dYVHHi
         9yqQNEzQuvbmcGnyybDCjmgupqhzfy+sg8oUQ43s3rqKeNeKdMwobK7OfhlkqbQUPV6p
         O0Ez7FvmLB22PsBCb7RKBt4GrskyTNUIchAyPX68UfF0rcfFFCbj3iJCKtuwZQoDi/xn
         292A==
X-Forwarded-Encrypted: i=1; AHgh+RoWF7k42BgNJjvvC89xQ+Se9fbgslLhZZqIz4ORdS6jE8QnVvznqL+31/zOrQ9VzgCZgg80JJDaB84u@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhe7rz9Xi9aC9W44N4PAcfeH/RuvwoGXMIK+GQaPsf1MfOj92
	V+jR8Pzs1r3dLkVODfaBsnFWtqZc7ZINyYwgoAipZ208UIcXn42FFWYgxGvyhu4liIY=
X-Gm-Gg: AfdE7ckwLX0EPHeMkib6qTaQL0d4ZE6Ffi3XmgZBbXmf5q/mYGAwq82yd4/ON7LTasN
	MEIqgfZi6VXT8kIfh0umiCAjUt8x51joRUMjGC8BAHGlMerwH5TI+W6KxoMwxaPEQz2FETj/8jU
	6m7qGwRzO5vWDlK+62b2e92MoX9W+iKdBPQlEkCkR+TwcxjK8vqObi8nqJtLBSQYgP29fxdACfR
	+MccB5hNfBBylbuZrWJut7DntSA5hXpEH+31cMCg6a38RJ79Y0CNK8ScrNFlRzFxvw106exfZ90
	+X8YPGUjf6XZImuTgFyxip0GfC1VZDZbR3FluOZ4SZp1tndDE6L1X/24vD/JnyJTz+8ipSJT804
	lvb6Bl8vj6ZUunti94Cz4T0BZUnRgybf75tVoCYirj06xKhh656kesekv8sK8/2+QW3zSgAsE/2
	Zkoeaq6OKrS1NZ2HxMJsv4GjEZngeaP1PP/3DRTIWNFld2nzPe6aF+mnozCKo7RuD3/gUC2YrC3
	C8TWLuO/F8uSsBn
X-Received: by 2002:a05:600c:2905:b0:493:bd66:3efb with SMTP id 5b1f17b1804b1-493d11f9072mr76087725e9.29.1783322708058;
        Mon, 06 Jul 2026 00:25:08 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:07 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 17/18] fs/ceph/super: reorder struct ceph_snap_realm fields
Date: Mon,  6 Jul 2026 09:24:48 +0200
Message-ID: <20260706072450.3920010-18-max.kellermann@ionos.com>
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

This eliminates two padding hole and reduces the size of the struct by
16 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index afe681a47f71..ca4db56ef2d0 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1020,16 +1020,16 @@ struct ceph_readdir_cache_control {
 struct ceph_snap_realm {
 	u64 ino;
 	struct inode *inode;
-	atomic_t nref;
 	struct rb_node node;
 
 	u64 created, seq;
 	u64 parent_ino;
 	u64 parent_since;   /* snapid when our current parent became so */
 
-	u64 *prior_parent_snaps;      /* snaps inherited from any parents we */
-	u32 num_prior_parent_snaps;   /*  had prior to parent_since */
+	u64 *prior_parent_snaps;      /* snaps inherited from any parents we had prior to parent_since */
 	u64 *snaps;                   /* snaps specific to this realm */
+
+	u32 num_prior_parent_snaps;
 	u32 num_snaps;
 
 	struct ceph_snap_realm *parent;
@@ -1047,6 +1047,8 @@ struct ceph_snap_realm {
 
 	struct list_head inodes_with_caps;
 	spinlock_t inodes_with_caps_lock;
+
+	atomic_t nref;
 };
 
 static inline int default_congestion_kb(void)
-- 
2.47.3

