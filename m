Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792583556;
	b=xK9lZcJr4qo8HklahEd4lnDgR0Fr0u9IbyofEgkiAw1DXrzeqxDqKPaqGOyH3biVhmHC
	 pfyhTuRO3R2vgxzSWxNM6GM/wEHnBhDMF3fKmQmcmHrXo4d1dcohNtazWjBxY1izxizno
	 JuxMAiI37yhhlC02s8fZeBLFUzJnhFoFqXB3c2cDAg5YzpwC0+/dWQpxo3m2zeE/Haz48
	 azBCR5Tqq5aeb5GzIXbEO5nI1ziALWmlikYDn56Oe08wvobCtaLWdz23o495OjwgJXXyg
	 d5f5MF0990Q48qz6RxglbUs8e9HoMfZSOb08hI6wlF5xo3Tkqt82lqLjXQus/YfQvgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583556;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	b=h4Yuod5deeiodzXPImitCwu9fN9rFefsP7kr5B3kipt4p9pN0IE26eFmAtPM8C0iEgN8
	 a+LvnWfFlR61S66A4FrdL+Kc+2fPerRtc2VDInL+3UpLsvUrQmzBUoKztdMNFgdRWtNKT
	 /xRVQOVwCJKfS/sYXmZ8J2k4ZBUd+5YoX5k1D8LZYjPADVIrXKtIrkoyXh2dFamYjqRmF
	 fD0YA6wcN91Qwfl0LtNwVMInaGBOwNsk0S/4Jt5WtwoRXZOCjNtbdnqMwMmCVIjMbzYt5
	 2hubJ8R2vqNlayGx43pLj0khnhhObVzqt6GayI+SXldSGM9aLdOnfqXCtzyNqCXXtUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzWLdPmg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9176606A327;
	Wed, 21 Oct 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzWLdPmg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792583555;
	b=YL9a6q8eg+o9CplzWTDgy51A7UujPLT3cR/pfGVTmBSbRsD3G8ZtaA+rwcoQo//X5Jrw
	 j8Qpeakp6pWyW7LOdwpfOmFyySw1mde3m21yJMc990kj78RNE9HPtMHcc41sRfc06zJFc
	 9tsl5+E3vYJNDcvMUGPlLUhnSyDZQRDbAv0tOMX5XY5IfoMVAVrP1I2BTg3Ts+Mu31PUR
	 33rTjMSUesVJwSrhpJOVWWgQ5VWUdCg1GMvU2vPyyCOoPcaFIgVORWsUdPh2OXtOYSyyU
	 eJzlzMFNsli70ZPELKQRnnHEi74yOHFVmh91FVvcah8IMIhu3Mi7FmxSQdx5ntZesRg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792583555;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	b=PS+XCKd7nwE4PPwgP2W2c3LN8hK07xqoS1RzEwzw3Q/DcwV6QhzOJQzkChj6XmyeUcdZ
	 K22Tgj1aqsOomDULFUmSS8PQmjvgzaMrTDe6O7L1INZUT48mRdUrv2mEEPuyWpaFDvGdG
	 yuiQbQ12L6J3yXFRtA8qUOIt0qDBMLWbBstEcF833G8dTqN0RsoBY3Gel2oIQMeMQQfO0
	 Zfm1qxl12iDNH8eWphBKoV/RQYil+1DMek/Svda6JeyYZRZItxyttROJqw6Tch1/A17JG
	 XzInzPO1H3Rz88/jqDHd33GVHrQEQFoqlA13od1VElTB6RZjtEmjcpJhRY+EXTQVBxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BDAA01F000C8;
	Wed, 21 Oct 2026 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583555;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UzWLdPmgow6qovwiwS7iNQmJ5gIbSh+fQ8Bo7HXYjlwD8Yo9D6WwgwZLfqKvJlZXR
	 RF6IQnDLn8Ve071Cb/dYuggvGpn4kbILPMNVNcoa6c+ZFt30aVVS2Vk+Mn4uQjzJdx
	 MX+vli/5NLpfOfTwLHiz03tYPvsaV0YRVrtZ7JT19Jd2DYV1QGbLscOScRfqkL/yuK
	 7vKQe7U2aNcW+glVJZlIQCtSPKLVjTm64P8DbOdMheOB3q0Xxs4hs4nd4bHcGmEeQi
	 zIXxxGfPhKucVkLMkZw3pbk5HuI9Eq4U0MGJWW8gDnRo4ILsioeqFKapmz3k49KxF5
	 Cvy1nXA2oSX5w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 34CAB43359;
	Wed, 21 Oct 2026 11:52:33 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 21 Oct 2026 13:52:04 +0200
Subject: [PATCH v2 2/5] ceph: do not ask for LAZYIO for a lazy reader that
 holds CACHE
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
Message-Id: <20261021-b4-wip-ceph-lazyio-fix-v2-2-25d28479d6ea@clyso.com>
References: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
In-Reply-To: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792583534; l=3495;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=9pCeVzQYSDJ5vZuuue3pphdfQCNRxqQXpuIHp+vghK8=;
 b=DOkuht8z9qJKjOxmQqyPBjIBTJ2ORMx3UhDM5m4uuWQuCOrYZ9a7h/Tu5hOptKpJ2bfEAIx/Z
 aqzaq4Uj37XDJokwwGkTKVFxbYJZEolOV8D2K823EEi3xN2ZARryOt6
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

A lazy I/O open adds LAZYIO to the caps it wants.  When the inode
already has caps from a lookup or a stat, the open is satisfied locally,
but LAZYIO was never issued (nobody wanted it), so the client sends a
cap update to the MDS and gets a grant back: one extra round trip and
two MDS messages for every open.  io500 mdtest-hard-read, for one,
opens each file once from a client other than the writer's.

A reader whose cache is backed by CACHE gains nothing from LAZYIO.  Want
it only for writing, once CACHE is gone (e.g. the file went mixed: the
cap ack then asks for LAZYIO), or while it is still issued.  A lazy
reader of a file that goes mixed now drops its cache once before
LAZYIO arrives, instead of keeping it.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c  | 24 +++++++++++++++++++++++-
 fs/ceph/file.c  |  4 ++++
 fs/ceph/super.h |  1 +
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index ae7b62b07462..c063d3cf7d21 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1125,6 +1125,27 @@ static inline int ceph_adjust_caps_used_for_lazyio(struct ceph_inode_info *ci,
 
 #define FMODE_WAIT_BIAS 1000
 
+/*
+ * Does a lazy I/O open want LAZYIO?  A writer does, to keep buffering
+ * when the file goes mixed.  A reader whose cache is backed by CACHE
+ * gains nothing from it, and asking for it would cost a cap message to
+ * the MDS and a grant back for every open of a file that was looked up
+ * or stat'ed before: want it only once CACHE is gone, or keep it while
+ * it is still issued.
+ *
+ * Caller must hold i_ceph_lock.
+ */
+bool __ceph_lazy_wants_lazyio(struct ceph_inode_info *ci, bool write)
+{
+	int issued;
+
+	if (write)
+		return true;
+	issued = __ceph_caps_issued(ci, NULL);
+	return !(issued & CEPH_CAP_FILE_CACHE) ||
+	       (issued & CEPH_CAP_FILE_LAZYIO);
+}
+
 /*
  * wanted, by virtue of open file modes
  */
@@ -1179,7 +1200,8 @@ int __ceph_caps_file_wanted(struct ceph_inode_info *ci)
 
 		/* check lazyio only when read/write is wanted */
 		if ((bits & (CEPH_FILE_MODE_RDWR << 1)) &&
-		    ci->i_nr_by_mode[LAZY_SHIFT] > 0)
+		    ci->i_nr_by_mode[LAZY_SHIFT] > 0 &&
+		    __ceph_lazy_wants_lazyio(ci, bits & (1 << WR_SHIFT)))
 			bits |= 1 << LAZY_SHIFT;
 
 		return bits ? ceph_caps_for_mode(bits >> 1) : 0;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 856710c63765..fbdccbae0d17 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -462,6 +462,10 @@ int ceph_open(struct inode *inode, struct file *file)
 		int mds_wanted = __ceph_caps_mds_wanted(ci, true);
 		int issued = __ceph_caps_issued(ci, NULL);
 
+		if ((fmode & CEPH_FILE_MODE_LAZY) &&
+		    !__ceph_lazy_wants_lazyio(ci, fmode & CEPH_FILE_MODE_WR))
+			wanted &= ~CEPH_CAP_FILE_LAZYIO;
+
 		boutc(cl, "open %p fmode %d want %s issued %s using existing\n",
 		      inode, fmode, ceph_cap_string(wanted),
 		      ceph_cap_string(issued));
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 458fd63dd79f..cdb238d48f72 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -952,6 +952,7 @@ static inline bool __ceph_all_opens_lazy(struct ceph_inode_info *ci)
 }
 
 extern int __ceph_caps_file_wanted(struct ceph_inode_info *ci);
+extern bool __ceph_lazy_wants_lazyio(struct ceph_inode_info *ci, bool write);
 extern int __ceph_caps_wanted(struct ceph_inode_info *ci);
 
 /* what the mds thinks we want */

-- 
2.53.0


