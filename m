Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794019891;
	b=otZHrWZN5JsmEP3Pt1itLc/kM3St8RNpfF+qS0fkd7ewp+371Zs04jpzzDzdyVnzM66E
	 2RlAey1by4XJdjvOVR5GJrS/KcAWpbewCSdyfqXYS/pNL04x1Ihlhh7thhRV1o+hVEzG/
	 fVSenoJA8GqI9esSx7ajKL4fOI5wMOP5DEL/GmB1+uDHT/i0r6tnn8fvBI00Df6FvWrf4
	 smHLr8Kzu5xQ4DusaXjPJres6JL50/RWQslmOyCOumvU5BG86G6IQhGe9xafTJJ1sWmK0
	 Uu7fD/8OKs0HWW685ekqCJsAA8XPXPGt2kWdw6vxj2MkWVa/aV5j7yU3gDOqURgIv9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019891;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xV5tb8fmJXwJLXpv4sdYEGIbHi2LQtR9BW99TKy5YNE=;
	b=Z85CG1cDz/eMNzXoCGsg/tLi+j3CXpoBwcXvSamOLsOlkGbmem3YFAndYNhHVTmGeOKs
	 graVxsmAu0ZWU1BukKB7fKji75buy6i0FNMjgpOv2Rn+TG2JozC2yXKUfF0f2rP5vd7WS
	 QbtvM7MO3DJINTttoAxnguPD4TR74K0qFcgXkZs3yL3tL3b5Hy9h4ZNZzXqc0ogpZXa7x
	 SEre8dtAmCMxpZ11evt5ICy6qMWRj0wMzbUM4yL95wwKBNjqMlbjAgJZY+409kTvgnHt5
	 v0W5813g6X69+HxbYzxum0ZOqvka4mwUBCAcJa8jU1euotbUGIy1n/DLX9IBsslCrqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2Ujtmx9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA4606A32D;
	Sat,  7 Nov 2026 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2Ujtmx9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794019890;
	b=GpM2ufI602Y6YGLytBWGPqtGuGzBk1VpvAc4bZKgLYLEJ9DVOQXMHYPBEnkG67DoPNAG
	 VGqzkEfdHS/S5rZhOhZtoBMWkqGurXaWUhpVwNjTeQy/PidQ1MesBVNF42NRuCkIkhxpw
	 SfKxj+zMpUE3GNgWrMg78qDRq3+sPk6hZ8c11z2byZnhfisrNgs1tZ/6cmgWzKhopycmD
	 ghJUJPoAqum1xrKsTQ49eUgPEuayDGwfoQPVPrEFPfx94LkcpxdC45GtS/1IXfOWkkjxB
	 DzxTx63BljDG/ymdqgWoxWWPTUXJwadoNIx0c3JLKd1z3ioVmGVfNBo+hs4LoHW4/OA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794019890;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xV5tb8fmJXwJLXpv4sdYEGIbHi2LQtR9BW99TKy5YNE=;
	b=ARtTHdnoAoof1XdTi6FsBturlhjZmeKtXLjx/64uYabPoQm7pnBCHa5uqoEpaUTpO+Bq
	 kJvJKFQhkfQ8DSvLMxxhk05/RaDpyFn/IUqDvKhst+8OIn565LkxRNxAKCQK4y4XJF/gK
	 1aQihjFZrkWU7Dk2qKZGuEfPmj1FFBO2Vqwq/WcWhZdhenhnsKhwK8NWTdUqQoTOpkubw
	 6hKdBMgnhApm49TNTpjcmvo8ZYXssUnB6bv1EcSF9Xz76yG1JAsDmyupz+9GRdrh/9WSr
	 plYkZxphj0I0oQRvt/Mw9rNK1BB24pwjVZRiynZNnkAMgP59/YGLyDgwctKu4ZuQTvA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 440171F008A3;
	Sat,  7 Nov 2026 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794019890;
	bh=xV5tb8fmJXwJLXpv4sdYEGIbHi2LQtR9BW99TKy5YNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=E2Ujtmx9k2UbYKR4nf2EZw9VSXlJ6PUlb2nM4UpP71oXWmb8hT8HYked3s3yS3bBA
	 cxk5Ia4v9WcsaIpOaWMzCYQa53ex6yyap3A2Q8b2QCe70AN00bMJR2+Ctny7H+ggaV
	 Cq/mkqQ76umdpvG3K7GlB/zdWDLOmbnU4GHlIt9uFtEaS85cOvYs7tFDRcmfUavMnO
	 XAeFKomYHXmwq02ENxfMas7m1Bo2KUXqhLdlSDoR8tfCWHdfh1V7uIeF8Ejhv0bZ9b
	 c8tWX/xgX4Q4b3APjkzO4RsAujlFhPrrgYrb1TdSQVMNIingveELy1oKRtmAzc/UH7
	 QcSCZ/I6BMeWQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AD07047A76;
	Sat,  7 Nov 2026 02:51:29 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Sat, 07 Nov 2026 03:51:28 +0100
Subject: [PATCH 2/2] ceph: do not hold a LAZYIO revoke for pages that CACHE
 covers
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
Message-Id: <20261107-ceph-lazyio-noread-v1-2-d04369c70ab7@clyso.com>
References: <20261107-ceph-lazyio-noread-v1-0-d04369c70ab7@clyso.com>
In-Reply-To: <20261107-ceph-lazyio-noread-v1-0-d04369c70ab7@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794019887; l=3142;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=Sl0LxPrKAtHetqfgc/TKI9v6Rg/tbvwlkGhYdSOWqMI=;
 b=bw9rbPPEQieegybJkeMG7glGLYFOC+04SaXe7t3wbwxt9taaR+MY8dEqxARA5+e3xgsoHNoCr
 XkOaBfSOTd+Dlrc3HslhIvrqneusNN5OM38S0kGQIG0didjCNYKc2YV
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

ceph_adjust_caps_used_for_lazyio() reports LAZYIO as used in place of
CACHE or BUFFER when that cap is not issued.  It does so even when the
used set does not contain the cap at all: with BUFFER not issued, a
file that only has clean pages cached (CACHE used and still issued)
is reported as using LAZYIO too.

When the MDS then revokes LAZYIO and leaves CACHE issued, e.g. from a
writer that has closed the file, (revoking & used) stays non-zero.
handle_cap_grant() checks the caps with CHECK_CAPS_NOINVAL and there
are no dirty pages to write back, so nothing acks the revoke until the
delayed cap check runs, up to caps_wanted_delay_max (60 s) later.  The
MDS request that needed the revoke, such as a getattr from another
client, waits that long.

Only move a use to LAZYIO when it is in the used set and its cap is
not issued.

Reproducer, 5 lazyio mounts: 4 create ~174k files of 3901 bytes in
one directory, a 5th lstats them all, then a 4th mount opens and
writes 5000 files of the 1st one.  Mean of 4 runs (open+write: 2):

+--------------------------------+---------+---------+
| metric                         |    base |   patch |
+--------------------------------+---------+---------+
| unacked revokes after lstat    |    7355 |      10 |
| lstat walk time (s)            |   27.69 |   25.19 |
| open+write p50 (ms)            |    2.70 |    2.89 |
| open+write p99 (ms)            |    3.26 |    3.53 |
| open+write max (ms)            |  5325.8 |    51.9 |
| open+write calls > 1 s         |       1 |       0 |
+--------------------------------+---------+---------+

In a parallel walk that stats every file with 4 clients and 3 active
MDS ranks, right after other lazy I/O clients wrote the files, the walk
no longer stalls on such revokes: its worst time over the runs went
from 90.2 s to 42.4 s, and its mean from 51.7 s to 41.5 s.

Fixes: 488ffbdd99d8 ("ceph: add 'lazyio' mount option to kclient")
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index aca09351a094..5669e458f287 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1112,11 +1112,18 @@ static inline int ceph_adjust_caps_used_for_lazyio(struct ceph_inode_info *ci,
 	 */
 	if ((issued & CEPH_CAP_FILE_LAZYIO) && !__ceph_all_opens_lazy(ci))
 		return used;
-	if (!(issued & CEPH_CAP_FILE_CACHE)) {
+	/*
+	 * Only a use that the issued caps no longer cover moves to LAZYIO.
+	 * Clean pages under an issued CACHE are not using LAZYIO, so a
+	 * revoke of LAZYIO that leaves CACHE issued must not count them;
+	 * otherwise it is never acked from handle_cap_grant() and waits
+	 * for the delayed cap check.
+	 */
+	if ((used & CEPH_CAP_FILE_CACHE) && !(issued & CEPH_CAP_FILE_CACHE)) {
 		used &= ~CEPH_CAP_FILE_CACHE;
 		used |= CEPH_CAP_FILE_LAZYIO;
 	}
-	if (!(issued & CEPH_CAP_FILE_BUFFER)) {
+	if ((used & CEPH_CAP_FILE_BUFFER) && !(issued & CEPH_CAP_FILE_BUFFER)) {
 		used &= ~CEPH_CAP_FILE_BUFFER;
 		used |= CEPH_CAP_FILE_LAZYIO;
 	}

-- 
2.53.0


