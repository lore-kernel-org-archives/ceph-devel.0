Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84C495E5
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2026 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650507; cv=none; b=R+dHnrMF7Y+kqCXqZ0WUv/zcU0iLGSZmz3JZIvIo75HFCKy9ex98UoXEBJloW5QmRLDsWPGCW1DyfygQDcT3GhrxWBdQqZPlyCbHX7yuCTYEVCHqOL/uVBu0z/TVOlUvuj2vCcp1tI6zigpEonKIu93h2u8mNGct/AtT5EseAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650507; c=relaxed/simple;
	bh=43wHOTc08YfWIcTRc39Ez/9eOUd5SRAE4DdCdfQEn2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFi4+OOSa7WrmZGIseHe3vDoXZ+n64wdzWWpENnIicu+giUMNFfxi+ZOtod0Xi+hrIR9BX+L1IT47q2yAKZc7WkZLkAOTEaxlylLrWpasPYexydnAJf3B/HEx8ERbrUDECxUG32BOuYOuV2AmzqCWCozRPpPqZfWQEPbASziZuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzZot6bC; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzZot6bC"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e6391b114so23877185a.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jul 2026 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650505; x=1784255305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/pFsjGiVutin/IDvHuVn+jLiTyGk8WNjtGFyhaDb1J4=;
        b=MzZot6bC4O9tZY9W1Ynqb168hVlthigBKyhDDPBTpmW1NBijsohmRYoydualDWulKH
         PiY6+6J5A/TS+5P9448ckMOnvM3sU+WvGIjmmt0PBME4LIj/Y3phhbfTrQPQ2JC+2zqX
         HV2F5MUTF7xGGLfqjCd1aKg6GPqTCdwlwUpKen1O75lVxXqBYwuJo1D/w+fTVvIaT/8j
         acq+XsReS2NOVBowXWQ/8G4rwOlaXDgn0ScrnXerJw4EPk5LLwCrWOOiKohz4U755DCx
         bH1r6ZHyDZMd02yRGDf98JpXKnb+BAeascnroIpqBag+ulGB4011D367WAVWgIQdL1SO
         EvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650505; x=1784255305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/pFsjGiVutin/IDvHuVn+jLiTyGk8WNjtGFyhaDb1J4=;
        b=HIQpxSlaL/NnBjkgUU7Jz2yFrzLdDdvyUZj1X6fb3vS1yjXivHWHqGMfhi/7nMWzRB
         Ks/Z1g1q5UgjyG9eEYHXB2sYJ0w8Iz55mvYCby3/4S4cyCEhXL0sPpSHw+SKAd3CWlDT
         GBkbEed7DtfTw0HOxqRnrpBFROSPakFQgmOJT5IktFqg+7BsPRoStPJDrDNbAh85xI/K
         4FQrgKy01DxH7VIwvXneEV2OdU2LOC3Ny7wCuvipOAxPlg01rRlYjtux1+DpE30koN1k
         X650yzGtU//bU6qRSkVQYJSE5BUuITNkDAzv7xNdH2XlbggjXsyaOoxhyFbeihYrDBh1
         q3YQ==
X-Forwarded-Encrypted: i=1; AHgh+RorDA3GddQae751mncoTYsHc8bJ2CDujTWBNI2DL4PLuN1ijpaakw/OMLeDZgIjg9TIpOvngCt+11dW@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrOg+2BWnaYA3aVT/l6RoJekXsGurFipuw1aNQTDPygZBvAjc
	tHJa33wNUQ90e70tCaIbKGO+BGmrIYXpIfTnCQkz47i0MAyvn2avvWUo
X-Gm-Gg: AfdE7cnDFxE6/Kh192tr0/ordIAatRtSTwbtlcvcqaps9A8V34angbhKBH+F0vTfxM6
	DO2488tsMnjnlJLPRqN8Gc15xjdRFx3CEZZklfk5i5hyamuMabV7O4hEbs4KVy0id9HkLubT5SO
	UkV8ExacC2ARY3MNYZFcMipPTOo30Qx2e8OQb2fcTEQtUDjJFgGGU6x1Y+efGvvoDG7+rBbjOtj
	i6/y46bYNDneaLRFw9lrpeJDWoQ3g0RqAZYxOAdgZaoiUL15zMnBGLK+/F0Zdr/tdLQGERxnGKu
	HEIGv2hHupFLZiZWksEjsQcpO78XIZuR3+UaJHenuo8LVAfGkTe9Sxs88OZ2LPFfaWwvmIvhJPG
	tt8LmLCUuDPQ9vfibrvKGEA652OTp3ZqKwXFufp3yBpJ9y/kU1G9AX34O+gPfwP5vXMbmyf+ll8
	Erxe1gXXtAd8LEl1ALcZ447ENjR9mD3m90LUZBWVG9TflVf8ACL9IYqlxiytNAKHkApemiTqxpb
	K9omRwgMhLkdYT6CfnlzeG+0ugknbyAjang6aDi8a8=
X-Received: by 2002:a05:620a:2a14:b0:92e:4799:a808 with SMTP id af79cd13be357-92ecf65d81bmr951657285a.40.1783650505239;
        Thu, 09 Jul 2026 19:28:25 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf78a5sm90864485a.31.2026.07.09.19.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:28:24 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Milind Changire <mchangir@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] libceph: validate OSD extent maps before cursor advance
Date: Thu,  9 Jul 2026 22:28:18 -0400
Message-ID: <20260710022818.3737468-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

net/ceph/osd_client.c:osd_sparse_read() validates that the sparse-read
data length matches the summed extent lengths, but it does not validate
that each OSD-supplied extent is monotonic and lies inside the original
request range. A malformed authenticated OSD reply can advertise a
far-forward nonzero extent offset with a matching data length and make
the client advance the message-data cursor beyond the request buffer.
This reaches the BUG_ON(!*length) assertion in ceph_msg_data_next() from
the client receive path.

Impact: A malicious or compromised authenticated Ceph OSD peer can crash
a kernel Ceph client via a malformed sparse-read reply.

Reject sparse extent maps that overflow, move backwards, overlap, or
extend outside the original sparse-read request before advancing the
cursor.

Fixes: f628d7999727 ("libceph: add sparse read support to OSD client")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

I reproduced this with a same-translation-unit KUnit test on
f5459048c38a, x86_64 with panic_on_oops=1. Without the patch, the
malformed extent triggers kernel BUG at net/ceph/messenger.c:1117 after
the benign in-range control passes. With the patch, the malformed map
returns -EREMOTEIO and both KUnit cases pass; net/ceph/osd_client.o
builds cleanly with W=1.
 net/ceph/osd_client.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c1810..76ba3abdad9b1 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -6,6 +6,7 @@
 #include <linux/err.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
+#include <linux/overflow.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -5799,6 +5800,31 @@ static inline void convert_extent_map(struct ceph_sparse_read *sr)
 }
 #endif
 
+static bool sparse_extent_map_valid(struct ceph_sparse_read *sr)
+{
+	u64 req_end, pos;
+	int i;
+
+	if (check_add_overflow(sr->sr_req_off, sr->sr_req_len, &req_end))
+		return false;
+
+	pos = sr->sr_req_off;
+	for (i = 0; i < sr->sr_count; i++) {
+		struct ceph_sparse_extent *ext = &sr->sr_extent[i];
+		u64 end;
+
+		if (ext->off < pos)
+			return false;
+		if (check_add_overflow(ext->off, ext->len, &end))
+			return false;
+		if (end > req_end)
+			return false;
+		pos = end;
+	}
+
+	return true;
+}
+
 static int osd_sparse_read(struct ceph_connection *con,
 			   struct ceph_msg_data_cursor *cursor,
 			   char **pbuf)
@@ -5856,6 +5882,10 @@ static int osd_sparse_read(struct ceph_connection *con,
 	case CEPH_SPARSE_READ_DATA_PRE:
 		/* Convert sr_datalen to host-endian */
 		sr->sr_datalen = le32_to_cpu((__force __le32)sr->sr_datalen);
+		if (!sparse_extent_map_valid(sr)) {
+			pr_warn_ratelimited("invalid sparse extent map\n");
+			return -EREMOTEIO;
+		}
 		for (i = 0; i < count; i++)
 			len += sr->sr_extent[i].len;
 		if (sr->sr_datalen != len) {
