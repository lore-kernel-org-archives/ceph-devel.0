Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793084465;
	b=UY+1BX1TAq+m6NuJGFvhTOLlek6PjRcQU7+rnKPw6uEDTke/roLIzPAKdRc1LrmAaXgg
	 mpJt38lbviJqw3RadIWVcbeL62VBvPajNV6dshy9HFvAl2xJapnE/9gR6dtXmoSIHX2NQ
	 dl9y53zaDP/cIKf1G6DubxrRe7oeFsz9vlmf8Zqtk5gEZqGB6wK6u427aFdeNV9HZt94v
	 XWXbAOjqT12AU9i6LMi1bwb8IYM3nbo+BcfC9OGmJm8uYt/Ro5VJw78YgZqP0qvGCKcNQ
	 AU94HwP860W8RgNX60i26jGaCLP2DlFOaqrRCQrRXVjSNUTmnVPf7nYn9LLep/DOXbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084465;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	b=raAeD5zDlCsZuNTqfW5IDvF9ymetHKpe8Wi5rRWcpcimRo2BCltmTic9XzaYNqEtCsyv
	 MhOck2y1s3ngH5HHWl5nIJEF4ZjpqOjX2qFIKUQtYcTXTzcd3M3rUNLy2/cb1Wo/4ufGl
	 6Drknjolv2Y6NOD3fA+9WX2Q2uxWUKjZnMlCTE6xafEVi2Kut9Qhu1ZjoH6z/ABrt4L7A
	 XtgBlUu86E9632IjxF5BxgGm2DcOEBGhTOLY9qzKVc3L4zRBBnGXvRTIJAMeTvd3u5Ssq
	 /MLZ6c+1O2a4L66WJGw4S8jxTPlrLJPxFEZC51LlS5W2rwKt+38K6M9fV/5DJ6hZWgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BZs5/unp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E85606A31F;
	Tue, 27 Oct 2026 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZs5/unp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793084465;
	b=wzBk/tNJans+QoprP7wtV8hUf/7RMNmATpznN8efCgm53lIkIJ2hPT3TdBrTagNDQkyX
	 9Hy1H/vwfZkKk6QGmv2xhhQBN+5FzjPGV+7oWRgaepjyPtKYEN96pgzHYYVSk614XSyv4
	 XKwP9XC86e8GFMrypm6bhtveUx8ZtBSjSK/b6vTYl+vJcmnsmIUUNtenrbRqRH408NLHm
	 bhZEslU6LMNlVbxQbMPw4SgBZ0YmrPLyY5FJoTdRyI3WpWw04aH0S/Q8bvfJFw8x+B7Wl
	 uMGPzJ70xHpm7DjRdpM1X7pYBO3f8aySi6+L0qb/usQooVro0LVfeWhbAMWX4uAbb9w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793084465;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	b=XIj1EU92o5f5TFy0Knm0flSDqi0Gjwbln7tfcm1IgB/9YguI/e/EL5eQreuYolDLMP+e
	 VAyg7RBtHYym8knnZXiHxJMlrCej7LTRsQ1pMJCfIl5OCYsiNbmQum/4lmdMQw5ZDTIu3
	 rMlO/GEfDHhOWyYYgo9o9O6zEW+VC0+F8mc7+zk5iLVEUwQXDBJQzcuOmVeQNh+LCbSID
	 H/Nyqt5gpzDDCEyBvnGN+uoRtCHc7wu3Z3hd3HMuzw+/8QuqIL4UP9c8TCj8K5eL9zBLt
	 p2rrEXPqg21zDlP1GVwt1z/C7lEnHQV528hsMdrL8Q8QHhqlQAxQ33oOUX4zKA3IXJQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B20271F01828;
	Tue, 27 Oct 2026 07:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793084465;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BZs5/unpf/VE4cUtRpCxt6G+wdTVYyqTPIASIoJCbxCfb5069+eI3ALN977I84h+n
	 XBHC8Lw36v6kAXZc8ZwAaVrNaiT2L4c1XwwC8j2Z6Ha2rqHMkLWuP/tI42FSyaIxg1
	 KNG1L0zI3rI2Tejp1z8V6TXOkC1ShYRMQeJpsK87DeIGq6B2hY8S8s9zeKvQv5rlej
	 6bJPkeAsWCQeFRKrNtIbKAmh2hjGoXNNY94APyPGW/tyJmdjCXLZA7SM7ysxeHcAvO
	 Tsfu8bXk6SRdbHpUKvmhIKpozIPFG6yG8i2XbzXrcG76ixYXDQVZyLWvwyi65+VJg4
	 iLvAnTPHDU6aA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3C8C645000;
	Tue, 27 Oct 2026 07:01:03 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 27 Oct 2026 08:00:48 +0100
Subject: [PATCH v3 4/5] ceph: ask for LAZYIO only once the MDS turns CACHE
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
Message-Id: <20261027-b4-wip-ceph-lazyio-fix-v3-4-df2926c30867@clyso.com>
References: <20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com>
In-Reply-To: <20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793084460; l=3543;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=vM1YJ8Qdb6EoK/7Y+Z2XaIpcesKUcnEvtBTos7L2Q+s=;
 b=lPZdiSqqQVPAu8YmiOtzxzoT1KLqFsZxXCmCRyWYUKBpmU3LfU0U1ggov9+FqfRTpWUc87QUO
 m+kBvosF2s4Cp0mQS6U92b27Df2T4aMnABP0fSAzfRJU0FQ7eoGGWHr
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


