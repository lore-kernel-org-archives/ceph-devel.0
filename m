Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE84EBAC6
	for <ceph-devel@vger.kernel.org>; Fri,  4 Sep 2026 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534193; cv=none; b=qmN46rXqXo8j+yuXif2ybXqKbITTrQCtDYbrfjqiJsu8CK/cg8oeMLkVEjBeZbWTCWOP0El7IEUXAEnAMmmpmNxNYIz6cMBp+QPuW8HtQXLL/+P4elF1RM9Vb+JZh7th5V+IfhQ3Yp9ruU5w9++noOkGhG6otbT2ebmXjR6yt8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534193; c=relaxed/simple;
	bh=vUYKsim8YIohPrr2ha3b5zw95mYzREtEWQ/Hb9jEMVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y89bu6EH+QLiQvdGiq96ljyUBgY4SxqK617o9bx3ixZdC8nrO8NUfjS3yDoLE+V05pErJUmbFxeO9O1CfQ6grkEkE7VJ84xOYXGqS1psbjy3YncvKmHvPLLgmnVw9er7a4mbOcbaDNz+DHO/C397v8BKnfXMptixnw8So1ZdTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=K2Tf1UdY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="K2Tf1UdY"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2055573c8cso140984766b.3
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788534188; x=1789138988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JT4rpozCU7LONPSkeYDRA/CM4iMBiYZN6doPlweUA9Y=;
        b=K2Tf1UdY0LQDWVTtm7dKcQBtF9K8GdsULQD45uGM2ydUm47pTtPDnXuycEo8pEc0Dx
         IJ+egf6wZPkmTG6NQitsy5skQvhjOnyndgoLV0v5CNi3wXEHaOVe4SYf9VYADRpb6phs
         PYlpbE3gqRan1JdEeBdF1WVWQXBfTuZL9rFOVT1fJmqmii84LoYnelbDfPJJ+FDBKpKO
         0mp+yQNefOqD6XzfcbrL1xFMK+ryPQ5RZo/bSQP18nnwSVrfc7nOIyC/P9qZY2+nveZe
         whLqyAKfLYgHJEbX/K3TKGGTI/RYIfe0Mi4FIxn5RtZZi5dBQosKGwJFYkpQU4E94+Qk
         4lOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534188; x=1789138988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JT4rpozCU7LONPSkeYDRA/CM4iMBiYZN6doPlweUA9Y=;
        b=ByyW6vd5hKWmx0JGg719PtDzojZz+JFJBon6Jc9Ze6IaSOxbeoqENdYfr5SNRrvH4D
         PtMfg0mWElJOTkQVq3oiOfR6zTe5+n4Ba2crNQyFSx+m0O+BEz6fJeh07pllYClN81TU
         aFNFrChciR5taA4mp6zc6IZRnoUQuqhNApewjsTDo1faEsXGo3qq1YBPBYl+8+Qi/b0y
         j4qyucQpOEbs3ZeiNgqTaexwSEGSxPfPDjVab5SYAwOh6ypV9dmq+KQRxWPKsYzjH9v0
         x88bQP9Zp1JFyEbsgCB01HP2qT4NzZz0oPFqKTlaekqACY/RL5RqbWfhVVFitQAjqw+c
         kF8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTu7gceYck1OnD73jJBkfqFnGO5m2VWsJPpmECM0kh0EviMWkHaXtjBtX4FQfUO4YbXJJpzSJMs901@vger.kernel.org
X-Gm-Message-State: AFuF++mZ/lacPlr2HLKLdYRjjvAQnH1f/OHkwZR5LgUfTu+469bhmlD+
	FI6t10lEMg6qACnylifVdlETd9q6kLO3eptaAydnuBilHNb/1e0TD89D7dEf9aILZ+I=
X-Gm-Gg: AYBFou2ab0axQ3A34867MSZyf9HbnFDgriTsSg+n3DgaekiyeJ1fPQLFSR0hV6YKrxq
	tRGIKu6UZGnMOcMr1PtNjwHVCFHQlO+no0+L0OsGtz/Lfcrh2sLPKmFXaZwx3W3F/ddfs+IOeLD
	Bf9//AI4cS1kx17UsH52ocj2NmBwmXZpa+J27dYzXVsm4yfo0Osk/ddhZPEWa++TUwO39KGztom
	x6RP/76DY4YBLABKDFbO8rS78LJG7YBTETAjfk8AOe5zwY3jioVsT5i4F1KtoeOEKeZYDrdYdcU
	DL5wvZ3vcJ1uQVbSeIHUKjT1b01iu5MA7nfWGhX5QMCZ3yhojG4+XGg4U76bRwi1mdDcPSbeleL
	2WBteL7noDtq0nj1CeRgBktbESXl367AJZI0R2mrtOIIZkb//hEcX9Cc7SOX8Guutx6QVGueyXi
	MwwYq7NPlpifHOIbb0KFwdGKVQmbqGqmuMo8ZJtRRwxY72S02piZJy+KdujK9h5ZGH7lH8BU1SM
	lmLFaIERSCfjQi8dGLGdXXgCzMa5BU8SpXsnlyVIOdP2doDV7D7ifvyl7lwgD6JlVWxt6onPRQU
	mQ==
X-Received: by 2002:a17:907:a893:b0:c1f:1520:4de5 with SMTP id a640c23a62f3a-c260c66a8demr277059766b.1.1788534188160;
        Fri, 04 Sep 2026 08:03:08 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d6e1c93sm122438866b.63.2026.09.04.08.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:03:07 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 0/3] ceph: don't unregister an MDS session before removing its caps
Date: Fri,  4 Sep 2026 17:03:01 +0200
Message-ID: <20260904150304.49104-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_session() removed the session from mdsc->sessions[] at the very
top of `CEPH_SESSION_CLOSE` handling, before taking `s_mutex`.
Between session unregistration and remove_session_caps(), the MDS rank
has no registered session while the old session still owns all caps it
was granted.

Any concurrent filesystem operation may walk into that and the next
__do_request() call registers a new session for this rank.  Once it is
open and the MDS issues caps, ceph_fill_inode() calls
ceph_add_cap(), which looks caps up by rank, not
by session identity, finding old caps linked to the old session.

The list_move_tail() call then moves the cap object to the new
session, which is already a bad thing to do.  Since it doesn't
decrement `old_session->s_nr_caps`, this quickly triggers:

  kernel BUG at fs/ceph/mds_client.c:1959!
  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
  [...]
  Workqueue: ceph-msgr ceph_con_workfn
  pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : remove_session_caps+0x2bc/0x2d8
  lr : remove_session_caps+0x74/0x2d8
  [...]
  Call trace:
   remove_session_caps+0x2bc/0x2d8 (P)
   mds_dispatch+0xf48/0x1b60
   ceph_con_process_message+0x74/0xa0
   ceph_con_v1_try_read+0x3a0/0x1510
   ceph_con_workfn+0x260/0x460
   process_one_work+0x168/0x3b8
   worker_thread+0x1bc/0x3a0
   kthread+0x118/0x1e0
   ret_from_fork+0x10/0x20

That's BUG_ON(session->s_nr_caps > 0).

I was able to reproduce this reliably by delaying the close and
starting I/O during the delay.

This patch keeps the session registered with
`CEPH_MDS_SESSION_CLOSED`.  New requests will be put on the
`s_waiting` list where they will be resumed on the new session.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2: skip CLOSED sessions in check_new_map()
v2->v3: split session pinning and stale-map guards into two preparatory
    patches; rework CLOSED-session and export-target teardown handling
v3->v4:
- replace "ceph/mds_client: pin sessions while checking a new
  MDS map" which was meanwhile superseded by commit ee611a750955
  ("ceph: fix UAF in check_new_map() on session freed during
  unlock") with one that fixes the remaining UAF bugs
- adjust ceph_mdsc_reset_workfn()
- serialize send_mds_reconnect() state transitions with session CLOSE and
  prevented reconnect failure rollback from overwriting CLOSED.

Max Kellermann (3):
  ceph: fix use-after-free in check_new_map() after early session put
  ceph: stop checking a stale MDS map after dropping mutex
  ceph: don't unregister an MDS session before removing its caps

 fs/ceph/caps.c       |   4 +
 fs/ceph/mds_client.c | 214 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 179 insertions(+), 39 deletions(-)

-- 
2.47.3

