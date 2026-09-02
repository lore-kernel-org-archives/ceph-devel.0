Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B283D47BF
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366936; cv=none; b=BYDlH5nXu/c2Q7qFc/v0kG7eHVyKwoGaqDwtz8czOdV1eiwMSfjupOoRmMLaMlUSlEEFvgq6LSrAZSLEzVZtQS5Qg1K4/I3iVgZ34S8wskgWmegsvdTofxM9JouCGX0s2xo2bULRe0OfvmtGavlTqA7VfuDzEc9NlHkPad1eBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366936; c=relaxed/simple;
	bh=YdiGCRpQjCWzo2cMclgu7t5u4t6xpOWcqmE9OMihhuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rYNCeowtawe9TWw3i74exJPUFkpvQa9K11dv9zaMvUdK6dL8lfLeuNhsPVaD0KH8uYZIbqhVWrraNsnEYa6I4ySv5FE+aV9+sKd8/yuizO05m8LXBWY3+5MAFGNz0vvPt4vWml78sN+R+UU+dne7kdqWAA++ZJThX0gLZV8P+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=uKLdfK+f; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=b57LGVNu; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="uKLdfK+f";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="b57LGVNu"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682GZMdZ608122
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=YHN1
	7pp/W44dKH+wY/7x1N+HJAhV2v9M+ycLDIQQfM0=; b=uKLdfK+fFvzpz4czc7Df
	QFm7FRvb2ZQs3OZdLbOC70gHvYfzFv4M3r5Q4OQjAB4+2wb3Gia5E8udYRN5wcuP
	MZ0icg1/LerjhALhi4xhyGq8Pi4uLnPxo/txtxykqVkGh1QFQn3zBCU02gsvehbM
	8eHjE1uGWSEgK3lM4t6jFmfATShPmwE8hyiLEfv5IXMVidVeiSRxfm4SlIToKU5U
	OmWmN+2O6Sj5uHugyS7c9x2TOMoTbDuvWNrMBmltOTXcfayGLaJwTXlI2FEk+iqz
	sivpUFkfKSXw4FkmEHtlk175v8xHp3Egnc6MtloX5nly1PYtQ8UpQcRPS8ZEzQIN
	fQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gec25m561-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:35:32 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90ce7ebc25bso26473546d6.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788366931; x=1788971731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YHN17pp/W44dKH+wY/7x1N+HJAhV2v9M+ycLDIQQfM0=;
        b=b57LGVNu1mYcaKQ4NqpYpM425PfGOYCfZZYUlQ2vk5uIJj2zJ5vd337EnPNvDfNtnh
         /VwqbKZKawmnO4EPBy246b2Ig8Uu+xwwtfISO7SU4fyKYTSCdFSy4dsiCJ/CefufOfqt
         b6AtNqdMbNwV+vynM/IZZ4+2RTj9jJv3Dc/NCfuZ2EV0/0BxhDrgDQJZsawP0pSNF74f
         SWOIo8qFjfjnQB9ArXPtaYw6d2ARTD5v7y5L3sJGkqDXoi6MxsPn7DbUhzYvQDLYFJsl
         Swe7J+BA62E9Wt28yACaBiTBbYPVBuJIgU180q2a0Pr1RsxhGlZG4WsSSlPZ8g8W71eU
         3JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366931; x=1788971731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YHN17pp/W44dKH+wY/7x1N+HJAhV2v9M+ycLDIQQfM0=;
        b=YKezEmwRq15vzJt1GCKOlkWuaxxDCkX4xa5aCdli6d2TLRZ/UzMw0jSSMAZLHy8zOU
         Bnua0ZKstx8WwQKVvEzSSzr5RZu1Q5AdwL6NEqWLRJqgBFGGHts8Hwl08ojDIc9qgaiK
         +xOqr+KAB7XTl3KQS0Nz+zU7Ty0zhw26gyO3s4QfnBwHiZ/yIoM77Py50gGnwRhym+Ue
         v8Mtp3+B2Ku5ilowfEbiJeUUCxNOdTIaD5I2x9p2STCxpp6K8aY+Oy9uVOupXvkiuqr3
         /CNAIcfDEqT2+2vh4jEWSk3NGby0vLA6EkWbD0lwqBLjCaKy89L683pb1naZ+hU3jT6Q
         O9Ug==
X-Forwarded-Encrypted: i=1; AKwUvBxhCPGdEJCi4LuZSdht08ks5Xhxd2chvBKjfENqipPcXBZbCL3rsi/efYc5Yd2GbWB7L9cUimYlKahL@vger.kernel.org
X-Gm-Message-State: AFuF++k0JxecKVt9qHmZ73CJeekDMsyCDUFSqmy12Qozd7SfexpJ0IA2
	xiQVdoiYOtqKto1jCH/ucGBJdOsec7k/vRtXMXnaQZaSTLTxrIuwAN5kKYUz4IZ7r1ZGYT3M+6U
	3IPyt0WiheJXCeJ8Cdmiz4x3Q8tm+lmYZW+RqF1tRzqLXZnwIR/LNmkD7e38=
X-Gm-Gg: AYBFou26jpwx8LLI1lpyM18CxledTPpLz+PsDoeOCGidkUBRLYjMdL8d7D0q87u5Ckw
	fmDG/p6n/5f6VDmItnsBBZfxlg8f3rn5Wk+LI4JingdQa4gXZdeVi4Dmoyd4cBv5yiIfkk3RRtM
	seCoUKHY0N+J//dYnyxuMgz2XVgR2C1KM3I8AMNfb80+593Ox7ZvgO6GBGzXnevqvBp2lKmdzQ0
	e/OaEGDZnINmbxnTtHcWvqUsnMFlwRdM0PQiQ/aYqHh63ulOAQ0zULAEQWS+E0j6aHMHRaRO4Lj
	DOjCcdWX4Pnng3ejIz1H0UYAYkp9L8ICwz2DIhUwQctk1KgSzCPzXmAQUKdW9TZ9O0T31svI9Hu
	K+pQhCHQs2v4LlzTBDK+W40NgYqUzT2uQZHC88TwYnXqZWxM0jDpEyw==
X-Received: by 2002:a05:6214:e42:b0:8e5:d7d1:7bf with SMTP id 6a1803df08f44-90ebafc405fmr87709826d6.4.1788366931574;
        Wed, 02 Sep 2026 09:35:31 -0700 (PDT)
X-Received: by 2002:a05:6214:e42:b0:8e5:d7d1:7bf with SMTP id 6a1803df08f44-90ebafc405fmr87709226d6.4.1788366931111;
        Wed, 02 Sep 2026 09:35:31 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eef5067sm21805726d6.34.2026.09.02.09.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:35:30 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:35:07 -0400
Subject: [PATCH v2 1/5] ceph: use a folio in ceph_get_caps()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ceph-inline-folio-v2-1-6c9098112352@columbia.edu>
References: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
In-Reply-To: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubli@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788366929; l=1061;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=YdiGCRpQjCWzo2cMclgu7t5u4t6xpOWcqmE9OMihhuY=;
 b=xXUo6K6vjQmwvcVP9oNSV3jgm9ylsc5ppGYvIc1vfHdt/9uPtM90FKGEyH3bGm8KAyHqdGab/
 7M2KHVwUmmUBybzEVuskqnFCzYRH03yNoV7n3MItgTahshJHbmiA1S3
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX4/BsE8lfJz7s
 kPRfH+jtCdovcVB2o6qtRWmIjMmJIlyVeulgMigwD9dwNG4y5fDVpAie6fGWGmKCu+2lMWyoImm
 fc0SYlnzxdfVC8ISWo4IYoWOCPR5PQflLE6AvjL4Kd6Yv5wzoZMu
X-Proofpoint-GUID: dY1TuR4HlTWzndMmY2p4TbGxMPEtVW8-
X-Proofpoint-ORIG-GUID: dY1TuR4HlTWzndMmY2p4TbGxMPEtVW8-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX3wrCVlAy1Jbc
 U2bS9uJmuoQqhhRUIfHF5IfnZOPOoYOf1fEKswNrWHw4zpTc4ibtL1Fho/rKp8nNfmU+UYyZllu
 tuRBFmWcG5wJk9OqffoVVd2WOF3ahXneUunxTBZOWYYKLpBSJjoZzRVi3CIV7mmM42Wvgjlf9WF
 HBvievDCltTylsidXysu9rStHLV0g1ddj18UQiOaW0lC7Vg6jd8ESNDgr7QRF6ibaUkZgUdaraA
 0sXQZDu+IHPEYA8735OxNR6YHY6GVRDpTpWMRoEB3Q36JDZK/GBO6QP5sp8g88J+nsPUwCkvSBQ
 UsF7MiJnMf/u7tIKuvMykCcHzz4EPTSg0Ad7rzvgvp39rSv31cXMSzxEPm9IDhAK27sHYXkb86C
 x53vBbNy9PxFISGACGX8VKfRYRQ/0sXjo386zd13ejILnOGVdF5Hy0ZlyKgURZ1TKe20VYo8F+X
 tRCjwkdzzUHoiWUUwKA==
X-Authority-Analysis: v=2.4 cv=BpWtB4X5 c=1 sm=1 tr=0 ts=6a985054 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=nQxxII3xdzKgKN-BukEA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=10
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020146

Convert the inline data page cache check to filemap_get_folio(), which
returns an ERR_PTR instead of NULL when no folio is present. Saves two
calls to compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/caps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 1847badddd87..5be858df0a4d 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3202,12 +3202,12 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 		    ceph_has_inline_data(ci) &&
 		    (_got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) &&
 		    i_size_read(inode) > 0) {
-			struct page *page =
-				find_get_page(inode->i_mapping, 0);
-			if (page) {
-				bool uptodate = PageUptodate(page);
+			struct folio *folio =
+				filemap_get_folio(inode->i_mapping, 0);
+			if (!IS_ERR(folio)) {
+				bool uptodate = folio_test_uptodate(folio);
 
-				put_page(page);
+				folio_put(folio);
 				if (uptodate)
 					break;
 			}

-- 
2.39.5

