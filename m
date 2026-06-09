Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA553603DB
	for <ceph-devel@vger.kernel.org>; Tue,  9 Jun 2026 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980016; cv=none; b=Z7rjIVjbpRdj7g6DkiM+qL0oBGwQgbAwoMn4XMBPGfMi52syjvXdVt5MSPzMypWsgTIkRVSqjZRO2LLjV0ib5p+EQTfqEbjo6Pk8C9ULnDK517hjabv4cxbH8aSPK/7+Jk/Ez7DVrfNT3HPiVI7YtjT2ejK0Jhk43pe1Bbwn/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980016; c=relaxed/simple;
	bh=v1L85JVUNg5IR12uBIHjM5OXAx5nj5m1S7h8F7FrTxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJFR1Iv/o7vL82tU2l/r1Iy14qBeWavW86HOfzbUQ+dzs0eGqcm4k7NyPw0GHRiEtiIwRiwIBw5EI4/sc+/Lqm3SkB9u6QNzPDwYYiBTQkO1jVhY6HoqRhWlG5hRYQ3hoJmF8zcsjHbg5KpdJhaK+C112qp3ajZju2sG7vzaAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=fYH2a09Z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="fYH2a09Z"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso34494575ad.1
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jun 2026 21:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780980014; x=1781584814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oBP7IA6XPRdR1x7ewjFsCs6JWy40OnP7nxYhaTRcWPA=;
        b=fYH2a09ZCBgLS6P/9ByKj/z41LjCsgZNCaKELR3/iy8YRRzYuT5NeTgpQ//ddwoNUU
         th9sZcma4dD/DhontVaatodn5S1moHYjWqhy+JGWjOYT0shk9VwcmONvXGrU4NZYK2g0
         YeRpn0GcAGUDmdGxJTy816jFdPXcc3nZ6PhoHY+Mam2QhwRNTlOF/89dC5Ezc4KfwwFb
         w/GBA5CHaILbNosxaKeIDmapWHg7/YOY/dYLLxjosn9Cy0T1jCrz4a5E5LG12U9O2WZs
         s1evCIhSbxOlplBeDjPK3g6z5CEFEi/E+5yEsqdOYRbHsrGo2UrlJvPU7HgOxNaSFeEm
         1AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980014; x=1781584814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBP7IA6XPRdR1x7ewjFsCs6JWy40OnP7nxYhaTRcWPA=;
        b=FLDx3LsmbWNjMx7brOZ9xlhR45tSxdkBuLc6qLAVqTc4025KbMdk3zfMsH4QnPQo0F
         9glnUfrHshmUysOhaBDY9djwnO/UyBYE8IHi0FltXCWFP8F3XAUbzur/UI/s2OPBS0ld
         VMMp9YocsZGIR7v104XWw5ex9SMKS1A7OwuPJjfEr6RSLwf3M1uj3LaM4fT4Iuk3ufTK
         XOo6p/FifgditwSqz3mkScb3vC+4HZ6/9QzJ6eIrSgB4j+BQuEHoCg8uez8DJJPqMK9i
         j3acgG96HsGXQtGaS99Y3xvEHxIxvPW+gDQSaaSd2P+yPRWe+dyxCgWNooEM9+GNqVB+
         utCA==
X-Gm-Message-State: AOJu0YzLU7y4s8sPdid+805p942UtXXzosmIoTSHzfZ1T7zYmfc4EaQd
	r9RsmKhfAyMwYTdfZOoqpCOl4oa037N+iDs9MOSeWW8EBDxmO4HN5DGYQxls7/W25UooatqAHq9
	OH/kJ4RKv
X-Gm-Gg: Acq92OGpb2hnxiGi89sLhhxkIXIDZsBUiJ0bo0zr790tO4nEjhLtDYNaAUg5zd+5RLE
	SFkTrhpuvaWS1PQCKj04uegCkWEu8Di/lISBPhlhpYX38molAf1f+tYTGmQ3pgAGCJx6qFglo2d
	IXhd/nNC26gnOJxSpZg+XfM4mAndt891MpvjU/khX3/z0OxI2+FcAs/pSRRJxXfuaOZMdGJnKRz
	WlndZ1125mx33uXZemJcnmh9IpKMBH5SS4Ok7X48IEimKlupC8gSKpCD/UahLxOp/XyKVA6gdhp
	xGCu0eB6cpjS7yAp5jZUIeadxk6Irg6FDFyFErXvNkZXJQWpL51S4sxACDLGvvHu1UKdGNNOU4h
	8g++pRQqqGdANqyTD3sSjPKvYWiXxcK1xXOfedC5Y+xpEs3SNtvBy2YD56t/2x3EgZ1lr9+xYbP
	L5hXCKe6pKJekJHik=
X-Received: by 2002:a17:903:3888:b0:2be:3850:297e with SMTP id d9443c01a7336-2c1e80ee003mr228103375ad.31.1780980014402;
        Mon, 08 Jun 2026 21:40:14 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e2adsm207799465ad.5.2026.06.08.21.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:40:14 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Weiming Shi <bestswngs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] libceph: bound pg_temp/pg_upmap osd list length to CEPH_PG_MAX_SIZE
Date: Mon,  8 Jun 2026 21:40:09 -0700
Message-ID: <20260609044009.2564543-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__decode_pg_temp() decodes an user-controlled length but only rejects
values large enough to overflow the allocation; it does not bound it to
CEPH_PG_MAX_SIZE. The helper backs both pg_temp and pg_upmap decoding, and
apply_upmap()/get_temp_osds() later copy the decoded list into the fixed-size
on-stack array struct ceph_osds.osds[CEPH_PG_MAX_SIZE]. A monitor that sends
an OSDMap with a pg_temp/pg_upmap entry longer than 32 thus causes a stack
out-of-bounds write.

An OSD set for a single PG can never exceed CEPH_PG_MAX_SIZE, so reject longer
entries at decode time. The bound is well below the old overflow threshold, so
it also covers the allocation-size overflow the previous check guarded against.

  BUG: KASAN: stack-out-of-bounds in ceph_pg_to_up_acting_osds
  Write of size 4 ... by task exploit
   kasan_report (mm/kasan/report.c:595)
   ceph_pg_to_up_acting_osds (net/ceph/osdmap.c:2617 net/ceph/osdmap.c:2833)
   calc_target (net/ceph/osd_client.c:1638)
   __submit_request (net/ceph/osd_client.c:2394)
   ceph_osdc_start_request (net/ceph/osd_client.c:2490)
   ceph_osdc_call (net/ceph/osd_client.c:5164)
   rbd_dev_image_probe (drivers/block/rbd.c:6899)
   do_rbd_add (drivers/block/rbd.c:7138)
   ...
  kernel BUG at net/ceph/osdmap.c:2670!

Fixes: a303bb0e5834 ("libceph: introduce and switch to decode_pg_mapping()")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8b5b0587a0cf..e35d8abe1773 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1436,7 +1436,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len == 0 && incremental)
 		return NULL;	/* new_pg_temp: [] to remove */
-	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
-- 
2.43.0

