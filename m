Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC373B71C3
	for <ceph-devel@vger.kernel.org>; Sun,  2 Aug 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689616; cv=none; b=DDK13fFy4ttGxagzeVAKfWU2zMawAOy/FDWnpZxzY/BsjT/7F0g5tEDNHAQSEKrA7+br7p3a0ItFeEMKqfSAgbk0fwpEQsgl//GA1qRjNU7XfNOHDI/+Fz4BEPGxTK+/HkQpueSs4ap+rM5J9YFOGWDNAZAHnIsJm+yfHBdva8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689616; c=relaxed/simple;
	bh=QqylW3bsSIhF05NLxH45ljAlwMTCLlW2b0M3h7Ydtyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Suve9ZpZRTkc9z1EqT/uFzOVYsvjUZK00PEjOuz0koWrBiRaMV0ABojE1Yzfq+r+NWnOzKgJ4INv/PaCTV2McOy5dQSf9xzkKqwTrty5E8a0A/JAldQNQSgC35onVgl8HGiljzsRb3mYhil+P87UKGQYJduCUSQ17MKt12GtXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=GCggjXSk; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="GCggjXSk"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672CZEkI3398236
	for <ceph-devel@vger.kernel.org>; Sun, 2 Aug 2026 12:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=gxVd
	pvxkC5zPJOy2sGwkp20ewyXEsgwMMwkoFsHT1cE=; b=GCggjXSkylmK9j0b1Jp8
	oP3vczyvYz5vManXcGOZUGpnAR3eQwyYlptq2RtkgZamFQKTR6CERuIQwtPdg/lJ
	YU3rEa2IxVA2JcK3L11HOSw6DrcgmmFBe/itIo5NvHQLi4e82RkV3Fz8/Ek/ZfPJ
	qK5nBCYxhMOFwQXtbCO1RzQVAzlv9TXeIvtqngpMG8hjyG5/mgNBFtYehPoDBaAu
	LHIQG5RNx5PAMEh+jJHUdIhgmJX1OeTKP9SGo2A1c9srlSeGdVfDdPtjWGn8xlkX
	4AdkHPOgB/s+3gheu+wBxieB6FXuhILGq2RdNbBfYj9Ajd9/HuEJJl4QgoJmX87F
	Ug==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fscuwwt6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 02 Aug 2026 12:53:33 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-520a00c7a03so48629111cf.1
        for <ceph-devel@vger.kernel.org>; Sun, 02 Aug 2026 09:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785689613; x=1786294413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxVdpvxkC5zPJOy2sGwkp20ewyXEsgwMMwkoFsHT1cE=;
        b=W2FIw9E1sXkrz/M6kcYncbVoGbRm3TIBfDlxd8W/4WkD6uIxD13lMlk9FYg5hDdEXG
         LB9YywXJd5mIA/Nzd7Ehxsd8C5hiBqKGY8Er0SpCbojvmHsXK86i0DE49oqmuuFwk94I
         /VWJpWNPxjb1KB7JuWivpUhbT6IzbQAN0X7n1ex6/yu/YXqdz44zozB9EW1RWipSL4tr
         XRHrKHUw/F/m2ySeqL8HD57nzoLybFlo7Liw3JkNZ16Q71iRT3tZbsKZb0+KmsNlyGB0
         6BzYNTA6jQB4q9uNw8jqNziluPmRq8IkFZpyUdZxsLMFd05DLgUhfkNcLtCcFk1elyE0
         L4fw==
X-Gm-Message-State: AOJu0Yy1SwiYorrSLLX+lp1ob3xlSQlai+DKYNT9VE/4IgsrnVBGNciI
	yiL/4da7Yz9pjOmlg5B4BMUsYvdCSiHk/+ivvqyykGuKY3W5tUKPbD9YBQPxVglJw8OOZas5JZw
	eW2qHeeBQogL/8MLi5u3OUrdTWWxwmR0whZ01p9lafYmRFswde2E2cgUVvSw=
X-Gm-Gg: AR+sD126u756UE4fHxexlqEMeInOvkZbt7D3mNoIpAm1aUQFn/V8ebB599jpdLE+n3f
	JqEgFpuH/AUv/3pyK9JjxcbvG9VML6xMVlt4Ez/MNWUr74uC6TzBpgow2Zq7i9jYDm0/KoXOd8q
	PnBFGzYDuisohjNlfwnyHLT93t42wBy2OBunEwMUxGMd1T+8fue1irywAvBie54iExoAuFjz9lR
	bEZwNcm1c7RVeZN2K0DEG/UHb7waUMuG6iHZz+KPqsfcuw3KjbrSKumGA++451eDobCTn/nVenz
	gAD+FtZmEDqaQ3MuVj8QVTlEQFtBGgJTRpskjTaTZ+3Q7aFUrUaJ2sPibnjiSXdhUuQM6PHEanR
	36TTqnZMtZWCFjSPovmy0Qe9403dxKQoZbodjQIT7GPPI2qATaEQ=
X-Received: by 2002:a05:622a:2486:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b5673f0b6mr159137741cf.27.1785689612920;
        Sun, 02 Aug 2026 09:53:32 -0700 (PDT)
X-Received: by 2002:a05:622a:2486:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b5673f0b6mr159137361cf.27.1785689612478;
        Sun, 02 Aug 2026 09:53:32 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm24064574f8f.34.2026.08.02.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 09:53:31 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 02 Aug 2026 12:50:02 -0400
Subject: [PATCH 1/4] ceph: add ceph_folio_snap_context()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-remove-wait-on-page-writeback-v1-1-6c35d6b3ad36@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785689606; l=1979;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=QqylW3bsSIhF05NLxH45ljAlwMTCLlW2b0M3h7Ydtyk=;
 b=dxZbHRsFgGPdfbaM7ZuaRZB4wbT0T9ysMyProgY4c8BR9d6NCgfGc+G/TZXj0NJTYAzcPrmn9
 AlW+bBeNVYvBE31GxwJr7e7QgAOWIYuQLUSYFlUILQVrkd9oIz1kjwh
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: nU8s0P7Ro51NjbO7jdPWMnhXVa2iVUso
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfXw4zg62A+eXRI
 yWhM5RaDIPHmlZKagPUzsFUhSNuw/r59RGbqIbio7492UtyFSVxNW0ANf4wVcLa4lvciRnc80UI
 eAcF/Suz3Ud08uWpjub25lAZHHDy1kGJ1Yn6wNu7E50LZu85wogf
X-Authority-Analysis: v=2.4 cv=OZmoyBTY c=1 sm=1 tr=0 ts=6a6f760d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=ALYDsW89DncSylXEcn0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfXy4c7XPeCP+vU
 5ynU+eNVNeXRx4U/mH6kdFO84KkLWV3YiGXWWJdNjcmzuavTmBF9PAFPuXyfdkaCSvMONMgcY+N
 7vSmtmKj1YKmBBXm+FcRznv13/JZLrq2/1+9J0giyzZGMVSGz7D5isiQFBzYlg5kZpdtscH6kUO
 HsnAisiemrAr1/au5XMPp/H9pw+FBwMNdftidnOtncVWGe0PTR4xgaym5bernBV/MGs/JswZqWp
 6jkajxoGMPxJDqMuHh8F2kPaWujnSRSob00BrQsd/7+DjpwyqHf4UflgtVPrWpXlXNE3Oq23Je5
 EjJrAR0pMRliVXXDzB/uVlOU5tgkYsZGKAKNnK2fruvgpCbsraLhpEYz/NQ8JWl4ZfAOshPp0mB
 1Ooj8Yba9kxgB6NZpKpje0KnMO6i0CzI6JwnAefb7aX3GX8ZqCBwFNxNpLC/ZRoeNzYEkyyPmgN
 DdBcn6HFvFupfHcewHA==
X-Proofpoint-ORIG-GUID: nU8s0P7Ro51NjbO7jdPWMnhXVa2iVUso
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=10 lowpriorityscore=10 bulkscore=10
 phishscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020153

Add a folio-based counterpart to page_snap_context() that reads the
snap context from folio->private directly.

Convert the three writeback paths that passed &folio->page to
page_snap_context() to ceph_folio_snap_context(), removing three
open-coded folio-to-page conversions. No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ecf33b66610c..a8ed2a14da44 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -75,6 +75,13 @@ static inline struct ceph_snap_context *page_snap_context(struct page *page)
 	return NULL;
 }
 
+static inline struct ceph_snap_context *ceph_folio_snap_context(struct folio *folio)
+{
+	if (folio_test_private(folio))
+		return (void *)folio->private;
+	return NULL;
+}
+
 /*
  * Dirty a page.  Optimistically adjust accounting, on the assumption
  * that we won't race with invalidate.  If we do, readjust.
@@ -745,7 +752,7 @@ static int write_folio_nounlock(struct folio *folio,
 		return -EIO;
 
 	/* verify this is a writeable snap context */
-	snapc = page_snap_context(&folio->page);
+	snapc = ceph_folio_snap_context(folio);
 	if (!snapc) {
 		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
 		      folio);
@@ -1171,7 +1178,7 @@ int ceph_check_page_before_write(struct address_space *mapping,
 	}
 
 	/* only if matching snap context */
-	pgsnapc = page_snap_context(&folio->page);
+	pgsnapc = ceph_folio_snap_context(folio);
 	if (pgsnapc != ceph_wbc->snapc) {
 		doutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
 		      pgsnapc, pgsnapc->seq,
@@ -1824,7 +1831,7 @@ ceph_find_incompatible(struct folio *folio)
 
 		folio_wait_writeback(folio);
 
-		snapc = page_snap_context(&folio->page);
+		snapc = ceph_folio_snap_context(folio);
 		if (!snapc || snapc == ci->i_head_snapc)
 			break;
 

-- 
2.39.5

