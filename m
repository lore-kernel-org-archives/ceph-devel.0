Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039446AA9F
	for <ceph-devel@vger.kernel.org>; Fri,  4 Sep 2026 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518039; cv=none; b=SIPIbKtbg3nelgwavfHgorLcnvPGjEMep6m1VOk/ntFwwC9iv0ADxzYQq+2Itl+/ODdBq0RdtZlKD1cLN1p9KYi1ikXHZqUVMr11HYGdrQPs6cBlb1B4pvBspkru7qLrOQV6k1KZNo4AQZ59zMka1IT5NkOWxxXRwXL8XVPOZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518039; c=relaxed/simple;
	bh=lnOd2Cu+mfYC06hiaS9xwajbcEsrwnQBxbyBPrBJXnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjasoYNDEQAQEU1pXLPhSEXDdnckVCgjF3shsqU5BL065vfWG4VKVUZwgadDHEC4hX32U1zQfa62V2HLQrEGOOKtUacHs0EyxwgmPVZmcUYrgObsCllxwK89kNktR8C+4aSf+NzC7ierdYlpy9rfLZzRIptXBwPgqkto4A/vAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dHQE+2sJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dHQE+2sJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so9798465e9.2
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 03:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788518034; x=1789122834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CH4/K0wijj7OtRSv4HcTF7FzgieNSCBLu9edWOGkVVg=;
        b=dHQE+2sJcyvfOvlxjN8MRvfSKb0YVCp2Nh2xKoUKmKqESo+yJSxQBAsUf4e92TLuAr
         n64RhNIAl4NCmEMxs4TGKEBlcD+cs2LDzMxNnAQ6uLiI2USwrp5n4dFWO2cA27irnjr6
         unPz6FMFM0xsqSgN/V+6P0WgZ9B8NmkIIf8AEqazeu1v1Tb+Gig8CVynvrA+K36ICWNt
         NkIapDGIiOqLxbvKmK7uIrrgGzmHv7/Y106KsDsbJfxtmitQCnvSLpsAHtvmPw6XvrjM
         qbxW2gH9Fd4kovWnkN8DzC61cziSH5C7aB5c1GDdND+NT/DGT9VcRZBm+Fj1wmtOLIpZ
         dmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518034; x=1789122834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CH4/K0wijj7OtRSv4HcTF7FzgieNSCBLu9edWOGkVVg=;
        b=mH40azhWo8jGYmIFkLo1/xr4VoH03t9Psj3iVsLhqm+fsi4DJlOViNOOQMmcCGLwcR
         VsmFK6IGf/gupoVqs1nrka4KNFb/K86A7VfdyNZXO9DukXyOFN4eDzNkgTGp0PL9hQ4n
         KYrUDcWFetA2irUw6WIr84/I2p0SbOuoeYqz4dPexIilop2+7MZGumfJBhw0Ff/3rJKT
         osDheY5Ek6KGuoX/hsM3hxBDsF87DekfLoimXDkWUKdC84kWcdMyyKb2XGS1xGFz+5Dn
         OBYR4Ru23r/fXWdl6HgbcKcSFu7MLg8DpN2oWZfC2egC0uks0el609vwqBkC3ck1YKgQ
         ezXA==
X-Forwarded-Encrypted: i=1; AKwUvBxUtMbEgHAeN99df+TcENEcM7afLEgziNKFWKHas5qjmXSezSxrPf/wKI4PcKatbTN6ZYJizFf1l7+K@vger.kernel.org
X-Gm-Message-State: AFuF++mxnWlejFFckIk6Wo85RuD1tK0qC9aaWlF3t3ts5Wsmk60AP5ZL
	daEdD0ulRWQIKvQ/tv51x+Lpjf7QbaByWfPkSWQ0KJTVc5DeZ81/55LTGXUypjmLPqs=
X-Gm-Gg: AYBFou1WK6pmq5JhMHedcnIM/XT5ZW0TU779gCj7TXxgzowmggkXg/Q1GrGTygWyc/F
	F97fx0VVysRfzXut04zEkZHjTK2FhXIFBK+Gr1HnvF8DMXfEMjflHG+JjJ1aZSDAP++UaRCLo61
	Zk8UmgOFDwO1G94bKnYoH5E2TP8ml9a27vZQ1mQ0m1D68GW/iLgoblg2IUTs2l66/BxbAzpnPBD
	OQQVr5mCf4ZK798Nm4ZJejS8IP6/UqWDP4L/tLE1jRovANyY2lAKRfdYn2oUGkf0LzpeXy9swyx
	qgrlmUjV1C9+Cof6u8CwKjxfS/jcxMHKHQVPhm6KGmgPuUtgKmcD+9j3Ms91jT1VMJc60Tnk39W
	AV/PmdtlHax7uba5OtcIjsLxS9uHqsigFs1OezLOnLifDiaydoIaU05Ddnv9l8UTf30g7uh+Xy5
	0YaEusE9VD4gwlo5a/GC8pmFgCz1ZIj/LitSZzEL9wIoINOMl+nouokh2p5XT2Sy7b3unZTOm19
	IUbFxuGHa/gI1qB+U7e+4B5uWObaydvYUukxdbN/IuwuiC5zTLNJKBQm8NAdqGi
X-Received: by 2002:a05:600c:1914:b0:49c:ff23:a6d5 with SMTP id 5b1f17b1804b1-49cff23a70bmr3661865e9.0.1788518034477;
        Fri, 04 Sep 2026 03:33:54 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm141003045e9.15.2026.09.04.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:33:54 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: avoid pending truncate during nonblocking cap acquire
Date: Fri,  4 Sep 2026 12:33:51 +0200
Message-ID: <20260904103351.15357-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Readahead acquires caps while the folios are locked.  This can
deadlock when processing a pending truncate; truncate_pagecache() can
then attempt to a folio that is already locked.

Return -EAGAIN instead when `NON_BLOCKING` is set, causing the
readahead to be abandoned.

Fixes: 49870056005c ("ceph: convert ceph_readpages to ceph_readahead")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index bcb04c6cb92c..86e195c5fd32 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2889,6 +2889,10 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 	}
 
 	/* finish pending truncate */
+	if (ci->i_truncate_pending && (flags & NON_BLOCKING)) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
 	while (ci->i_truncate_pending) {
 		spin_unlock(&ci->i_ceph_lock);
 		if (snap_rwsem_locked) {
-- 
2.47.3

