Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412E2690EC
	for <ceph-devel@vger.kernel.org>; Sat,  6 Jun 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780772446; cv=none; b=Yl8Ry5J9O44YA2o6hSSbiD5nNb/ZONKAxvRAyKYaNrA0YqHWYyIUd3NxU2RghMlZqZPqELxPrMDMYO4RzBBkldnfKukFBPjAtHnm6+xTo5EoGba+893VvXXSouvIAOL2rMcmXtb0AT0ptnM5AAvW+NOMvZ0cZHNEwY3rcrKFVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780772446; c=relaxed/simple;
	bh=SB7Q4h1MSqAh0UeyNq9Vk1SWGT1nQgzgNaQF44rZQy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f29z1aob/6b2WJsFJHIWVM2DSLhh5TnsnxiEKU0dpi31CJ3wElYruI7oO9+eLxJK/FRuneGLv72ANbEMH3R8PeYFfxllQXtjuKDkvpEu0KWO+a/6nyKCXT98j4rT1ZY6VNoY7tQpdMoBzvbPi10zQia6XIfaBS5yGQ59gP1J3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA7OGTVL; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA7OGTVL"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51778077b28so34479471cf.1
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2026 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780772444; x=1781377244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mql0QQ+9J26Gk5KyJRUIzwd78adrG9s2r831auI4Ui8=;
        b=aA7OGTVLrMjR2Crnk2XybjO9444dGr/pDZ33mkjZNVcQLpGtroxPZO1KPQSSAVtXvn
         MTHkt+DZFZ3KFHC1h07TLgogQeUURDX9JaBacX7140e3JL+liO0RC7qT6WqSfIvvJSgE
         aZ57EcU/Jb8c699zIfJ2FbYWDYd8q2EWgFb6L3PAkwgS7dbPc3CIuR7/IkxIvuvxlPJd
         jOD7GYu5FGZbgyxeN4Z4gKFzvEsa8BlVHVdXxNZw10bwJ6GvfKdrvU2G5zPnR0QmHMzN
         66Oxww1awOREj2RmcMT+1ly91FgXOmWlXrmC0xLr2tijGRNuiPMkdQu6mrx1TvWUBmRr
         ZAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780772444; x=1781377244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mql0QQ+9J26Gk5KyJRUIzwd78adrG9s2r831auI4Ui8=;
        b=EvakAPj+44LhMhrmLKRGcKo5nAJerWtx4ygC9T7C04JNmVj+cTLjBzovMkK5cymTM5
         DOkBryiZ0za/6zfVRQDNwnyxQ7N7zfFIVD+RBvr0czfTL8OLBRSKf5YUT1AbsuiOY4FR
         jLScPd5kjPG++B6cmToSJpZpzuUY3d1fwO1KLZ+6uV0GBHVPKHN536V70AolWchV815d
         WasdaAESpeCKA3pra8T/P/nojm6Kw0Fd+X0v2W8jc4pirXc2jUjntu3Cx8iexO8eIFkD
         c6C6hpx/PxdmH83FyfC7HZV+DyYQdC0aT2u8N38kru728qFHKBjfk9aXcA1eijg4q3h2
         K+1g==
X-Gm-Message-State: AOJu0Yw9Z1aY26KkyMKKTIglBVk+GMGJkIJSqhqfZAmGD3FUMHQzAjwF
	4QEaX2O12SoiiIBKlAZ2PSlQnTwecUvbMegJND8pICwM43pV689+4FTz
X-Gm-Gg: Acq92OHEvQtthFfh+w9lIq2NbXG9bn3xIOJGyzzWrQkACvIzBqD6Rb/vRsv7ujs3Yzn
	fHnXJdf7o7mUBzgFTLoBMxchxgcl/olt9nTSB9vgzkyyOYlAbYn6LcwrZ8kwY5lmyOidU9FgYyB
	AySHVaLpvsAXPdSHiB8izGHfryZa9YUtp77X8daH23h6nqgIn1TGkuG9JyhchWtKqUYsiYgQa4m
	5wEqUURQs6kAuVdGbTIkJHTGnMNpDObz5/0/QXOdi/j/5/oiKvBN+nEr7pDaQ1jVbLgyIhi1gwh
	pwVGGnrFy+PjxtIJimU2D1V+7EexPAqL0m22m65Ev5YKY4ljm7OcOHXghGQm17CeQ/QUDi9hfGX
	krNSS30v9iX9I1zGKJOhbMv3x7g0BSeBGsW2zASgW5knwFqdnRoTX1yFCfxz3e5pExLr7EPi/y/
	8I5UfDdPXVAk8uHe7KDpueMUosOtIebvcJTAUssAuMxtLkKGjpoC/y1z00qOXUuaEhTSsuC7uv/
	2YKztpzMfQfmKj08d518T3qxaraFLY=
X-Received: by 2002:a05:622a:4d09:b0:516:e290:991a with SMTP id d75a77b69052e-51795be8192mr142753111cf.40.1780772444140;
        Sat, 06 Jun 2026 12:00:44 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5179dd9d908sm40084581cf.15.2026.06.06.12.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:00:43 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ceph: bound untrusted MDS and monitor reply decoders
Date: Sat,  6 Jun 2026 15:00:21 -0400
Message-ID: <cover.1780766417.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780596023.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is v2 of the CephFS decoder-bound series. The first two patches are
unchanged code-wise and now carry Slava's Reviewed-by. Patches 3 and 4
address the review feedback on overflow-safe sizing and aggregate delegated
inode bounds.

The four bugs are still independent:

  1/4 rejects a final xattr value length that runs past the xattr blob.
  2/4 bounds MDSCapAuth path and fs_name copies in handle_session().
  3/4 bounds the mdsmap export_targets array for info_v 2/3.
  4/4 bounds delegated-inode parsing by session population and by one
      reply's aggregate interval length.

Changes in v2:

  - Add Reviewed-by: Viacheslav Dubeyko to patches 1 and 2.
  - Patch 3 computes the export-targets byte count with size_mul() and
    reuses the checked length for the cursor advance.
  - Patch 4 replaces the per-interval cap with a per-session population
    counter and a per-reply interval budget, so repeated replies and
    duplicate ranges are bounded too. The cap stays a fixed client-side
    constant because the kernel client never sees the userspace
    mds_client_prealloc_inos option; it is sized as a generous multiple of
    that option's documented default of 1000.

Michael Bommarito (4):
  ceph: bound xattr value length in __build_xattrs()
  ceph: bound MDSCapAuth path and fs_name decode in handle_session()
  ceph: bound num_export_targets array for mds info v2/v3
  ceph: cap delegated inode count in ceph_parse_deleg_inos()

 fs/ceph/mds_client.c | 59 ++++++++++++++++++++++++++++++++++++++------
 fs/ceph/mds_client.h |  1 +
 fs/ceph/mdsmap.c     |  7 +++++-
 fs/ceph/super.h      |  9 +++++++
 fs/ceph/xattr.c      |  1 +
 5 files changed, 68 insertions(+), 9 deletions(-)


base-commit: f72c95f3a516d87483e225ae081a402a09fd0127
-- 
2.53.0
