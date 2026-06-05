Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68CF3DA7F6
	for <ceph-devel@vger.kernel.org>; Fri,  5 Jun 2026 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648997; cv=none; b=HFeu+LQvElmqPNujIJcJAbbWDj8aJfiA1Dss69wGkH0e3VxcwFpLSsnpSYNpq6VK8uhuSdbn9DLjDMYg2qC31pKhZJlBKYXjtaCKlyi7zKHUfnW0K1R7CM1lT3p+b0X5x6Jd8KfpuOsW/P7ivWOkWsyZ+kydCV17+2VTDgY0Bw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648997; c=relaxed/simple;
	bh=p5sW33wuB/X4gnRW65hkq13W4VHt/MMmG4ThUbPqpWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBJIVq42xpugEe8q+qvjffFF0WAt4rRHyoOYsvsSI12Td0QUYdCCjvjuS9TxiaYxybUg4vXXP6gh6Oz6eZLjZfKQk+TTdXIqC5X97+sGbdi2SBVyEZJLmn85jjW0SV4HiOmTG1PMwgIWtPiypZs4ngMgrbdTA7m86XOSSso3QIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAC31L4ajCJqUxtfAA--.31502S4;
	Fri, 05 Jun 2026 16:43:09 +0800 (CST)
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
Subject: [PATCH v5 2/2] libceph: crush: use CRUSH_ITEM_TYPE_DEVICE for leaf device checks
Date: Fri,  5 Jun 2026 16:43:05 +0800
Message-ID: <202a922ea6673113.1780640154.git.ldy3087146292@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780640154.git.ldy3087146292@gmail.com>
References: <cover.1780640154.git.ldy3087146292@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAC31L4ajCJqUxtfAA--.31502S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrCw4ktFyrCr4UuFWruFg_yoW8ZF15pr
	42gwsFqFs7Zr1ftFs3ta4I9r17GrZ8CryUurn8WwnFk3srGr95Gr4fKFZxtry7CF4rGF92
	vF1UAryvgwnrJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEJCWoihtAA6gAAs0

From: Douya Le <ldy3087146292@gmail.com>

The CRUSH mapper uses CRUSH_ITEM_TYPE_DEVICE to identify leaf devices in
several paths.

Replace those hardcoded checks with CRUSH_ITEM_TYPE_DEVICE so the code
uses the named device-type constant consistently.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

---
Changes in v5:
- add Reviewed-by from Viacheslav Dubeyko
- add a cover letter for the two-patch series
- v4 Link: https://lore.kernel.org/all/062971a5852907a5.1780473721.git.ldy3087146292@gmail.com/

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

