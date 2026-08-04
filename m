Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1947A0A6
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869578; cv=none; b=E+UVGjCWy0yrici+Ie9VNZm4lNSke0aoabl5sGlygkmaF+9mIdOVO43PzxeWz+IZWcZHD/m0IH9ip9/CSXjRNj7OXAdC48H7cqyDsFUX31ROFFCEmwjjGuGpWgmsOYEcGaTahqLZrcBrZZ2EPhEt3eLcTWL/B3WiPknC3C8igQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869578; c=relaxed/simple;
	bh=Fy0wHmd3j0nRih2sYwsjYIDOGoKEx9pprPd7Ycd1PEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5JsM+X0tY36ILwG9ec/qAUIG1sU4dAXdToyoHtgFORhzFXhmj2IUXGTqoZIEJoPXfIFnYFlp8O8iB0pGYhHEEoWT7FS8nCXz/E0rQhlGTjGSrhcFrutlp4Hp0UgTO/pPzNrOTiYKAiySt/DTOcWbH0dWHxrEAB7OfYA09Njh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=P7C0CHDi; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="P7C0CHDi"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYKmX2404575
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=IXGG
	w2at+L2vnEOc5GYny4bpp2wSKxYA9ebiI09IaVE=; b=P7C0CHDiaLIMwRlERVCQ
	2JS5t1syYGUmkwtfAi4bkz3mbz0/zBvmII5X/9F7bQopsz6mbaEwVC/gm4Cxmx8i
	N1jgbz26Hs6k1PkFKqKmzWfR2gFjWsHwNImqgzJmhoIteaEpMFp1wDv40+vHf6x2
	+m1YVI8YOAHYv94djGb2Tg9dQN/K6CnSKWo17X51RkWmZevfH35nQ9TrYeztgRI9
	hmB+IJ2rcRgYg7iXpx0WLaXmWo43pAzj2TGNgWgKjglYg2D6Kx8xzhlN4yiL9gZ8
	/yhLAlgaZE4a1r156ZckLlvpA+VC0x580HwCaQ5OnIXpW7TdO27iVYuMBJfHaa5V
	jQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fue1x3nhb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:54 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso1009041cf.2
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869573; x=1786474373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXGGw2at+L2vnEOc5GYny4bpp2wSKxYA9ebiI09IaVE=;
        b=iUzgvl28Ra14692LO3PIDdUjQOZurmNwEnhxIAEY2DQIK89bI5QafARkIPlIt3zy34
         9+OIizexX6vyvKQhXlj7ciFzBIaWX9KWSpWD2WYv8rZAOpSyDaifW1W6CMOwwWMMMuEy
         UVre/dRaGx2QTEniK4mF85Egc20ivAKoOK456B6sxVMUXqJq5Yz2BSrtgyZng7MGyzYQ
         wd9ajNyQmPvl8Rol78PTqlCdeR6DarBuWoKbbGTCkTXz6JLwOjeMY7bVYLRrUJGEhcHo
         /B4ghpk58ZWufKX0Y16sdsiq9Q9PJQ5XVfELPCKy9Y8I2ZOaMrZzDgStLx50wYbutCIF
         BhLQ==
X-Gm-Message-State: AOJu0YydX57686q3kFRKOcleKQbb5ZKJwSMNavOVZUh9D9ilnENZuzh3
	vCkgKxiLw0VSlFqFEuPRycZN2YOmjn45kdD2wfJGGJV61AnXMwuaslK9TSneBbn2h5L8D708n/u
	8d9mW2FctofKMI3oymIZv96ARbBRxCEVJ+o4O5BijSziOLX8qXOcBgHcxqG4=
X-Gm-Gg: AR+sD12ZCT/ZX/mssh694DQT6fo5TqG4peNCb2QcxYRe82HptQwWR8D7gh9XWXUIgO3
	Ig8OhUen2kpoInAEUsTv1mO+BxeYRcbMNXvsHJ0JE5RTfhJki48MlZo2F+qjJZMBuJEisBHaxj/
	DfQfQnbrL7ufFKV8B0OTkXU7Hh8snEvkOu7HTSc1tFqYGXn+P7Dz4ZD1S2Yg3tt4WWEQECPUptD
	VhYFEHuH9+l68S9ysZuVeiog47eSMPogp2nowbxTi/D7XO9vA5KAOJvEZQRl6QBe4cw1oiyafvv
	4AMKQ/jgYiKCzAPQkwAGAxB1MK9oTEzCRqJ/U1MDtT4Cgy334ql60HlEAZSIaYle+HuoCBEvTWd
	goqeK07Bx
X-Received: by 2002:ac8:5a12:0:b0:51c:1f97:e860 with SMTP id d75a77b69052e-52ce5f2752cmr13886821cf.3.1785869573285;
        Tue, 04 Aug 2026 11:52:53 -0700 (PDT)
X-Received: by 2002:ac8:5a12:0:b0:51c:1f97:e860 with SMTP id d75a77b69052e-52ce5f2752cmr13886441cf.3.1785869572780;
        Tue, 04 Aug 2026 11:52:52 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:51 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:18 -0400
Subject: [PATCH v2 10/10] ceph: rename ceph_check_page_before_write() to
 ceph_check_folio_before_write()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-10-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1302;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Fy0wHmd3j0nRih2sYwsjYIDOGoKEx9pprPd7Ycd1PEY=;
 b=0IePVxuLC7vw8rtzQUNlq/BT2+vfHxRsOOG3aH3xK67+jgzeo9E2ec8vR2z6rFQq+G4a62iq2
 yew0TORASoFBpyZLd/LrUzrNW1mBhpUUwLMTTyU+1n577jdtw9woP3n
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=C+7ZDwP+ c=1 sm=1 tr=0 ts=6a723506 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=pveTg1YcNyQK2WBy6c8A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ZbVF8zMhr58nY7K2Ni7wj9C7B_PhOGWi
X-Proofpoint-ORIG-GUID: ZbVF8zMhr58nY7K2Ni7wj9C7B_PhOGWi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX6SGqOZP70bue
 8DJo671mKZvB+oQcMUwt2H9Md2vk9kau9MaZeUfjTEfnA7sYlJIYloQ9Xj9usyaJMxRv+foATGP
 Oeg8EdV/Yf4gRVRHJRo9mADuOqJdqLGwNOEbYyvqLLGbxj1INtV4H3Gx6uRfe1/S09r98A6esG2
 eNbwG5DCFUlEQ9SJCy9H1Zvi63/kvskXKMuQrRtR2SeMzTMBGYtSqdU65JnJw3Z+mTlXA2l/uZi
 BswAG0ZI+8kClwDOozn8PBdJlC9+LOqayoaeiRSdeN0gWsrVvrbcMr7FZbIDIydMicpM13qTXUB
 a7bMIWVp17xzQSricZpm7MwC4vYIFPPoGZzcoGza05JCJKgolbPOFCXJgFH9TnyGFWYYd79cgG0
 dHibzJHGKKWwN9Oapitx/Ve0Jv9MitWAKMbyTurZuQAA+nmi1VOuKzb7adqMrfhUo2MFS8VsSvl
 aKHsZYm3zRBJW6v+F0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX8HWzGgUCdhLS
 f+dWAyWPJirFrMko8UTk0ZUmIXdJcAci5mxvMnTH45b3Q57S89JTH310puP8lID6ryW2sgeDGG/
 CgORBkBZ4c9tIuJr9gPJZxGcrsIRUzroqzBvXSTIwDokOpE/L8Gc
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 spamscore=0 lowpriorityscore=10 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

This function only operates on folios, so rename it accordingly.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index eaf5b3f6d13f..08d854ed663b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1153,10 +1153,10 @@ bool can_next_page_be_processed(struct ceph_writeback_ctl *ceph_wbc,
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
@@ -1340,8 +1340,8 @@ void ceph_process_folio_batch(struct address_space *mapping,
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

