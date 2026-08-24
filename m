Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A238550C
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596932; cv=none; b=abYLgjF9HoH1by5xPpdkmE/d/33Ag833okXzksPFk1JVD0j0NVZQ5b5Rqpjfeauhe8f48abVTALomwb7wgin5GaQ5OkVcIzWDFaa7LqYmsgYDE+1JXZrIit2WX8DmHhu2YabokL85i3yco6t+FWwAHj5bGWgXldarFSy6pwqA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596932; c=relaxed/simple;
	bh=5icy5WLnQld7+BVb0m0Gt61ZuRCkDgKSqCiuK9SUqH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PP0oGw0UkmpN1zlJWmRWJD/5eutvxOaZeXjWCKzDuuaezUIoP7FMpVcjU0d9lF4q0X2DtBjoUUWduAF2LA4CfaW98bQwW++zRtU0BTi7fAij9xam6HhHncPtS/wP8+vYFxxUD0cCWSIcBryFsXS8yKL4d84fFzdzqSt3fEzNJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Lp33DiA6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Lp33DiA6"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20ce3c118aso3711666b.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596929; x=1788201729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tudv4U6KHiUOLIUed9okqXEMeGQ3BMrjlTjBjw4+vNA=;
        b=Lp33DiA6E2qNShgM29JZBpd8auywwuTI/fwX/Au8rfqXSBFGJEu3IAVDYnGPsLrQJB
         4adkfGLYv3lwlrUY1szWoOQztirAlhn0iLiawcs1FQvtO9WNCPGRIx4ncf7Ep1nK4aM2
         fb2v9lVRBClREppfqXISHQFq16UIfW9m0khapzldKBWlQDV/ibuQJsbAsn23o8QBDj4F
         aBN86w/w0U9gO96mRa1EXcv4vY6ew6MSAf9Ms1t2OhDiFc1ytX2uOO1WU/sVrv7/lazb
         Z91JCdfFi5dxi8mzRL9JRxJB9Z5v04Bp7glwzoIOKRXWHewm/ppRWmvL+tUdWAChVXiD
         +lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596929; x=1788201729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tudv4U6KHiUOLIUed9okqXEMeGQ3BMrjlTjBjw4+vNA=;
        b=ly24+CdX+jONqf2MlScp8ri7ap5CVikslYn82EZxMC7GHzlFq4sgut6cYAjLnBUAW+
         IZS48HRtx2/2QDl+sxN29wx4FcY5nd6d5VdlTzSxogaAhst9YbQyuITBfr68ZTxe4eRB
         iR88cxPwq/NOVD5bt9iEWrkO2sdPupvxxyGqrf9zW4ZPPxAd4alLh1kewQQl34iOCvyq
         bzSGRsCWF4ofV7MMKA7NmQVBo1FCuy/lDeSlayj1d3Totx2HPhKBVPbGJu1+xIsr7Bvf
         A55niuc4IB5aL6wmBXiS3/AnYcjVZw72K+UCqatXZliMVWJRtw/5GogzSpJd9Mreyq+P
         95lw==
X-Forwarded-Encrypted: i=1; AHgh+RpPX+wT6qPfBRi6fDiStidLRpru0zUjdGEZ36VczZBvgWJXP7FXtK0bAf+x8T8kGcPgiE1719ULvSGV@vger.kernel.org
X-Gm-Message-State: AFuF++l6zOXS5i09bE3YPGHlElrglbFd4jkx2tZOcX4RtbKHPtUGmPPS
	X4aVnrp0AUEhtlIcnucEIof+jEboSHO+iaahqrEXwOG/K/0Zmhxmf4C7G2jQ9a81aDuyh+I9F2B
	IBa97hTg=
X-Gm-Gg: AR+sD12nZ2kBD/qnHyBJ9cMSLsqFLKYqk21TZMNxP/V22LE+ZD919u9IrvgNKEIshTk
	43/ABhSsUFfP1Yy4UuPKdala/+b7NMBDw4X5oxZlp3TZS6sZxcAiZYlcm5i4t6GNcOSBsoY0caG
	NOE/wd2KVGbT3SzwGIEu84n+pNnjERlauRycMcUww6wz7D+IbUCCyRI/IB6YboUfqR6Qpwyltr3
	wYYAkFzqR3ew38fm8PQKiSFDoDNy4hRIasjYu2TZY4klMndMFUv1A6T35mmfMhlQz6RaH9QViru
	OjVnzKVa08kvvYQkqcG4bIG9ars+zzbSJ2ViiyG2oik8xHDIwGU0tU3yef1nYTCDnbgQOhRGnaJ
	TIz8nwEI6LW/wIZi+HutzuRxBsb6LCeDyKXF91m2e7tO4F4gE+L5THs7aIEuFVhryRDw3g3T+xX
	rxcprgQJlBBOo2f3mw2SDD34jVkUgerpwFHk0JLV2m/c02k1xF6N7sq7BbUyZ8/zWYfAuiJBiRW
	xPQoUmrwidXzsQanETMAizSJIebvbmEh+DSkMr37cGE2nmHQRI0JDpNOmE5ZMPm
X-Received: by 2002:a17:906:f597:b0:c21:7c98:d9ec with SMTP id a640c23a62f3a-c24e2ae78e6mr78838566b.5.1787596928714;
        Mon, 24 Aug 2026 11:42:08 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:08 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 00/11] fs/ceph: optimize struct layouts
Date: Mon, 24 Aug 2026 20:41:48 +0200
Message-ID: <20260824184159.240821-1-max.kellermann@ionos.com>
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
v4->v5:
 - drop "Fixes" tag from "i_cap_migration_resv" patch
 - fix multi-line comment style
 - drop the "pool_id" 32 bit patch (may break RBD)

Max Kellermann (11):
  fs/ceph/super: remove unused field `i_cap_migration_resv`
  fs/ceph/super: make field `i_truncate_pagecache_size` optional
  fs/ceph/super.h: convert ceph_inode_xattr fields to `bool`
  fs/ceph/super.h: convert ceph_cap_snap.writing fields to `bool`
  fs/ceph: consistently use `u32` for `time_warp_seq`
  fs/ceph/super: reorder fields to eliminate padding holes
  fs/ceph: remove i_truncate_mutex, use i_fragtree_mutex for both
  fs/ceph/super.h: add `const` to helpers
  fs/ceph/super.h: add helper ceph_in_snap()
  fs/ceph: use ceph_vino() etc. instead of accessing i_vino directly
  fs/ceph: remove redundant inode number from ceph_inode_info

 fs/ceph/acl.c        |   2 +-
 fs/ceph/addr.c       |   7 ++-
 fs/ceph/cache.c      |   4 +-
 fs/ceph/caps.c       |   6 +--
 fs/ceph/dir.c        |  20 ++++-----
 fs/ceph/export.c     |   8 ++--
 fs/ceph/file.c       |  28 ++++++------
 fs/ceph/inode.c      |  38 ++++++++++------
 fs/ceph/mds_client.c |  12 ++---
 fs/ceph/quota.c      |   6 +--
 fs/ceph/snap.c       |   8 ++--
 fs/ceph/super.h      | 103 +++++++++++++++++++++++++++++++------------
 fs/ceph/xattr.c      |   8 ++--
 13 files changed, 156 insertions(+), 94 deletions(-)

-- 
2.47.3

