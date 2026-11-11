Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413916;
	b=xivyj5tqRPwSvLNZNer++wGYEnMsyrX1M+iDf+TnXNUpGPmliIrEEDQDlGOttJMcSAr3
	 298Z7GdwSe5jaPz27khviO/Ae3jirKu4QlaVreJ66E8bOx7yfk7hXuWmq/OnjoT1/9J0M
	 pu4UY+ATY+wVnfsXSAm3IYHUYbNxOqz/UacIkFGQdqbNO3z0S7EEi+edo1e1159dqKHbJ
	 r6IPjfdBSfKoXU6Z83Qo8mUYVHkrYhWafjZfIFtlJ2YqMSiev7jdHC546w0bsv3FbM5LB
	 c69V861uNL3siyNyljVunFobLh+39OgZzr3bcTLUy6HDQfzlcqkyaI2rXdv/Jj4u8zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pYaVqWRfVMO0uhb95MhhUmPfOL+wJE0vw9tIEmvoQMU=;
	b=5B/Tu+Fl5twxHdpR37EVa3A/V2VKKuVrfhS/WxK9t1Y11u8XTnk8uzTlMXV3sIvrNsKL
	 /koLXQEeMI5nIyBMcl+qSM92GNQB5i4FmL/r7H9eKzoVrw0p7PeTXAiUS3M+8Pu8QWvy5
	 plsdVLdrlkwdkyz+3rhGnBlZSBvZsW4P8XXtghMqnAs/TsYuECKVia6+pS9xu4fIgnkwo
	 lRHQ5Bpark6i0M000cR6rlRbCpaLfM93albEcCIfp8TNs6RoXgayMp90yPtTsWpQ419hh
	 7TFQoM1/mxrqbeA9vtlU0EQuDRsA9N17FjiDuSSZvu4AFMOIr6eEMCEaZhYHQWCeSOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=Rwc5Xg7p;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C66606A32A
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C66606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=Rwc5Xg7p
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso32071855e9.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 08:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413914; x=1795018714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYaVqWRfVMO0uhb95MhhUmPfOL+wJE0vw9tIEmvoQMU=;
        b=Rwc5Xg7pOzJR7tJn91gyQ+7iHZOO1AkhGOyIbokAGQB7iwuy1rDutrIgH8HWLCj5U2
         FRxt62Agv68Xt/BwXY2JVslgR7sN+xb5xZWyiGeqbln29nva+H2xWYlFTmkDQRnvkXNh
         jRqR0ypCH5Pp8NZHKYOlVwNhj09wqJDmivf8Sa4+hfWDMGAOy4nZrGSPLhhSPsDxjCJ3
         bMiPMWUY68s13BiZngXpRlpwIs7s73+jJmVb8p8WDYUEFptoN5lm7GcD2Any49M6EL8/
         HV701N3DNqfIuERDhulzdNY29glm/i2QqkHZB4SpMB90xW0tbT+OmjiQDvNL8N8dLbRc
         y5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413914; x=1795018714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYaVqWRfVMO0uhb95MhhUmPfOL+wJE0vw9tIEmvoQMU=;
        b=F4JBYxliCv3dJWwQOOVpeIODXnRXT78R8nYog0PKAion2edZFAHoiltowsPDtYiQQj
         SYakJUqJGmIuRA8loF3eX8OTioi4TzdaBPBMLHuajGFdauRwJE44Pe1qd2F3NMYnrRBh
         16PDfDHUfq0DHtVVCyNll++YgVFNPOEQqUb9emC7gPTm3KqjV64zWgpFFbT4yurPF7lv
         kYhbvEhfuDIfeOJawnpHQawVBVv66YUT5ItPhJXlwQ+7mT1C/me3ntOQjsM1y19UPDI0
         IKC6gDht/5yjwu1GuW01EHav6/XcNAuZsX46Bqv5z1M1P+KH9ANytnV3GdUl6/xG5WCH
         Ph3A==
X-Forwarded-Encrypted: i=1; AL+hErE5rUijXUT95tbL45qVA4aiTB8OmXTd+M1BY1itMhrVwDc4Hm1UO1Q9wLDvvht7hqYy+D+g3GHh8sFU@vger.kernel.org
X-Gm-Message-State: APuU4Z8GwYuC3uq2U/F05IAE0RaxHJ8LZsPsC6l/hFdsdrq/pbBsZzzC
	nMxjNYTGq3N6wKp8v2bH0dc9FAf5oKeGgMMf/xBQMeNmbQDT3PnGyZmlqI7Q4w4TMHM=
X-Gm-Gg: AYBFou0zLKO7q9tq28xhYRO1uw0aMQuJtHGtvn7OHhY5vplCtu8Ymre7aH3Cc685WYg
	xQ+bp3VonE3Otddgvto+Bsy+21hf8XAeatlFtQsvDDrG0MFi3Hacec+w7VlrzGhvNZ8KEiuyhvw
	8u3+B6w1VIAo4LmCn8CsliHDkO9E5bPZ10l7ku51lBpw7zw1SCPM8mdwrwLAYmAqAufz3IPrLC8
	b7S0ibKNIFNwEX0cb8QeqrMnOo7CO6hRmunk3c6wfCQqm5iuqkQ26DJ6irniueff2FYbIDgPhWU
	yrZv23eQ31zyvn6qJXHvZvUikMwUZk71W7kxOBZ/9sH5iSZv6b+WvqwzSvg8i4YRD1p5y+t7G3m
	8UIVeiZVtASJIghBDPsGhvJgWZggcC8QEzfAy6bn5vx+PPBj/r6Oihost8i592QOqG49esDM3DG
	W+npTPyWc2tvYB68Oa2UBBrv7Sg4rjjkJvdR2jAFAzeqJCAjxXCZOp/Lwth/9qWj8/2Yp57p0ud
	W1uYhEPDQaOwG/lenpNNJRWaqsioIOZUDR8pwcYoSlLs2ZRrOBS9pGVdxyjnG/gt3/ODmweliS4
	UbkgoWQ+ZJIl7bgZUdwnzy+Ivt262qzObs4bEti190Q+R4YsCYB42uOe4oKFfmetuVaiteHDFgH
	YQ3Zt7uh7IvHdGkBp0Kinaes7K5SX7A==
X-Received: by 2002:a05:600c:8b34:b0:4ba:e7:ef3d with SMTP id 5b1f17b1804b1-4ba09321cbemr52115015e9.1.1794413914216;
        Wed, 11 Nov 2026 08:18:34 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:33 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 0/9] ceph: fix mdsmap and osdmap use-after-free in unlocked readers
Date: Wed, 11 Nov 2026 17:18:21 +0100
Message-ID: <20261111161830.1336485-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MDS and OSD clients replace their maps and free the old ones
under a lock: mdsc->mutex for the mdsmap and osdc->lock for the
osdmap.  Several readers dereference these maps without that lock and
can therefore access freed memory if a new map arrives concurrently.
The worst is ceph_statfs(), which any user can reach and which loads
and dereferences a pointer from the old mdsmap.

Each patch takes the lock that protects the replacement around the
reads.  __ceph_setxattr() cannot take mdsc->mutex under i_ceph_lock,
so it uses a copy of m_max_xattr_size kept in the mds client.

The same problem in ceph_compare_options() was already fixed by
commit 19db525816db ("libceph: use RCU to protect monmap in
ceph_compare_options()").

These bugs were found by code review and have not been reproduced.

Max Kellermann (9):
  ceph: fix mdsmap use-after-free in ceph_statfs()
  ceph: fix mdsmap use-after-free in debugfs mdsmap_show()
  ceph: fix mdsmap use-after-free in __ceph_setxattr()
  ceph: fix mdsmap use-after-free in send_renew_caps() and
    renewed_caps()
  ceph: fix mdsmap use-after-free in mds_peer_reset()
  ceph: fix mdsmap use-after-free in ceph_get_tree() error path
  ceph: fix osdmap use-after-free in ceph_sync_setxattr()
  libceph: fix osdmap use-after-free in ceph_wait_for_latest_osdmap()
  rbd: fix osdmap use-after-free in pool lookups

 drivers/block/rbd.c    | 13 +++++++++++--
 fs/ceph/debugfs.c      | 12 ++++++++++--
 fs/ceph/mds_client.c   | 18 ++++++++++++++++--
 fs/ceph/mds_client.h   |  7 +++++++
 fs/ceph/super.c        | 19 ++++++++++++++-----
 fs/ceph/xattr.c        | 13 +++++++++----
 net/ceph/ceph_common.c |  8 +++++++-
 7 files changed, 74 insertions(+), 16 deletions(-)

-- 
2.53.0

