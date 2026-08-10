Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A613F86E0
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371686; cv=none; b=GsmYlkOv9YqzkPxi6xQo8sWFjlYqhMsgz1ER757k8uEyyDwkWn8uim7whfLEg6Fi2XOcODINHf2rc8lr/MA5VN1vO69z6DZ+Ifnd3TJz8ZCiUtS9KRszBqhHH7UisFPEUTugTepmqUofY2CbWK5uQ0HGGrUp8Hqu+h2k+NPmyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371686; c=relaxed/simple;
	bh=6dxbAtDCmrnDYkfOuWrS6UKuWVd+lmgUjReNrbBmSH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8kLt2UIPfhhDAfDUcJLd+qG70yCpIKr0Coqto5BYhEAQ6VpstEa+vpVNjAE5zF4t8ypk+XJr8o/46/E3+qX3aoezR/gW1UH0bzRuJqPqeq/gl3I1sk1xQT4J99VztUUQIAFdnYO0isQuGhFaRaKhl9l9rMmLkCevoZfWTlLeU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=a4TWNTA0; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="a4TWNTA0"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACa9Jx2933042
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=0np+
	Mh4g6FbtGTotF1tdHYY92zqeAhsY3aQwW/2FAQ4=; b=a4TWNTA0jldsAoQxZpdx
	gKVTI89o/WtLiku4lqWkbaqHIimCfvpBOsgmQ3NajBr6av3Jpzs89t9CNmBh7f2o
	pzbEZyuRQSQbgKiVFtnMjWs+j5H3OnPItob8B9Dd1sZxJxtbG+RFPFg7vhx7GrgW
	ImrBI4iVxj2sJDW/QYuOBwgzVJyurI/l5jpngzk/or2XmHNedXJ906ILCXFqu0+T
	uNXrQpW6xeFnMltsG4qhCFkSiXXTntJoht255EHo1peTIMWpX7fTQJFYpl8LPYgk
	h5uu9ArmsWvSbwlSIS4z4J0dnYIpex7PF+bzADVBDv2Pb2rhVsBL38kgUv1Dz+zD
	+A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fy0rmkcfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:16 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bff5c7035so40791091cf.2
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371676; x=1786976476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0np+Mh4g6FbtGTotF1tdHYY92zqeAhsY3aQwW/2FAQ4=;
        b=L1hPGXqyykIHce4riY7cPtybzKC4Tf9fmwyAl0/pSUGDfrRY4/igKSgXTlu3obIPY0
         nH4trp0JRIsDHTHn3lTmB+EOdRF72Xl21Pv2r8Jq7eASpmtTDJQcoJvE6blW2uaQwiN+
         2LqoWRJwlcLOcAynq0A2qgxPB3yoS6id777cqHwlwC/Y7u6qhjM31IQdE6ndGvv1JOmI
         +Ql+gOZHV+CIEbT/JeM2CT6IaGYKzbCt8G2+dn1s8xEdruqFTzNkdgKiF3MMmV+3TqyT
         sWmTFIzWdnqBIQ4Q2qdyxFn1qP40KdCr0ApVuglL7HJ0+sEXIXWtX9AromZDPu8K3bc1
         d5Xg==
X-Gm-Message-State: AOJu0YwP/Q2w2SHAn3XC69EATA2O7ViPZ8PFoneZR3tveIYfjbtN4Agy
	jHuhxgIKcUbvxILW6XtHHiBqLvuqb5XcbHskppL2/V3jIxXXXz/MBeA0MyjJrsCX1kPOfPkZTRq
	DOsasdwCnFc72Yw9J1oEGCz+tBiIjUVdLCKnq5Rgqdd7XEGFxXSDOkdoETU8=
X-Gm-Gg: AR+sD11UmTir2Gxn1Jh+5o6MY4y/xcNgNNvAN+JVkfVVPrVlUdf8rxLV+kOSAOZXpy0
	i2UGftKjQ4Qe5m7IwyXg1cpjnhc9TY1x/kASY8XNXoRYlnlvzWBZsjliZL0crS34IlbOxPVvLIm
	fG0EwEDJOETFtGeGPnVdsUc4L1Ba6a7xOK0VjAlFGwc880RQKWsx873gj0TUaJuAUy+f6yzUVyg
	AV0+VnOLtJoYjyaWjzaYCiSyQNMbKbfDv7Wgy86B/ED1i6R7rtQ+540xaP5pp4PsLcMG7pebVlm
	9Ua70Vbj4g3nl8+mJNDnO+A7CcRu9kfruGjkiJ3qVjZKypjvm80jhE3psY8djT/I/GnrAKHY1iz
	o6lZY1jSK
X-Received: by 2002:ac8:6f08:0:b0:52b:4f1a:5fde with SMTP id d75a77b69052e-52d4bbae79bmr27114461cf.19.1786371675795;
        Mon, 10 Aug 2026 07:21:15 -0700 (PDT)
X-Received: by 2002:ac8:6f08:0:b0:52b:4f1a:5fde with SMTP id d75a77b69052e-52d4bbae79bmr27113101cf.19.1786371675218;
        Mon, 10 Aug 2026 07:21:15 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:14 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:16 -0400
Subject: [PATCH v3 05/12] mm: remove wait_on_page_writeback()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-5-dd7531704f26@columbia.edu>
References: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
In-Reply-To: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=1451;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=6dxbAtDCmrnDYkfOuWrS6UKuWVd+lmgUjReNrbBmSH4=;
 b=61yGVyVUUcoA+BeFj6z7ZvMKTrknl5Vy07EqPr8fQbcEitcS02/CCYCNWVboS8DvW4Ni4Bvq1
 Ka4sfab8C3RD10XylVk59bT0fPLpe6Z6WhfUVMqvXYkJBpnLyaK94HK
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=6a79de5c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=qBqFc3eaEPVjc8k8qNUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX1mTJYeiUz5Mq
 vcaC0GBWnilcYdZJ64GPNs6kY8aNwFEYHKBFvhq15AvIHa+Aa+KvZifCrOG1oxbRwOFFKKEQXBn
 cn28NvIcW2D9K5pUpp88CTq7ooVlumqtiwcyfGIB5clKcRXwNdQ6
X-Proofpoint-ORIG-GUID: cEWbG4O4WY9G7kw_E7kEdj2ESwOUxUVM
X-Proofpoint-GUID: cEWbG4O4WY9G7kw_E7kEdj2ESwOUxUVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX8rpbBpNkKijp
 yIr733NJ2UY3PmumzOtmbqkEo/RgFQbi3muKGr1snmAxqVP/DXvIuoOhYf24aO1S/gB199gHsf+
 yZCYr25/SEEGj5qSAMq5ILPrAyrtODX4ZyTGQN6r+wMZ93s3jpwZYKWcAVjIY4JuQhwvxZvefeb
 ze51p0JGXVR4w5VFIPvIdXrt/mcHv2eA3QMAxdbOyuxyrO+THl2elNkcx50Y3WhtUw1i86rV3pC
 /7gnebw9cITHM5sUorYL1yG7b77SXCSZhHd31YrrZqRf3FLCWWXv2yzvBfl/r1LTKh3HRY9ctEM
 0GuzntNwtvm1HsdVHhXs9cT5l5CGNjilclgLKuK/f+FP6oI06G2H/kOBrMUS770C8DII5ZtV/YC
 JKx5U8aK+b+ij/RhvaWmN8WG57KEOIhpK7U3Jifv5eg5tchXUuXjonvJFOsXEiuMRItzi9M0ZPE
 lyZ2xyAx8MXjvx8UfQg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=10 bulkscore=10 lowpriorityscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100123

The last caller was converted to folio_wait_writeback(), so drop the
wait_on_page_writeback() compatibility wrapper and its declaration.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2c3718d592d6..3748dde2b97e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1240,7 +1240,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
 }
 
 void folio_end_read(struct folio *folio, bool success);
-void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index a02179a0bded..ae0271591d37 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -23,12 +23,6 @@ void end_page_writeback(struct page *page)
 }
 EXPORT_SYMBOL(end_page_writeback);
 
-void wait_on_page_writeback(struct page *page)
-{
-	return folio_wait_writeback(page_folio(page));
-}
-EXPORT_SYMBOL_GPL(wait_on_page_writeback);
-
 void mark_page_accessed(struct page *page)
 {
 	folio_mark_accessed(page_folio(page));

-- 
2.39.5

