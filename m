Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B741930BF67
	for <ceph-devel@vger.kernel.org>; Mon, 15 Jun 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505092; cv=none; b=LXTkTMxQf/YeQXgzlVl59OXg67F1YQjD9IVDav/LKDTaIwAjhft/dNYtxkLX9qHJl72Aln99r5Kg0+hEJO5se2EvIO4N7CPtupQA3NwPyvl7InTBsyT4sh73SGoeXBclPBMOI6PYIOqyPXHRQoPq9RHE8Bp3kbkXxS0xmc5/HiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505092; c=relaxed/simple;
	bh=JotDjOJ6DFVe7DkP1P0ifgaNMGdhAdSxG81L4AriNUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDvwI2O4xiYPwo9AOx+hphWNOVSoLHX3VV0c2JHy7AotKUStMcUYg/xAUSuZolzjjXcDrrsJBjU2RyLMkoUSzvoEcm2MQRu/1Tx2zWpWtkMx4HNMcz8OxkCnM9y9CtRmSkHh0u1ZtQqM9SDvFe95pb30wQHMJ04PMVNLoI4O86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAB3j7ktnC9qKLqHAA--.41259S3;
	Mon, 15 Jun 2026 14:31:13 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@newdream.net,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	ldy3087146292@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] libceph: debugfs: remove client files before teardown
Date: Mon, 15 Jun 2026 14:31:06 +0800
Message-ID: <e346902d49608e030177ffb00423e776f4a916ee.1781280238.git.ldy3087146292@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1781280238.git.ldy3087146292@gmail.com>
References: <cover.1781280238.git.ldy3087146292@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAB3j7ktnC9qKLqHAA--.41259S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4rZF4fJFy3Gr45Zr48tFb_yoW8XFWkp3
	WUC34UKrWkA3ZrW3ykCFn7WFWfAFZ3GF47X3yDC3W5C3Z0qrn8ta4jk39Fqr13ZFWxGF1q
	9F12vFWUtw1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0TCWouZFIO1AAAs+

From: Douya Le <ldy3087146292@gmail.com>

ceph_destroy_client() tears down the monitor client before removing
the per-client debugfs files. A concurrent read of the monmap debugfs
file can enter monmap_show() after ceph_monc_stop() has freed
monc->monmap, triggering a use-after-free.

Remove the debugfs files before stopping the OSD and monitor clients.
debugfs_remove() drains active handlers and prevents new accesses, so
the debugfs callbacks can no longer race the rest of client teardown.

Fixes: 76aa844d5b2f ("ceph: debugfs")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/ceph/ceph_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 952121849..a797c7360 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -762,13 +762,13 @@ void ceph_destroy_client(struct ceph_client *client)
 
 	atomic_set(&client->msgr.stopping, 1);
 
+	ceph_debugfs_client_cleanup(client);
+
 	/* unmount */
 	ceph_osdc_stop(&client->osdc);
 	ceph_monc_stop(&client->monc);
 	ceph_messenger_fini(&client->msgr);
 
-	ceph_debugfs_client_cleanup(client);
-
 	ceph_destroy_options(client->options);
 
 	kfree(client);
-- 
2.43.0

