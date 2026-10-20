Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792483571;
	b=rjwiCIT6i5xON/hCJeCKS8w8KhvpVNemKdVjrkt8tB3BEy4NuJwZht2LDk3Iq/rsABWX
	 AEqem8ctZaKdPoVR3qJcnfbW534Dnk09iIBMm42Y0ua1Ws9+crFN1YyQFUENnj8PYfglr
	 1D1rM6HfPwzKoSijzBw/ovXQWgZdgxe0T6NefOGlFk/WTojNPSsGuInF1X6bY9uwOFTQj
	 GIMQkKhOUpYQGUYPe5h7X1LLaueowYOPgp0GOj1DLIeUlLvofuEXriwxqtd6jHGa72XoT
	 MAhqDz4mPx5OTF75YFGoqN/Pq2SEh3ISmMGXJ+c/4OrbisK27CTI7+QurfnCXpE0Ifg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483571;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	b=sZtRzBYsVSDNfM7A+0UJzlBU9TOYpFtFgcnVCiB/W0cdpDm4jucxKt7LOWyhyme5VzC2
	 cU9QzLu5Uc7nVvUWq0NYPPzNOk6zQBL24zx5fMjX9oGw1BCfjVmUtnx/fVFQpCTWHOdZB
	 ZmitC6IkKZpzcw2bUSUhMo8tRsO5DOXfrPlTUIAw5vtghvCEDHQD/vpcjqwRYU4dGyRAR
	 9Zz2p4GHss1muPS1M7wYUYKet/MTMymv8SVq61Gy2nC0SeuTN+BLoK+BWjyckHm+Lqif7
	 i7NCd53KxFjN3132a2qeXoR1tG+Ew7UDZXM9Ut0Cofz3C8poiF/1Oz1XpKujk0ClbpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrdZ6hWj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BD606A320;
	Tue, 20 Oct 2026 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrdZ6hWj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792483570;
	b=X3y9vwiHM9kSu2bDpoSbmWDD8hAJ8gHo4E9J8Q3Daw6bCOKcSY/y27haorgawf0lGlMY
	 WCyi6e7qAQ9pAnpK4EZPFKvFD4yA94bSx6abp3kMrK1XqpxdGofzOIl+cHqxbeU4jMhyh
	 9tHRkYri3Ztdct34alnnzWJLTLwUuKjsrIUzznDsgKvUuXEgSEKNzP/C1lhBRGUtxwkp/
	 w12sIFHnJo9Rd4mDIawGUkCiYgZcn72Ru4ZF5RA0t9hfwCi6IINXL9tnQ1Rg5i2tRFHpn
	 9BFuLbPNYDZFqa+m3za61dW8ADxWmOoeaCba6HL9N60g6cjLVqD9L41sq9zhFq9847w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483570;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	b=PoPlE4B0CuOW6+Lzc3X367wTKgxBGW0rek7YPvBPQklg3BXcG3exVXy7km21692pwEA5
	 EDZxXyFwSUTh9PVavTX708zD6VJMKFx1cF9y5xrSQsXmj1oGbwWqkqdzRrWRjMgXg8s22
	 wQQsXFnSvjDu3amAuCjGltU2oXROOWubdL5BgqmCwubZp3ta3fgAF4r8QjUO3xZlK1uqp
	 pG4HkI4uXd8XeJ2Y+p5DA6OqpgwjdO9fn6oxBFwDgrBgq1g72EumOvJNy1vSxgEo4Sm6i
	 dEvbzvAdkKO5CmRlkOxR9b/qB4umXZDQ/LPI2NOLD7VmYFrtUddsQzHwk8hjVx+njow==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E12D01F000C4;
	Tue, 20 Oct 2026 08:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483570;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VrdZ6hWjH/P9RE79BbLPKaamfDim/9MQtL2xxBXhg5QdKQnfxgQpQLb9+Hw9SYli+
	 LOq44JA2gbCzquAmlQ6rfrnAccEShUMplpqrWohD7fR2IhEyvIjAycnPTlO17GcFqZ
	 V44bHBZabx3qwGG4mFI1hG9rw3dOg6maLtFjGl6heRd12Uwdssv/W1Na6bUy6ceUvw
	 jy17uUVP2SLpKeT5xHsXqIC0HYy8dPrnbMy9WBmSjghxuBtxAPPQBGfqJeUcEXPrev
	 ggkaE8bNL8sLOxaz/H4WVuAwrg4NOcOFT3rOPjZ7bUE3KyB5XsBGZ3auibKx5afLC7
	 yZwPAvjlhlGdQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5C455430B6;
	Tue, 20 Oct 2026 08:06:08 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 20 Oct 2026 10:05:50 +0200
Subject: [PATCH 4/5] ceph: ask for LAZYIO only once the MDS turns CACHE or
 BUFFER down
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
Message-Id: <20261020-b4-wip-ceph-lazyio-fix-v1-4-f4cc62459d37@clyso.com>
References: <20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com>
In-Reply-To: <20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483564; l=3543;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=vM1YJ8Qdb6EoK/7Y+Z2XaIpcesKUcnEvtBTos7L2Q+s=;
 b=AKK4OdZXxriM/rdAq2splM2MD6YPQeGEzL3R2a8HqP3mg61t++9RgOSEncKUR/eca80XegfMw
 0+OuT+nwJECArMgic66FZDqCBdPhxLXYxTKF1AaXHRtoXQfSiLMBdzt
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

A lazy I/O open asked for LAZYIO with the other caps of its mode.  The
MDS issues LAZYIO in LOCK_SYNC, but not in LOCK_SYNC_EXCL: an open for
writing by the only client of a synced file makes that client the
loner, and the MDS revokes the LAZYIO it has just issued on the way to
LOCK_EXCL.  mdtest's "read" phase opens files O_RDWR (it passes
O_RDONLY, 0, where the backend wants IOR_RDONLY), so with the lazyio
mount option a file read can cost a revoke and its ack.  A reader whose
caps came from a lookup also paid a cap message and a grant for LAZYIO
it had no use for.

LAZYIO only stands in for CACHE (reads) and BUFFER (writes) when the
MDS will not give those out, i.e. when the file goes mixed.  Ask for it
once CACHE, or BUFFER for a writer, is in the wanted set the MDS knows
of but not issued, and keep it while it is issued.  A lazy client of a
file that goes mixed then gets LAZYIO one cap message later than it
did.

Reading 2000 files O_RDWR from a second client cost 930 revokes and
2916 cap messages to the MDS before this change, and costs 0 revokes
and 2000 cap messages with it, the same as without lazyio.  In an io500
run the mdtest-hard-read phase still sees about one revoke per file
with lazyio (2.5-2.7M); those go away only when mdtest opens the files
read-only.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index c063d3cf7d21..49e5c1c36b68 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1126,24 +1126,32 @@ static inline int ceph_adjust_caps_used_for_lazyio(struct ceph_inode_info *ci,
 #define FMODE_WAIT_BIAS 1000
 
 /*
- * Does a lazy I/O open want LAZYIO?  A writer does, to keep buffering
- * when the file goes mixed.  A reader whose cache is backed by CACHE
- * gains nothing from it, and asking for it would cost a cap message to
- * the MDS and a grant back for every open of a file that was looked up
- * or stat'ed before: want it only once CACHE is gone, or keep it while
- * it is still issued.
+ * Does a lazy I/O open want LAZYIO?  It stands in for CACHE (reads) and
+ * BUFFER (writes) when the MDS will not give those out, i.e. when the
+ * file goes mixed.  Until then it gains nothing, and asking for it costs:
+ * the MDS issues LAZYIO in LOCK_SYNC, but not in LOCK_SYNC_EXCL, so an
+ * open that makes the client the loner of a synced file (any open for
+ * writing by a single client, as mdtest's "read" phase does) gets the
+ * LAZYIO it asked for revoked again on the way to LOCK_EXCL: a revoke and
+ * its ack for every file opened.  A reader whose caps came from a lookup
+ * also paid a cap message and a grant for it.
+ *
+ * So want LAZYIO once the MDS has turned CACHE (BUFFER for a writer)
+ * down, i.e. it is in the wanted set the MDS knows of but not issued,
+ * and keep it while it is issued.
  *
  * Caller must hold i_ceph_lock.
  */
 bool __ceph_lazy_wants_lazyio(struct ceph_inode_info *ci, bool write)
 {
-	int issued;
+	int need = write ? CEPH_CAP_FILE_BUFFER : CEPH_CAP_FILE_CACHE;
+	int issued = __ceph_caps_issued(ci, NULL);
 
-	if (write)
+	if (issued & CEPH_CAP_FILE_LAZYIO)
 		return true;
-	issued = __ceph_caps_issued(ci, NULL);
-	return !(issued & CEPH_CAP_FILE_CACHE) ||
-	       (issued & CEPH_CAP_FILE_LAZYIO);
+	if (issued & need)
+		return false;
+	return __ceph_caps_mds_wanted(ci, true) & need;
 }
 
 /*

-- 
2.53.0


