Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D639769A
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566604; cv=none; b=gxRB/MJ9SAEihOnTJ1XbGDYfBXSxes6//+TfG9zXXVhsCs0B7HLwnOgDYDzGQNAUMTqgMva1iB0RkkHpkP6CmIdNeF6HFv6Oh8SYrwWh5HSR17C8EP6xD+8SUzgRHA5jZbLVTOIlBYD29lZUlmD/WlYNJl93wg5g3A6Gn28q5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566604; c=relaxed/simple;
	bh=ydMbZxq34ruyJFOol9z/eePAkONXzW5eDvPVgtQSUB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLRkcvYE3budoSRwn2a6PyuJNwQ+QHvnuwldzV1sbgJ6WFJbrGrGxVvR+2UG1trVzt0hA/tAMLCV1DnCGXkRhDQI6lj6Qyng728c99kQeOkqYcgyDnjmdqkDY8pPRy/vEVdRmy/5d/mHozai7TnndQcyK5k8rrpcJ9dsj3E9gcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EKsOnFS3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EKsOnFS3"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-480033bdcf4so806165f8f.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566596; x=1787171396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YGuKGTpdrzZWc64MUsR08y0Wt8X5bbDyQkVM7jDdv08=;
        b=EKsOnFS326Zkz3ZnSC7SXjh5HXhehiCgWablypWmbg2fbzheQtNftxKkfaY3JU9PAx
         glghhsTMhMXyBjrMQFJm/qZuypYCy9nEbKT2KO8CS1bw/qpN1kn34GuOxDsldPilmYHy
         JaJXm2f81fVqDi65EoYdsihPtkzjaBLk1dED8nPejjs7IjOhCH1tNKcmJXCoWb7FHUoJ
         VRK9p/WPmXVqJ5rX00QHR8ucQJQGXvUFbq0bDCQg+EPPu90kPENlvo7CLCqpfzgblnbX
         ppXasJXc26Y8cXGJbUh/mGcODdZAJYiAiofQwjLkd/Bs2nD90DCCJsd0r6Y01vcj9yZM
         4d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566596; x=1787171396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGuKGTpdrzZWc64MUsR08y0Wt8X5bbDyQkVM7jDdv08=;
        b=OoWIBlt005KM8Q78uo1FBrIIPbnqokpBhwctBtNYg+VMj0x2fi8Yn4APne0G4FNXjv
         KesVEekrsVHtRDjLT/R6ObYbiqMFGv9gW3PRTIguYqy8bJoIfMk3hTuTzRPQNrISY7jo
         GYKIdqNZXT5TUz94gvn/4sfu7k1N25ixQvXeW0bnzTIPbSyTsGMZsGqCSYQjjfHmMUdi
         KR35hurXA7fiFFpOIdZkZLThImRah+fXnSKYMr7UOiL4TmUKBZp61yggRUaLVue39OWq
         +9viKBvUhnPDqs2voP06mV6xuv99vlW7Z6Fl4kGwFqwx8G67Uzq0VpwrIAebdCDNDDz1
         NqRQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+JyE0UmxJau/Ro12kq7qVZh8Jo8tm+GdZ63JLYjlBZneklNM+JGTS0jyuY3MdSTu28RwRlwggDWaE@vger.kernel.org
X-Gm-Message-State: AOJu0YwY1joBKag5Y0/k4tBJ7tKjNeiVDYHwRnxRnNkmMOqVAHIMWJ0c
	S9Gs7uqqd2fQai6WySgvCI8b6EUCVWXXIdqLo0THKnwCBjbjbQErKyKhnYqP5so1/DE=
X-Gm-Gg: AR+sD12zZQJCHjtJnMlnrUqfkAoLWTgzpYthRucJ2bZrUtIbqHCaHp1dhFkuycSrcdB
	wfG/TFFJllK90olcNUfwQzNSlRxnNTOB5sruc5s2bBOjx40EcJW3BFWqnaF3T/UxzGb5W42CkzJ
	AdnIikL9dMuLPq+NtcAJBPOpbrYIPgD2jS6bi6rZ6oNaIyzzQWMNV6R04J7adFl++cby6aKjk9L
	G1xDn84jHxdIHxNHdPaYTssXgYYOsgd8peD8lCnw7+3iesGtB5LYmvAa9g8wHZyy3+igB2Oy5IM
	oQ0ME/fnCRkqNoNS8PBJMx/1zgXhuXL6kwOoGh7vrv7NS8eRCkSq2hUmy+F5EYwpM9ADO7RAeOF
	a74yFjJOGgczDiC0LXNqL4mdOnqiSXgrpBNXTj/GOS9+uggS3AgDk73f2dE4PEx2PygOszJ3as8
	r+eQAZnYSRx8MCOJH6a4FTD//VfUwHh0fMCedUOlD9UGKpmly9I2GXYhVGQVAtfsmxB+yNNE3bR
	RG7jWQ7m7VjHuzKbowljGUTWiZw4SYxaAzzAvyN8rVso3O9uLLDRZrw9MUC5rG0AGrfhYWh8Lll
X-Received: by 2002:a5d:50cc:0:b0:481:51ce:542f with SMTP id ffacd0b85a97d-4815a028804mr692033f8f.21.1786566595886;
        Wed, 12 Aug 2026 13:29:55 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:29:55 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 00/12] fs/ceph: optimize struct layouts
Date: Wed, 12 Aug 2026 22:29:37 +0200
Message-ID: <20260812202950.1800340-1-max.kellermann@ionos.com>
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

