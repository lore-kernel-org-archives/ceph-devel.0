Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC81340A6C
	for <ceph-devel@vger.kernel.org>; Fri, 19 Jun 2026 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854825; cv=none; b=Cf+1Hq8gSXJ0UreT6JlcjfhfI+ac3PWa64QEz/K9xNZyaafNg6zHmrXOZrQbJdGT7FR5NncUfQZ4Ax0YjUO4JjsSU12+z33A12E+jd/XgKkwVrOI293VG42PqUkjTPVFbci5ZSmkfrFvvgEOv1qclzF7gl8iIa6Go8pawU4Tz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854825; c=relaxed/simple;
	bh=RoS5cpHcYYNir2L9D8p6GDJaFAJlKj3ITVBBgWZlTkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6j12CJI2735kH0D55Gr7zcAi8I5b+rnrnftgkOtcLHAAlftAna9MlA/dgGRaLnijHBg2vewVVx4G59aH10tNivcRev67bNbUqQYsH2GahiF6DKyKj6MfE5K2konKKMJZri0ArnEcx529hKwXq0axoTM+JuUIBW7/hOKrP6bv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app3 (Coremail) with SMTP id ywmowAB3tv5Y8jRqOIooAA--.41671S3;
	Fri, 19 Jun 2026 15:40:12 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	jlayton@kernel.org,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	zzhan461@ucr.edu,
	n05ec@lzu.edu.cn
Subject: [PATCH ceph 1/1] libceph: osdmap: guard missing CRUSH type name lookup
Date: Fri, 19 Jun 2026 15:40:03 +0800
Message-ID: <c6e4a1cef523893d420ba622078fb03219d78747.1781808861.git.zzhan461@ucr.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1781808861.git.zzhan461@ucr.edu>
References: <cover.1781808861.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywmowAB3tv5Y8jRqOIooAA--.41671S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr43AF17XF4DArW3XrW7XFb_yoW8XF4kpF
	W7C3s2yrZrGFW2kF1kJas7XrWYkws3WFy7ZFsYqasYvwn2grnxJr1SqasxZr15Cr45CFW5
	XFsIv34UJwn8JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
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
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0DCWozqlMOZQAAsN

From: Zhao Zhang <zzhan461@ucr.edu>

Localized read selection can walk a parent bucket whose name exists in
the CRUSH map while its type has no matching entry in type_names.
get_immediate_parent() then dereferences a NULL type_cn and passes an
invalid pointer into strcmp(), causing a null-ptr-deref.

Skip such malformed parent buckets unless both the bucket name and type
name metadata are present. This keeps malformed hierarchy data from
crashing locality lookup and safely falls back to "not local".

Fixes: 117d96a04f00 ("libceph: support for balanced and localized reads")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/ceph/osdmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8b5b0587a0cf..5eb50d9c1361 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -3055,8 +3055,11 @@ static int get_immediate_parent(struct crush_map *c, int id,
 			if (b->items[j] != id)
 				continue;
 
-			*parent_type_id = b->type;
 			type_cn = lookup_crush_name(&c->type_names, b->type);
+			if (!type_cn)
+				continue;
+
+			*parent_type_id = b->type;
 			parent_loc->cl_type_name = type_cn->cn_name;
 			parent_loc->cl_name = cn->cn_name;
 			return b->id;
-- 
2.47.3

