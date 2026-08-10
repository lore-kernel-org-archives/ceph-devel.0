Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F83F6606
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371681; cv=none; b=cdsCl39xBCf13Nn/nwhy5ZC643Iv483v7ZaEI/li0CRzUsjnstgB2zDpT0156o0kPhkOB1pj9Cp6Na0zwaYqY0Y5Uaijo4wJeN/tZQ5XmHlE0OOCzrlY9Tkz52Y9ErE8k7OC6oYr85KLiyNhHdZ8tK6UPE9by7UwUsC1ETsuvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371681; c=relaxed/simple;
	bh=7O7yrVN4O0oLp3x/dLZGdiLj0pIUK9KzDcYDRFGgB18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZKs1k+rlf6EQ6tSYScbSJLp2sWFeH2R5KityT+g4pLBdNIUsSK4Ezu6nGyDQi902GGAW2m4Iyr3JUyRB5x72sePEv3p4X5y9XfO4L/sRThBTS5ZT2J9+b5WmYkpYz/4uQd00w9F3Lrv/o7llfyGz10ZhpatNmPbYn3TapXXOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=p7UYcBOs; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="p7UYcBOs"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaQiO2722686
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=lZAV
	MDkDi9w8ZU6GK98RKcAV+HW3xUm2lluu/vojFZM=; b=p7UYcBOsaLr+pPgsuvLr
	R/MPvSANKRo7h+FTvLCjUg1W9gLw/P+sbm/usRn/2eddqqPspDB0T/nNH5kDnGWx
	WUhUaUmn2aQFPpG7arLYdteqS4NTxG8HBirKP976dPJY16902eRjwjbBIKybL1x4
	oz19MiM7Eaa37ABKsOoxc6eKS50e1dzLtzq6Ik00JFAI8wyJh1IEj3Lmy8vSG5xu
	+yRZ+mykZkceaNeTd5w4Kn3cb4zVT5SMe0CDw5x56ZVuMZ6SytgY0rho0+ZaDkpB
	QzErQ54R0Ev1ZPJMs1/Qf4lm8vz4Zih5lVgjEQIpHA8IERJjMSuuLVB9bOSwkMO1
	Vg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fxyvd3gv9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:10 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso33815791cf.3
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371669; x=1786976469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZAVMDkDi9w8ZU6GK98RKcAV+HW3xUm2lluu/vojFZM=;
        b=SyY2//jpA37T+ajdrmURhGPjYVS96GcWKJBbBzoHpRgH5hhrG0lO+DWh9sruFt20oD
         Ndy9nxc5Jt624sOEsqcCZheDpEJl0DWpsUohZCbUiE5EZN/zJhFraRUUrbhXxQvbfP1H
         byf7PhzRLwdKrBwhdJm+wqFcrC2v8sIFhRijGkaAsgXg5f8pBxMClghIxhIJoNN4WsKV
         7WVfZBucJgtgh3Nct9RKGYvJAGlyu/GCvR0fxhMtqyBuswLdZ3SXzNVC/zNwp47fZC6j
         NgC6ZvvB+wAFRYaWjDtpRiYBdPWoMs5tU7AsX+u5CEFtbsEDIJzI5Ha4Ta6bf43+k+HV
         BJfw==
X-Gm-Message-State: AOJu0YyJtZOdi8HwtLaKrO8HANkdmNKyloCzP6zBwkkGYwT/lpvcuQMc
	vTImKKLM5dQDx69P+C6/6WHxiufy8jVw8547Yzar7d0rJvSOk6V2Q3nOb9wZND4aO4bXqlzHpM+
	9bP0MpyHVhF9TkFuaIpE0PGIYFtu3rAYKHyiJJdsW/gdBNOZNHV/3TIfHgnU=
X-Gm-Gg: AR+sD12EMUKMR+3ud2S3hq7fHZiwCFWdtAZe/TefgJJXBGp20vIOAoKVgkW/Mg0erM/
	UMB7o58v7r/xYxiOqwfu0d3n2Zd70ZKpZr4b/yOhVIsrfjS3AVqK/Bb6tOGwr77YQWf7f5JUtT4
	gIfZv455k93YPh49nhLIFUhvC9GK2gvdZwQtxkf8r4VVNajrmaDajCPH7TKJw5VRHnvBFrA/ZnY
	iOn2h3660M/yCLsTMqygTmj5XP25bP2WsxtBQ13szJQqGm33Da7avK+gV6X4+d3+AI/Jzljvx9B
	d8ENzeQCI5Wz3R4QS/EQJWTC6zeoqAdMlDEb69fQGLkLhU1JjXL1AMl04FETPaGIbevoRFt+Z87
	0YnMWTKv9
X-Received: by 2002:ac8:7d0f:0:b0:51e:47a4:4851 with SMTP id d75a77b69052e-52d0b003eafmr297600041cf.8.1786371669533;
        Mon, 10 Aug 2026 07:21:09 -0700 (PDT)
X-Received: by 2002:ac8:7d0f:0:b0:51e:47a4:4851 with SMTP id d75a77b69052e-52d0b003eafmr297598971cf.8.1786371668881;
        Mon, 10 Aug 2026 07:21:08 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:07 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:14 -0400
Subject: [PATCH v3 03/12] ceph: add ceph_folio_snap_context()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-3-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=2021;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=7O7yrVN4O0oLp3x/dLZGdiLj0pIUK9KzDcYDRFGgB18=;
 b=3gSQg6M47bO2pgURxJWAmFQ4PnvlGi8AWeaabt5bNBcjpfLt1y0znTJf5ZvHSRcsXLgqlAj71
 VOCHDcekvzuBKKOjVXYC/adYE5gwRzuUdjjSiA2b/54HZ5bpM8mfi62
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX7xmIrG4XSkVV
 Xz49dXEcplcEvWAnY5yAdw9vSGUvvF2rb1P1xnVQPXFV3z6fxHKMEYzJ375SLhwLH3cfCLHkZ6A
 wRKhaC8kdDWUXVC/gYzNoLB5mhgH6UkTx1my5SSd8G3qCX0f1eoj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXwWuVs70zYlMD
 TiXOp/g76f5PnLTb5NPyd6MgYRgGK08fEMZNbojg9dYaaFbdxHXZymPw88GvjjsGL8TE3N8TWd4
 9nc5OIsFZ27SN8LLVSY5afDEf9qAyKHZASvCERPfAWAJ97oAwdvkMwu5e1ZV3MO7O31HTgqdyDX
 YjsT/4iV08KQeX6qkY/s+ztKlhMhWKNKhYwJQIHTCbs0AnV8QC54mmk+n6eyT+rCtQQRYus8VGy
 RoP3YRD8fPCKXtoVPNsm0p2IIUXocZjqBFIWRpzu2r523f3C5+WpjlH2ubS6bawyWuBn0fHOuEm
 rXfhKOJIjdSG96KuLNQaErqarokVEwMt1z/vlSKYQLkpvjpOekoJ2M4SssvsafpCCbFOZnfIDnQ
 rWNCZYQyLrReom17eW43/dCAMySsol8X1AC615PpbkWKWAE7ArA1fV8BZdjcIYJGoYE43BpCoAg
 o4fJBkHorbZgbWAXcwA==
X-Proofpoint-ORIG-GUID: PR9OYPCloNYzx2emx7Zq0miWQuZPw3xW
X-Authority-Analysis: v=2.4 cv=Gb0nWwXL c=1 sm=1 tr=0 ts=6a79de56 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=JfrnYn6hAAAA:8 a=Ikd4Dj_1AAAA:8 a=bg0B0yAPDd754FioS-UA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: PR9OYPCloNYzx2emx7Zq0miWQuZPw3xW
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=10 impostorscore=10 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=10 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

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
index de0113b23940..3d86e4c85b06 100644
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
@@ -1840,7 +1846,7 @@ ceph_find_incompatible(struct folio *folio)
 
 		folio_wait_writeback(folio);
 
-		snapc = page_snap_context(&folio->page);
+		snapc = ceph_folio_snap_context(folio);
 		if (!snapc || snapc == ci->i_head_snapc)
 			break;
 

-- 
2.39.5

