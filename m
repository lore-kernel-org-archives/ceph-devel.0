Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7EC43FD05
	for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843792; cv=none; b=QWgge+aXbpOluQJXyCE9LU4mW867PXiQSUymOKVBR5Ff+KyXYvMdssiUunI5CR99PqlTzV1rXck89K1Bt63ImxhESwR18oU4x2cr+ZeaNzM94cC88I/eGSt6l0iR10AJESFopM56FAdiZo7MhfIa5ArY6T0p1caVYZoEW3FuM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843792; c=relaxed/simple;
	bh=BRVLrK4oRNq3SMWiTqcZYNPP3f0yzzTdczJcufYytXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KYsdadzJT5Io4le7cLtLi35gVJwIPq0X0bHoqYkFeVzR/gKu/aTrXRcQ7v9WJahO55GpCPi9cuwj1W/nZTd4GEuHe2DYT/LgtdllCH7JWAx/buf7+BYlUYy0vD9iPG6sw8cax/CKL9mo4i4z/fAR2gGnymtATV0WIEjsLzJivmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4MmWOQr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HN/PoFBI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4MmWOQr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN/PoFBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787843790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0pC5Yh9p8nfJ0EodjMt6HKJco5XStz+GTjVeg7/fvLE=;
	b=O4MmWOQrQrPoGH3iDli/8gai2oy/oELUFTXqu+Blm5NaJ9S55aiu81/yF9V9JsZPJJWljh
	jN+zKY10KYAQrh9UDaatoYM3IY3UFo/89w+b4Bn1VNJHtEwWSZrqzMeGURJut9Tjs5jr1U
	0v5XDou8o1/WmlFHHUqg7/hCk0JQqWA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-gZNOlMnWPxyGTYE22g25pA-1; Thu, 27 Aug 2026 11:16:27 -0400
X-MC-Unique: gZNOlMnWPxyGTYE22g25pA-1
X-Mimecast-MFC-AGG-ID: gZNOlMnWPxyGTYE22g25pA_1787843785
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c21946c03e5so111507666b.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787843785; x=1788448585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0pC5Yh9p8nfJ0EodjMt6HKJco5XStz+GTjVeg7/fvLE=;
        b=HN/PoFBIs9xeUrQ2bFHQwfNhc+IVaOeVeMOnQ96s/AOIpPERGitvqTgIO3BEpH+5bl
         EzPADuEPr/Il57V2JHeArk/Lou8Fr2DHAJZT1pgNVB7Sp8eAG7i5dKBzF2MKc2bWkvgx
         wi/2KxSNkM1qQZcGQQe1O4bv2jT5oW38chNXfHtXSNZsk5a2CHcbOrMRLHpqmqspEEr1
         MiciMHq4mLeGzIYmH//tTF1r/7U/MB9C0qEgQbxfteU+EvUWUz7BSCqLH1kugbOrdKx8
         TFpEqqgatPUq5XLYBxuKgClxIiX3jztNt2CAL7+acfX9usY7eRcy5c01HNwbo42Vwy+W
         bFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787843785; x=1788448585;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0pC5Yh9p8nfJ0EodjMt6HKJco5XStz+GTjVeg7/fvLE=;
        b=Nsbt4y9GuDF+bK0WIrhBqJK7PZZVrCcP9ZIsaarAbHeNF42+cIGo7oo622HeSRJTp+
         X+5SbJnlasHwDm7tC8QmHf0SmQZliwpK8vGwOS/ONXQaFwm6PI+MOMauCiWnPjEKBqca
         yOCtJARp+lFwKzhfapo1jrhAuVBarPyEs776ymZyapXDnTrWzmLofl7YAqucl6oOR9BV
         sV4D1+LRZK+ekLZpRc4RgNDE6IePG+tpTFrv0y2cOeLAQgiY+YScXRmb+XYmfD0tzN+1
         jSeSnQhd6p7TnUFi1FAbxEXd5TxvvFizHqx4IV46B24VVQtf1adeeqNS4PK4DpaLnkwO
         uSXg==
X-Forwarded-Encrypted: i=1; AHgh+RqtqW7UwEArZ5dugN4F3uPdAjARq8pJuNHzxkLlg2RLNWbOsPzT7IfG45vhnpVCCZreqpemmSx4yakB@vger.kernel.org
X-Gm-Message-State: AFuF++lg/Xzz5D38HLTywPBmtTOJxgOkq7pD507DCdy0lhX0gFaauR1+
	8adw+GnR7PT6KduP1lL1FW8eEtnXfOxMQ1BZikb6ek8PvhIIxB3LT2V2jpCB4YjHbwvq87Mk7Pp
	Qv/WbVxUg3wj4+jlgy2yMJr0m2nMEv0IAI1oqo0Vv/9/jsla+RUrClGGhpVHtK3Y=
X-Gm-Gg: AR+sD12RHXdduzxiJLuOiglYf9eDyBw5wRn+WOpuIsDpzcCXwIiqt2e8XuGAS7Xcqp+
	23xCHKVUjL0HIGEbKkjjnoxB3pFqMnO9PGzgxN0w9Pe0iahnSJZodMilrqLZwXZ8piYaCTWj1O7
	hWnHqWeLajt7QQ55cs3QxXACTBvDehvjDnqg3mQMPd3Fxq0b656xKiDiWlWJG8ICys3Eqs6/o88
	99GdYkO2pwbi910lQLugmkhaye09Xbfm15ARTIfoHgLaG949j3JhlU5zhrBQcyMNyeLCuTksz2Q
	rfWnFPaD7XvyhCHvyeofjkjR/Y4GyALAA8uUuLF8Kh7Czhm2JykcGdJAOcTwFVVNa8XW0mSztJL
	FFw83DINRDWCLwnYkgCoqSNCmtKcSeCmwAQ==
X-Received: by 2002:a17:906:f5a2:b0:c25:4a19:45c3 with SMTP id a640c23a62f3a-c254a194808mr230595366b.8.1787843784821;
        Thu, 27 Aug 2026 08:16:24 -0700 (PDT)
X-Received: by 2002:a17:906:f5a2:b0:c25:4a19:45c3 with SMTP id a640c23a62f3a-c254a194808mr230592166b.8.1787843784422;
        Thu, 27 Aug 2026 08:16:24 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c253b0684a1sm139666666b.25.2026.08.27.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:16:23 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Xiubo Li <xiubo.li@clyso.com>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ceph: apply nearfull_sync on remount
Date: Thu, 27 Aug 2026 15:16:21 +0000
Message-Id: <20260827151621.2758276-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ceph_parse_mount_param() stores nearfull_sync / nonearfull_sync on the
temporary fs_context options, but ceph_reconfigure_fc() never copied
CEPH_MOUNT_OPT_NEARFULL_SYNC onto the live mount. Remount therefore
succeeded while writes and /proc/mounts kept the original-mount flag.

Apply the flag the same way as ASYNC_DIROPS and SPARSEREAD so remount
can enable or disable NEARFULL IOCB_DSYNC promotion.

Fixes: c7a12c20bfba ("ceph: make nearfull sync writes opt-in")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 6c6e9a1100db..d8ae49495c39 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1423,6 +1423,11 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
 	else
 		ceph_clear_mount_opt(fsc, SPARSEREAD);
 
+	if (fsopt->flags & CEPH_MOUNT_OPT_NEARFULL_SYNC)
+		ceph_set_mount_opt(fsc, NEARFULL_SYNC);
+	else
+		ceph_clear_mount_opt(fsc, NEARFULL_SYNC);
+
 	if (strcmp_null(fsc->mount_options->mon_addr, fsopt->mon_addr)) {
 		kfree(fsc->mount_options->mon_addr);
 		fsc->mount_options->mon_addr = fsopt->mon_addr;
-- 
2.34.1

