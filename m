Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792583556;
	b=zSpisPl8IC9qvUIU9d8RcykC7wotL953MJLR90n7rCumivrXKyAUFaMgHkrV4qjb6Nqa
	 mO02aDKIu+y7GDfkl8AUy+PPoGM5oAeOHarDls5jioU378LQ7VyAKDwAbN36+xgy9AkWZ
	 IkGyUwnKsJTEbx/MzbzU44vL6XxE/pwK3ulSRJO/aYkC418mk+FRh3LM8EyDHy+5bqnEp
	 aiTgEWMTxG1lZLpAjMrhBFQGNgIgEqNebAq/PA8opGL1MXxzTPHiV+a/aJX+ju1blyfY5
	 otdhHobTs+jdaaRL4OmKw5kq3+eBQqCXV2M3Ooxqy2l81zccL34Tl0QRlmb2PaS0VWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583556;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	b=wBisYOWWCZz1mrJvzv81QZflOyrWrPj2jlnje/0zg4pvT+sKJ3F3JAmejGMm9iCVEIlk
	 SSViBVSZW9o2pEkvoyXy74aVS8CqsbxEwoAX9bvWUMHnJooClqCro6/afoLstJ9+vDsAg
	 jk7eGriWJmJTW5T7u+EbR+ZY0/2gmcv9CEKrYd13ZCe0jgPCLuRJ3dy8yf3mkXrDUBLSz
	 aTGMtDW83eEu0vXNpLvxisZKmfa4ig5Kf7exH1y8cpUZXXV61Jj9rTcWnQrEBf6Dax5HE
	 +B8Reevjrdq1HJml8LVy3squyAETO0/b8zDZbJSD4VThctr4ZfylRsAgRVX/5EsobNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCtaQsK6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7651606A329;
	Wed, 21 Oct 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCtaQsK6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792583555;
	b=qR1ngFKxDUjktBJEOw5VPrL/6U2xHVXteBEbnCI+16AWtp2txowr/9WxlvoKCAIGEX1H
	 j0uqGJNTl7OM2Y7Gy5i5o0LA2TROy9mCHOdzMkVsQ5sN8LHE9QCQcm2kKvxKg2CjvVBZ8
	 TXlL8RPaRLodNWG8H2ZI9v0xRlqO9KKA7FXrGlGnoNmWtu1ZKlqKc/h0miV4e/yIMrkGY
	 66M0+oXfpQ4AtTaPwXQU2kyPwvAPmPD+u5cHKdo0KRdXxpImKGzJeo930PsRWRmHF554h
	 s0cJqLtMVmAdlMR+ode01f2FU6YOYmKCXKPn9v5UXiSWntQQ5m+SyMqaBa7cXC6FDrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792583555;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	b=ufi4pmicteziE0XqhQrvTDLW+hKyO5TeMBPtYnM8WVaBS94OHK8cTYYlxe7yqKEYkxQU
	 McF/v+5TB7hF90wiCBxw1Eu0Q2Yh6ovfJbNa6iMezmboxKIbXAYhr4er6vXVxTtawsIta
	 mk/MKMkaYhtFvf9ROFyhr9/XGBdSwSl41d+StdRSo6153dasnZ/jJP61zp0ebA4GA4+q5
	 K+4DDKbObBdTBNooLG8nQq5WnCl67lDAxmjCrnVS8zpUTjHSFABmeHgUHxWppXCzM13Os
	 0qmwMb+Iyw1ILHMwg4FD6OEeQd9ITenaJfL5YYuKzvYDsIRpv51NO/TsEJuD80xNvmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BDAE31F000C9;
	Wed, 21 Oct 2026 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583555;
	bh=l4FObfvQRMO41M3XPigHMXUMperNlJvjgYrcLSCu3rE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UCtaQsK68kjr1Tn32fMOSCj50vZ33QBlxtzNeA91/r/A4vGVMhHv/gj6hoSFNrugY
	 lUmUff8+2mL+KcxUo21cA69r7BiPS8URD5eS1OZaDCMPwDxxeKlJI0dpKxi1QNOZmn
	 cJSkjqK/Wecf3YKtrWgikcnS+TtJNXKOzuFPSwzPiFPKGNODGf5ZV3GwB7EkmBlSZj
	 uuD6E3A/yTW8d6pfd33IuO08m16gMiKTN32e02BcALaA1tgD+X8To78J9qAmpsPi+W
	 vqT4q97CHT7/No/khiGYBuWxBPilgh41rpJtM9+/8AErEl/GMGA9sV5hARL+A5KQMP
	 Y0M5KinK7pMMw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 42D0F43361;
	Wed, 21 Oct 2026 11:52:33 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 21 Oct 2026 13:52:06 +0200
Subject: [PATCH v2 4/5] ceph: ask for LAZYIO only once the MDS turns CACHE
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
Message-Id: <20261021-b4-wip-ceph-lazyio-fix-v2-4-25d28479d6ea@clyso.com>
References: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
In-Reply-To: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792583534; l=3543;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=vM1YJ8Qdb6EoK/7Y+Z2XaIpcesKUcnEvtBTos7L2Q+s=;
 b=RY+hUl7AzJcIaofibMUXinOg/wSVf/LerXeXYMco53jx9J+I37npoSwxq2atvqAqwnsHVVZ2y
 lznu/GXymJpBkKlxVW1zMOcGeb2EnslL/LXEJ7ZG/cvdaPSaTYjBhEw
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


