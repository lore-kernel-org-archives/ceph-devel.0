Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382825;
	b=5rOCRC3l1y2NzbLN9CreQOlfGA38/cYH9APfIIdvRv0HnWPUvG1BqrCr+hGwnL5tVgMV
	 aRTCK1vvc/DI2Rqo24ee4c3qYk3XxhhLtSXyS2OqzMjjf8aKwQz6CEzRzksVm9aPEYLAW
	 b7ejQQkwvKWwdZEjIMaRLFkN026bZymoVrI2M7rZqwNa0RRdk6wNIRrKwaUDzJ+tJpXXE
	 5R2TdxQtwud/3hA1+VMpBDCQZBj2nXCCBBqxfQg85JLa4sAPdMOxB6BeHFA6PbeWlIH0K
	 ptjHmv+TbZmwIW5mqJbLGYfZCmosNC4bgHzQI6kd3KaIFRCK9bZUknm5Wbn4859TYAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382825;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-FangMail-Miltered:X-FangMail-Envelope:X-FangMail-Bounce-Flag:
	 X-FangMail-Outinfo:X-CLEAN:Message-Id:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=QDtPahw/9d52GP8Q9eE8fV2HAD09jxXguaL7/707geg=;
	b=LDb87yelvYap9MeeDexipDjiSWNiPQJTZ/j8qjbuW8gPDDF4dE9aF8g6hu3s4Ry/1y3J
	 xx/ORF2lI3sN45/+LLiDCvwhfAm0NsJAfvphT2x3EoeUW83OzVJdTIJpMkxZ9u1apIOx0
	 jfyooThzxFtNZzQ7drOYFFHLQ1jPHNLr9jHiBMrGs9AFRqV3eU9R1BhnW4Vp2iCU95dRe
	 zjjDAlgetjIhaRIqspUpbfZt2nI5kRr/lmZm+VWV8zGnB26wnwa6qCSvW3oE/MHgRVmON
	 2PvKFhxQvdjHLjtgqMs1Y1gA17Hu5xebR9dw5BC7AzNzGHkZ5atKOvVznWMDwON4T6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F0606A333;
	Wed, 11 Nov 2026 07:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B31F0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jPb5k0FlFz6R2s;
	Wed, 11 Nov 2026 15:40:10 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Xiubo Li <xiubli@kernel.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	zhangdaolong <dlzhangak@isoftstone.com>
Subject: [PATCH] ceph: fix slab-use-after-free of capsnap in ceph_put_wrbuffer_cap_refs()
Date: Wed, 11 Nov 2026 15:40:09 +0800
X-Mailer: git-send-email 2.48.1
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
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Wed, 11 Nov 2026 15:40:10 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AF41BD9.002 by FangMail milter!
X-FangMail-Envelope: 1794382810/4jPb5k0FlFz6R2s/6AF41BD9.002/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794382810.6AF41BD9.002
X-FangMail-Outinfo: 1794382810/6AF41BD9.002/4jPb5k0FlFz6R2s/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794382813.6AF41BD9.002.4jPb5k0FlFz6R2s@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF41BD9.002/4jPb5k0FlFz6R2s

In ceph_put_wrbuffer_cap_refs(), when capsnap->dirty_pages drops to 0
and !capsnap->writing, ceph_try_drop_cap_snap() may drop the last
reference on capsnap and free it via ceph_put_cap_snap(). However, the
subsequent doutc() statement still dereferences capsnap->context->seq
and capsnap->dirty_pages, triggering a KASAN slab-use-after-free when
debug logging is enabled.

Fix this by emitting the doutc() log message before calling
ceph_try_drop_cap_snap().

Fixes: 860560904962 ("ceph: avoid sending unnessesary FLUSHSNAP message")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://tracker.ceph.com/issues/77923
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
 fs/ceph/caps.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 4b37d9ffdf7f..2f9f334276d1 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3393,23 +3393,24 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
 		}
 
 		capsnap->dirty_pages -= nr;
-		if (capsnap->dirty_pages == 0) {
+		if (capsnap->dirty_pages == 0)
 			complete_capsnap = true;
-			if (!capsnap->writing) {
-				if (ceph_try_drop_cap_snap(ci, capsnap)) {
-					put++;
-				} else {
-					set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
-					flush_snaps = true;
-				}
-			}
-		}
+
 		doutc(cl, "%p %llx.%llx cap_snap %p snap %lld %d/%d -> %d/%d %s%s\n",
 		      inode, ceph_vinop(inode), capsnap, capsnap->context->seq,
 		      ci->i_wrbuffer_ref+nr, capsnap->dirty_pages + nr,
 		      ci->i_wrbuffer_ref, capsnap->dirty_pages,
 		      last ? " (wrbuffer last)" : "",
 		      complete_capsnap ? " (complete capsnap)" : "");
+
+		if (complete_capsnap && !capsnap->writing) {
+			if (ceph_try_drop_cap_snap(ci, capsnap)) {
+				put++;
+			} else {
+				set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
+				flush_snaps = true;
+			}
+		}
 	}
 
 unlock:
-- 
2.48.1

