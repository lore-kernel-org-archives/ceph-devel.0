Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65748262808
	for <ceph-devel@vger.kernel.org>; Sun,  2 Aug 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689625; cv=none; b=XT15GuPtMGqgfaa5KO45VJPdnYDt5/5Yh2KOfwHd7eptywdHsvHpc/WnmmgBEyWaxFhABk6WVRRy04irF1Ua7BP/DA4y7e1xSfojVPg2fx1DG+aeu5eEDqAN8Kcp8dNzZLs5Ngnl9tVKGPWqIlbNkVB2jt6RB5jeWphn9y6TJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689625; c=relaxed/simple;
	bh=E+7MzW7ymcOmm2fAOpewcVRXAlWP28GQ8bwE/xkarAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXIGiyc8zlJC0Na7A88JqGzwx122mqk/h6DytSFRqhl1ZQzJlECUhJJrNLthPcJdBZjNl+geZdvrffoGlWN554n9D9uBMTY45P3fhJIq/ddMnrCAUVP3TPC9ITP3J14vzb5Y9ouzYQH5+3XjSjOleXAxru0wWryozxxbtybDqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lsnrTEqo; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lsnrTEqo"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672DSm0o3509786
	for <ceph-devel@vger.kernel.org>; Sun, 2 Aug 2026 12:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=YgZD
	12vF5o4SjGPupBE5NOIO7mg5JBXcQDcfIckANSI=; b=lsnrTEqo2LT6TEG7vP9k
	kxCnydT7i+KLPh3FM6khNDUcEeh7r3bpmjw4ho9//jQfGfwp6l4lpPAGmI2+/TLG
	gmpB6U/NZJNclhxo/IUGUl+WvenUkYtiYHIuBHI0Hp+E1lyqCa2V4n/S83pOczq4
	sjDiT4+xNLyn231+Gw3p+g2UC21cwg/k+RqhZEIY9L2NP99I4P6rfUH2rbwtjDR3
	wMeYR6qiBnRcnBRpPdBRGimZHPeEZLHfOL7V0ZhfqV3ggSNQiXi9Bynso4c8VuhW
	v7lwlMkbpF0w4g7sxcbaukGlhvOHCbKXU6wbun8NU3jkGMd6KZN6oYWqP6Nv8/K9
	yQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fscuwwt7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 02 Aug 2026 12:53:42 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c07f25de2so19099481cf.3
        for <ceph-devel@vger.kernel.org>; Sun, 02 Aug 2026 09:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785689621; x=1786294421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YgZD12vF5o4SjGPupBE5NOIO7mg5JBXcQDcfIckANSI=;
        b=gq0ix0oVwVFpupeyXCFqgTWhJJtFjZMT5u5qMwvZTtpvJzCJX2Jq7KJh1L2yGlwsuA
         Vt0ZvGTsjfX54fASWrJSkKIMbsMICLq+1XjM8FUDLvmmkvXiqFfZG0IKGdv3BUuwkvJ9
         Aj0xwlCmOn5yWLqFnkcH7A3JSoq+E0USLIN2XrxAUh4Bps0H8ioXHERV+/l8cwo8SPKM
         ADU6tcXp7xFpMQasqkePnR3YWjbdlwRnpgaHlVGx4Q9+ykDDDaYAzrf/QeEjuOVJo6go
         hyjaJX6CpqtsJEV3AJWMKGyrGhE5UTtVkn5IT6kWx/08Iyy9SJQRONd5lEQv9sdimd7+
         IlGQ==
X-Gm-Message-State: AOJu0YxcT/MOmGXujNlb9CzBh5/7JJ/lah76zEb8DkXSnHPESd5hh0D8
	S9H2NqqwH8xI4Ck3fPwnMt8Iqct25t/LrIfOuzS208V3vBKiSZwYrI1nTMlwP0voFlT8r+B0upA
	nLAngf2TTZIMCL2EZuCpGRD+OLrpMF7FFt/pL8+dPJVjnOS/Yj8ipiTaFXYw=
X-Gm-Gg: AR+sD12zaYOvb5cPpM6oId2dEnqRAMUKPV7+brpgBwmEvfjptrnngHndYVfCt5e6NA+
	eIvdub3liGW1l+8tNWRPK0Iy+X0NjNhT42uJDsbsDLWYDO9p3Po2rGkQIL7qDoglTPcVId0CLcQ
	lc/tRR8Af7whyjrhUtpCMBI7xmU4oWWbVk5eZqz1iG3a2IqPPVWm5L6M9waBrgezSsnD33kwCTK
	2kJoUvZOaUzVh6Zc3L9TxAiVx7P1vLlQeD1R3Cb7Hu27KOJOMNeIyp2FlRM3nvi5gNwzoweZKOJ
	xsxeVKb/yqGGWWRlO2hSd+EhP2ojEBRYxjd0sJG3rEU26/t5LB6QJYp4i+OJcNy9paSXAsnQBpZ
	5Kj7fn5pVm9b1ENeXl4ZtUs0bt9gd1u2wNnN8WsorpQKNd1dHDvc=
X-Received: by 2002:a05:622a:1247:b0:51c:844f:28da with SMTP id d75a77b69052e-52b56673bf2mr163448641cf.5.1785689621476;
        Sun, 02 Aug 2026 09:53:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1247:b0:51c:844f:28da with SMTP id d75a77b69052e-52b56673bf2mr163448101cf.5.1785689620984;
        Sun, 02 Aug 2026 09:53:40 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm24064574f8f.34.2026.08.02.09.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 09:53:40 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 02 Aug 2026 12:50:05 -0400
Subject: [PATCH 4/4] ceph: remove page_snap_context()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-remove-wait-on-page-writeback-v1-4-6c35d6b3ad36@columbia.edu>
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
In-Reply-To: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785689606; l=1958;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=E+7MzW7ymcOmm2fAOpewcVRXAlWP28GQ8bwE/xkarAE=;
 b=CGrtCZzmymnOg0P1AnYYYJJhAxmkHbTbgJSoW9X6pUAWQ24AQTP1LclOZq1dzmzHdLFh9Byxb
 fftOg/3aKaoDeb0vSDcCi66HsuVSw4joSRlXCjwpzGhun32idb8IvRp
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: EgZiNdudT7diEONjgq-nTNdjUQ45N1W5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX3ANnuN+ef+l4
 Dn32dMftJ8jsrmBqEmSrQXlzsbIV7jTSXPnDRdiPYnwA+HzvRxhZc5iVIp7BAP/hp7+JDJBwHPI
 9cgl2NtRCUO3EKOCwu/KAFeI1YHHqm1dJ0ps6b+CnzYPJxSxorZR
X-Authority-Analysis: v=2.4 cv=OZmoyBTY c=1 sm=1 tr=0 ts=6a6f7616 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=7ovMhKOaTh8UDYQOW-cA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX0y/HEU7v+u+I
 YDtp2NsbzSivH71f5c7IJPb9BT5jDmLx7qU389I7Y+5fuPNngZvnQEZoEKL/j2wRJiBDQ6fJ45+
 vtJS28V/Z9weKNK34WaaufAx/vPKpMausPGNtWOjb2alpzt7n5yqoax8qSfxnISRJkYvUrsTuTB
 OxweT/eAaYNd5MDURLm5OxZ1aR0PqElI8gAw+DXyIj2YsLaLciWIf3+cC9bMjuZ3AQtuyB7iJ5M
 G4m82sWUiIYYPHVuV2CLUZF/qURoaj2Mi+PYTBmUni52B68w1/MxlM6WKfNT+r0XZtgk5BNey//
 hcISUDRTTM0peEiXx/J8FJ9l7htDTWHTE/7w732BYKq0Io1FS6+J+turpWLBKqCqXvc7qsZXMkF
 /l6CRSSJhU8BE84RCHq2Z1lpW+n92cRdkbnDIL2Cp2d4bCoy01YY0CZ2PRm+SJOsjYP+OjK38wt
 yCc2EGONG3Dq3+eXqxA==
X-Proofpoint-ORIG-GUID: EgZiNdudT7diEONjgq-nTNdjUQ45N1W5
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=10 lowpriorityscore=10 bulkscore=10
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020153

Convert the final caller in get_writepages_data_length() to use a folio
and ceph_folio_snap_context(), then remove page_snap_context().

This drops the last open-coded use of page->private in ceph's writeback
path.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f4aaf9a5f196..702cf5fc1eab 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -29,9 +29,9 @@
  *
  * There are a few funny things going on here.
  *
- * The page->private field is used to reference a struct
- * ceph_snap_context for _every_ dirty page.  This indicates which
- * snapshot the page was logically dirtied in, and thus which snap
+ * The folio->private field is used to reference a struct
+ * ceph_snap_context for _every_ dirty folio.  This indicates which
+ * snapshot the folio was logically dirtied in, and thus which snap
  * context needs to be associated with the osd write during writeback.
  *
  * Similarly, struct ceph_inode_info maintains a set of counters to
@@ -68,13 +68,6 @@
 static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned int len,
 					struct folio **foliop, void **_fsdata);
 
-static inline struct ceph_snap_context *page_snap_context(struct page *page)
-{
-	if (PagePrivate(page))
-		return (void *)page->private;
-	return NULL;
-}
-
 static inline struct ceph_snap_context *ceph_folio_snap_context(struct folio *folio)
 {
 	if (folio_test_private(folio))
@@ -697,7 +690,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 	u64 end = i_size_read(inode);
 	u64 ret;
 
-	snapc = page_snap_context(ceph_fscrypt_pagecache_page(page));
+	snapc = ceph_folio_snap_context(page_folio(ceph_fscrypt_pagecache_page(page)));
 	if (snapc != ci->i_head_snapc) {
 		bool found = false;
 		spin_lock(&ci->i_ceph_lock);

-- 
2.39.5

