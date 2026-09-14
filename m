Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A43BB40
	for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789344221; cv=none; b=SkTI4Ak/dMyhL+OdbI/sRhgOW+uud81n36SmCfVULkfdclqXgUjrh05B5kv5GufGh3dcrJXluh44J8iWsdkkXxhNrYuGLemqNtBfgaVtFa8jN6SOTfQ2z4PHUUthkHpwHmeyWIe514oN3PU0W7lgyq/v+MLxEkjuWLXWGR17w5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789344221; c=relaxed/simple;
	bh=wKhSu78++sh0O9IkgXyrWNCfNBExKUA7HjL9LndaCY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mdfJU3c0coGMdcQb/mJGyfoIY4h6Q+uZ0al9cbzXa30vR3R++exGePaGr2tyXTraVzc8oarbksvb2DSvcfqNF6KeVtHsvhL5/i4WRCRbbtOOBm6no/HUMOU8LAdJ/JXAZDdGgwS4yLMQ1J5j2+FhUijw+JolZ8e8D6bmXgz2ukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=rUomLr9H; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=4PCwKYjb; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="rUomLr9H";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="4PCwKYjb"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DMZXtn1949250
	for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 20:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=d8Bp
	P5sa7O6Wqm4yfg6fCZkf4/CrH02Fjev0pGAt2Q0=; b=rUomLr9H2LJqC4bjXVKG
	H6ocbSAp4SsWggEryeR7o8EtAc2MsF6EmHrK2J69Z9xLXMLCvZ1mYU6E9ffiL9Ds
	AEIejzxDPbegD0b4mfUTvqTinTKzC2cj/Wb9fw/nxfiNbiCkCUc1Nc4rQFW3P4LL
	Ro47DeIa6MH4XzG3KZxc9g28JzImbyTj2LLXdWrOPmwbJW1AnLpMav/XqrvCY7z1
	r+1noQHnfRi4OUV6auvIlr2/uxVmRhQtL9bOCGTKSxAquE7OQoUs7v/15+Ezo8WP
	Rg8WwSafrNxDYh6gdHyuM70xMp2HXqZTEnihXY2qPFZH6N8GjlHhVRDL7n424YW7
	BQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gp1d1h2m2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 20:03:39 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939f27c80a3so530414585a.1
        for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 17:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789344218; x=1789949018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d8BpP5sa7O6Wqm4yfg6fCZkf4/CrH02Fjev0pGAt2Q0=;
        b=4PCwKYjbgrPzAHGLiGEXy0j+PcoiNxpBaqx8ThuXkoUmnKZwlFThEd6pXMq/UXq6hr
         IEBC6tV9qN1UCqGTdIcE0mW6JA71eOBh4agIUa/wsAzdxygp/hgD0RDefpsW9hU8AiLF
         1z09x+foYyjYD8j0NuI+1wAmO6IycB8U5byQD6KQAxyKPTGmnJIrCrd8js04IfE2RKsy
         O/IOTGYwUy2FlU7fSDOf6d/C6nf9ZdG2YxdP0hHoCCk01c45ycVC8PRSMwq9JQw76iH0
         64hr++sjuhfG/hiYRK3BHFmhrBl7eOKqfcSS6+O/zCVB8hvtLHLe/uvJ4vFFGPuJW1Um
         QYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789344218; x=1789949018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8BpP5sa7O6Wqm4yfg6fCZkf4/CrH02Fjev0pGAt2Q0=;
        b=EWDiHDOopDdYa0O5D405T7ENehaObuLiWWxivKmv0laK7sF2SWL3ZxquIqJkQD/oI1
         UY8mEl7bP4cRIVav/QKKUneD5PQ6VGXN1peM3bUOvTQOWeh8SOK0DIvuBtyDxlsmuduJ
         t1AUoNcjA29LBE6GWPTZp0EciHFoDEuAYkZpsXD3Bp1uq3j2mhFfpxzBuDMR9D6BicYr
         I8z9u9N7lsEuOm6sq8/CFRoVDT3g3cIFGlnYlBUvoynbwMxiS+e6ILrU60YM79cySoh0
         y3lKFF2qaCcIm3V/6qWcFgavTchemGrwNQ8u3q1fd+TsV3T7jqzEZVTt3zlhDSYU2Cmb
         Q5TQ==
X-Gm-Message-State: AFuF++lbwAkdFMA5qF4mWnkDocON3W8qvxzbO15huVA3AL51E+EsxV2/
	weBKV903iZlsofOI/tKb4f/jdWJtFhfVXWrR/EOJJmvwuri2QqBhHNoTbko1a0cbHHXuRZcd5LB
	m+13oiq7RB0C3BEG1lZgWUJ9whQnwYofYKgQFqxhCTXmDkU49I5LnD2Pb8ao=
X-Gm-Gg: AYBFou2OzYnwjzHVUjA7futITj/9t9n17o0SD7LpC8Us2ikrCLTgkC/GAUJjhFArLqM
	auaWm8E1FmUH0Q2HttwE+FOh+ZYKyLZPScad8JttvaZrrYzmcsm9vgRSuxH07C4QW2dMekqtEMD
	b41GTGrOoSuCi09odqG3YNd9yimNiIsy5KJYQI8hLsrddiwvGifuHPmmFqxWcwKPgox0KrhEeNn
	D+W8CK3WBrrG9Kdib3O1uBawtcwfLVulsZxjWmLQizTpBeZgU1IO6m8/Buogb+uYYye1KStjz/y
	KusWJT2SiHCb92d877RzBiXRyyj9f/HsaYY9+vqENZuJDK+4IobGfLotNhR/E5dT5C0XSMTmKiC
	ppVNFgKNKyaefJySVtkB5odlY6i6PkvMInd9qM3j/lkPFqrTpnQBt8Q==
X-Received: by 2002:a05:620a:258b:b0:939:cb1a:2c5b with SMTP id af79cd13be357-93a2973a2bbmr58834985a.11.1789344218596;
        Sun, 13 Sep 2026 17:03:38 -0700 (PDT)
X-Received: by 2002:a05:620a:258b:b0:939:cb1a:2c5b with SMTP id af79cd13be357-93a2973a2bbmr58829785a.11.1789344218250;
        Sun, 13 Sep 2026 17:03:38 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-179-215.net.columbia.edu. [128.59.179.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f19291sm872250985a.10.2026.09.13.17.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 17:03:37 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 13 Sep 2026 20:03:06 -0400
Subject: [PATCH 2/2] ceph: use alloc_page() in fill_fscrypt_truncate()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-ceph-alloc-page-v1-2-c436f2f4c068@columbia.edu>
References: <20260913-ceph-alloc-page-v1-0-c436f2f4c068@columbia.edu>
In-Reply-To: <20260913-ceph-alloc-page-v1-0-c436f2f4c068@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789344215; l=778;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=wKhSu78++sh0O9IkgXyrWNCfNBExKUA7HjL9LndaCY4=;
 b=6OUHHi2HuQ9MoDnsaAAZdVDjVxYGhltRL2Cg33Tqccv7lFjOyfUJQqe1UpStctg/dOKrqVc9k
 7o1eX5bfWJYBlUNyF6fjw3PNErxMKHBk88gzla67phSe2uPE6+8zpHO
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: U4mor4kMzdN6zRSX7qGHhw7kljFKbgYH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDM0NSBTYWx0ZWRfX3a/UFpKgpFOZ
 sW7rZAXn/rEpLZBtDu83lPyOnVoJtttMqD1N0hQAQBFb4CJWg9rRv8LRqWHA7SORXoZhLbdgz9A
 lBioUe9yfr9Oha/k5S5GRGeImiyA8jdAcx/FQH81fvyfq/JVX/5Bk5BGqHlWnQ1+zcOtxwSbyUn
 C/Ux9maDOtvFLC/6fUUd4S6wQz/xQ9MeNUZZYlGQcCsJFIK18mSdUJJJFb3/SoaFUGlFRB/myD6
 //uvXMhW7KEH/ReOZQVC6jjmqh9ggHl4mCJwmt0qHUDpNGBea+buD+Sj1a2mN58BNZ1KfVOJmyu
 H0MmWFkP1y/SJS82xltR35zX/nt932ZyqO48ewxfNlegAL9n4Xqm+pI2r6xRqmpYkSoiHLGuZo3
 CCBoOqUb74kNY+RY8rUNoQ9Mfl0gMic7p7LSGlHIDXnOy7ae3VGIIiUupkvGT9NHoKK7fh8WbMv
 FPJwVnHWXn66Y+wI25Q==
X-Authority-Analysis: v=2.4 cv=PZxqFShd c=1 sm=1 tr=0 ts=6aa739db cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=2jelXx5xVcRIF5zNctN5Qg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=nQLs2myRgPBXMuZXUeQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: U4mor4kMzdN6zRSX7qGHhw7kljFKbgYH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDM0NSBTYWx0ZWRfX05EBWBNzgUQo
 AUlntiZWMkXj2zp63lm4qdNh2e1mdxwNb3tn99yMgxl/JEG7tIyHZTGi1BKb/RM77tKtm5TeVXX
 oSnxAPnm6VqgrzVQMWq2eIko7VA1QCBSySe7dSSuhVkj2levict+
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11904
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=10 phishscore=0
 impostorscore=10 priorityscore=1501 adultscore=0 bulkscore=10 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130345

fill_fscrypt_truncate() allocates a scratch page with
__page_cache_alloc(). The page never enters the page cache and is freed
with __free_pages(). It does not need the cpuset memory spread policy
that __page_cache_alloc() applies, so use alloc_page() instead.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 149a82f0b3c8..63c3973fbb9d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2547,7 +2547,7 @@ static int fill_fscrypt_truncate(struct inode *inode,
 			goto out;
 	}
 
-	page = __page_cache_alloc(GFP_KERNEL);
+	page = alloc_page(GFP_KERNEL);
 	if (page == NULL) {
 		ret = -ENOMEM;
 		goto out;

-- 
2.39.5

