Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205863BB126
	for <ceph-devel@vger.kernel.org>; Tue,  2 Jun 2026 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387316; cv=none; b=Bb7w8bLzfDCbUHVQpgmkmRKAUTtCeC7H5P+OL8sJrp+cAQZ8XYw00VUQ42jvO3QJbF6Eqm70hy4mSA3dwsp/5DOnGnpqQyqUEok0DNA2aM34zydj3Vd1Ol+CBbUVTkVPlPCfYi/rr6rM8N0/UqlwkXCmTK+W1s6Ykop3ngkigdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387316; c=relaxed/simple;
	bh=A+rWdpv3mL2HutPWyv08rVN6lXBs5QmF8eVsi5J/vvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PS8FBp3R0JL5z5t7IE7aIsCsq8vCmtdJH0o4rZmO0ttTYq0cetGmDjDJd2WlY5EytJcbmRvfH1IKItKwGvOTdnn25GiOEb9DcKGzyVxjcMD5U+gHhM+Vuvg+rqtJdMg8bv9vcJvG3iJbGEDqICV+WDocPwsFenXcZ5Jx/GQccK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADH6sTbjR5qy7VPAA--.9728S2;
	Tue, 02 Jun 2026 16:01:31 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: Viacheslav Dubeyko <vdubeyko@redhat.com>,
	ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@newdream.net,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	ldy3087146292@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH v3 1/1] libceph: reject zero bucket types in crush_decode
Date: Tue,  2 Jun 2026 16:01:26 +0800
Message-ID: <d21e2f97dfe6f250.1780369814.git.ldy3087146292@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowADH6sTbjR5qy7VPAA--.9728S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF43Kw43XFW7WFyrXw17Awb_yoW8KrWkpa
	nrCr4DWr9ruryUXr10ka129r4xJws3Wr1xWrn8X34Yv34qqrn8Wwn2kFZIgrnxCFW8KFWI
	qF97WryDuwn0vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsECWob708A3gAKsC

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
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

---
Changes in v3:
- use CRUSH_BUCKET_DEVICE instead of CRUSH_ITEM_TYPE_DEVICE
- v2 Link: https://lore.kernel.org/all/3200151429f33554f06ced8a.1780197742.git.ldy3087146292@gmail.com/

Changes in v2:
- use CRUSH_ITEM_TYPE_DEVICE instead of hardcoded 0
- v1 Link: https://lore.kernel.org/all/4ad15b49fbbae00d86dfe12348bf94d45aa60ac2.1779949116.git.ldy3087146292@gmail.com/

---
 include/linux/crush/crush.h | 1 +
 net/ceph/osdmap.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 30dba392b7302de3e14861f8b769242cd8cbac9e..ea0b1de2902585ba9a63566cfbb2b0569846a00b 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -111,6 +111,7 @@ struct crush_rule {
  *  straw2          O(n)       optimal      optimal
  */
 enum {
+	CRUSH_BUCKET_DEVICE = 0,
 	CRUSH_BUCKET_UNIFORM = 1,
 	CRUSH_BUCKET_LIST = 2,
 	CRUSH_BUCKET_TREE = 3,
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8b5b0587a0cfa2c437b76c8c87251199efe20291..f6cc93939907bc61943069c462cb752d13c8b3ed 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -518,6 +518,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 		ceph_decode_need(p, end, 4*sizeof(u32), bad);
 		b->id = ceph_decode_32(p);
 		b->type = ceph_decode_16(p);
+		if (b->type == CRUSH_BUCKET_DEVICE)
+			goto bad;
 		b->alg = ceph_decode_8(p);
 		if (b->alg != alg) {
 			b->alg = 0;
-- 
2.47.3

