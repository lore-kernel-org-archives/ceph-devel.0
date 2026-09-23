Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208E44D00D;
	Wed, 23 Sep 2026 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150907; cv=none; b=lTZ9WysXR7HIZFpsbbzRs7E/Qbt0dIh+CntIgiXyGmqKajsxmiqPlQhiynkhYXZGTeV2hIkEnQKEYc2+TjbkdQ7wZwPO1yYAEwRsmwjVapkZtPWXt1uJk8c03V2gYfwvx7kv1W6iteau3mPI66ZZCsnxpfBmhZg+W1Sd2AGsehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150907; c=relaxed/simple;
	bh=L1dNVP/nVc+K5lHjqtGo2yNq511ZXqNmXEi+E9Rrics=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IkdVtuosLzjaqPdh8oMQw/l6j77a7n3MZAk0QsAN7cXt8XVrAUx75tN1cqTX1EUMpC85GHMHlqwU1bBDwmwqjsDdMbcuZ2oVvV/5Nq9XLcBeixU0HNjp7CNuR3+vFZyZk6CG3AyMD4NHfThzziYLrbTaBVgtFllUezIRWcnHtb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=NwYvI4qS; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="NwYvI4qS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=y9VsGeMwH8LrO1CfT/F1sX9FelthI44bVHLyciNcphw=; b=NwYvI4qSFOs7YcNeAsqmygkASF
	lV+crXoZMHI+i7dLv8iATs1bv2EabQ/bTKwUKS5ygHXvuIAPzA848are0HVQdO5NVgA0+bPPHSzqq
	z3g442B7IkVKmOrZz6OmZiebxViabOVXhuSstAoLIiPIfLuMpE/larxUpTpt081rf09MMtQcedqyo
	kEk5kloR7Xo3pjd3D6Qb3HMNhesa4NKqqoSZGsuMXE5nO1TDYBs8h9yowIoWQJQUWcrnDIDuWaR1F
	ppruY7sk5D7ce0GiY8iOfPMAMpaZzCUi7tTqwE1HCjHVumjbP25Ea1Mp8Fg/GpQyA6OA8TjsMdVhz
	kqeOLYnQ==;
Received: from [151.115.150.205] (port=45614 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1x9I1Z-00000006sct-2Brg;
	Wed, 23 Sep 2026 10:08:15 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] libceph: fix out-of-bounds reads from repeated CRUSH bucket entries
Date: Wed, 23 Sep 2026 08:07:21 +0000
Message-ID: <20260923080720.1680210-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

decode_choose_arg() assumes that its destination is zero-initialized.
Although decode_choose_args() zeroes the argument array, it does not reject
a repeated bucket_index and can decode into an already populated entry.

Repeating a bucket with weight_set_size=0 preserves its existing weight_set
pointer but clears the count. Placement then reads weight_set[-1].weights
and dereferences the resulting pointer.

A malformed monitor OSDMap triggers this during RBD placement:

  BUG: KASAN: slab-out-of-bounds in crush_bucket_choose+0xdd1/0xf90
  Read of size 8 at addr ffff88800290df70 by task init/75

Reject populated arguments before decoding another entry, so the error
path can free their original allocations.

Fixes: c7ed1a4bf4b4 ("crush: assume weight_set != null imples weight_set_size > 0")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/ceph/osdmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index cf34b35c9a90..ac0027169b06 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -383,6 +383,8 @@ static int decode_choose_args(void **p, void *end, struct crush_map *c)
 				goto e_inval;
 
 			arg = &arg_map->args[bucket_index];
+			if (arg->ids || arg->weight_set)
+				goto e_inval;
 			ret = decode_choose_arg(p, end, arg);
 			if (ret)
 				goto fail;
-- 
2.47.3

