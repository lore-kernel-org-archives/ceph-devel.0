Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE637D123
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994135; cv=none; b=EUh3YjxF8uQcdeVBiz+DcJa01wQ3vRVAap61BoB+zbGIbMsHaRGETvcWv4TEq2hvN/dyKbiqVQ4OScCDecjF8HNW7PPA72Xb6qKb+ZgJGccOaZmcQ9jsVFN2j54RZwMj1CpUDOw32eDQ5pJDPgoIg/S37Nybf4Dfu2iQoSVhAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994135; c=relaxed/simple;
	bh=r7cObkaVqRRIL+wdtu2/yPB7QQoopFCx7t+aV7SgOc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kb8AKmAs+ZGdZSztW2rjgsE0iRtmlzsI/DNDUGd5TmYdTSdfUDBIEdzfB7WqKQf58uGBRpAYWHpg+Cz19Lbd9uH0g66lyux9ygnnqCg5AAH1WpY9nyT5FEY1RKNcuq2cxAQVofS9QylqoWVgxFqbH0U7m3GcgRdP+PRtCqWtJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=N12JWwrf; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=WPPDGMIw; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="N12JWwrf";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="WPPDGMIw"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIvmsb3692265
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Fr/Q
	NEus+gmPbGxGS6P4kCT2ytKtU2/npzD38c26G7M=; b=N12JWwrfNxhrI6dS50j8
	yaF/X8kkPkIb3jI/CTI8yAsr8/Do3b8Kl2+S1Iug9aK11uLpGQFWgW482DZfvdOJ
	eCQJnMuDFbXCyXrl34NCRbGdk3y/t8qB7DoHYFJcaIJwx/n6IAyizBe4vHqEHAwv
	JyYRlJ1pX05m4RhBZm4nRqNuKJNnq3opWqAA23rL5srK2nLHVPZyn80At19GbEy5
	y88n+HlVzbB5Ai7kUwjyuNCrg+GIuVwCprksf6xRjsALEPqR7d0+pQ8t7YT3lic7
	2xkozZgnRP8GSuinJNgmtgSIBhJNaarNa6n92UuU2OHb70TCdKdVo6Mra3WvMlJk
	kQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g481r85rp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:27 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-933023a5980so636857885a.3
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994127; x=1787598927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fr/QNEus+gmPbGxGS6P4kCT2ytKtU2/npzD38c26G7M=;
        b=WPPDGMIw82etFtthx6Ymsk9zq7Vvk5saJViN05K2isqglpn8aajdoARWmMy8O2NGgr
         UNQF8oAs6AZnC7cBbuWhXY25wWfGWuPOBRok+kGxe0vWqe2efLQw134dOKG1w/XWoNpr
         T3ia1vg5gBwF40ZCakhWdd6gQl7TevqhmwRvbgS0iepyU2ZCv9hgTXMZPxUIlheewXiX
         gh/djU7dzM6PxGrtp31F36labnpsWZ11w03bopTwGYRUYFJW7NgBvhcT+2BGKizgimuo
         8ZnnNeJ/Y5CqeARJSBWdWb6belbXyvDDPgECKkwpdi63wsaDJxiGKo+0DrVUWTOCHqWj
         U/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994127; x=1787598927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fr/QNEus+gmPbGxGS6P4kCT2ytKtU2/npzD38c26G7M=;
        b=oYRyEAquoF4RzOg0kvnMFwc4DTR6izBhKQsef4mQ6CK+/9m6To8w1vPDcAo2L2rhRk
         w5x+0K5scSXgrFSYXEFjTwgGu48KI4mEZy5VI4T7JZgIDRHmzF0Um+taoI4GcJCtghAV
         AywNFrdoAtRh8cOahlumyHauG3YPa7uMzWKtGOfZRGi0AVnU+Bcrv7lD8yjkRa9IRvZP
         7v8RlAYf1YBTylFp7jtvjB368jLmNJwyinIGDgEAhD/dh4beT5bZhZDo/QvK+eJoYVq+
         V6S7v1R+8uFANSYKpHTuKoIVw0ILvq/ua75724JP782X9ShGjOdPUDm8NHx0JEgqDqN0
         yDsA==
X-Gm-Message-State: AOJu0YwpnZOjhgbpsOjAmTKuYE0w2yYa55L92Q+Bda34T5U64Q0RVIXt
	uke+xmy4kKF3E9moHI3XgTjhVDdqJ2aF7AnDwnTIrYM2AYzebTvbVjdh1hqEYICmEpGFbiupS5I
	4wpZ6hlEpINQh5+gL3zIdgWpq7+cD32QJ9BvUbpZcdc00AiEi4lfwo+gLlXE=
X-Gm-Gg: AR+sD11gwzFqERnVb+OtP0TWA3p1A+fSATBpN1l1FsF6Yv4Ml1I8ovj5G8yeBcX1mPH
	O4kAdZ9eIV2EhOcDrul25kDDYxZ9bvBmIAOiwHNYNvf0eNQ+HGUCKAa3hhmtgcez53v/2kD/wh6
	3m6sAFB68Yk8W0EWWfXSJsu8OoKPhyiFq/eHvKd/WMoCk3aITh0gNN2WMc1G0foX+E+WQ2+3WID
	/mhTG/YSkyWzs9FqNfWNsR1J92wACeD8rpDHtX41J3gCQcaBKWeeMvqfhHTKIzS5MirIa4503qx
	PdtaEN/NHm6U9oZ4VP2G+1f3xLW8xDUAOWIK+pe+kY2OFiS2XuMDR+pmPaUqC09dFkv4VoEnnGn
	S38ANUcdY
X-Received: by 2002:a05:620a:7103:b0:92e:6122:130c with SMTP id af79cd13be357-936d236d3admr2634576685a.34.1786994126499;
        Mon, 17 Aug 2026 12:15:26 -0700 (PDT)
X-Received: by 2002:a05:620a:7103:b0:92e:6122:130c with SMTP id af79cd13be357-936d236d3admr2634567785a.34.1786994125824;
        Mon, 17 Aug 2026 12:15:25 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:24 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:19 -0400
Subject: [PATCH v4 03/10] ceph: add ceph_folio_snap_context()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-3-0e5e53d47eb0@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=2021;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=r7cObkaVqRRIL+wdtu2/yPB7QQoopFCx7t+aV7SgOc8=;
 b=qvfXwcd+71pgd5Ui7KZL0V6VYseBVVLGWlAU21ogyGiBVWB5xn3TcbFuBch3EiRGKffdXoJqp
 qihhI5u3EaDCzyrd6mNyEW6fAIUjT6G9CShNL571mtRopekHEAuEa5z
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfXxQqyt7jBDELN
 U9DGj+ASBP1XodFhVFWxk95QRjcnO5sWnOfH25H+M/AuxZgJ0blG4MOFYpjHaA18MwtXKfLq2DS
 qNZYrxqOzq/L5yPGA25Ni6q1qFXB3JFePyNQisOjlXNxv47jjlrJ
X-Authority-Analysis: v=2.4 cv=MOpQXsZl c=1 sm=1 tr=0 ts=6a835dcf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=JfrnYn6hAAAA:8 a=Ikd4Dj_1AAAA:8 a=bg0B0yAPDd754FioS-UA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: i5TKMxOxgkdzy-8Bx7HHxETC-wSzd67n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfXxLzA+JeIANKu
 RkO5Xf4GQDktXjotL+OZxr2qVv/+sWU/2sJGeFgLnUrW40o5zahpIWi6LbFk43hXj9Qhz8k+4oC
 EqFZPrVpUz2TFGksbJe1iZHhiKyc7gu5ybYIJ811Pw9NvvwUhbnItFsPuZ4W0KsflYcbMdPV0zU
 rtluEVSA6A9xZt45pa1UOHFMvPXatlgugr9RS3jKj0j4KBZMHUj6hqiBQS1c3F96qr2oUt6td7Q
 9Rs3PUIEY+hKl3jJNK0KP6+HH+2BqgJHXK1Z6XT6P1Gr1oxJNp1buhOxLKsbT56YEWUFOYddozC
 N/gsxAL5wCfTucuax6JwPRd9Ugy4LmBepNcN3xjLb0kFokTSI+pLxgYZ8B/mxRNScG+/oA2uAhO
 9myClrALx/yhJqMcxVYO8vvvSTsuDWTtG1614zAzpvhghW2rH2CWLchZi/6JN4ubcWi5R0OzGgI
 18TggMgELap+GmYIQ2Q==
X-Proofpoint-GUID: i5TKMxOxgkdzy-8Bx7HHxETC-wSzd67n
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 adultscore=0 phishscore=0 lowpriorityscore=10
 impostorscore=10 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

Add a folio-based counterpart to page_snap_context() that reads the
snap context from folio->private directly.

Convert the three writeback paths that passed &folio->page to
page_snap_context() to ceph_folio_snap_context(), removing three
open-coded folio-to-page conversions. No functional change.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f1f4caa8f9df..60955060dd1b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -75,6 +75,12 @@ static inline struct ceph_snap_context *page_snap_context(struct page *page)
 	return NULL;
 }
 
+static inline
+struct ceph_snap_context *ceph_folio_snap_context(const struct folio *folio)
+{
+	return folio->private;
+}
+
 /*
  * Dirty a page.  Optimistically adjust accounting, on the assumption
  * that we won't race with invalidate.  If we do, readjust.
@@ -758,7 +764,7 @@ static int write_folio_nounlock(struct folio *folio,
 		return -EIO;
 
 	/* verify this is a writeable snap context */
-	snapc = page_snap_context(&folio->page);
+	snapc = ceph_folio_snap_context(folio);
 	if (!snapc) {
 		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
 		      folio);
@@ -1183,7 +1189,7 @@ int ceph_check_page_before_write(struct address_space *mapping,
 	}
 
 	/* only if matching snap context */
-	pgsnapc = page_snap_context(&folio->page);
+	pgsnapc = ceph_folio_snap_context(folio);
 	if (pgsnapc != ceph_wbc->snapc) {
 		doutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
 		      pgsnapc, pgsnapc->seq,
@@ -1851,7 +1857,7 @@ ceph_find_incompatible(struct folio *folio)
 
 		folio_wait_writeback(folio);
 
-		snapc = page_snap_context(&folio->page);
+		snapc = ceph_folio_snap_context(folio);
 		if (!snapc || snapc == ci->i_head_snapc)
 			break;
 

-- 
2.39.5

