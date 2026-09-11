Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F63939C8
	for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2026 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133503; cv=none; b=nOiP3pdMglVhWcxluuyFQuDqaZthfqBsShEn9gWw8Exe0c455mzMvBctV/iwsktMX4Jev/99CCLDZlKL7jrtPJWun/yXOjXB1b47phGxXL49JEWTgAgdODJgZIhDowfQippRs59Qhk7u50x2Rp3DKyi8qsuUxhW/C++gUr8wlWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133503; c=relaxed/simple;
	bh=ZppestnB/L/9h/jlv1SF6oIBtJU8mdjxcVXZv2t6Ldo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5hzWlxfZD4YUu1JcYOQJxxaPsJ6NypgYGjCZkPCjih+0GjPl18fjjwKCQkSzAywfFiPQmGD3Rt80X8OsvQsfqb2ac0kYXhRMjYCGYufF0NtCq0EUj0OppYOPVdYK001upovv3CoeuZf1wj+v+55FqvUYSjG89sbi5n7C42cCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guqYGqgQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guqYGqgQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso11679215ad.2
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2026 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789133501; x=1789738301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3EUyltHhlIzlcifnulrGVfpB7IyEyQBzKiFTuyNy3E=;
        b=guqYGqgQn5sHhRmhd8SFEybvQkfNH+VAVRiXmwe/35XSr+Qw6WCrD/F0A2HnPdCR1G
         gZSeSwkWUV1XA+FqpEwYwQpNPdvTlTw6CuSrfbaoZVs1F+GlxcxzFXBi9617Z+aOZlNJ
         oVxK50LitwLO3g48c7zgyut7t14v5PY+txJgZPaMyfKYFZEF2GSPgHIUCpFJaytV/K1j
         KBewl7JS4bxlHIdGm+Cw8iAi9yxTQ5s+28zkiQOJ21xhrWutz9bneTjbAalehNzJ9oDA
         r/oB7B85oYHM7usub9omoJeY2pw8qpzd2gk5MYDpT9/RlozKGphCd2XuSmFFcUoqe4TL
         R11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789133501; x=1789738301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O3EUyltHhlIzlcifnulrGVfpB7IyEyQBzKiFTuyNy3E=;
        b=RZ9VBtmU02Nz/QNahs3BtwpOXOucs0CB7j2syTqefL7SZwCeH2PB4A6ipLl3ReD16C
         WESqL5lVLMtZY2M6SJHrY0iKhMKigwbAS9LAAhY/zUDtKD/Kpt4jQdzKT2xuZa0Rvp1W
         /m0xr5nALDlccn9HbUxn/yZQWBaDFSx6rG/h79GtHtKn4djglDoyXJ6t0zwtudt7bRLL
         TPe6v8S0Nz0dDX0r7cMsoDzD5MgzJQaW0DQ8x5pzfxNxRWY52OnC4UEnyK1ofwgkjl1k
         adNE3KABQn2ZYLkYCEl25wYh2yMcoTFJvXgGc2jQzfuB7QUScbNHfFNSrym3nQSrpSJt
         Rt2w==
X-Forwarded-Encrypted: i=1; AKwUvByW53tpkrnFw0L5EiExUFnl2xRAdlGug1CWrvjihQvn85nJFS0b9lKlShCEW8di0D4zVoHzOys/rODZ@vger.kernel.org
X-Gm-Message-State: AFuF++n3ICIwMjg6+BrCPV0YqaqiRIkXnteGGuMXRrvGcIp+BP+O9ahf
	73EH8pcSMwaxFrFGg7Jd7mlbTyVzDgUFUKByQ9ndof6LZXzBCyNGPAkz
X-Gm-Gg: AYBFou0xqL04L++jZVeB9LVO8qOnfEPKm+yOz0mBAzv1J5vWNIaN/E5HrnlAYrIoyEJ
	r+xNgrQZXiMT6D5LPUe7SDe6lWk5yLq6r1SozAkQ0NBUoeuISjbfAa/rUgq5nAjuPhsQy1t9OFk
	qc7FafwzXLh3IAgBozxdTJ5vZrlkxT/3GaZlZ6ArejeEJCQG60AnHmKvvLbzWwb/FQ2FAlxvd1A
	FHZ+1uqZ3WDUX5C/Q6JCK7YuUwpvgGzKMB2RA8NJyfYriLh9F1tOfn0rYHBpEiGH7ZJwgG4h5bX
	kAnWsMz1840LcS6EoKcvk3YzCynQd1DZ6GAMNVBVaZ8DDBO/rQ1Am7s/zSluov9rOYPVSEjMVQ1
	FiRTB9Zg3/ZeCaCAw+75U5z6IW/7ct+qJNacD2MuM3E1p65wKSFnS2RrXeAZ3VKS/CJzMHVkqzi
	lLuoBB4g2fpIeoGQaa4plQMaIuNuCuMemQ3+4xe8kKbh/8Ap3KQ+fViUOVRhJDL0TA93NUOyjbp
	ylLMjmYC7SaMPoLz/Yb7AaO
X-Received: by 2002:a17:903:40ce:b0:2d9:599e:df95 with SMTP id d9443c01a7336-2dd2a1ce379mr80201455ad.3.1789133501529;
        Fri, 11 Sep 2026 06:31:41 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.135.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc5c7bsm11349015ad.51.2026.09.11.06.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:31:41 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+1dbed5969931c19d3eb5@syzkaller.appspotmail.com
Subject: [PATCH 1/2] libceph: reject an initial monmap with no monitors
Date: Fri, 11 Sep 2026 19:01:09 +0530
Message-ID: <20260911133110.2218-2-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260911133110.2218-1-yogeshgaur.83@gmail.com>
References: <20260911133110.2218-1-yogeshgaur.83@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

build_initial_monmap() takes the monitor count straight from
ceph_options::num_mon and builds a monmap with that many entries without
checking that there is at least one. ceph_parse_ips() writes *count only
after it has parsed an address successfully, so a ceph_options that went
through a failed parse still has num_mon == 0 and the resulting monmap
has no monitors in it at all.

The first thing the client does with that monmap is open a session, and
pick_new_mon() asserts the invariant that it is non-empty:

  kernel BUG at net/ceph/mon_client.c:211!
  RIP: 0010:pick_new_mon net/ceph/mon_client.c:211 [inline]
  RIP: 0010:__open_session+0x60f/0x740 net/ceph/mon_client.c:245
  Call Trace:
   ceph_monc_open_session+0x46/0x60 net/ceph/mon_client.c:534
   __ceph_open_session+0x135/0x590 net/ceph/ceph_common.c:798
   ceph_real_mount fs/ceph/super.c:1173 [inline]
   ceph_get_tree+0xd98/0x1fd0 fs/ceph/super.c:1362
   vfs_get_tree+0x92/0x320 fs/super.c:1947
   vfs_cmd_create+0xd7/0x2a0 fs/fsopen.c:231
   __do_sys_fsconfig+0x55a/0xcb0 fs/fsopen.c:463

The reproducer gets there through the new device syntax: an fsconfig()
mon_addr= that does not resolve ("libceph: resolve '127.0.0.' (ret=-3):
failed") leaves fsopt->mon_addr set but num_mon at 0, so the "No monitor
address" check in ceph_get_tree() passes and the mount proceeds with an
empty monmap. The next patch stops that string from being kept, but the
assertion should not be reachable from a mount option in the first place.

Commit 40480eee361e ("libceph: Reject monmaps advertising zero monitors")
made the same BUG_ON() unreachable from the wire by rejecting
num_mon == 0 in ceph_monmap_decode(). Apply the same rule to the initial
monmap, which is the only other way one gets built, and fail the mount
with -EINVAL rather than assert afterwards.

Reported-by: syzbot+1dbed5969931c19d3eb5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1dbed5969931c19d3eb5
Fixes: 7b19b4db5add ("ceph: new device mount syntax")
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
 net/ceph/mon_client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index c56457378d00..bcbcf47506c9 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1141,6 +1141,9 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
 	int num_mon = opt->num_mon;
 	int i;
 
+	if (num_mon < 1 || num_mon > CEPH_MAX_MON)
+		return -EINVAL;
+
 	/* build initial monmap */
 	monc->monmap = kzalloc_flex(*monc->monmap, mon_inst, num_mon);
 	if (!monc->monmap)
-- 
2.55.0.windows.5

