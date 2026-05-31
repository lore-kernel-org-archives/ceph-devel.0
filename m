Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6BB27FB05
	for <ceph-devel@vger.kernel.org>; Sun, 31 May 2026 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780221784; cv=none; b=nkMqMqwUrDnxJx+xLb2Ve8z38M3XmERdaEGiEajMQDqVL4T+yNlvTJ4OltcJ1ua3B3igtFTZP4wCDc3aXl+9JVNFlgiW30x8y6luxZimZlm8KOJOEZrwsyZrfh6VcEzQAMNFAGfzXI/qxPZuizxnIWHQ0ipEHjm5+7dnOHBE9iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780221784; c=relaxed/simple;
	bh=eHT9djEAKuP/Sb9Q6ZmRiNoCE/8Q2JPImO3nPP/yAsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izDka458oTsz+azFBU45d0K4W6H9YLWJ4QMMv/smQnSgTf50l5YHpNxdNBqzG34kHftgJxOQ+xp38rBPxR0c8WGbnavjyW7EG7sAD8cr5v2GOkbaX1QcE4ECwKYwFF/2mF2H0F2vXlPPCHvIdGEOcLdk/t0D30fvkF4SGIwX6H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowADngwtGBxxqsvIVAA--.43097S2;
	Sun, 31 May 2026 18:02:46 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: ceph-devel@vger.kernel.org,
	vdubeyko@redhat.com
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@newdream.net,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	ldy3087146292@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH v2 1/1] libceph: reject zero bucket types in crush_decode
Date: Sun, 31 May 2026 18:02:45 +0800
Message-ID: <3200151429f33554f06ced8a.1780197742.git.ldy3087146292@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowADngwtGBxxqsvIVAA--.43097S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF43Kw43XFW7WFyrXw17Awb_yoW8ZFW7pw
	srCrsrJr9ruryjqrn3Aa129r47G39xGFW7WrZxJ34Yv34Dtrn3Wrn7KF9IkrnrCFW8KF4a
	qF929ryDuwn0yrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEECWoanc8JKQAEsL

From: Douya Le <ldy3087146292@gmail.com>

CRUSH bucket type 0 is reserved for devices.  The mapper relies on
that invariant and uses type 0 to identify leaf devices.

If crush_decode() accepts a bucket with type 0, a malformed CRUSH map
can make the mapper treat a negative bucket ID as a device and pass it
to is_out(), which then indexes the OSD weight array with a negative
value.

Reject zero bucket types while decoding the CRUSH map so the invalid
state never reaches the mapper. 

Fixes: f24e9980eb86 ("ceph: OSD client")
Cc: stable@vger.kernel.org
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

---
Changes in v2:
- use CRUSH_ITEM_TYPE_DEVICE instead of hardcoded 0
- v1 Link: https://lore.kernel.org/all/1cab97763b0564d03a583deb7eed485b68be6182.camel@redhat.com/

---
 include/linux/crush/crush.h | 1 +
 net/ceph/osdmap.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 30dba392b..eb469972f 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -111,6 +111,7 @@ struct crush_rule {
  *  straw2          O(n)       optimal      optimal
  */
 enum {
+	CRUSH_ITEM_TYPE_DEVICE = 0,
 	CRUSH_BUCKET_UNIFORM = 1,
 	CRUSH_BUCKET_LIST = 2,
 	CRUSH_BUCKET_TREE = 3,
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8b5b0587a..21cdd33f2 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -518,6 +518,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 		ceph_decode_need(p, end, 4*sizeof(u32), bad);
 		b->id = ceph_decode_32(p);
 		b->type = ceph_decode_16(p);
+		if (b->type == CRUSH_ITEM_TYPE_DEVICE)
+			goto bad;
 		b->alg = ceph_decode_8(p);
 		if (b->alg != alg) {
 			b->alg = 0;
-- 
2.47.3

