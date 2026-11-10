Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794312740;
	b=J8mjiFErsqDpnHToBVDeI5gT0mHcPjxWVBrihvj/Rk4z89rTmILVLU670vEdhVLyIzK1
	 8G9wZ8O3zsgJyPwzvJiQyRYMutGWM+yXLeiWQUbbYbThPiYglVzuIIxm9PKgyYF4c3w76
	 y+QvvY3X5WWgK/my1m7VQ1pSXPYVbzb6l4bP7MZZpAU2G4PuONa8vb5wec3g1s79wO8eA
	 55XP8KO9hs8HztNW1uVwM73CPGblB9QusfXXkmwCysaC2gAemzQo7r736uN4tnM6olOdd
	 tfzCDPAjtFfx/FUBHTJ3usvhEgBmGP+wZD2kBkvKilSlF2O9eDs9c94pm8YXxlUoJaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312740;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xV5tb8fmJXwJLXpv4sdYEGIbHi2LQtR9BW99TKy5YNE=;
	b=k2Vg8k6OL7Phok1DXt6LN+qxikc0EDmT8HPBjyuDRjtWg3Cyy128MAbb+OXlx/kVrI5k
	 f2UI1bCP/+BhuPggkm3jjRyHhpUJ4s81eFFYfYd8/+mimDXQ2x/60/eSEM9ueY+wqfLzN
	 Gd2MTy0p7/aMfPCwqyg8BXciDqjwRrREHUZVqYnimJg7AncS8tIaQv5V4GxBHk7xNM1Qt
	 PuNcLPzthqm1xBHATp1RtcTknpmco/5HqLL2uyfE1ntx+iLdBhy77CXLd/aRoP+JW6Eac
	 dBG9vMDp4kitzpWaJekkaE559vTNVfGiqxwjpuml/wstJvcSH1v2fzk5sULEYN4vEew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNtZtt+i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D6606A331;
	Tue, 10 Nov 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNtZtt+i
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794312739;
	b=han8DZ/vzMy1r4si85WFCfNnBhETVuNpfLVITfiADxlZnBblLA5pHXut/xf2YXobC8A5
	 l/3rSgM8iEL3IlexqfFKhB2WhriDTjfnDAs3tKXh08IhHRDQdr8RPVfihlgj9Kpnb2ABt
	 z1z99/vC3pYpIBs0AEWcyHj6WQNZ9jTkRt1HnTogb9l//DxrgPWZ4L0KKIHiGOmXKYmyO
	 tHPDaiMqOR0Vf8XghT3vhj3VOusCPxGzCFPL/wIKbSRUrmMiE++CZL8xHYrZbq5Jr67Kt
	 K7d00Kc+h4lBUOCMvU+5ArE25cyvnRcEEobcMKpGR7pnezmNOgog/qRBYzCmdbS2MhQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794312739;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xV5tb8fmJXwJLXpv4sdYEGIbHi2LQtR9BW99TKy5YNE=;
	b=eY2tbuV0b3fJzJKQP6my3PAQ4X/LJa5FT/xV7kmP8Sd1wTYA62JHM6mQIzVx2wXWuleQ
	 XSy81zA8EL5vE+aybzzZAycgvDAmfxuevHhCyAT5hmA7iCmTmZ8e+RB9HFfDPOq4fp28J
	 Mk+bs9SVNyl2JW13NGxPGwB9z3viiHqu7REAVaMI0MVkzYebv4Tp9fkHWdGAB1utkb5kH
	 R75KkNzzpRxzOrLxdSMuqviWDdn58atEwKOmZq/dWDq31X8ZfUiK3SynUHk/GIzy/fD4Y
	 EVX3ev24uzhQ+wDXd8unfxQIW0RfiHwiuhpJE9tn8X+kmlaWz6rZ+kzY1wSxmsegitA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1DC2E1F008BE;
	Tue, 10 Nov 2026 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312739;
	bh=xV5tb8fmJXwJLXpv4sdYEGIbHi2LQtR9BW99TKy5YNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YNtZtt+i/A7+78cjBYlc96G02c/k5F6gohC3Ox1ZCdEUeB9YcU7Fw41e+x28YV8Yx
	 +FXFiPBJBQxVNLVfEaZ6lxTLPTXKuiZAU/XVzROV9GJSSyymA5l4AY2tI3x0A7eWBr
	 JnJGWaCqCFaIvgAN9a8UL4EJvPclK9pnB90TCSRGKCRw25LzWCGdouA3fIVboyYHLu
	 JA/eyUxXnCE9ELmzHwAJH5yNVTkzV347dUB9gVbjKp1o2HXY4kCeERbmjYvPd8DR76
	 Buu7YPjN1vcYtjUl4WXmylGNUmChZpvxBWkqUeqK56rIdHqeb0QHmyNOaeXdGN9KIj
	 w4CJv1iHGbyTg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8D0C148B35;
	Tue, 10 Nov 2026 12:12:17 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 10 Nov 2026 13:11:53 +0100
Subject: [PATCH v2 2/2] ceph: do not hold a LAZYIO revoke for pages that
 CACHE covers
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
Message-Id: <20261110-ceph-lazyio-noread-v2-2-259775214b39@clyso.com>
References: <20261110-ceph-lazyio-noread-v2-0-259775214b39@clyso.com>
In-Reply-To: <20261110-ceph-lazyio-noread-v2-0-259775214b39@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312723; l=3142;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=Sl0LxPrKAtHetqfgc/TKI9v6Rg/tbvwlkGhYdSOWqMI=;
 b=oRGjDdp80KOgLWfgVhpTNHFJSYrByfMDdn4K2erJkJtw8iTqyin5FNJq/wsnk1EhjMnqkcBCd
 VsAJDgQNoOZDf7THRBy/8uNArNjHKNPLZ0mMKGpTzRl8ASqfFRim6j3
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


