Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612E31F9B4
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447572; cv=none; b=JRGKygGzJRYu3DxeTGay+dIiW3rt+T5KV2FPzF0GpdbrnUkbOKEzc+ohEl6bbV+sZ9WwDG6KnB8FFuNRgCYqFeXg710P8qpkrOgdH2gq4jWuOyRiqgqM7bY2iIRANjEj5FyvTLQJ536M6A7VE8rBZlDPqgiF8ReAkm0h03UZesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447572; c=relaxed/simple;
	bh=NWTLOshyXHMRH/Dncw7yrLlSn+VlqS7kcEkHLHotwpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKcmpbEc5Wnu1So7JeDzee5Pf1GOmf8V7sDQ6RDC3V/TmPuCt/q5mLKuQlNEX0oK6occauMwIPToxs4a7WlqpllCb6v5WzbEs9S2YCD3puNeX4Y+grKhXAgSwdovJF6O0qdmh3m2MTLn5UUyDmTZLAwhLWzSm738u4P4/gpFEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg/g1DJq; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg/g1DJq"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8e5be46f663so29116076d6.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783447570; x=1784052370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wUirQAAjAeaROJy7goki5PouYfU7+UV7BzjTDszmjJc=;
        b=Gg/g1DJqqMB7LKpEPbWaNxkI27h7SDtVxC+zrqiuDEk2lMaZBTkehl7k1OrM1VwlMV
         Eyb7wxoyv2rrYNekutOcLsO0VSbxwsgQGwEh2/DJ+P5NbfoP22gfkqSY9PV0S9oM+BC7
         LUT1g5TTatZ5MKGFXe8CJVup0y4vwQ9J6MoYrapUTWSR2MAQ4Cg6t9ZPo+4f1EY9zlKv
         HR2GydS7T28t1KK7RE4O4GX2b8UjfZtFqadcV2wHUDnIwNOQR7IfO7BBoeTfdVAx9ND4
         P8YtI6jTln5lz18jXPc23SsUF0axG+OVc19Ranl28WKaHDuoRu3ldaoDXWNnqZ9m7zLu
         2Q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783447570; x=1784052370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wUirQAAjAeaROJy7goki5PouYfU7+UV7BzjTDszmjJc=;
        b=m4YJhww6f2ZKsmc8icr2l4RtmD0973VzfpOet7J6oBHPX+8txeAOMeZ9bRwULVFlim
         8kxb/VUFEabU2o5ps4rRSh7aftJh+ybf7Z255X0AoJ84NM5g6QpJiaJv+w2pgvt9+f9y
         4CJ0vo4IUm3rE622n42Kqid9+KQ7l+Y8r2R5tgkY0v/hbaEqz7ybyYG1BcqcoZynwyKe
         DVnsrG/97EyxhtEIDWtrrE0nEnesV4EsWcybdyyEFMkgx8kDMV8G+lL5PmokltHHrSyX
         Dnq0ZvCkZYw7k1/4RHomkfcuga4APgLHnfmZqsA6bFLF82UNPTtL4EG2oo2HHa/vKd1m
         QnKQ==
X-Gm-Message-State: AOJu0YwE4so4BRHAeWaQbBPW2ns68oatUmrAaj1M7/IRTYf6GS7YsvRr
	WnbhJjxLB65IqmrDu73haZg8lKm31EMo5af/1cpiW+3Doy6QPD2i/6ST
X-Gm-Gg: AfdE7ck0R5AeT8E02wNWic3DtcC8IcoK8GCHqRdYxZZv3P0Z3nyA2qqIcqnlta7mFrG
	7h0Px01dbNxA/+uMv21LYEPFz1csygLdCaofks5B6VrRVn75u/iJvuPZoN2V9T1ZjB9m7PFlPI5
	psKCY6Fr8llG6llGdC6xDyZkX6xWPHQ0fISvFL4DudNjdIma77KusKyw7VU4I4RSb68GIm/HbQ7
	HAEMnd7LXoRSo/ivPmFKCSUmXC785kzcD6dxxCEkbNVskgJyWmsl7Dd0LN7PyIwCyuED/YDvY8s
	/9KnAyFIqTVDOsOiingIx/DPg5ORbXXuZLMiSSIu8siQHLFhqK+pbcGF5qhq+NSUp60fgBzfUPK
	d5V0tYP46qNT71vVpvL0GyNfnHwMeIYStHPZxY7h9xA+gK7ujkOWXanNUkAP8DdN+4RLcq8MKvW
	Tserk9S246bbmzvPpsM+P+G+eLYnqr9TOMD2dcV3UqR5cxjIqvBDHHrqwnrMYu3vYzKLLTbqPge
	pmjgs4NsW4HNrn3qTxSUfwaPAI72H05c0WdqttmpuU=
X-Received: by 2002:ad4:5c4d:0:b0:8ef:a4d5:1523 with SMTP id 6a1803df08f44-8fcb54d30damr80070956d6.42.1783447570376;
        Tue, 07 Jul 2026 11:06:10 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de87e3sm166404376d6.35.2026.07.07.11.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:06:09 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] ceph: bound untrusted MDS and monitor reply decoders
Date: Tue,  7 Jul 2026 14:05:56 -0400
Message-ID: <cover.1783447231.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is v3 of the CephFS decoder-bound series. The four bugs are
independent; each bounds an untrusted length or count that a malicious or
compromised MDS or monitor controls on the wire.

  1/4 rejects a final xattr value length that runs past the xattr blob.
  2/4 bounds MDSCapAuth path and fs_name copies in handle_session().
  3/4 bounds the mdsmap export_targets array for info_v 2/3.
  4/4 caps delegated-inode parsing by per-session population and by one
      reply's aggregate interval length.

Patches 1/4 and 2/4 carry Viacheslav Dubeyko's Reviewed-by from v1. Patch
3/4 carries his Reviewed-by from v2. Patch 4/4 is reworked to address his
v2 review, described below.

Changes in v3:

  - Rebased onto ceph/testing (base-commit fc67edb66b3c9 below); v2 no
    longer applied there. The series applies cleanly with git am on that
    base. Patches 1-3 are unchanged apart from the rebase.

  - Patch 4/4 reworked per review of v2:

    - The per-session count is now enforced in a single place,
      ceph_insert_deleg_ino(), using atomic_add_unless() rather than an
      increment-then-decrement pattern. Since that helper is the only
      caller that grows the count, the per-session population can never
      exceed CEPH_MAX_DELEG_INOS, so the separate per-session pre-check in
      the decode loop is dropped.

    - The per-reply aggregate check is kept. It is the bound that stops one
      reply from spinning the insert loop on duplicate ranges without
      growing the per-session count, which the per-insert cap alone does
      not catch.

    - CEPH_MAX_DELEG_INOS is cast to u64 where it is compared against and
      subtracted from the u64 interval length.

    - The redundant warning in the decode loop is removed;
      ceph_insert_deleg_ino() already logs when the cap is reached, and the
      warnings now report the counts involved.

Michael Bommarito (4):
  ceph: bound xattr value length in __build_xattrs()
  ceph: bound MDSCapAuth path and fs_name decode in handle_session()
  ceph: bound num_export_targets array for mds info v2/v3
  ceph: cap delegated inode count in ceph_parse_deleg_inos()

 fs/ceph/mds_client.c | 67 ++++++++++++++++++++++++++++++++++++++------
 fs/ceph/mds_client.h |  1 +
 fs/ceph/mdsmap.c     |  7 ++++-
 fs/ceph/super.h      |  9 ++++++
 fs/ceph/xattr.c      |  1 +
 5 files changed, 76 insertions(+), 9 deletions(-)


base-commit: fc67edb66b3c9924c4e0bb366a92b32ea13c526a
--
2.53.0

