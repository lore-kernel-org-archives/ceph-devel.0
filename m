Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0438737E
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283140; cv=none; b=HTAxdZzawN7TGAYn+vNCRYdUz02oGpPcuX/cCMHT05LXLcRFnyhqjtBuxuwBLw1ZOp7bpz+ihyd7RYBjxiDIfO0fEEyLVPwDcCYr3AzJFbuurtPUty6jeOWpy9P00F3MungnFsji1HVk5RmnaAw7Ug0bbhbaZZQMeQlRITiCleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283140; c=relaxed/simple;
	bh=02e03u5CyNTHWcBqjOHwWkUIMHRE177XW4wR3QCeJZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhabvlbGbd4KfKx82BB8BAuk1EITRKPuDRRHBpJuKgQE2/ZSWnCkC1/Y2eKC30YwTzZjGoDjzzupIM40PEQAEl8BgU4O//1+WipLkUJXnK0G1i8Oxs7g+d10qYS0fm7Mhv76cGmny68zv86vTNRgW1QwVUC4ZbTtQUgMlFzVURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JAFMtuWR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JAFMtuWR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46015dc517aso934815f8f.2
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283137; x=1781887937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8GEd2ral1iLxfzHi1TZa71zVgX/umE9oT8nFWBZvHY=;
        b=JAFMtuWRgDXhgOmiG8VrV7kuzVvK1UdokMzBhVUaDPfu2SCMs7azaXK9whmpUv9eAW
         vNJW/lUbebzgoeljwrRR6XxqG0h1MFc7LTY3jx5h1YBXWuFX4SzXArgkVXPl+e5Ex93P
         4n5COYSt3FJbTJiLOmH9A0j8zOOwdoYDyyhRvRFQN8QnamQ4KpaT5GDaFIn0zcxO5HwA
         xfexETc+UsoBPNv5sg36yQ7KRjrHujiTajzcp8BuGHYWZ3Fu61DUdEilXHAc3cWTEwL5
         6Qbpk98xDb/lBFhN9PSpJ7WAblFmSTWGRqSVyXNb+9eLALQmfoLILT8Z0aMWqKWbvPXY
         JZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283137; x=1781887937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8GEd2ral1iLxfzHi1TZa71zVgX/umE9oT8nFWBZvHY=;
        b=iBoiF/264clVrJrwP3t4rAHIpG1lWHb5ZBrrVPVyYnBkMlSkp4sw5lQdNADDe3jAUm
         W2hCzbUYZxtY2pn5ihm7hvc3DL/ZT8BVBdm8BLUMhBo8m1ziqD+gUUGJeXvLeHdqHoB5
         u4iDMgvZjNsqp4Bn7Z4Tq50Z/W1O5kG8pEtLuWNlrPQr9W/3rHyooLaLajiroo+ZqGEW
         7eHoi2Iyim8PYsvFdqsDuSdea0/AEoO9cyqskGpNiVnWiZFILMuUrLJfw/cJsG+sLsON
         t9uMDt2+9YuKwJETKxYTqZam25+ZxDJqwq5fgmx3VFssN3wH6Iu10qhKK1zEgeBxE0Nq
         04wQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yrxjLxf17jVzRjEIVGEYtQq580BNkK8xjwQKiWnE7vUwzGcMPBEmLbUw3Yxo93rFAeMdJPqQrWQs7@vger.kernel.org
X-Gm-Message-State: AOJu0YyabMWdfBEUMEvhS2RyGVR/+zo0+1in2uu6yi4MKCfeWTpHz3G3
	/2jfXFoSnZIWKdVCcIT5rbPe57PRxA39U0tfbqEGX5Jvm9FucKYjhV61sqL1b6ZAxi4=
X-Gm-Gg: Acq92OEAQ6Rmm6nJ+YmP3XUkjh4hbCkFMeQToHXmRztkbC1jl/yVwxCa34eYTR5Muln
	ZPD5/aGH1DtMz0gK42uoeghmXkoOduhJypzlZCR3sDw5E2BsxakdTtI4Pgac8gT+asT8+gODJDr
	QD5KfnK1X0xfyYFCJ+K4EQdjUZ+UZ8G9rSk6qsJvkP7mN0sXsiyDygkj5Z0HzUzdRJEe3tKuCZb
	8/ZFT3GvgdaWEH+p7NbsLIpoPXV4YTNaTMTJrRsOVGvSCQFzKUhHOPZBhDFoG7/rnfDSRuDaCZ4
	1/IKz3RI8E/ZjWRLXz9rL+DGMnX0r8q0r5RBoVvUtup0+835fVvt4HFS1yRWGPmMVwXYjlhLk+l
	uj2CyVzvNcvKXfsMmqZe83JG2me1iXf1A9zOrKrlWO/0H1VTW3l7bJqvo/0gN/uhTJBN8cIBVJp
	gkSyre4O4I7C29aSDxtnBEtLNAV1wktAqLYIordulEslfGkJFbiqjA27RuYJEHhOVf4V1idqXV2
	66e58rLbIi42PFPRvfF+Q4JOBs=
X-Received: by 2002:a5d:5c81:0:b0:45e:ed7e:f900 with SMTP id ffacd0b85a97d-4606da57ca1mr5226250f8f.6.1781283137105;
        Fri, 12 Jun 2026 09:52:17 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:16 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 00/12] fs/ceph: optimize struct layouts
Date: Fri, 12 Jun 2026 18:51:52 +0200
Message-ID: <20260612165204.86137-1-max.kellermann@ionos.com>
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

  /* size: 1456, cachelines: 23, members: 78 */
  /* sum members: 1424, holes: 8, sum holes: 32 */
  /* member types with holes: 4, total: 4 */

With this patch set, struct ceph_inode_info got smaller by 96 bytes:

  /* size: 1360, cachelines: 22, members: 75 */
  /* member types with holes: 2, total: 2 */

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
 fs/ceph/inode.c              |  38 ++++++++-----
 fs/ceph/mds_client.c         |  12 ++---
 fs/ceph/mds_client.h         |   2 +-
 fs/ceph/quota.c              |   6 +--
 fs/ceph/snap.c               |   8 +--
 fs/ceph/super.h              | 102 +++++++++++++++++++++++++----------
 fs/ceph/util.c               |   8 +--
 fs/ceph/xattr.c              |  18 +++----
 include/linux/ceph/ceph_fs.h |   2 +-
 16 files changed, 171 insertions(+), 118 deletions(-)

-- 
2.47.3

