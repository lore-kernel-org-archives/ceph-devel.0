Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758526;
	b=DGS5Hj6KdJQhGPE6nFi5NtQUJop2hAXVLAXP/V1Sic6VQrD+2KUiLHp62uMiagRuEfEn
	 np/04Oy52+CcaM31Vl8DTXC7uThR/FE3kWeohDs4NaopOJhfaWPYol+g9th2IdGjd4Yys
	 6QJ0RGxGG3EDUf7hKInKkSXAwTgzM3Fueiq0wziJ6f/mdnY3MklG0U9Pu25ym72hrJIaM
	 UxxYUlZj1lAp2bZZWsqJCwHbd/W1b+LrSHkgKmmMIOPZPFVx3p7o8l4OyB8KdtJmJbWKY
	 iWaH4Ae2UxLMdbNEoEDthz+LqDEVscp/3Y2zvYVTisd0EXzbp+G0/GqE/IrvdIZ8jkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758526;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=XUNAuMt7YUTIvzRWXrcL8Z2SWrDWnGJd/db01OpiegE=;
	b=wc8NkNu1+OvhG9cAORVnHoQXFcvIB5TnH703Aw4r/bm4T43U1KirYzD0nBxht53FMtTM
	 +EZNzfXsSwGDoc8MePY15VMOAdOzoUu9FbU8Pnck/Gofv5WWrTw3Sm6Wcpf5d8krprNgT
	 iY19se2cDaarrRpA3CWZA6sV/GaZVhxgQQRqGvrabtYwHcbQze7r5oT2TW8Kw3gMDsK9h
	 6Xi0vRZ+dklP0lfqIbvSWewih6ULydRvDcGP5+82mnOX19E+mDEOBQFhc0O7UY/eR4xhe
	 fVqmRpdRwGIRzvxRFQ1Dog7mPuT9vSjaEs66HYKdCZDtIgdreJdcgMHDwfLZGIcRfoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948BB606A326
	for <ceph-devel@vger.kernel.org>; Wed,  4 Nov 2026 02:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 948BB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAC33vg4lepqmXc+AA--.9339S2;
	Wed, 04 Nov 2026 10:15:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Subject: [PATCH] ceph: drop the mds request if the inline read getattr fails
Date: Wed,  4 Nov 2026 02:15:29 +0000
Message-Id: <20261104021529.1468722-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC33vg4lepqmXc+AA--.9339S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1kuw17tF4fAw1UKF15Jwb_yoW8Xr1Upr
	W8WFZrKrW5XF4xZF17JF1Uuw1Fkr4akFyfCrWUta1Sk3Z5X3929r12q390qF13ArW8C390
	gr1qvws8ur1jkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYbiStUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUBA2rqY-m42wABsm

ceph_netfs_issue_op_inline() creates an MDC request with
ceph_mdsc_create_request(), which returns it with the caller's
reference, and hands it to ceph_mdsc_do_request().  The reference is
dropped with ceph_mdsc_put_request() on every path that uses the reply,
but the error return of ceph_mdsc_do_request() jumps straight to the
out label.

A failed getattr - a killed MDS session, an interrupted request or a
reply parsing error - therefore leaks the request and everything it
holds, including the inode reference it took, on each inline read of a
small file.

Release the request on that path as the other callers of
ceph_mdsc_do_request() do.

Fixes: 5b19f1eba459 ("ceph: make ceph_netfs_issue_op() handle inlined data")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 fs/ceph/addr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 01f62683a0b2..aa5dcbd69404 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -310,8 +310,10 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
-	if (err < 0)
+	if (err < 0) {
+		ceph_mdsc_put_request(req);
 		goto out;
+	}
 
 	rinfo = &req->r_reply_info;
 	iinfo = &rinfo->targeti;
-- 
2.34.1

