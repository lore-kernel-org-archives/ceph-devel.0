Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853D73F58EB
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322722; cv=none; b=bTuR5fBD57WrI10kKnRAck6uiZXggnwYrpaosEE/yjOD+T9THOFZ8aBF8/OERYwPsxjB9jhkdZrkBxpBMa2OrK5g7/tiwMKr3ANmJT7PhuiO9bv1f9nVvBgN1C3MrlkJ3bP/kJuTmLvEBat+f3qD2vahWWqQOVrjBrVsR+AfupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322722; c=relaxed/simple;
	bh=9N3D1JdA6UgBEtBexlu4fyeGlxQejR0JbfCW6VcEuMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhXutLq3Fh3OjhoIFrW5BHtnWBI5pLTntqcBgOjrFfmARru6Yl4QiQsMIykohH6/x8kilYjQI74IWNhoyLyC8mHSfT0eoenc4gjP3N2QygSQQbCxcJW30nK+gFYb2R32t74jkkfxBXR9LzBpYWS9RxsEQWzUY7iEK99ELT5Xz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FJmAwMTr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FJmAwMTr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so14294945e9.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322707; x=1783927507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE6M5yyybFDeD5AwWJUv3PfTIyMtdXSGYBvf4zcPAws=;
        b=FJmAwMTrYnMEEYlnOZyyxuLlAWijsiw+0C0Ek1vaqFODwjRatmwWVhlTBkbIEIWCxg
         TzHnR6HugBPKPVA3G/dgv2TBgiz6/gmvLx67RAxulZsO1NiiKdW47GeBFU0BbYpbDr7C
         TJu+5YPyBpYQoCkMQ4HYgCNGdpXnoVKfvydAManadhPPclRd7Gav3x7eRnzRrdJYl0OH
         PydLNBH02jaQh/7inubaxkLbWoEr7TobztDxndg1xSpU00oHQwg1u2l6EU3BgRHzZNqb
         eqet9Y8knYrUATltHdNOzEjueubib4ONGSV1xG3QjaOv4ufl4NmU3kmoad80Rul/oLEU
         A9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322707; x=1783927507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kE6M5yyybFDeD5AwWJUv3PfTIyMtdXSGYBvf4zcPAws=;
        b=eSV2SPMzlyxfPabffO+eSRcEEABdlt+CphxIv6hrUa0foDBOCLhdk8o9R9iyHzOSlQ
         zNyUKJJqOZ8fzdhYLCFSCOP90dv2cHJQ8qY9AoYdd8yfmqUfgmpdQF7FcdI1ua5kQ2xh
         +2zJhXftSTi9rYFBNJFT1+WEChNOR7j05RQBxjYS4b0O/RkYN5lMDVsnCbZ7Q7wuAZj2
         V81gjqk5sHH8ElfhfBB0xw9mbt5eSoC9NTQR1Ueol9R0pqKR5LMIu5vCGU8c8gg1hzWA
         5fCr6iqlE9ft6DgvhxcO4rd79odJYnHZ3gU0hk5RAW1otzuzyAr+shLVdVUZ+fQXROgx
         CQQg==
X-Forwarded-Encrypted: i=1; AHgh+RrxQffSwR2ikpj/DhgNzTXgNjdTR8Gx6qnm6l3wOWlrXFUU3jpDiOsBVqtA29zHiP2wKMxMTqpJ46ae@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9P4I5oYw/VkFO6m7avMK04RtppBc5Uc+1ygluItGSGGyESxp3
	NppcqcnITNRbscGAkcRfroiIVqIFU22VdpsRBE5Str9718DbNBqayvs3Sqlv6ksjiyPo4948sl5
	srkcAQKU=
X-Gm-Gg: AfdE7cnSh7Cf0l7WJtAyyTMYQy1KJuaR5eLfJE89dmgYkBdIdC5EJP5e39wYYi59lov
	6Hu6BWgEAjm4SKjqypxa7H0P/k0IfuxxJokB14cCGC1Va0KibmZmlFsLEwJyilvGSxcps5jb21T
	PiFrl5tkM4G0S4jsl0SzPhFIOREv7AG4ZyrkQMBDitN/SzHBpfqUJMviDWEsFfRfvadVH4sLkM3
	Q711CzJMQ4TIYLKr3/OVJcQHE2SGpErxi9OUzVkKcuWGI/W1Ktap0SyzL2lIvsFfXLVT7nw4oBC
	zZ7QpBvEwcOUb79w31lnRFqHdZGuhadC29LUsKbf+1Oh6W82zTNLli5Hia0xtiJzi1Gjk2K/elw
	f05WBaimv4xVD24QTHiJD/K2VA62Ph5gchp3Ml1OfXB+KiD317+ps2rPunNr/Bt/FOOTqE3KcXh
	AGPSTPHf2xoXPAxlDYDQQ3lsWaMI5yRCbvBwcmhD4oZXDJ3O/Ehbjb0LIl7rfMJ7SAzHSBeVPCJ
	KpwEN0L2cWWjLWw
X-Received: by 2002:a05:600c:6286:b0:493:d2b1:48c8 with SMTP id 5b1f17b1804b1-493d2b14ebemr96316045e9.33.1783322706829;
        Mon, 06 Jul 2026 00:25:06 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:05 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 15/18] fs/ceph/super: move `ceph_cap.caps_item` into the union
Date: Mon,  6 Jul 2026 09:24:46 +0200
Message-ID: <20260706072450.3920010-16-max.kellermann@ionos.com>
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

The `caps_item` field is only used if the `ceph_cap` object is
"reserved", i.e. when it is in the `ceph_mds_client.caps_list` list
(but is otherwise uninitialized).

This reduces the size of the struct by 16 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index abe403eff0bb..afe681a47f71 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -208,6 +208,14 @@ struct ceph_cap {
 	struct list_head session_caps;   /* per-session caplist */
 	u64 cap_id;       /* unique cap id (mds provided) */
 	union {
+		/* reserved caps */
+		struct {
+			/**
+			 * For the `ceph_mds_client.caps_list` list.
+			 * Protected by `caps_list_lock`.
+			 */
+			struct list_head caps_item;
+		};
 		/* in-use caps */
 		struct {
 			int issued;       /* latest, from the mds */
@@ -224,7 +232,6 @@ struct ceph_cap {
 	};
 	u32 seq, issue_seq, mseq;
 	u32 cap_gen;      /* active/stale cycle */
-	struct list_head caps_item;
 };
 
 #define CHECK_CAPS_AUTHONLY     1  /* only check auth cap */
-- 
2.47.3

