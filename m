Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017FC287510
	for <ceph-devel@vger.kernel.org>; Sun,  7 Jun 2026 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780824973; cv=none; b=Pm98fMCwGho5dk+6wVQHMPIT0PUVNWnstZT9ouq7lbUA0ZKb5+W9D2y2N0Ft6NZDimPiJy5E+vzWAhnP0sTBSH1QWAsmnYdAxlumYfNue4IjK7dom5xETjCq2ainUxjq1e4XL2EcuahpzSCRrey4RhBfc6Eljfz/dxRHahRkNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780824973; c=relaxed/simple;
	bh=E/puqhYzj2q9xMnDxa1nl3t9b26sMMJzF+Kbhj4ayYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZI7CWF/XjZ8uQg6E+N8r2d0BdQ4TRB8SGWQYy794hSay1QLmWI3xFNWm4wNXS8f8nngSxsQS276RrKl/CC0rXWbIpmBxDjNuGBVHMeOPXz54hWEqIKPybYAgTa55khgWXTd9u7A+942nihExkbqDNAopL2OvgOAEPneYpW7ABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADnB8J8OyVq1_hmAA--.10314S3;
	Sun, 07 Jun 2026 17:35:58 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@inktank.com,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	ldy3087146292@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] libceph: mon_client: bound get_version reply decode to front len
Date: Sun,  7 Jun 2026 17:35:49 +0800
Message-ID: <51227a76810cc04846bff23bb891bb216fc55a57.1780374480.git.ldy3087146292@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780374480.git.ldy3087146292@gmail.com>
References: <cover.1780374480.git.ldy3087146292@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADnB8J8OyVq1_hmAA--.10314S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw15JFW3tr4kAry5CF48JFb_yoW8WF15pr
	47CryrKrZ7AF129Fs2kFyqqF4Fy397WFZrWa90kF17u3WDJF4SqFyFg390qFsxZr4fCF4q
	kr9FqFZ2kw1DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQELCWolKdAAuAAAsM

From: Douya Le <ldy3087146292@gmail.com>

handle_get_version_reply() uses msg->front_alloc_len as the decode
boundary for MON_GET_VERSION_REPLY.  That is the size of the reused
reply buffer, not the number of bytes actually received.

A truncated reply can therefore pass ceph_decode_need() and decode the
second u64 from stale tail bytes left in the buffer by an earlier
message, causing an uninitialized memory read.

Use msg->front.iov_len as the receive-side decode boundary, matching
other libceph reply handlers and limiting decoding to the bytes that
were actually read from the wire.

Fixes: 513a8243d67f ("libceph: mon_get_version request infrastructure")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/ceph/mon_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d2cdc8ee3155..fd3ebebe5f4c 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -821,7 +821,7 @@ static void handle_get_version_reply(struct ceph_mon_client *monc,
 	struct ceph_mon_generic_request *req;
 	u64 tid = le64_to_cpu(msg->hdr.tid);
 	void *p = msg->front.iov_base;
-	void *end = p + msg->front_alloc_len;
+	void *const end = p + msg->front.iov_len;
 	u64 handle;
 
 	dout("%s msg %p tid %llu\n", __func__, msg, tid);
-- 
2.47.3

