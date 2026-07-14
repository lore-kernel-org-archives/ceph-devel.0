Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7E38D419
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029909; cv=none; b=oxtTVHpJLgNSy/Sbu+N8noy3cz5etOiXna7y1MFYtfZzHMHF/xXZuoSiO08nGnp4aLm5NAUzgz/U+5cjs6S198/JEIdYRHGMRF/smulCme/mCVml0V/61ggwku+fZXs2+cctEAALucXffHDLeBFPWOf5G+ZDXdDlc8LJsYNw+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029909; c=relaxed/simple;
	bh=JpnDZ8ql3IabuVoCGMVqUfzzVcIrlI9D12dRWum7fzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE+rDrjBdSvy424BJJEqaEo862Rhpt3dbc2LXml5YDM8Bc+PPHWErdPwk8o+ZSn3PwM3wEjeq+gvDkQXmI6/xZEATWrpaCh8O1zd5TXgSmHTjek/7m/6KxVEYecCHGhuNqq86mjoO/gWmwhFL0L88V0cxufGiXl91+uq5i661Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRVhmLQX; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRVhmLQX"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e57a753f9so320844685a.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029906; x=1784634706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9p/+/UmywR6wfRNM0SB+tDIf7SPmlvrUuoPqzMH3Bt8=;
        b=CRVhmLQXuYhcFRtawFDba1mWcn4TLI7Fvbe9G0vaiskeR7OGKsIbUehmcqtEQgN4lc
         xs6aKQQ7ivcDrDSwcR/OyRfAkJvdmBLGPftqJ+NwhhWfRyzHWGDNCfLaUFHCU8cj3Q/l
         cscvRFLY0Tl3/T1y/huqIlDBtp/HI39b9retGyyQHhYB7tXUdx4XiOHvhs0KqcXuO8CP
         P6IlLNR/dPVkVFYtIRGOHbdug6FtMmdL1vEprxRMktiJT6D0lCRygE11p7LrwU3kVYRU
         WIn28rmJAqZCFsxc6PYI7XMtrbOYwTTGn6IOAP5kxIu8FWEUujEi8tDgMUK73jSWcWD4
         OxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029906; x=1784634706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9p/+/UmywR6wfRNM0SB+tDIf7SPmlvrUuoPqzMH3Bt8=;
        b=HagQHP1Qw9kRjuqGe8NcEFTpa8d3O7IITbejNRicZFMcmiQxc2VZMER6eJm4riO/kA
         4Hs5261eAbAice0sejVw4NwOw0uAJ2A6GzST0fkbYxDkvLZkts005End8HKCmG8mh7T0
         HVfe5LB7HEPVSuNG1CJ7zfRDN2Oqui9x7zBOSMHMW1zvQF9M2QMbAN0halXUaH3duoF/
         2CuMRHFHp03iw5AqnOnNcHm9suUSfUNJ9xK8oq2yQ6XwaofGcjDHz5kxBZIz5NftoAJY
         Qh7axb2gqYxZtWDxiwnt+rfQuYFxXWOtl2z9MWXVThwHfrsedhlnKHSxBEFBbVf0vPfl
         Bduw==
X-Forwarded-Encrypted: i=1; AHgh+RrcahttNoVfHZBaRyIcMe8V1UHJPC3pWtfaxMwgh2OQy9OLZ+ySBJoFsBDEAEDUHiRR9hNefYgDTUrG@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOY9maK6Ug9qYF2DOojPSlzOWfpVCZExf/h1UQc8R0JsGFtiK
	PrrKTyvJ7S+7MbQsWgx/UxQ5IotlgL0U49aF9ANYsywuyj+obcOSYcEu
X-Gm-Gg: AfdE7clj08mXCMZvX4xUy5/PtbrVzMvOjFmOhw5z2xnpCID3W6JfDZ0QqFTHzUvOyHn
	QX6AyxoOIv2yC/mKFeOycCbbM/NhrxgSPhI0Z2UrFmWYdXZ4fl+JcftmivpXebqO3NcjBrZxAq0
	21qnGaqia9slh1y5tsLuaxYMAK/4GtoAqr1OfSOpAcR+BvOBRGgVCx3AQ7EgxYfNKKnxVbuaDe8
	LEVVHMQvzMdlGNQ1HMhK84t3/Zw0gswgQvYhAf63qJDPc82oKE8/IUPpDqQUjU467hrSF1cymHI
	xLPMlExZWc5e4xLIo9Q51YeCNrnS3dFLOCMzMj6kUKcGaEKP/fqKS/IbNsF6QsDEx3TYIR9HqOw
	nG+ABSvuzIvmMzg4ywLF3zVvqg98yFJih4jNFXsEdPXvsLXeoohrvx4gxOAwR8ZQefc6KFbWopN
	+POGXtqHDF6ZqEezlPlDgUtpxc4EWiMYGsXf6q4yQj29zN1EHIAq9m6VCPZrJLjbCIaYPGWV6CD
	yh5xyanlw==
X-Received: by 2002:a05:620a:2790:b0:92e:c117:9eae with SMTP id af79cd13be357-92ef2e57c99mr1073038685a.92.1784029905785;
        Tue, 14 Jul 2026 04:51:45 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6c28bsm1479415585a.46.2026.07.14.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:51:45 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] libceph: validate OSD extent maps before cursor advance
Date: Tue, 14 Jul 2026 07:51:39 -0400
Message-ID: <20260714115141.3768034-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714115141.3768034-1-michael.bommarito@gmail.com>
References: <20260714115141.3768034-1-michael.bommarito@gmail.com>
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
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
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
-- 
2.53.0

