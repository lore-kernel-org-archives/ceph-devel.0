Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4B738886B
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780543166; cv=none; b=AJaO6yQ22Oto58473X5iAx/wJ03zkkxZfl5XHqXKgCqJw8YJVxTxGRZnltbDjgJ7okYaCVY1DnEMCUU4Ci3YjGhCPJFAxtyO0pKQqUbnZIH+X6ErRNAvaJ2GBPSiQzPxTTrCFyL3co8PL+aWyQRaWOLA3ISrxwh3r6R2I4INJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780543166; c=relaxed/simple;
	bh=uk5eazkFzj3iJU4CG+a6HiQHKT7Qe7d1XUfdl4RgkfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/wii60kOZGT5k5GtyFEZNSXwye2DnzeJCd4M5Rymzr5A7umK9yEq1KAfewBm5PRpNCbF/ssSoKXs/3CD9lWte/uoPQK3C2xlC/e912BmtO0l9RA5QlLvaCdqkqVnnav7v2ZjgnAHTBD7fA6HNbcerwD5c/47ud5NRYYrLQlEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAD3E76t7iBq7vVYAA--.47646S2;
	Thu, 04 Jun 2026 11:19:09 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: Viacheslav Dubeyko <vdubeyko@redhat.com>,
	ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@newdream.net,
	Slava.Dubeyko@ibm.com,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	ldy3087146292@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH v4 1/2] libceph: reject zero bucket types in crush_decode
Date: Thu,  4 Jun 2026 11:18:46 +0800
Message-ID: <8fbe4d61ba313a26.1780473720.git.ldy3087146292@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAD3E76t7iBq7vVYAA--.47646S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrykur1ktr4rtw15tw1xGrg_yoW5ZFW7pa
	9rAr4DWr97uryUtFsYka17ur4UJanxG34xWr98X34jv3yqgrn5Ww4IkFZ09rnrCFWrKF4I
	qF97Wryq9wn0vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
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
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAHCWof488ItgAFst

From: Douya Le <ldy3087146292@gmail.com>

CRUSH bucket type 0 is reserved for devices.  The mapper relies on
that invariant and uses type 0 to identify leaf devices.

If crush_decode() accepts a bucket with type 0, a malformed CRUSH map
can make the mapper treat a negative bucket ID as a device and pass it
to is_out(), causing an out-of-bounds access when indexing the OSD
weight array with a negative value.

Reject zero bucket types while decoding the CRUSH map so the invalid
state never reaches the mapper.

Define the reserved device type as a standalone named constant instead
of mixing it into the bucket algorithm enum.

Fixes: f24e9980eb86 ("ceph: OSD client")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

---
Changes in v4:
- define CRUSH_ITEM_TYPE_DEVICE as a standalone constant instead of
  putting it in the bucket algorithm enum
- move the remaining type-0-to-constant cleanups into a separate patch
- v3 Link: https://lore.kernel.org/all/d21e2f97dfe6f250.1780369814.git.ldy3087146292@gmail.com/

Changes in v3:
- use CRUSH_BUCKET_DEVICE instead of CRUSH_ITEM_TYPE_DEVICE
- v2 Link: https://lore.kernel.org/all/3200151429f33554f06ced8a.1780197742.git.ldy3087146292@gmail.com/

Changes in v2:
- use CRUSH_ITEM_TYPE_DEVICE instead of hardcoded 0
- v1 Link: https://lore.kernel.org/all/4ad15b49fbbae00d86dfe12348bf94d45aa60ac2.1779949116.git.ldy3087146292@gmail.com/

---
 include/linux/crush/crush.h | 4 +++-
 net/ceph/osdmap.c           | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 30dba392b7302de3e14861f8b769242cd8cbac9e..76bd1fa036538df86d548b1c668163035c30ade6 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -110,6 +110,8 @@ struct crush_rule {
  *  straw           O(n)       better       better
  *  straw2          O(n)       optimal      optimal
  */
+#define CRUSH_ITEM_TYPE_DEVICE 0
+
 enum {
 	CRUSH_BUCKET_UNIFORM = 1,
 	CRUSH_BUCKET_LIST = 2,
@@ -130,7 +132,7 @@ extern const char *crush_bucket_alg_name(int alg);
 
 struct crush_bucket {
 	__s32 id;        /* this'll be negative */
-	__u16 type;      /* non-zero; type=0 is reserved for devices */
+	__u16 type;      /* non-zero; CRUSH_ITEM_TYPE_DEVICE is reserved */
 	__u8 alg;        /* one of CRUSH_BUCKET_* */
 	__u8 hash;       /* which hash function to use, CRUSH_HASH_* */
 	__u32 weight;    /* 16-bit fixed point */
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8b5b0587a0cfa2c437b76c8c87251199efe20291..21cdd33f2945e0c1f45277ac05fda373bf217586 100644
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

