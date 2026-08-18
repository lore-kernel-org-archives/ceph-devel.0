Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927A439F89
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076711; cv=none; b=CAf/HoXlcwO/TXjaJxD20nDBa+ia3nLhPVb5tP+Iegj+8/6AZpzbMCrS+IGuubXkbjni3psd8yfrdSiuzFCUwXKcQPkSAojwLPpNXrYfovMYRTwE1TUNQ9BvviEWvqE5R0t4mJuq96UE4GcAl2rIP7NnxU5OIvyv1xPplRRmN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076711; c=relaxed/simple;
	bh=fioPhgmHciMoE7UuKEunmKhTSqD6P38N0y1XF4t3Zzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSZDBjq3m2DrLjfHyUJu+SCJG8FSTSy41g6OPTkd9I0e/orxiOmdmLw9VGmrZOHsKvlHe3aIwwi5ut1V3n0ZGbjVWb06XNEQp7EMGoXQsATaa0b+OAlHvRJQ0VOGx+bsaZmJiWNGB/bYY+ueZ7Z/aecyyTAymxkCjThJR2rOsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XPVxrZyG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XPVxrZyG"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f703a9d05so81665f8f.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076708; x=1787681508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VFGA6zfBRvuka79KLiQKGKF/hjDIO9g5AnMpvdvhUHs=;
        b=XPVxrZyGqGT5e5DaPInYW/xJq942zPeXJSABEtatoWJg832AXkBvmngXKWdiJ837vs
         elOaOB5qnXfY56MhhjD/gBTyDf8vVoyLfDWkp07iuXLSZVGmu3klZ/Diu9G/Wa/mQTZU
         nI+RtHJVhXHFIpteW4f7ci3isDaTLD9jZWYWDjjI+8LjKR/trOcI+5Dci+fvtM616B6o
         b9t1PpQDc8N7JrJH/Yw7bD4UO6PlvDkJsCTb0L2ZfD3H5PgQf4VNYnCUQgL5WjnWnNeN
         CawGnXChPdLX+bSozC58DDby/8+avT5CKUnd/K6DBx8PFXeW2StdC15fL3Fb9cJUDTFr
         oOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076708; x=1787681508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VFGA6zfBRvuka79KLiQKGKF/hjDIO9g5AnMpvdvhUHs=;
        b=gWAuwGJcj2EJdHwfnkqmH1UHqaofQ4I/gP7TseBcExtNHcvj/mD7LtGVI+TI422sWY
         Meis04w5lsAqZnZLnrJSzzQUiymimCEBrE90QiHdGfnWfjCM/7FBHYuFRceXgXcjqAp/
         C97t15EQojwmigy6QtqDBbu+G8lQgXguQIYjaoRmlPLceeZ22nxKs666o2wJR9WsF1/B
         vuHcNrrvQ4tevloVv2Kpzaba5FUJiG4q9L/oRcgYIdWA3r9IgmAkFR5QD5xR5sr8f79a
         A/Cte0tl4mGSHZLdd119poUeTt85giaKdRoBM5MDnFpQF1e+j5TZIjRUzmqh1+cw40iQ
         db/g==
X-Forwarded-Encrypted: i=1; AHgh+RqAnFKJjVyL63nNQEZ3eJfEJmZmnxHy4F4gWdFUkR/cH/EhnDnTTn2KMC/lQhuR9FG7qTqeSdg8wcVZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/G5k+I3yV/XvQSDNoCp91A55fZ70S9U8ILZGwIxwpZH1kZ38Y
	QXat9sFLNarAD6dmWBWpX55o7yEsVgxcbixJlmyJ/nwX+OBeCsuUAULHDrZUm1Ki4r4=
X-Gm-Gg: AR+sD13CdTwkY0Ixwze+vW+QdUPb03ljgZ04NLEOCqpOwXqBL+fiUK78ybzIG9Z11t2
	TB/x+EI6oALqFnbYZhHMyYLPJsucsk8OzwtxzOqH3Wz6/jI6U91jVdwaM1qAsRzjhr1EUuLX3IA
	C9DcP8Nj8+Cn0xqC1hUGEXJyhns3G62+/ZDUo0ORRb9AOmM8PPWmFfbl/AbJzTQ/NinwzntsNhR
	daM6vtEnT4GSC6e1qsu68cfMd9xM8OtfPwTL1D/xa0s4CuKZTgGFP7ap4jCl8BmA2QwY+jWYIT4
	jGUN2QqPZ8VPEJUgZ33RAfnU6NZI/j8K9qOJuGu81v/AoH+fgh2ECcoQH3zR6umTarQRv2jtAMz
	IAg33UwknrVc5Du9Qn1o/5amjlMAcMHdRPPHMCaFeLJ+hUCYYprZ3q79D6ncNZEmd6PoQX8L+4t
	tnt+N2Bfgm+65l2H0VD+YC+L2Y+jWQxdfyRwmVap5YPbS08b4mtEaChliuxEW1oJhl92BgfeWoU
	0W+GxPhgsDmr0wmWA0Tcgy8SNxgu4rEFLH70BzZXkpEo5kF0BRj3HZJGXQsC0xf
X-Received: by 2002:a5d:480a:0:b0:481:4697:8808 with SMTP id ffacd0b85a97d-48160798dcbmr48554864f8f.22.1787076707911;
        Tue, 18 Aug 2026 11:11:47 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:47 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 00/12] fs/ceph: optimize struct layouts
Date: Tue, 18 Aug 2026 20:11:32 +0200
Message-ID: <20260818181144.3541770-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set aims to reduce the memory usage of the Ceph filesystems
by optimizing the layout of structs, most importantly struct
ceph_inode_info:

- use `bool` instead of `int` for booelans
- use `u32` instead of `u64` where possible
- reorder fields to eliminate padding holes
- eliminate redundant fields

Without this patch set, ceph_inode_info looks like this with pahole:

	/* size: 1456, cachelines: 23, members: 79 */
	/* sum members: 1424, holes: 8, sum holes: 32 */
	/* member types with holes: 3, total: 3 */

With this patch set, struct ceph_inode_info got smaller by 96 bytes:

	/* size: 1360, cachelines: 22, members: 76 */
	/* member types with holes: 1, total: 1 */

struct ceph_cap shrinks by 24 bytes:

	/* size: 120, cachelines: 2, members: 12 */

	/* size: 96, cachelines: 2, members: 10 */

struct ceph_snap_realm shrinks by 24 bytes, too:

	/* size: 232, cachelines: 4, members: 21 */
	/* sum members: 216, holes: 3, sum holes: 12 */

	/* size: 208, cachelines: 4, members: 20 */

---
v1->v2:
 - fix CONFIG_FS_ENCRYPTION check in "i_truncate_pagecache_size" patch
 - add patches to shrink ceph_cap and ceph_snap_realm
v2->v3:
 - rebase on latest master
v3->v4:
 - drop the buggy ceph_in_snap() change from ceph_d_prune()
 - fix -Wunused-variable on BITS_PER_LONG<64

Max Kellermann (12):
  fs/ceph/super: remove unused field `i_cap_migration_resv`
  fs/ceph/super: make field `i_truncate_pagecache_size` optional
  include/ceph/ceph_fs.h: convert `pool_id` to u32
  fs/ceph/super.h: convert ceph_inode_xattr fields to `bool`
  fs/ceph/super.h: convert ceph_cap_snap.writing fields to `bool`
  fs/ceph: consistently use `u32` for `time_warp_seq`
  fs/ceph/super: reorder fields to eliminate padding holes
  fs/ceph: remove i_truncate_mutex, use i_fragtree_mutex for both
  fs/ceph/super.h: add `const` to helpers
  fs/ceph/super.h: add helper ceph_in_snap()
  fs/ceph: use ceph_vino() etc. instead of accessing i_vino directly
  fs/ceph: remove redundant inode number from ceph_inode_info

 fs/ceph/acl.c                |   2 +-
 fs/ceph/addr.c               |  23 ++++----
 fs/ceph/cache.c              |   4 +-
 fs/ceph/caps.c               |   8 +--
 fs/ceph/dir.c                |  20 +++----
 fs/ceph/export.c             |   8 +--
 fs/ceph/file.c               |  28 +++++-----
 fs/ceph/inode.c              |  40 +++++++++-----
 fs/ceph/mds_client.c         |  12 ++---
 fs/ceph/mds_client.h         |   2 +-
 fs/ceph/quota.c              |   6 +--
 fs/ceph/snap.c               |   8 +--
 fs/ceph/super.h              | 102 +++++++++++++++++++++++++----------
 fs/ceph/util.c               |   8 +--
 fs/ceph/xattr.c              |  18 +++----
 include/linux/ceph/ceph_fs.h |   2 +-
 16 files changed, 173 insertions(+), 118 deletions(-)

-- 
2.47.3

