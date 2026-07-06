Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF6377575
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322728; cv=none; b=EfMVlT5ELkE/e6qfRIgGnUWY9h2Cx3hkay6qIdWz/9qWDa6rFGrV3G3cpeXaMLsvwk8ZemmUhvLMYJQrMXtlBi1WgISG/2wyzktA1GMSYc2qjLQxHi3FTQ58o+h6mw4WKgL+bQTdAXQ4j+SV44TRAAmwK3sfEpKCBtoMZ99yS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322728; c=relaxed/simple;
	bh=L4ZAEJuJ3nUGAvhl2YYsZRvYFtcTSPkKzORS6KVjz6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9qOSyKKIzL7S+FDNnKC4LebaOXRaowJEukPF79p5T+FZM8NNJQS8AK3fHHDwCWqXw1DGp5e+heuA1EcNUFb1i4ks+/pbLUN9nm+Z8tXQNBiaiDhGSsoNBex2mSnj157N5LG4fPHjf6U214aDEOOqrGDgbWrOQeleJiq9H+UMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ExNFK+TM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ExNFK+TM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so26957665e9.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322696; x=1783927496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/gFRPBue1C+IeFNGXJiFJ9K/meUxgqYNAfA0Sl+a8ng=;
        b=ExNFK+TMDOZXefCOezSCuOOs4RZovcdaYWBfBu++IPsXGlQZKhACBp+JhPaBNyiBmq
         np5ZqKOi1+lPvpgjZljPs+VR8ODG8RCCuvQ+oOoLpddyPAh3cLglMKD35v59WcvvM+Kb
         SXq/ZJMMd9uLWRbx3E5VF0qleDxlJl9cC4pJTlz+VufhtpXgMV8z1eCCaktN/6ZGjbe0
         PJ3cV+T0+hO2GlEGjrZO+6+aTQjbebiklwQamwOyKilPVQOtd+GEnUvu8BIjrbfXSfwg
         /WrgKQAfjD89xmUDeSlWvvVv1u1qY+thwDIjhpdM7vl/ZwaXl+ZnZKpLmcH9syEszVJT
         ElDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322696; x=1783927496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gFRPBue1C+IeFNGXJiFJ9K/meUxgqYNAfA0Sl+a8ng=;
        b=csrf9z3jTXG5fvL+QlZI8CwolL4rkr4k33V5jCN/2GilRDKwafEmJVOPN4GBeU3CS1
         GhbdLyUY/o+KXqR5Qy+3N7qE6ttbwQi2mvZCsTPwQwbG1QyidPIdAMUm6rkUzlYN46NE
         8Ts4nEmyslU8CHMi3gLWedIcHG8Re5oYiL+tTjtgmnO3B9gygXblBcmkCcyBQHlWHsaA
         woEtbah9DS3f6xfZl5r2aob84k568qwa7g0kPlVjkve33yPEY9stmi1Oq8Wt+IeFCUDs
         z+nGEH8N3f+mBCJqYQFHUKrRxSincLJ9yTdgI2094vC3FSUkrth/OHEv7PbW/55bxDVF
         VvBA==
X-Forwarded-Encrypted: i=1; AHgh+RrkXJParrbpy1RCxZtbi9dlOgbgDO50NuLCbbiKJYp37B9tfrQahM3vsoOYBnuaVXEinEs/ZvyZxJCl@vger.kernel.org
X-Gm-Message-State: AOJu0YzbcFLZKK9w309N4HcpAto66VNalDvMsMee0GXwtlfetZ6vtvc1
	vjYrmj2Oye2LbrFBfUFrpJ1jGyYVw6cSoblM/v7WjpuVYu0g0WMupyDyfQO0cnlig7ktp2gmA8e
	OteHBjt0=
X-Gm-Gg: AfdE7cn1eE77HCbTE0pwXONkF9EBKD7rh1xkvWcl5oGbWaEDWG2d97oIs9x4H1MrS6C
	UaOq8XtN75DgEUEhpt354B8koSsH6YEbSm59oYBObBcdYBOLkCqrgdUnPyN7dMpAblYRx1aOoVu
	PEbiIKORjCSiZYOxHokGg0/5az2Dc2RxVSOi71Ue9LJ9Q7pE7lHUWHdwGp590vj97IhD1q3H1Go
	z1Sz4oKXC29riXI9/VLPJm7Rkse5cW7EW2dCIKPYiTWjpK6p2c1E3YMQd4vftN+PI5W2Ag2x1MJ
	yjOuDBw2VA9wdivBhJWsPvMecse+maDX3rekNoIA9mYpdE4QpTK4X1+Gmma8c6QN7OFMtEqYIGR
	hOksYuSZg7Q5QSveJlDge4/mXcgXPAWsppiRbgrfKk+oGrRUtkmSYtf8UYYtEi0VmtMIZu4QjNe
	aHpCIR15wNdQzQTBdQiP9qD6M1OvgqP1a4qihJv07z15+nb4gT/hGPTP8n+1ZhOgjnsdU5J3INP
	zfUsH1lsvMs1HUi
X-Received: by 2002:a05:600c:6986:b0:493:b8d9:f28b with SMTP id 5b1f17b1804b1-493d11f05aemr102524055e9.23.1783322696230;
        Mon, 06 Jul 2026 00:24:56 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:24:55 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 00/18] fs/ceph: optimize struct layouts
Date: Mon,  6 Jul 2026 09:24:31 +0200
Message-ID: <20260706072450.3920010-1-max.kellermann@ionos.com>
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

Max Kellermann (18):
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
  fs/ceph: remove unused field `ceph_cap.last_used`
  fs/ceph: convert ceph_cap.queue_release to bool
  fs/ceph/super: move `ceph_cap.caps_item` into the union
  fs/ceph/snap: add a kmem_cache for struct ceph_snap_realm
  fs/ceph/super: reorder struct ceph_snap_realm fields
  fs/ceph/super: remove redundant field `ceph_snap_realm.parent_ino`

 fs/ceph/acl.c                |   2 +-
 fs/ceph/addr.c               |  23 ++++---
 fs/ceph/cache.c              |   4 +-
 fs/ceph/caps.c               |  14 ++--
 fs/ceph/dir.c                |  20 +++---
 fs/ceph/export.c             |   8 +--
 fs/ceph/file.c               |  28 ++++----
 fs/ceph/inode.c              |  38 +++++++----
 fs/ceph/mds_client.c         |  16 ++---
 fs/ceph/mds_client.h         |   2 +-
 fs/ceph/quota.c              |   6 +-
 fs/ceph/snap.c               |  17 +++--
 fs/ceph/super.c              |   9 +++
 fs/ceph/super.h              | 123 +++++++++++++++++++++++++----------
 fs/ceph/util.c               |   8 +--
 fs/ceph/xattr.c              |  18 ++---
 include/linux/ceph/ceph_fs.h |   2 +-
 include/linux/ceph/libceph.h |   1 +
 18 files changed, 204 insertions(+), 135 deletions(-)

-- 
2.47.3

