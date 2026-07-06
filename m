Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C66394785
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322726; cv=none; b=guYd3YVSF7JRIQO1cGaIgSuw4B9335/WbQ2M4CHq2fONLjPhUekGk2Gys9ropOvZsoE0eUKtaam4IIQxIP9/wvjxNBF0gxve+N1CgqmPKQM/PsZlzzibipRV6tGy5fV+0zzErYtjLsW2xsL+FS0XrJfIbsbYbYp9/R42w2Qy2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322726; c=relaxed/simple;
	bh=DwDkodbW1ly4jC6ZK+lnuPyhZZq08agsspgS0AHIn2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVG25rbGh64VMhN4xUjL32LL5pPOM3cfG1kFhH+NSDAdjCD2qVilc9PEbol0lcBwbEX2wqVzli1olbXF3hMPUhdGD6lD3uGYdYWpxajRtDUw8zBjHIbKCyFT+xY7NJosL9nLVL+prM/pAXygjmvC+Hw6gzuIexAddcBFbjdm8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=L6gu4giz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="L6gu4giz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493d3135e9bso8344845e9.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322709; x=1783927509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsI3ahW87ZFKuZWFJmkvVpXNmYLO039xLtbsuV2z/ZE=;
        b=L6gu4giznIxIbm9Q9UHOcD4HK9Ns4mwq3SNhDRc36iYA1ejhxiqjDAvgtOeEcaNJvt
         tcpW0NMZ4mfNRdSKWDbE3c+1UWXXKBZgv6Y9JuPC92IiCf1WB50HqLsw6prxDx5yacCl
         6h90xjRulno23zWBehfcS5U4sWwgSqd8bCwmxUV1zqbVlduBMOtb29eYvmbfubKH0FaD
         r4VvhpOve8vtj72YtuEPBCNdNCk8eb5FaUn/OUd0P2tjbZExwajByyxfPaX3RsCZh37K
         e6PLwWzYxhmBkHzLzIPrpVLnxlmb5NlkhE8zp77YGlhltqmtDPV9ZT5pLEdNfsrM6LxZ
         OvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322709; x=1783927509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qsI3ahW87ZFKuZWFJmkvVpXNmYLO039xLtbsuV2z/ZE=;
        b=Apzb9I2s7tsWIWKGmhQeriEXgzJ93c4AfISB32g5ue6wHk1eOfOdRKj65js3EwgSAJ
         zB8sR5wjtcc0wpA31tPYGSqFAjcsjdiYMPhv4Xu8EWByHe7yyDSJhWLb67cgNP8EQF8b
         HTh1AW6DQx0GO+ljzDPGfCKMZ1HaCV3+dwkhkZH/sTOliIC5CYerV9gZ57C6/tyg9BQG
         JiIqN7ZIIN2/PTd3iltiZC8dEud5cUSTZq/V9eCZ/aWotqhxRospIZRGdVXGv68n/uRl
         YTkAg2xUnVRypcp+p47WtCdE/5lWogLf22lcwzR8ecdfHe0s9q+H6pcqghaaRL29dJjc
         839g==
X-Forwarded-Encrypted: i=1; AHgh+RqCd923hZXk+YY4kIt+s3gemYpq7ICBSOpqReQggJH+jie/gDuvsvjtk5qaRQmlCmlYEzo+YAXnbXMx@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmSWCdxhaRHJ74Jbd2/Z9Kou/IY4+Lx//5fHJPrtinKJmf6CS
	Cl6EN0e/io2PnRGjKOk4wQGvnLcReN1ZUesBwPDXcLyaiF0I+z7VlWAWNIWd0hmCIk4=
X-Gm-Gg: AfdE7cnz4QZb70KYAWYcRc/81TsA71bK3V/7BtafJ4w3nNeZFEYVqsPLDYbD33esJkE
	1bz4ORfBI8RWF1CCIWrfaxS8EiJeCsE9LXmFnwxV49lSQb9eUEagg0GwDdJXuutpom8uP9KsnBY
	94imAG2HEgNmPdAdmmX3RNuQM9EqP168FI1SXl7OkfND34eZiMiY0EKhzrCGOnxIrNbLQ+Saj/a
	aC/oxNjFtoSagU64KKFRDJ9R8w/2kvt4JkZcvwvA7dcPK5ZYyk685eTjO4HVKj5/bKr4n8teD77
	ZnXGDh6s0+DncmstYX+1nEbZe5q8TqT8/pTB6jsfdKMTNhgDCZLxHw1xLEYXk1H/3YL6BUXSHcL
	+LU987awM+DJ+8cQyQT7w1gANttyhK8eKc9ioumzHerRuGjTu15bYxzuTSJQlGy1ktTui6beCsq
	kQf4oTl4/OAzLlZY12NWMAsmp3+kqa2y6Jk8HES0jd/no0VLEmUmuMVDUZWbX0TvF7OC8f7BIoh
	ZBkuQRhMKv4SmeA
X-Received: by 2002:a05:600c:8a16:10b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-493d11ceeb6mr78265185e9.8.1783322708704;
        Mon, 06 Jul 2026 00:25:08 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:08 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 18/18] fs/ceph/super: remove redundant field `ceph_snap_realm.parent_ino`
Date: Mon,  6 Jul 2026 09:24:49 +0200
Message-ID: <20260706072450.3920010-19-max.kellermann@ionos.com>
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

This reduces the size of the struct by another 8 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 4 ++--
 fs/ceph/snap.c       | 5 ++---
 fs/ceph/super.h      | 1 -
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b4a1c126cbc9..f0b9d653ffd1 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5044,10 +5044,10 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 		}
 
 		doutc(cl, " adding snap realm %llx seq %lld parent %llx\n",
-		      realm->ino, realm->seq, realm->parent_ino);
+		      realm->ino, realm->seq, realm->parent ? realm->parent->ino : 0);
 		sr_rec.ino = cpu_to_le64(realm->ino);
 		sr_rec.seq = cpu_to_le64(realm->seq);
-		sr_rec.parent = cpu_to_le64(realm->parent_ino);
+		sr_rec.parent = cpu_to_le64(realm->parent ? realm->parent->ino : 0);
 
 		err = ceph_pagelist_append(pagelist, &sr_rec, sizeof(sr_rec));
 		if (err)
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 12f80df4b651..a5f8f3f95f3b 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -297,7 +297,7 @@ static int adjust_snap_realm_parent(struct ceph_mds_client *mdsc,
 
 	lockdep_assert_held_write(&mdsc->snap_rwsem);
 
-	if (realm->parent_ino == parentino)
+	if (realm->parent && realm->parent->ino == parentino)
 		return 0;
 
 	parent = ceph_lookup_snap_realm(mdsc, parentino);
@@ -307,12 +307,11 @@ static int adjust_snap_realm_parent(struct ceph_mds_client *mdsc,
 			return PTR_ERR(parent);
 	}
 	doutc(cl, "%llx %p: %llx %p -> %llx %p\n", realm->ino, realm,
-	      realm->parent_ino, realm->parent, parentino, parent);
+	      realm->parent ? realm->parent->ino : 0, realm->parent, parentino, parent);
 	if (realm->parent) {
 		list_del_init(&realm->child_item);
 		ceph_put_snap_realm(mdsc, realm->parent);
 	}
-	realm->parent_ino = parentino;
 	realm->parent = parent;
 	list_add(&realm->child_item, &parent->children);
 	return 1;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index ca4db56ef2d0..86a5929ee5d2 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1023,7 +1023,6 @@ struct ceph_snap_realm {
 	struct rb_node node;
 
 	u64 created, seq;
-	u64 parent_ino;
 	u64 parent_since;   /* snapid when our current parent became so */
 
 	u64 *prior_parent_snaps;      /* snaps inherited from any parents we had prior to parent_since */
-- 
2.47.3

