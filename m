Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560D3F99F3
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371723; cv=none; b=qQ2uZT5q8vSIM4fxf29t2wcMtSr6iZsEmx5nKH7c2YAu8DidQKsH9vCMt0H+4w+pRI05yPiIas1fBYi1iaKF6oSt94G5FFx/VlmrVTz3RUt6Va8lX4DZUeRQ8pTLU4pyHHuFurEHcebWVXm/NA+t4jtjbR2AaYUZaRvU59Sq41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371723; c=relaxed/simple;
	bh=H+WPEAg6fNk21OMcWq4m8PpfVy6prUL5jC+rlshnioU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spVebz+xUeDSKjoKqFSphYorChemeeSJhR3VUXAxsTIggDiMzK/TFG2Lkjs7AlRvRX1jlkimSXadj5Xs7EzY+vz1pi5UQm2PW5WEbSKwgdfUCNkWbKoiScZ8LlycLZUUEYx8V/GkKKTH/qi7uUFOvmS9jWIWfkQLHUYj71qMy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=bojn0z/I; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="bojn0z/I"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACa99P2990304
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=HS4+
	+7SfsgCqjVhck++B6W9XvkcEaVeM763sEjq4goQ=; b=bojn0z/IAr5WNLmoq+w7
	vS/X8WLw0/NTfqXqTGcamUIQWo4g/1L1wzi+AIV++Dhbx53xF/eodzujqjggv/dp
	Wjl0FEdLtxLDhDIo31SXiluw+6npK4Acz30nLDsWhvE/jjhT7xs4fRSt1DLPX34s
	a0p8FYeF/EvPTQo9DDd0DA1sr543nK5+qGslCJcvF4AH9g+k4Zqi5OnxofRnM0cf
	dC/eTYsHibBWFmdQWofYkVJ1z30MDCp6hzDaDdibLrbeqEbrlElFkVTP9CieoFIX
	yR9YAZg9zzfGmOkedQz15nZ1R/gVgQxhGlD8I0nopJIAskQHX9nrh1vLNO2JGaZv
	yQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fxykwujjy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:38 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52d33c89a29so17997921cf.1
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371697; x=1786976497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HS4++7SfsgCqjVhck++B6W9XvkcEaVeM763sEjq4goQ=;
        b=nhB5K5dkRqFtJYUPS440KY9y4TERjv1nFBKCdxUMcZXJbGvN80WWAw10mAL3Sc2YID
         bsPJ5h64nzPYdvWKipRD20E05RMk82plz+qqISGm1BtfZpS0uNhXhRqkFD96z8iA/XlO
         qlpOKvpU72syv5FcEItaNSnpXkTxYdrC0wb6OPBjKJVulAbuaQz1C/5gZIjjxQC3aS60
         NglMPjsjDl/z4T8/Ocka3Lufp1Y+R1A6N91Pi0BmKzkxD/qt7eRumPs3lkFMdi6/odNh
         AAaKVgfknd+zhEk9QTVmAEC/gf+N2MwjD8ta3mmsx755iQStspyiTOCHySa5a+y6b0pe
         YhjA==
X-Gm-Message-State: AOJu0YxpozBC+O3Disl4YqFemWSEHl6PrcRknIGrfE+U5WwWhXf61yFW
	6dq7tQrYv5NWAS4CVRWmg+avq3D7P5xeR2pOwmHI3ze4bf7ap7eBqx+wStNpk8AS/hYGZMUpwFh
	Z8aoXSofHbg8+PUotf/7kqbjlMN5LuYPeeEvCIbwR4q9p4XqukXMpzb2hfVk=
X-Gm-Gg: AR+sD10hTq9dQuppXXcpA1xatK56cEGAsPlCgQQV6mk9z+XEwdfZZQ14ntC8MptCtyg
	FIi7pwESdA/Om7ASusplaa2pdlinDuq3/hMpHVw3rzn5kUnIizjXtnSMMCDJxk5PPtU+DZHmPKp
	Oqkmn4SVv0dmN/Beox6y/JXv+koRoi6VML7gzqUMRr68yyCB/TRQ09/w+q9NjkmCog6olynxFma
	QsclGTRy5AKT/soLps+V8O2OAeXEx5laJjJza2d39fl05Byyty52SXHVLfvYxT/ToGC9Mxuxl5J
	F028UdxD6rxs2oV5zPxlnbfEyZgU96pyyXweqFw0QosQ2eZO1H7ri8bqyScj9yRRc/GirhMU2iE
	NOB9meSxe
X-Received: by 2002:a05:622a:4811:b0:516:d60f:6438 with SMTP id d75a77b69052e-52ce5e01448mr479946451cf.0.1786371697310;
        Mon, 10 Aug 2026 07:21:37 -0700 (PDT)
X-Received: by 2002:a05:622a:4811:b0:516:d60f:6438 with SMTP id d75a77b69052e-52ce5e01448mr479945641cf.0.1786371696835;
        Mon, 10 Aug 2026 07:21:36 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:36 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:23 -0400
Subject: [PATCH v3 12/12] ceph: rename ceph_check_page_before_write() to
 ceph_check_folio_before_write()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-12-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=1302;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=H+WPEAg6fNk21OMcWq4m8PpfVy6prUL5jC+rlshnioU=;
 b=Wb7zxOOE2mdK7NryczQ1B0RD/gwzEja+WEduJUoRi/Dwu2V70eerTkzJiLplKw68Da/YSBGCZ
 nq/6m0GxSXwBAU0HM+984/XsYO0YrPj3RTxev/kZTfV8Wr3VvludnS1
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: m7p3elOB5ADKOPX8i5AkI5cX7aUjiLOf
X-Authority-Analysis: v=2.4 cv=S43pBosP c=1 sm=1 tr=0 ts=6a79de72 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=V3EFW1AtJEMGhprvICUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXxgOlt7TbDPHu
 w33B+y6GXvlYOTAIqd/pxJP4NsrIglbULc3LYIPzBRLnGC2Wug+jt2902lVPmrYRl+gPKrKj+Sm
 4r6Ay2z36hWPuuwkCYib+pI/rh1cx3EFk6PAiajZ2Os5Faeqce7F8FaqnpP/UdaLlQBFXZJB2Ml
 aHX3eBsSRPkMaD4v4cHm/tHdR4XDXbgUVBvvoWHAVzT6qPfhAODzqBbpOI5liTd9kF3SAKF7JqZ
 31BDznGJyzKN8OROBwkn6M/Tg7Iv0w3yQTEHpqbcl2haj38vlnLe10eHH4+7UELNDJT5oI1ydZh
 P9UJX4TIBQc4/R8cZuTtqqlskQr/QGMYuB9oHj3si/2BzlZcQ8XZivJmSg3lOk0fWObvvbSmQ6t
 sF4dF8sPPwQeak9pEzLhVeE34fQhmpvtr15MXqLzd23WKPPsOkuQrP8x5RGRc5tckGqdUlL0evF
 LAjDBi2pePMBrA1Sw/Q==
X-Proofpoint-GUID: m7p3elOB5ADKOPX8i5AkI5cX7aUjiLOf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX/FMu66pj/tLA
 WTXZmjDuocAnKGaVHklw2dbMCXWeClkpJ/o0VQgK+b9QdygvI7vk2cN9cs7WD2zcHjQrndcLKHL
 lfpZbr1uTU8MA7Q5+iHmtU10zpkQC48s/Jz4X4oqPHCniy4RthQW
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=10 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=10
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

This function only operates on folios, so rename it accordingly.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 708343a8bf35..68018fc097c4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1164,10 +1164,10 @@ bool can_next_page_be_processed(struct ceph_writeback_ctl *ceph_wbc,
 }
 
 static
-int ceph_check_page_before_write(struct address_space *mapping,
-				 struct writeback_control *wbc,
-				 struct ceph_writeback_ctl *ceph_wbc,
-				 struct folio *folio)
+int ceph_check_folio_before_write(struct address_space *mapping,
+				  struct writeback_control *wbc,
+				  struct ceph_writeback_ctl *ceph_wbc,
+				  struct folio *folio)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -1351,8 +1351,8 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		else if (!folio_trylock(folio))
 			break;
 
-		rc = ceph_check_page_before_write(mapping, wbc,
-						  ceph_wbc, folio);
+		rc = ceph_check_folio_before_write(mapping, wbc,
+						   ceph_wbc, folio);
 		if (rc == -ENODATA) {
 			folio_unlock(folio);
 			folio_put(folio);

-- 
2.39.5

