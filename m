Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF83A963D
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348731; cv=none; b=fIXZj1mwAboK6SKmlD94huYyrs26mFfGV92ZQfisJq7fDPV1tkcNxYcVx9cYPs274UyVkznm14208JVv52be2FBBiijK+bhV0HY57ojx+ngsJHwso+uYCaMhXnYzx4wF+e4L3nwvASNlqdGxfqjOhsn3os8Q8Vn/H4CakNhx60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348731; c=relaxed/simple;
	bh=VXHCdG/SfipBhU/H1Gd+PlHxRz29AoHtoJOCjqeAXCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nGbft9FVFQW1sCfgvL3+8vb9EbIYay7DnqBNYQ3jMKfmkbQzH4PNnP+5dCgb7iQ8lrWHtEr3j50IBlMJKFcs6mKnQiVb5Y3wIfpZix34hHuD78MnHcnOjgmgMgfVCoS3aVQYXI9/71lkiMPjRp6Fmdji5ymQEYKurKiA8KsJ3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz9phKn1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uDigNlbO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz9phKn1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uDigNlbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jCuQsGfuM94zuuSDRBMZ7xlSsMRAqQde2jYi0A9wYqk=;
	b=Dz9phKn1XsgXFOJCSKKgTp/6xWMo2FRrgxY65ZqYW4EjZ/CgVJWtiWGMfNdWVFUIIBr4sF
	Pc7fG9nKygB2gB2e2TTtJ+PGBTLtqD4fpC0FePA90A/55RMU/Ld3p9YrRxG4vswju5DBOK
	bI6/SF9xSzb4+qvS01kqy69XwjaKoe4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-fc_gT0DDMEiLOBHRghAdcw-1; Mon, 06 Jul 2026 10:38:47 -0400
X-MC-Unique: fc_gT0DDMEiLOBHRghAdcw-1
X-Mimecast-MFC-AGG-ID: fc_gT0DDMEiLOBHRghAdcw_1783348726
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c12dd729b4fso221707966b.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348726; x=1783953526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCuQsGfuM94zuuSDRBMZ7xlSsMRAqQde2jYi0A9wYqk=;
        b=uDigNlbOADW9voivl3HSqkSJwxEWKaKEyaafD3QN2bmJItFyWcX6xqjLSgjAzIURlI
         jGiXzEYM+kwVnoasMc1UCuyo44DO8fUc3XanmdfjUN49qBaocmRCo13IccWbHLwWMnOK
         5il/TeSy5U+4HP6h0aK5Zso4s9UwMJpdm/DYS7BcdjUmyWFptior8rp52/eFk/svu7jR
         5i11Hu/lJraFU1RUATPrnB8eEXvQrD3wyuziPIHg+iBL3w9j4iVrCFrsE/lcjqBmnRlU
         Ou4TH8XIwRzEfyRyuwOCMYY2TxgLPjLcVJmXhZaR6rm5WLYWiVjWLI/bAzmeyuMsaNvM
         57VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348726; x=1783953526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCuQsGfuM94zuuSDRBMZ7xlSsMRAqQde2jYi0A9wYqk=;
        b=oS6E9p1aSkb0lpV2ey/G04CeMvrQEMBH2z51fK0DRdyr1LfYXe6SLGX1kFlK/FQuU/
         iHoNpoC3O1RGpmXSWaSHd7VpwRQZimpQD2V3XwgKVyt1M//VK4yKzYhXRuAJq/IlpNh6
         wK1yE0EeUyGI5Zvcdf90q/mc81+S1JW3DwXoOutSYa3FQKuJ6bvMFD8qBA+gQLlQ8VFP
         KS8OhLYa2nsbKgJhxIv4BlzQjhF9cWZa+h/VwBuP2TXe3FvbuNj+VjmKmY9PVDAiEwC0
         PFZ/pWRCAXVat/JJnQIK4Bkn4y+eet/5A3ewd2R1LIQB8CzMSU2R/EhEAf5w08eAzbdD
         MXpQ==
X-Gm-Message-State: AOJu0YyZOX00UyQBqx3p1f5r7if/JQkPG4Iaat2b3UBvoO/6kPu/nr/z
	MCfZ1YRgEFzL3JQddMi/wfLqGyIV3eakHRoGVo2OFjx2RZ0x+Sc0tMIHOmLiKWlo4aBvf1OLnFT
	BXg5z655YUWfdH/FJCUuHzYYyb/Cl+/Sk+pnyLfkTYI1yaymKYm11YoysDjg2hxEShVANEncKzD
	ET7n3baXZU6kcvs+DV9itTT7LKJTfcoqorliZ5NzYfAealQKjmMg==
X-Gm-Gg: AfdE7cnqsoYXaHxF8lkXd1MHnhukiDWBw6r74GTINvsFjWqRSWnwwl+rbYu49yiyhGc
	es7VFMz0BYYfdgvkqmQa4fbOItPbae+sPGL53die8OoL9N9j0rLNGtuHoeyEuuAj8CT0cridD+G
	0WrbO3s2jdTKxp564xeTuedLBaV+VZ5qrkhcAOPXTXwZGFC/kch+OBi+0bCAtdtUz4r5ukqqeAO
	iz+wH1K39YnA8DIIBLuDFxIyadnZ+M+zPY6JlZSdhxnhzpGlsRFEy4lXVeHzhMNAcoBnlcUw+Hd
	B1skOAS58U1CyOqOlYmW1P+6oS/5uNMLuGbx+u9/Yx8qw81xmwSjzYCOY5X1783iHZT/94/37dq
	hKwmBAaCchcZxYcKcW6Y6QeNmE1yclZryOElhzNqYeUmh
X-Received: by 2002:a17:906:6296:b0:c12:7d53:cc88 with SMTP id a640c23a62f3a-c15a69a0053mr56160066b.58.1783348726026;
        Mon, 06 Jul 2026 07:38:46 -0700 (PDT)
X-Received: by 2002:a17:906:6296:b0:c12:7d53:cc88 with SMTP id a640c23a62f3a-c15a69a0053mr56157566b.58.1783348725355;
        Mon, 06 Jul 2026 07:38:45 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054b99sm777268566b.8.2026.07.06.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:45 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com,
	jlayton@kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 00/15] ceph: add binary logging (BLOG) for CephFS
Date: Mon,  6 Jul 2026 14:38:28 +0000
Message-Id: <20260706143843.1980879-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a lightweight binary logging subsystem for CephFS that replaces the
existing dout/doutc text-based debug logging with a binary-serialized
format.  Log entries are stored in per-task 128KB page-fragment buffers
and exposed through debugfs for offline analysis.

Changes since v1 (based on review from Xiubo Li, thanks):
  - 01/15: populate public headers with struct definitions and API
    declarations; v1 shipped them as empty 0-byte files making the
    series unbuildable at every commit boundary
  - 02/15: blog_des.c: pr_err → pr_err_ratelimited (debugfs read path
    is user-triggerable), -EFAULT → -EBADMSG for bad serialized data,
    fix snprintf truncation off-by-one when ret >= remaining, extract
    des_advance() helper to deduplicate the snprintf+advance pattern
  - 07/15: linux/sched.h now included via the populated blog.h header
    chain, fixing the implicit dependency on `current`
  - 10/15: remove unnecessary IS_ENABLED(CONFIG_CEPH_FS) guards around
    ceph_blog_debugfs_init/cleanup in debugfs.c — this is CephFS-only
    code where CONFIG_CEPH_FS is always true

Alex Markuze (15):
  ceph: add BLOG public headers
  ceph: add BLOG deserialization support
  ceph: add BLOG page-fragment allocator
  ceph: add BLOG magazine batch allocator
  ceph: add BLOG logger core
  ceph: add BLOG per-module context management
  ceph: add Ceph BLOG scaffolding
  ceph: add bout and boutc wrappers for BLOG
  ceph: switch MDS request plumbing to struct ceph_journal_info
  ceph: add BLOG debugfs interface
  ceph: convert VFS inode and directory paths to bout
  ceph: convert VFS data I/O paths to bout
  ceph: convert capability and snapshot paths to bout
  ceph: convert remaining helper paths to bout
  selftests: add Ceph BLOG smoke test and collection helpers

 MAINTAINERS                                   |   1 +
 fs/ceph/Makefile                              |   6 +
 fs/ceph/addr.c                                | 168 ++---
 fs/ceph/blog_batch.c                          | 312 ++++++++++
 fs/ceph/blog_client.c                         | 266 ++++++++
 fs/ceph/blog_core.c                           | 424 +++++++++++++
 fs/ceph/blog_debugfs.c                        | 434 +++++++++++++
 fs/ceph/blog_des.c                            | 332 ++++++++++
 fs/ceph/blog_module.c                         | 584 ++++++++++++++++++
 fs/ceph/blog_pagefrag.c                       |  95 +++
 fs/ceph/caps.c                                | 252 ++++----
 fs/ceph/crypto.c                              |  14 +-
 fs/ceph/debugfs.c                             |  19 +-
 fs/ceph/dir.c                                 | 290 ++++++---
 fs/ceph/export.c                              |  83 ++-
 fs/ceph/file.c                                | 274 +++++---
 fs/ceph/inode.c                               | 233 ++++---
 fs/ceph/ioctl.c                               |   6 +-
 fs/ceph/locks.c                               |  66 +-
 fs/ceph/mds_client.c                          | 293 ++++-----
 fs/ceph/mdsmap.c                              |   8 +-
 fs/ceph/quota.c                               |   2 +-
 fs/ceph/snap.c                                |  66 +-
 fs/ceph/super.c                               |  58 +-
 fs/ceph/super.h                               |   5 +
 fs/ceph/xattr.c                               |  88 ++-
 include/linux/ceph/blog.h                     | 196 ++++++
 include/linux/ceph/blog_batch.h               |  44 ++
 include/linux/ceph/blog_des.h                 |  16 +
 include/linux/ceph/blog_module.h              |  91 +++
 include/linux/ceph/blog_pagefrag.h            |  32 +
 include/linux/ceph/blog_ser.h                 | 270 ++++++++
 include/linux/ceph/ceph_blog.h                | 284 +++++++++
 include/linux/ceph/ceph_debug.h               |  44 +-
 include/linux/ceph/libceph.h                  |   2 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/ceph_blog/Makefile    |   7 +
 .../selftests/ceph_blog/blog_analyze.sh       | 124 ++++
 .../selftests/ceph_blog/blog_collect.sh       | 116 ++++
 .../selftests/ceph_blog/blog_smoke_test.sh    | 363 +++++++++++
 tools/testing/selftests/ceph_blog/config      |   2 +
 41 files changed, 5218 insertions(+), 753 deletions(-)
 create mode 100644 fs/ceph/blog_batch.c
 create mode 100644 fs/ceph/blog_client.c
 create mode 100644 fs/ceph/blog_core.c
 create mode 100644 fs/ceph/blog_debugfs.c
 create mode 100644 fs/ceph/blog_des.c
 create mode 100644 fs/ceph/blog_module.c
 create mode 100644 fs/ceph/blog_pagefrag.c
 create mode 100644 include/linux/ceph/blog.h
 create mode 100644 include/linux/ceph/blog_batch.h
 create mode 100644 include/linux/ceph/blog_des.h
 create mode 100644 include/linux/ceph/blog_module.h
 create mode 100644 include/linux/ceph/blog_pagefrag.h
 create mode 100644 include/linux/ceph/blog_ser.h
 create mode 100644 include/linux/ceph/ceph_blog.h
 create mode 100644 tools/testing/selftests/ceph_blog/Makefile
 create mode 100644 tools/testing/selftests/ceph_blog/blog_analyze.sh
 create mode 100644 tools/testing/selftests/ceph_blog/blog_collect.sh
 create mode 100644 tools/testing/selftests/ceph_blog/blog_smoke_test.sh
 create mode 100644 tools/testing/selftests/ceph_blog/config

-- 
2.34.1

