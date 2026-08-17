Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AE37F331
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994142; cv=none; b=IT+EtCm3n4RmA82cHUeAn5oM6Hu3sFOfOjSHk91Iqbf6sQfKkphDdgJyPqEpa6RehhPur61+Jgw/iEf3zP2gQ/q65hqcCLAi1/qVqW1qp6ppdLdf/weYIVjxqEVvkMS2gs0JJ31wU4UaMZ8IAZh5YM2vcy6sRsT7wP6lSHwCWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994142; c=relaxed/simple;
	bh=Py9gUMYDLXU7l1TUEJ0L6HzvJXCNw6ptCakw/+crsQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrzsrB6q6c/4Wkr8HoigpfaPIbzaSSb0s5WzYT+OFOI9t0Y1DhyS7jwCAGxSn8zYQtzJNMF90KhArBMktLUBpU/ALmOFoYtinkhfiN/on8wepe/4+yVehgXc6nGj9hJn2bW0xo+4HEU3LolowdvQQTsO1hJ7x2UnYOlhYj+bPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=aQ2iaOWu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=MWQUkMAJ; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="aQ2iaOWu";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="MWQUkMAJ"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIvgAv3766642
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=GWf7
	W7btzDJ2DedURkbQJEOrdsj9qNB2OmbEzhz1xwo=; b=aQ2iaOWu/u9y5uDpTyJk
	mg63Q43oqYRBLEtM3bWQdOMGQBnMy/ewC6GuzPhp4gssH294S97auQcmFiFDjGWv
	I6MHFNLOkvfeRi8xBXTzbgU+S34m96INXoYVTJtqIKpvMFbqELHEM04yUPhHn1Q8
	A/R4xZyBdvl6tzrqDd89Hj83LJSAckC08fdZ5KW6RxoY9mzgRGhGQwLbdKqmyJY+
	kOvaQsdXalqU5ECHyfxCLy45SrMcZe7hLbtkcYQhaKSUcMWsaH/u09BAgjlxxAi0
	0GJxkbF08m7yAvyuL0AA7bPuGZW8+sL5md58v10GAM/+CcXWDe/BZAmvvr/kehSY
	pA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g481r85fv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:40 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936d067836eso391560185a.0
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994139; x=1787598939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWf7W7btzDJ2DedURkbQJEOrdsj9qNB2OmbEzhz1xwo=;
        b=MWQUkMAJwL7Tixx9u/cxj5qMp5LaHyRU3lCP8L4Up5tq7KabnAodNe0Od7LGL8W+ge
         2Imn8CQ2KaC7fVc5MaaZsuT70zZZ8YMhPpi2Y4UnFrRTmQFBQbFXDMe/HwmrLpOf88My
         q9QIiHo5KFxrIolEwdeCiPegbtUg19eQVqiDxraWPwoD8NtXC3Ain3Ir7vfh352atYyy
         Gl7R4LaimNrKIaI2yZY5osCNS6OZBYuynqLYnowkpvHeYfWwySt1ROGatj5x8uJcMtw+
         Cxnj3IpDLfjLiiv0HUq5lHWsD3vlFKTcogm0ySk8malQdPSOpGFyq6lVQpT4jg875a0E
         9hCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994139; x=1787598939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWf7W7btzDJ2DedURkbQJEOrdsj9qNB2OmbEzhz1xwo=;
        b=dXXwARWdFgzoQhP71HUgyCc7SmzVyXHP9JHD+i5mNnlJNJ5eD02cqR/gVhn0UmY3bE
         qqm0KLYpytLJEfZ8nmzntyeyOu6vTKJK/94nXfcqDJR0LTw08EDmvSr//SqA0wJIMQcO
         anHDMAnRItybn4iioAPe8M8GFx+Ivf/g8pFsH1dX4//2Gi4KgtirVB8+IV/Zjbdk1d1Y
         Dwtn1mRgOF7SGZrNADQ/cODZJe7ZUepnCGnEs6sftpc9cSQT+EAUNwd3B8NYtHhTPDjx
         jWxxFWkXoszw5zazw2qMe21aC2vs7Hzzvyc0hXp6sO03z71h2IibgUEWKiMwpUIFHacO
         jxHA==
X-Gm-Message-State: AOJu0Yz159XBuLYF2jGJcn+vl2PFIOkL33luLYcd9Cm5b2qKu1JD+eOq
	3D27vAbcb+evPbpnFM2C5QuN8gNGOftjy2hSUJDxRyG11+RpBfpz7QnI4u0QORRDRFfyIVNlxaV
	5DQopc7TTarlnsn8Dfj6UOM2FFWe8oCwLoOdCREHf201/1wyUlj+guYvxmGw=
X-Gm-Gg: AR+sD11HYZ5dbWlY8ZAxb9fS0GQl8Y+dr20ya7aNfKte6KoRQ4D/zSDXbX6QaEVFt9i
	I9uIDMfASTKo8VMwAw6LdYXqb4koSaIue3hAyFEc/5JPrt9UaCh9zIdZki+6B/rz18izvdroz/S
	YlS8Ddy3p7Cu1Gnl9DYkX5xtS3qIFk1nBTSL2cvqkxI8wzqpc1bC80ISI3t6nRL0LxLm/NpuUre
	xVxeOnQDzgSNTy1zyzJNLm4m17DnQbFdcKZVDkhyR/cBr1/pkZXFn53Ef1gOBjvUeu/xy44fHZ/
	Q6z2NL4Il3k6irWs/UY+UI1bdeLovToZ3H5b25ZdudOh09VomdxfoSAec+v3apUwbWrhRfsS6Pk
	ISSBzBkpR
X-Received: by 2002:a05:620a:a18a:20b0:936:31c9:6c57 with SMTP id af79cd13be357-936d2145af8mr2163067285a.7.1786994139710;
        Mon, 17 Aug 2026 12:15:39 -0700 (PDT)
X-Received: by 2002:a05:620a:a18a:20b0:936:31c9:6c57 with SMTP id af79cd13be357-936d2145af8mr2163060885a.7.1786994139218;
        Mon, 17 Aug 2026 12:15:39 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:38 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:23 -0400
Subject: [PATCH v4 07/10] ceph: remove page remnants from
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-7-0e5e53d47eb0@columbia.edu>
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
In-Reply-To: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
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
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=2482;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Py9gUMYDLXU7l1TUEJ0L6HzvJXCNw6ptCakw/+crsQc=;
 b=KnKavewnMLt7GfgB/b9gNamxCvAKCVliqz/Nl42GLPbGPgNz4HqeqCOPrXbTI4+qdxkMA50j4
 O4CmW/Hz5AbBwj/z9IrdWPBS9SXjRb5arFT/T2ZJwzAs+6gmLmK7RuD
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX3NFEUVvh4PGN
 7la3Vv1O8t+2IN7YhRDwvathEUhSYNh2qeSZm0ClBB0rW+EI1CaDglr2PIrkFrcB+aEInCVW6pb
 sRJI8hwE6//2JVc6Bb7LrAiPyQp7rVZvpXbaF9YOkpPzHLO+D8V0PajgHdxqNb6JMH4qklTSfKV
 pV4dcYZQO/93ilxy/dccqzpKksEdLT2LWRkXj2HjZKpCNJi3snm6tzOA7MT/X023L+3nkKdIzqv
 NnASnFFq4ny0enQsydNbbsR3067HyI4rMHYVwt7xjTNU6vUJ7PZ1lzN8QY+ff3O0G30TE/8RwHk
 KIkjUphxCem7JZYZcXpPloNuOJWGZ/6LKdKlfcN51V2odWwrzh8/ox9uRkF4csSuVuVDbuFO1Kk
 fASz0M4a+tQsgiIPR+iYf4CIV4o7siYO5od/1kIFq+xdoco9iN067RsDafD9X7Jy/a2AVtFs7Lg
 jlxCcKKgv0jj+VXKgjg==
X-Authority-Analysis: v=2.4 cv=PKw/P/qC c=1 sm=1 tr=0 ts=6a835ddc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=vHg950cVU3XL5QtsloQA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 56PPVo_u4oJCdJpUAQJA_aX_q0sLgK--
X-Proofpoint-GUID: 56PPVo_u4oJCdJpUAQJA_aX_q0sLgK--
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfXzdAb0nYvWW+g
 LsrK2Rz797ivqVqcjG0Go0UZlunZX7zWV+zKXeYyYxOW+wxj4FN4c5NmxNp3/DJNvcZPBUPeiYw
 BJv+o1DdgmS1MLgZkNXY7iVLpGmX6QB6w5cmmLoaMpcHODFWhhof
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=10 lowpriorityscore=10 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

Use ceph_folio_start_fscache() and only use a struct page pointer at the
osd_req_op_extent_osd_data_pages() boundary, which requires a page
array. This removes a call to compound_head() in
ceph_set_page_fscache().

This was the last user of ceph_set_page_fscache(), so remove it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2d89d3d51bf1..756d44eae838 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -558,11 +558,6 @@ static void ceph_folio_start_fscache(struct folio *folio)
 	folio_start_private_2(folio); /* [DEPRECATED] */
 }
 
-static void ceph_set_page_fscache(struct page *page)
-{
-	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
-}
-
 static void ceph_folio_wait_fscache(struct folio *folio)
 {
 	folio_wait_private_2(folio); /* [DEPRECATED] */
@@ -589,10 +584,6 @@ static inline void ceph_folio_start_fscache(struct folio *folio)
 {
 }
 
-static inline void ceph_set_page_fscache(struct page *page)
-{
-}
-
 static inline void ceph_folio_wait_fscache(struct folio *folio)
 {
 }
@@ -743,7 +734,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 static int write_folio_nounlock(struct folio *folio,
 		struct writeback_control *wbc)
 {
-	struct page *page = &folio->page;
+	struct page *page;
 	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -825,7 +816,7 @@ static int write_folio_nounlock(struct folio *folio,
 
 	folio_start_writeback(folio);
 	if (caching)
-		ceph_set_page_fscache(&folio->page);
+		ceph_folio_start_fscache(folio);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -845,9 +836,8 @@ static int write_folio_nounlock(struct folio *folio,
 
 	/* it may be a short write due to an object boundary */
 	WARN_ON_ONCE(len > folio_size(folio));
-	osd_req_op_extent_osd_data_pages(req, 0,
-			bounce_page ? &bounce_page : &page, wlen, 0,
-			false, false);
+	page = bounce_page ? bounce_page : &folio->page;
+	osd_req_op_extent_osd_data_pages(req, 0, &page, wlen, 0, false, false);
 	doutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
 	      ceph_vinop(inode), page_off, len, wlen,
 	      IS_ENCRYPTED(inode) ? "" : "not ");

-- 
2.39.5

