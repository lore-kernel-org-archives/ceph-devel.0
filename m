Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5212772D
	for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789344221; cv=none; b=mP54VWWseq6amFCADEiRtw762YNVZBGI+Uqs7Upu5XIQ4uF3gLwvb/EsTLeCDBU+OQMs37RPTJmjNLsnLwRHQ5lxilDO/G1y80adHRdq7LJh271W5XGopGK87UDXKXezP8u63y7PeqFV/BQj8JYN0hsXJyMd4E/svSYY2mh+5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789344221; c=relaxed/simple;
	bh=p1jlM65ZxQ3So+BBCB1oyi/3+0R55NP/llbG6qT1Q1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fG02sRiojnkpzUSTmf7bbfrQwY8WyPrJNFbvDQHUjKwqDFBOk+hMGTPLn5McDCpVW8VrKpWk8x8KiVVW/uLuo/VM5po1atFaZwBZUKYYtn/s6RGWrdOTjx7ibQoQ2CYOFDN4Q7gTjA3jpNVXapmJj8+DfZiCoSiY9UbY+5Tl7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=d6s+UU0I; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=H6zUoCBp; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="d6s+UU0I";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="H6zUoCBp"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DMZ6va805505
	for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 20:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=rNlN
	N2Xh3Jh7xF4dZNSpw4lMXaF92rKdytyUcFoqXGw=; b=d6s+UU0IHeiSa/yRknjU
	SFeg4aV6In/eAxDDB5pufHfJUaBUJv/ro+wf0UmGfon7QCeFCjhdfSM44umvMaeV
	jV5Pj+G3kiJO0B1PDFkcDXGkRo6+cjHQmXvt3/2DxCUaKejWRusO0m9gRGx6Fte0
	cGrUPxy4UEynGUs44FM30URYVWmfTwhZwUiuK8d06e00cE8/osDXep2sP8BoOV2H
	NNHmIXtQYyv+7IWLbT0wyHimsyOwrdkuFwgyfdjvF6Q0GDiDIOkAlUdJfDAIx4Vv
	E2gb5Fzzew334xqnvO5FloXvr5pLDoEiuMfFiIrEDEf6YnE9AWoQHYlndaBPN66j
	GQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gp2yv0pbd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 20:03:38 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9393ac4961fso303103485a.2
        for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 17:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789344218; x=1789949018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNlNN2Xh3Jh7xF4dZNSpw4lMXaF92rKdytyUcFoqXGw=;
        b=H6zUoCBpmrI6PU22CTTYCXG06xN1wwMW4PQhGV+RJDSjAuO0q9KEJBQhGXbONfXOe+
         tAXVgaj5UlHIQhurHR21yldSSOBiR07XRQ//IdBwIdxv84QcoAV0il3vt1bCEpAnxVyg
         lg0IC+XCu7txSqiktM9nv0XJOtykOQztY1mpCBAP6MLEg9rZCulOwPtEQ6LzfpGNbSIp
         b735EkW8wTUgZfi4auiBqxOdUv/WlN54IbI38hvJ0hLiYvv7Wm99vLAMkILd3hV3SZDL
         Ay0jj05MyrJQchn0MO1xJ85x/aTTfwua7Y6F0Uk17X4T0GIWVIOcuCvMdAvRczvCXNHQ
         tgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789344218; x=1789949018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNlNN2Xh3Jh7xF4dZNSpw4lMXaF92rKdytyUcFoqXGw=;
        b=VLQ+iOlKf/SCaVargDhpmuiwbQ7dRnE/o33+QkjZxnTKzRkDSXioxNnH6D0HlLJxDV
         BYHvrFIP897KkGtPUc+080v8mqrpleemFqaxnDrQsu1ivR5/tVJtkuGsffzYeVuDmhgZ
         obVYTTFnMcTDZC5ciP3ThJIBrKNKnYYwckaLBTx+NOm1gVVTqUmRGxQGp+sm8eGJphxw
         3bH3x+5mcBIvkkWtSL/y8TpwQ4nFtURhwD5Pjr5eIw/UmYHLJ+KSDoWUPhRhsjxwJhsi
         BZdi327QXuvvhFAOOOitbsgibwUUj7DJg55MehYv9dfAN4EHy7zsPpw4MV3S7PMya9I9
         fxSg==
X-Gm-Message-State: AFuF++n8ObMfSFeCVTgzX8/IiYVIcQ0+yQDTaWLDl+4yvutQXnvLUVO1
	1cYqcrjyUfRTtGngLIQvV4rZcQ8iEq8Z+jpTXwXCbPDg4SuzvTmCEKoulS0uudvKdAtW8UVJMse
	QV9yVQaDk8owYbyvGcsD1BI+rv75t0g1RfDhMOMycSPFftwa+Y5hs4B4nqT4=
X-Gm-Gg: AYBFou0Z/2v/I9rkQRmCKmr1xt3xTm8bUd56kNBXMBpSgFp4BZDFZus/ArTRigfY5gO
	UHPPWZJ9R4MEUDKK0taYPgA8dXBwXGV40y//Ax8aMs3PlewsLWQn/8ZZMiKRqjYz5NvwIuOoNkR
	0rN7Hwd2FDw9Mwxwkb7TmIMqQVJfiEez8Zrxvwj0yz5aZp0wUIM46mnVBKLOndMSIpFXDmGt9BA
	5rf+qO4BMWJZfe7uwenAFP5fmJz8f6hpURwoLgWL9yWgxUEhiBvceRYlAJLjp6fglTnZPPFW1s/
	X92u5nFvqWGyekfB2yT1vkmheMWhmv4NIN5pp52JMZLIhT1tUF+lc29QOP7Wg5EeQAdsoMUDac4
	+2SQi0oTM3c9S/w640L7VQikSOEXyUE2ISfcw8uYT8CWwd+Hfqt7rZg==
X-Received: by 2002:a05:620a:3721:b0:939:6de7:8768 with SMTP id af79cd13be357-93a29bfc96bmr50309785a.47.1789344217705;
        Sun, 13 Sep 2026 17:03:37 -0700 (PDT)
X-Received: by 2002:a05:620a:3721:b0:939:6de7:8768 with SMTP id af79cd13be357-93a29bfc96bmr50305385a.47.1789344217275;
        Sun, 13 Sep 2026 17:03:37 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-179-215.net.columbia.edu. [128.59.179.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f19291sm872250985a.10.2026.09.13.17.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 17:03:36 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 13 Sep 2026 20:03:05 -0400
Subject: [PATCH 1/2] libceph: use alloc_page() in ceph_alloc_page_vector()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-ceph-alloc-page-v1-1-c436f2f4c068@columbia.edu>
References: <20260913-ceph-alloc-page-v1-0-c436f2f4c068@columbia.edu>
In-Reply-To: <20260913-ceph-alloc-page-v1-0-c436f2f4c068@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789344215; l=878;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=p1jlM65ZxQ3So+BBCB1oyi/3+0R55NP/llbG6qT1Q1I=;
 b=92+fJ4gu5ndZNLo3q69o9FyuWlR4s6e8LAL9DwyXxXEdfrj1byabHcaO5+agpdQzqTksB52vQ
 t2IOKqGQgX9AMUj1imGTWnV1+LP7s7aOgu4Y4DChU7LtkuwWjD3L86w
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6aa739da cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=2jelXx5xVcRIF5zNctN5Qg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=DGrGr6oAPidr8uhfY7EA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: FBzyl0qP4Pq3pL4SZHE9-rjjnhBZi3al
X-Proofpoint-GUID: FBzyl0qP4Pq3pL4SZHE9-rjjnhBZi3al
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDM0NSBTYWx0ZWRfX2fm0OAz4NlSi
 vAWGjHTuoKTijmnpJr+m2BDZ+pzWRe9Fvq8QPUAVCjpk5T+yPefO+KVCoG1ZFNyl5eFXSyzbNWt
 Ss3oRs32f97M9/AtGn04aKvGxVFamgZpB9tHv+UuUsqJRbuKTyhj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDM0NSBTYWx0ZWRfX/K2b7np5f1Su
 blgezNveku7cj14RtVMWibRWSeLNV55ejYlFnC4vMSHw9SnOpKW2xM1rfToNUCokMPHu6g1brnC
 +1uBQ/psOrsKLn1ZLC1v5ZTyrVfq4I2tJu4bZ1fVvDV/PixiKHHtcO6KJN0OK+zlUFEmAQcVDFs
 xiGw8uxhWo5lN/fL5YpqvQIUtnG1vCfnO6RC8+yarO9BDO2e46D1OWHBvIc7XEQoUebVDUCa/p4
 qlgi8BWE1MM9Oa1eEO5+tA0yeL2InuIoaFcnYwhi4SDc+NJhk/S4SoH9x+nqEMsl8TZZM6tJx1b
 1FGlT29CSORZUfYCGcWPsLqEsYgyp8TXgaJq8ex+hJ0tIvOzkDyqdzDkchl1+ZHoFNiFIxYWsDA
 SwF5HyYT6XhfWwRZxdaOyxL/uR68Iz6gMVrYdDVFh+ubxAOMlsNcFncxzrOt8Yd1go+EaehXe98
 xDd+X6aqECjQFMLRbFQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11904
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 impostorscore=10 bulkscore=10
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130345

ceph_alloc_page_vector() allocates its pages with __page_cache_alloc().
However, the pages are never inserted into an address_space and do not
need the cpuset memory spread policy __page_cache_alloc() provides. Use
alloc_page() instead.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 net/ceph/pagevec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index a6aa5b3b7a1e..885e58c2d129 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -32,7 +32,7 @@ struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags)
 	if (!pages)
 		return ERR_PTR(-ENOMEM);
 	for (i = 0; i < num_pages; i++) {
-		pages[i] = __page_cache_alloc(flags);
+		pages[i] = alloc_page(flags);
 		if (pages[i] == NULL) {
 			ceph_release_page_vector(pages, i);
 			return ERR_PTR(-ENOMEM);

-- 
2.39.5

