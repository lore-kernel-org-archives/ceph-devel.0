Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D84317D
	for <ceph-devel@vger.kernel.org>; Sun, 15 Mar 2026 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773617118; cv=none; b=SgatJJsj25282LqCwfGQqg26xrippZo5GMun8NNf+JyZbP1AI5I2H3et64lj6IFlPICGh+CFp0wjIqEloaak6oMFGiFwmmd5ihN6YE5vgeV0ek8wzW5pj4CV9WUFX5tap/qkPcM+3DKP76buT8HxLdZNMQmrseax00lhlvawdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773617118; c=relaxed/simple;
	bh=jAMfolcZSWXlBmUQWetpINLpy01Bq3OSZvhc2R2/9CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbrGYjdAYxeFyvcmfWXrAX1SNnw3jIls/Q3ZsdBUGE7isa+bSUKJDx3sTw8D9wB8AyK+DpY+NGFbZl5piMY2nP+zA6yC4BvzcCylAnOs6UyvaMknnsEw+QGbXP8H+DhsZOI+JtNZpkvH8/JAxOEKer+5KAQGa1rF9EWi2Wy/lw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duygOQXM; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duygOQXM"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so1602290eec.1
        for <ceph-devel@vger.kernel.org>; Sun, 15 Mar 2026 16:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773617117; x=1774221917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AeJ4mquJYADCwtgoxMoMXaszduThytc8keaBhAGxhiY=;
        b=duygOQXMHtlmZSAaZsJLarnH+A5ocoOLHLvMDcw6N/W4KI5tI9F0RFLDW+WhzuXOLG
         PJSXfjUyGWxBK3L12rkxfH/2aCWI3Xt+FnBbydO0TlvcTrxu8J/2tPe1QrQkoXnvKyRY
         hfpilROOY1Q10wLt6xLWdx8oU0Om3HBmmxQPVSumkVmvIfcrSKMAtO02YkmBzzIlLlN8
         ZWgjnVfNqzsOTtOiJzi7QCaZnXUuiTWvsld7F33rNMEWZLyByj2EibnKUkW5Gkddbfat
         ZTXQ0pb4Qvykmh7dw9YbCTYE+XofFqlNVwMZs4jl9otH9L1hr84Ke8cSQXR4/911Y/Bh
         ZQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773617117; x=1774221917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeJ4mquJYADCwtgoxMoMXaszduThytc8keaBhAGxhiY=;
        b=PpiswH+I7EyRMdnU3ty+V+NxS+ueu1s0AxKzi1Pybtt8vaB2xFQHwevU7wskvEluEv
         xK/rV52ebQt3K4DC8sD18p4/b7I+hao3glz27l7x5rQkaBTE0SzLS9oM+bNk7RIzdBW0
         ASfnJUclyYZxdOKaYa1yPNlvTYHd3XZUvkEflgJcb+NUzb6EOKdh6KmHNgA4bxXSu2Mi
         8NyLbZFwnWSrUWFX8aIr/cA7hj1+VRrQqYQiE90XSYJmAfHmsKd+lp87lLXGBc4+V8Du
         9lFstsUywXfDx3lECwWT5uTptleu2TqmtcgZFJqHWcrZDQ0bg1i3Nb0eO1ovcWz5zBlu
         5+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUYtWZOd9dKN2izGWp5K2YX5t5419bzZpjF+lq0sbsvC1azX5+imW3Qfl6JfBtBFy/W0B/enRSW8OOv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh+co6tiEv1BaZU8meWPkusC6DF9uHZwXfsXbTyqqAwQ+TZ5xT
	i08u8cAmeZbGrFZIX8Hzih0Z3bXZlwgfwmzCGT+byN/z5GGUUrIbdw7p
X-Gm-Gg: ATEYQzwVR+jW0mBed0LJoNnHu89pjIZvbmJaHxoCLMyE0EMb3nzxv6j4LJ+UOv65Hlz
	gPCVFDrJytwT5D7pw7eBWNqUp7Cc24qhiATyOoqtOmsNSZ5XBDj6SfJ5ZShLDz6dt/vh6BgXUgr
	zd80lfzzdGApw1XegJp3c+rMEa+y3bxVyKysVKnJ0+RO+gcjpcBQh+quZ9PPeVcxTKQJoU44fqU
	TIbmyk1HbxGYZNdChS+eM8tgO2TuF5fyfgMkyd1b8YFKfwb6v+C8OdTRh3lh3N+96PXfBlIJEFU
	7JlmDitDfgp+2zdy7YpY0Viz+gtPYOjBVklxYql4Qi2i8QRD7eTkT1JfTf9RBXA3ANUNqjHJZJB
	RCgfv9QOHIgTHbpBFGZpQf7qus0g1xttp+OhJNNZt9uRJ1qiw1HN6/KHMrPxDLLq12mg6TyzXPU
	qbaEXJNOFbCDcc+tlFWYKAWhFMxIHkq1DtS6Ac3JrUrZkV6wRjecgWIuAAXfVFfppp
X-Received: by 2002:a05:7300:2319:b0:2ba:8e16:260e with SMTP id 5a478bee46e88-2bea5473d9bmr5229217eec.11.1773617116756;
        Sun, 15 Mar 2026 16:25:16 -0700 (PDT)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a0b3fsm12531375eec.5.2026.03.15.16.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 16:25:16 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Milind Changire <mchangir@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [REGRESSION] [PATCH] ceph: fix num_ops OBOE when crypto allocation fails
Date: Sun, 15 Mar 2026 16:25:00 -0700
Message-ID: <20260315232500.251088-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move_dirty_folio_in_page_array() may fail if the file is encrypted, the
dirty folio is not the first in the batch, and it fails to allocate a
bounce buffer to hold the ciphertext. When that happens,
ceph_process_folio_batch() simply redirties the folio and flushes the
current batch -- it can retry that folio in a future batch.

However, if this failed folio is not contiguous with the last folio that
did make it into the batch, then ceph_process_folio_batch() has already
incremented `ceph_wbc->num_ops`; because it doesn't follow through and
add the discontiguous folio to the array, ceph_submit_write() -- which
expects that `ceph_wbc->num_ops` accurately reflects the number of
contiguous ranges (and therefore the required number of "write extent"
ops) in the writeback -- will panic the kernel:

    BUG_ON(ceph_wbc->op_idx + 1 != req->r_num_ops);

Fix this crash by decrementing `ceph_wbc->num_ops` back to the correct
value when move_dirty_folio_in_page_array() fails, but the folio already
started counting a new (i.e. still-empty) extent.

The defect corrected by this patch has existed since 2022 (see first
`Fixes:`), but another bug blocked multi-folio encrypted writeback until
recently (see second `Fixes:`). The second commit made it into 6.18.16,
6.19.6, and 7.0-rc1, unmasking the panic in those versions. This patch
therefore fixes a regression (panic) introduced by cac190c7674f.

Cc: stable@vger.kernel.org # v6.18+
Fixes: d55207717ded ("ceph: add encryption support to writepage and writepages")
Fixes: cac190c7674f ("ceph: fix write storm on fscrypted files")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e87b3bb94ee8..f366e159ffa6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1366,6 +1366,10 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
+			/* Did we just begin a new contiguous op? Nevermind! */
+			if (ceph_wbc->len == 0)
+				ceph_wbc->num_ops--;
+
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
 			break;
-- 
2.52.0

