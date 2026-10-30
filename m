Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793347675;
	b=3u9H+Z/lwXaFIciKFOm+Z3iQdPYd/zPFxN333MQzgv2POYhE5M6vgurJnRyFXZX+iT2N
	 4i9oDrZreSgtW+X7BJ8BQ7Lvn3VFxTYwNct23JTgbTs95RqPos5Vvq2T1b30VLMPWd5Sz
	 /KnKPIVePEuayyW9oC2IFeP+1dgfZYswS7WPoDcaTTzsTa8B9LqpWX/wBuPXfb4HMHiqy
	 DtRt4ya9FhAuNX3kaX/9r28D15iu0lvtch/VUpBDNoDUYw2Oez3oTCKsIx3pUKj93i4Vf
	 w7jyGRORttvI8gJK81Z/W6FRQ+ZptQ33Jjq/6Vc16HCiXhCOyNgtDeOdP2TKP7t9VNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347675;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	b=MwiMd6D5AgwXK9sQ95bOeNgGD3cJtXYzIm3yoeFZ4E2q0sgjLeePCm9RG17SPQSrko/O
	 vJp5LEW8VZVsr9pPWhhqmdYrMgYAHDPNcrCS7PdTY+MN0asTBxPLbdPokfJziJfHDzEoY
	 RVpPzCQ6UE/AmBvJj3aMPqGrygN84Zx22f9lOsDy11gFZAIIgCtzEoqG3fnRDEfD6RYzm
	 x1+RI7r99RFrEl+dmjn+o3bPJOY+G/IJHKciBNDd4JH8JcdANXIXqAQAhtYVBg6+dMm2t
	 gz4ckQnvtZD6pIiDb//HnoFo74S4uCtxonVWo4Xz5f74dTVxzRcY3N1dG/PxvpBXyuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwg1K8Pv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D68606A322;
	Fri, 30 Oct 2026 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bwg1K8Pv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793347674;
	b=sEcvDtmEE1nkVFWOS//3neu1GFv4F3AZ1ArdiSovWLXMj7EmTxoc2amutlMWuP9Mt+vs
	 tBoaDk07UXKvH7IyQb2syzhxzp39jqOLjNaMPWp9ccQU1LOPvw5p7LC60IEMCgR0FgOMt
	 6e8JGJKFZ/ZbSd5zYSsHyk15kaAKcFlzLuXXhqH7oIElrhm2bYd0SWPF1ZP/ULiwIujUY
	 aBwFHjACQwEAbOw5AFIhOMWu632Z9WM2/+SSfH218c2UE2J4rDQK8Mr6evxTlTJR5yTaB
	 CBAC2KigE62dhSZQVbWF2CskIYae8c3Ek5ILCe3kcbjD1JgupWgyMWy8eIWeL+HrRWA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793347674;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	b=GYJcu26yNXSLwW81Qplx0Ixa6c++/8iYyPCI5lKfS3+iVZYeDypjbkSE24+axFocjZZ1
	 HusejOf+GPyanUiTzJLJWREJHd435K3rixkGi/UuHFP10TiqgJOF5rQyROnSkYWJax9p3
	 G8loV2T71CNSPgQrBHLdByC+hqeyJIA1bkf7nW70LQjNLqTqAz1yTOL2jweMFZLFJj7MO
	 L5E21y/PMYme1bRPWjr3wIhO+E09ndmI8TlXhDxNtopiNy2alOR6gyi7rh+Hmb7Jwhudx
	 ffBVHTX/oEqpw83mGspo40ODic27sareUj5B6cV1GGzizQtJ0rM8NcAdxRXFa1NaXqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4BFB11F00A17;
	Fri, 30 Oct 2026 08:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347674;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bwg1K8PvryYXZZgLkfauL7spOyxahNuS0VtIYDBKeH37EbK6pt3Wv+flEB1XSHdl9
	 WSopkXsOIVwl6zrIyRBDOlnbkRHIIDag0SXWjXrIpvCj5ZlJVcXG+WGhP+qpQ/kEe4
	 oIklcpxGjIY8HLVzf8iwtKL2ypGpx94Tnt+LeXIeYOdvCN+jDUHRdodOQJQeWiAVIk
	 LMAc1g7fXZDvRf1yfl4r+oet00sZIY9pG5u0k6ljt4n19698OAmTBRnHqGJXU6x0Du
	 YJe/Yr1nd7IGboofAupVUVzJaKewLj2xzmAUXgeWJbv+6p2NmTpaOg27i7+OtOWbO5
	 QhCLkGBsAgpjw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CA81A436DC;
	Fri, 30 Oct 2026 08:07:52 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 30 Oct 2026 09:07:37 +0100
Subject: [PATCH v4 5/5] ceph: keep LAZYIO with the read caps of a closed
 file
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261030-b4-wip-ceph-lazyio-fix-v4-5-f734a26bbaab@clyso.com>
References: <20261030-b4-wip-ceph-lazyio-fix-v4-0-f734a26bbaab@clyso.com>
In-Reply-To: <20261030-b4-wip-ceph-lazyio-fix-v4-0-f734a26bbaab@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793347670; l=1563;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=vCRKa1jTwTRmyvIPqElXVacQQHdBR1gNvKu9DI1jLQE=;
 b=AAKsSDEVpRVRCJek6P/no7bgd17eiCjmHzFCKyDlvStwBzV9Aw+cipkZ0bPZSdOd7BEogo13g
 LDY+r1EFzIGAVGzAA25emvIiTXXJbt9z2jJZ2al3vfXogP62C6Wu5OR
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

A lazy I/O open of a file in LOCK_SYNC gets LAZYIO issued along with
the read caps.  Once the file is closed and its wanted caps lapse,
ceph_check_caps() keeps the shared and read caps of a file that was
not opened for writing, but not LAZYIO, so it sends the MDS a cap
update for every closed file only to give LAZYIO back.  With the
lazyio mount option, io500 mdtest-hard-read sends about one such
message per file read, from about 60 seconds after the reads start,
and the MDS serves the reads more slowly while they arrive.

Keep LAZYIO under the same condition as the read caps.  The MDS still
revokes it together with CACHE when another client needs the file.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 49e5c1c36b68..aca09351a094 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2266,10 +2266,13 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 			/*
 			 * keep RD only if we didn't have the file open RW,
 			 * because then the mds would revoke it anyway to
-			 * journal max_size=0.
+			 * journal max_size=0.  Keep LAZYIO with it: a lazy
+			 * I/O open gets it issued in LOCK_SYNC, and giving
+			 * it back costs a cap message per closed file, while
+			 * the MDS revokes it along with CACHE when it must.
 			 */
 			if (ci->i_max_size == 0)
-				retain |= CEPH_CAP_ANY_RD;
+				retain |= CEPH_CAP_ANY_RD | CEPH_CAP_FILE_LAZYIO;
 		}
 	}
 

-- 
2.53.0


