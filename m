Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792483571;
	b=oiRPFXkBrd+n0BrK551rJu+fNA4K/MrGpxg+sikpODFMd5e0YAoS4c5wQ53Ac/7x1nAx
	 Q8w55nGC5kgXlMO81Cz5lcg4aoQX2IF9vCeqFkvMEqtmpS2JCJFxG1JbtVLaxc5SymoZr
	 4SFoxOBG5Gsejuhcs7KbxjlFjkkWoY8P6t4Y+zZIWvvi4NAhAX9VIFD1gQMDvpz7nTPQ1
	 LMQ1tiFs+2h7224kLDUBQLbABms21XHSDtX2u7DS4VKuc8TNRtIeIhKUl51C1b2cnziCo
	 ITItXPQoz/Len61p6Y127dB5Uba9pmuTHUnWLsD0jhnKps3Rqizji1zgP3zKAWjkT5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483571;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	b=Lax3QvImNXZdJrsgZoCjrrpExPoAIgHbbbNjjRIHz7ynFSL2kjXmL4z/VLIsb04b9ujT
	 TnaH1GxEQsigOiJa0rOH5AGA/EZ3jpMFTlSlHT7oGA2lOWAizRT2tnqnif+Fepe6sPKS5
	 YXiChHyuNJY25iBYYn+8gOqZit2qjP6fpRf5M1Fr4MyoFKh8KTliuekBZDRY4IR2NId1V
	 xweHqbCxtBv4e6I5HYZZk7Eom4fRt7HiBK6Q2U//PDGjWccaeM+BZk/xeNMNwbtj7X7zN
	 T+X5sdenLqNQ9Lzy6J17MyJYlI9u8I7tFC3qg3NymwmuOtScZ+nVN/6xfiizqEIuuow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4c2WWhl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66260606A324;
	Tue, 20 Oct 2026 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4c2WWhl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792483571;
	b=xKwTnyWlJCPQFhT88Egw4YaFMnPXZ1bP40yr7OJl1XeZYEdu8bcF7SWWXErJaDdRfSdn
	 M5BhXdrhS42EjVltkW6W4krGMwMOgn+lQiUHySDYlQ8dTQ03nVFC62FC2NaKczVj758pN
	 OLVGWXNJz4UmJ7dWGym2ZYVCjgwktdKVwyP7Sli8lQf5GtdqdQJKDFMyMjrk8lxhfaOpS
	 X/7yAtF0GXRWQJVJ6vbxt5Dj3GZtil547wlMfuIkZcIBg/JmHi3/mctOhHEBpNm3lKNax
	 4l4JG7NiVFtUcynacKTGXTdJuHBcfpGYArx/j2dXfCXyvpmCs/Fx/TFR/xX84Yy9QyA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483571;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	b=gXaySSPAs4+sNtRchgeL17qUA433h3AHRIusq1fZBqJpPYFZns472o8Fis4oO5i01zuj
	 /nCB5TQzQV74afIQWmzglGj5vF4CYHDX4sgoqName0+krQewroqCgSj/OpXbYFigOLB3v
	 UkDwPXWLNXjUdbpED8ckwzQ4V85ehc1mH6XKjphAHwISoP7auy9rGRLqsYnkGJOsYeGZB
	 GcIfkWBC1LLZ0ZlR2YN9KNBUKc0uGTLtZ0rIL8sSqo3r+QsWQt2owooweE0lxzBG/1mCM
	 SQms8B2+91jyPr0YcJJWN3/6UIgdsRkhiWmcK5/7xEfxl7YvykawMVJsKTtnSlTmvmA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E13771F000C6;
	Tue, 20 Oct 2026 08:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483571;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=C4c2WWhlK4Wzq4tyCL6tEy7WfNw7Dsde/8TezQ9uUo0dym7/qS8FtNXhK9nDZ2GjW
	 dMYWFhzkqbQT+L5R+Qyjlylahig5PFCKYFwI8fpnuMuB8tMRDwbxGwI0YjpYFas++Y
	 nF9nyAuzbUb8NzDAdcGZnLFuWHZ0ndGBYjHLSIghSSjM7xd3/WSM6R3nV21de4JMss
	 BkMJHSEP/aNN36OGauLNfbbvimRRjjCPwV8MbEhApcA/CAH0kQOl5nFCknpA2nvGPX
	 +NNDYUNEgyMIFgfwdbcGHm0yZWuJT3HJqGZ2S7VkByMIoEqdrpKxk63ZGZFHRjcWC4
	 60ioIA1af8o6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4EFF94309C;
	Tue, 20 Oct 2026 08:06:08 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 20 Oct 2026 10:05:48 +0200
Subject: [PATCH 2/5] ceph: do not ask for LAZYIO for a lazy reader that
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
Message-Id: <20261020-b4-wip-ceph-lazyio-fix-v1-2-f4cc62459d37@clyso.com>
References: <20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com>
In-Reply-To: <20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483564; l=3495;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=9pCeVzQYSDJ5vZuuue3pphdfQCNRxqQXpuIHp+vghK8=;
 b=Gq3iMuN32u1e8wEYA7jEnRAYaqOgLMfnZs/AuWe2XUuktu/alvkPfVm0ryzY5FZlbfUE3JFd3
 ypV9wWT0GRuBr6nUMYoz5AR27vDwznlOSaT8/2fUxa38takGHPIIQaN
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


