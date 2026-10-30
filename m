Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793347675;
	b=dnPuVKHJ3n/awN6WpxQcrbKFIG3y10CSgHR8rqTxoBs0ayMgNkFzPQacVfxq9tpIKzuA
	 gCYCXtW7sFgaxs5fDIyba7boMmREjA+wVDkU6GNIvGW/79v0FG/gZUDHUDdDxMnMIM0s7
	 tmoEXnOcp2qtExp3db94UGoPhxbTJcMpq7SAJW/vNTxc2DJ2ZRMjzazH9WNu++H/sHccZ
	 2rwVlK61a+B7KZ5YYlFaEJYXQDlEbHIskNXRRSOfskuSdadSy7XZC051BpvZ9ZhTCKjUi
	 ml1pitkP2kzlDhP4PnpFCND9HnON3nKG25kTCfytLZhR3brIf/T7k8jWEjsewBkgoKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347675;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	b=RKEk20rhom/cXXsW/eTDPt11iDIzgyruZOKgSvFX/aNl/o8CQJVua+DRlmOJwH4THc58
	 ByhQKTlLwHe/NoMa2ra1LdSydsA1dRMt2hG46xQAHLu+jylU2ZQb2jD3um1up1Em7LUtq
	 /tNr4gBKqDzvw7VlVE7unns1P/a0UlT4o1Rd00LYVXVBP/saLvfahJHcr7jQKHy2xgrzI
	 XR57xMEoMHIC0YfyZGnU/797sewhWCPlbLec+1+GmQ3+EuMl0doK6yEvT88ve+ExzBIMc
	 elQA5N69t6R3hBxL6ibDd3IOkfPdBNYA5k7E95rND2VS3VNAsEMYjGklDOBVG797aEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmtOVi8L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A167606A32C;
	Fri, 30 Oct 2026 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmtOVi8L
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793347675;
	b=MDi9W7moIwh9saNoF2TpYcnRlXMd3s9HvoDv7mhJtW4kFSC4zpNBgaVEpvCcnQh6s6VE
	 Hq9fQQb/nFh4hPX+oZJvheek2k3lVP/X1U0+jPem92JM5hIWvizjgI6pK/eoasIrrZ+cD
	 0cMpNOYw5lpuIR+utCgHbk9V1068tfMx1N6Gvlz4V/HbmMYkC9v6Y3e8M2sHCTyMvXQVB
	 AV8hgjCT09/nOnbXdrPO7UY8zMdancvJXDrkpHJhRD7Uik3fwc9jfiwabv4yPJNL3Wkv3
	 bmbTNIjV+jseIkG4BkKvcM4lx/RQ5/igYwBlGbNyKzW04azUaRWjptE7ZKDerF2bUng==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793347675;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	b=ufewBkTm8aMvbj51z8fyqocgeyc8HVEjjk85dODJuxf3kWCA2GFuoqXUEatOLKWIwr2r
	 ZSBwDoe4oNd7NcffH72sixXQotkX6ANM8F3d2ws06cELZqlDqwZj+a5VahbzsEHyoCOVy
	 zEXYcdAjLrWSce8iczCLI1DA0psBk5SHi4zr6ZZiRT4HCrcqOeHVkVuex/vVbWo696Pm7
	 Ky4nFHIRNgDVq+2YfZ6rTzOSHBLB7R7RpQHSi01Sccnz6VJfoKiT2WhOTZ2z+n+f7LNtl
	 onJ0xzn0XVAbYPGPSz11jrjI3zyrH5ICzLvwLTTk9PopcR2RB0q07C5leYAQ6z8RI8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3E59B1F00A16;
	Fri, 30 Oct 2026 08:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347675;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AmtOVi8LqeiJTgBVoN8aM8c+e3sTSi7+BA35yCbuv9dnh9an2x/2+QiFH23sEH92j
	 KcxezqPYKkDDolPdLuLbx/ngdCVEtmdPGs7kX4SV8Tu9ShNP++G4JrWsEUZzDTaXug
	 4F/pnefSFAYdm/a8Id7jHFvoyiCuAuC+7naVROwfQf6jlEkUY2LvYTjLnLmPQLrMYi
	 Y8R5IR3csCVK/NzBJkVYgzC7kt0TfOUPrFpqd+tC2Pb3ZuuJkuuVhd9KoDVFrISN6a
	 fVF3FRoq5FitQGD3FUPEKTvXqJ3eD+VbBGOrXWd/PmaGqS59mnzT1vzyE7Rt3GEI7p
	 W/bC3PDLs2pgA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C0DAD436D8;
	Fri, 30 Oct 2026 08:07:52 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 30 Oct 2026 09:07:36 +0100
Subject: [PATCH v4 4/5] ceph: ask for LAZYIO only once the MDS turns CACHE
 or BUFFER down
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
Message-Id: <20261030-b4-wip-ceph-lazyio-fix-v4-4-f734a26bbaab@clyso.com>
References: <20261030-b4-wip-ceph-lazyio-fix-v4-0-f734a26bbaab@clyso.com>
In-Reply-To: <20261030-b4-wip-ceph-lazyio-fix-v4-0-f734a26bbaab@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793347670; l=3543;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=vM1YJ8Qdb6EoK/7Y+Z2XaIpcesKUcnEvtBTos7L2Q+s=;
 b=d92JxlBTKlILnCBo7AQJ8z/aBqPvcJd3+wbsotuabpmXfyDm3KNGxOX4CD90v9fnYRdC+BdDk
 YD98HuLVWXJB4a5kVvfRYxPWXv1KCnu6FgXGMdoPSsWzkL0WV6ZI1Lr
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


