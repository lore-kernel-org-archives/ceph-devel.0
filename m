Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A747CA84
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869558; cv=none; b=evU8edqehUyJREQbeYgl6DdB/pF09GFZo9mAyRwSJN4n9j/WqlAXRELatMh5/SD9Sth9aFI7s8M1MOCblCtm+r5t6f46ndT2Oiq5cCUjuGWBxApoOirtAFnewoTXJUosBTv5HmktgIuToUnWBSpjHGMwxkMBR56qcSjpUCf3xlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869558; c=relaxed/simple;
	bh=g8jPUs8pg/UEHyzRirqPZNurckpVqv7a3bIwEUEkAXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5rooampPD9buCooYI+7sPQa1/1pAT524QgLcYhnh/wO7Q7Y6SbO4W+zLW4yTeVnkL80+vPDDMloeg6WKVgxRynytOYabHQQ9ZUUEnFD1PvbLyjTnwDGCpjss02m/jpqiMZN3vhzD5D4kkErwtJVvGgW6fXPym166QrtTqNwXZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=L97s7PyH; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="L97s7PyH"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYbNF2127315
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=6cEc
	Am4InXbaEDJaVpQUaZztPzUmrUXxaK7Mht5hSMw=; b=L97s7PyHs9MoxkJbnlnJ
	bob3e54A+PzjFbMJqyEpOSP83Qfu462DaYwFPq0SP6TG/IgGCWXhz0Nemgz1N/tQ
	YxEwK2Ez7Zn/m+S43x3BhSZWbb6ZajJUC/gMwuvpP2FqyHkUKrF+Ptz6Y0KAsw0m
	m4ix2vYWYNqBphFd0e1bSmW/VexIogi+V3XUJMixmM9cePya+6IrVwLnmDMcFSrV
	V1BOmk472SN3Q8+N79xBqvJtO1+AbYwc5WkRsjslFsVCPZsVPhI0vn1wIauvO5kZ
	PjLcr+yUXpjmpwzW/8wej/OKEhWliJKDw7BL6BCdFun7MLDAZev+Hlbs119SpYSs
	ig==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fuj0et13x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:27 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c12e43b98so1217321cf.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869547; x=1786474347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cEcAm4InXbaEDJaVpQUaZztPzUmrUXxaK7Mht5hSMw=;
        b=T2pDQC8StYanbu79M5xWFwPnIDM1qXILI3e87J4JHBscYcaRXTiklS5Jxblp0Dig6e
         T0vSoY9+TH7yCYa5FYg03Okwr/Fh+Otc3Asffl8kXqNqqBxKAehefNUQh5i04YNhfllV
         OprYycy129ou/0JwgoxtnUHQHc4n5gxYe/5J5vFtW9GiNo88MhU9HvqytKmdYiBpICQS
         TLa4O8/6ebytc+giWDBz63LH9XDz7oAqtqvniii4fiwfDiy+EmeAmmUm+xC670Cmu0xx
         dpD7owwRhgKFVnFFNGqtqamXg8tiG8j3JbsCWe54Zmex6TPDakxrIBdH1S/Y/3YdSqzS
         W7vg==
X-Gm-Message-State: AOJu0YyzjB1WMwqhtXaoc7q9gA2Xz+kn9MoB96SL/knjRtbd20Xf4Lgk
	X/kQlXse/JTrL7gRKaQH3zpxpYCKqy5sLABRyfvCp0IJItdwTHhj+WpJwMqXBK9JVieZHa8SStB
	AJ4kpDfe90+O2WZpJTCEKKbjXzxT81tQMivEJ/czv+GeExr7hTf+9mtNCL2I=
X-Gm-Gg: AR+sD11mzR68Ryo6HdHdVgMwIHLFnO73Ptf7oD3rPLILym4TFGWZwxKsTgqpL5UNHdu
	IQjiKYoAfW9vrqZdtuEhnWTUs48hLEMQwAfhICNL5i1yqkcIDmMLN9HAAiLwoQ8yjIBDK2BHnzl
	LUYy2dQ14SdFCG64zpwFJjamUu2dRMe6zwyst3stN7U/LAdFHxV1Mg9dy1BSSyiIYRtdIfxzqvn
	eisfmq6U7lUgMDjne4VUL4lhMk9cG//1kMiG27DybsMt8s0UeJ0XqnuB9XsaX3j0ld96UAf/e1M
	BGYxn2xUlAuLXq0OjwFnwtaGH6H9StqwEOPkmDHttqfckab5mfK7wcxw9GGt7R9f8v8e5Noa5HY
	dToxK6CBI
X-Received: by 2002:a05:622a:258a:b0:51c:ba4:d837 with SMTP id d75a77b69052e-52ce6033864mr14931711cf.18.1785869547245;
        Tue, 04 Aug 2026 11:52:27 -0700 (PDT)
X-Received: by 2002:a05:622a:258a:b0:51c:ba4:d837 with SMTP id d75a77b69052e-52ce6033864mr14931161cf.18.1785869546719;
        Tue, 04 Aug 2026 11:52:26 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:25 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:09 -0400
Subject: [PATCH v2 01/10] ceph: add ceph_folio_snap_context()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-1-81f0ab065284@columbia.edu>
References: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
In-Reply-To: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1926;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=g8jPUs8pg/UEHyzRirqPZNurckpVqv7a3bIwEUEkAXw=;
 b=kPzJerCbpMCCBKGAtZw8eKWb6/5ZVD4+Ug9RVQ0xo6KmV7nNnkpdLDMCwQucUV99QtMamuOod
 lxHS1F8FsRxCiL9AoDQknGXRMPSE1dKxItslwY4r9TZxB1CubxQ3RQW
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=ePIjSnp1 c=1 sm=1 tr=0 ts=6a7234eb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=ALYDsW89DncSylXEcn0A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX0VR0SjvhIXKk
 PKxZ5hhga7QWKWavsHxk0ST3CqXd+5tEjjn7id81qnyiOAokRTg+nvI3ATLckoV+vURouejYWDT
 CwDaD96FDL5oPCv7TjSdnxmmGRuNtgLq4PUYToPdwFoWcl5LfmFJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX4VOCIgBfBjmQ
 LekNsZHz32F7ItpUJwvKb0VSD2iVjN8FFUL/0wIsy8mWd3/9+5UtFp1cXDdm4WV70uW4fvl9ybA
 8wCu2F/jJhPmdGRBwxn+KX1iHHYhOQOodA7Aer1e1w52WexXocwIwahPXsJoHxsBwT7AA0keueD
 TvxOIRvIzwKdgOqD3tQukCjv0G7hcNyJW0D2s8VOrSeu6lONXAAANNH1Mxe+Fyqb1Iz/IQYWSr8
 tSUN4H+yeyI2seWfmIcp6idsJDkxVTofTPO8RtXH4jJnt7vP6WU8jq8eWb2ZQrd6NmAqny4DR9X
 ScuT3vsVjjQiJQ6hcfEP1P/EsvYwUrXyHpHOimUTECrQdsi6T4F94NU0hz9M1b969zt9oEAoVCY
 f3Nv+xxTmW2dx48QcHFnR3VtTRBdBBFftkVAHbSDtUOX5tDWihz3i8IrM2YvAd4LFKlHgI/3iax
 iM/JHnBPz43rjKVaUUg==
X-Proofpoint-GUID: -k_TIHcVZWqrf0JX_iQpCq9AtLc3HTMA
X-Proofpoint-ORIG-GUID: -k_TIHcVZWqrf0JX_iQpCq9AtLc3HTMA
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=10 lowpriorityscore=10 bulkscore=10 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

Add a folio-based counterpart to page_snap_context() that reads the
snap context from folio->private directly.

Convert the three writeback paths that passed &folio->page to
page_snap_context() to ceph_folio_snap_context(), removing three
open-coded folio-to-page conversions. No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e2da3ab9f808..8347366ce5d9 100644
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
@@ -749,7 +755,7 @@ static int write_folio_nounlock(struct folio *folio,
 		return -EIO;
 
 	/* verify this is a writeable snap context */
-	snapc = page_snap_context(&folio->page);
+	snapc = ceph_folio_snap_context(folio);
 	if (!snapc) {
 		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
 		      folio);
@@ -1171,7 +1177,7 @@ int ceph_check_page_before_write(struct address_space *mapping,
 	}
 
 	/* only if matching snap context */
-	pgsnapc = page_snap_context(&folio->page);
+	pgsnapc = ceph_folio_snap_context(folio);
 	if (pgsnapc != ceph_wbc->snapc) {
 		doutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
 		      pgsnapc, pgsnapc->seq,
@@ -1824,7 +1830,7 @@ ceph_find_incompatible(struct folio *folio)
 
 		folio_wait_writeback(folio);
 
-		snapc = page_snap_context(&folio->page);
+		snapc = ceph_folio_snap_context(folio);
 		if (!snapc || snapc == ci->i_head_snapc)
 			break;
 

-- 
2.39.5

