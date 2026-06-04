Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23F36AF6
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780543169; cv=none; b=MMGmBxahvy+Zf17eGNT9iJ0Rvrcqr2cRbOVYuW/QqXtWlxxquXmXqNVLoznQNuIvZKqH1TO6DeVrJaifNUKHhlubD8auSqdwyK2h4TvztLLNu5hR4lDZ9/dfYedcs5HEsSyY04ogxg/U5qO8v0uJLwH7Ir1vtmcJeTokpXfQIMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780543169; c=relaxed/simple;
	bh=VH5SzsiTnzAS9CfGPt2hLOIDvgpuwiWXfuvvWlqBdFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrP3NuT/kb02JQ1m64ovOGekOGlChFNCnOnwgFK0U6AHFPOH4mo5t2F7fIf78K4NF+MMy5k4Aubw99ocHEspo44aKd0/tdrXe+O2xvCnQ+3Mmmmx+6OtYnX9gjwVddKxJPK0c7LUEy926Il5bpHed3YqDkS1wWrOpEmVqZjK500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAD3E76t7iBq7vVYAA--.47646S3;
	Thu, 04 Jun 2026 11:19:19 +0800 (CST)
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
Subject: [PATCH v4 2/2] libceph: crush: use CRUSH_ITEM_TYPE_DEVICE for leaf device checks
Date: Thu,  4 Jun 2026 11:18:47 +0800
Message-ID: <062971a5852907a5.1780473721.git.ldy3087146292@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <8fbe4d61ba313a26.1780473720.git.ldy3087146292@gmail.com>
References: <8fbe4d61ba313a26.1780473720.git.ldy3087146292@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAD3E76t7iBq7vVYAA--.47646S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrCw4kJr4kWrW7tF1xAFb_yoW8Ww4rpr
	42g39FqFs7Zr13tFs3t3s29r12krZ0krWUZrn8X3ZFk3s7Gr93Gr43Ka9xtry7CayrCF92
	vr1UAryDGw47GwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAICWof488OKQAAs+

From: Douya Le <ldy3087146292@gmail.com>

The CRUSH mapper uses type 0 to identify leaf devices in several paths.

Replace those hardcoded checks with CRUSH_ITEM_TYPE_DEVICE so the code
uses the named device-type constant consistently.

Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

---
 net/ceph/crush/mapper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 17b041779fb9da2deb8cdbf58439392d7fa2e8ef..00e139efd54eae36f75ed7cebd79ac9b0dc27262 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -530,7 +530,7 @@ static int crush_choose_firstn(const struct crush_map *map,
 				if (item < 0)
 					itemtype = map->buckets[-1-item]->type;
 				else
-					itemtype = 0;
+					itemtype = CRUSH_ITEM_TYPE_DEVICE;
 				dprintk("  item %d type %d\n", item, itemtype);
 
 				/* keep going? */
@@ -588,7 +588,7 @@ static int crush_choose_firstn(const struct crush_map *map,
 
 				if (!reject && !collide) {
 					/* out? */
-					if (itemtype == 0)
+					if (itemtype == CRUSH_ITEM_TYPE_DEVICE)
 						reject = is_out(map, weight,
 								weight_max,
 								item, x);
@@ -743,7 +743,7 @@ static void crush_choose_indep(const struct crush_map *map,
 				if (item < 0)
 					itemtype = map->buckets[-1-item]->type;
 				else
-					itemtype = 0;
+					itemtype = CRUSH_ITEM_TYPE_DEVICE;
 				dprintk("  item %d type %d\n", item, itemtype);
 
 				/* keep going? */
@@ -796,7 +796,7 @@ static void crush_choose_indep(const struct crush_map *map,
 				}
 
 				/* out? */
-				if (itemtype == 0 &&
+				if (itemtype == CRUSH_ITEM_TYPE_DEVICE &&
 				    is_out(map, weight, weight_max, item, x))
 					break;
 
-- 
2.47.3

