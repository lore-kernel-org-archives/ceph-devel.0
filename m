Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19D388E7C
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694535; cv=none; b=oconuZ4WPT8pSNOdFozUtgzDl8vwXIuPsIGZ2+bWCbDcXRCWbP2693ByAkksAXWAOiE1O4Vg277knVmxaZrDK8aLn6gct4J17T4fhq+/xTGkAkLE+qxoTZiWLOXUumAgSmM7oVkWNGk68qxvVQ2z1SqGikMLWfIcdiiOPj1szCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694535; c=relaxed/simple;
	bh=wCXx6gySSVQtNNpiAcoYthUhph4w2HTEw7CB+d+HVVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oE6g3Xh3XlKVoQ/90rYe5op3Cgoz7/jJBrb54AoDd29rhY9PUIXmTRtglQAuG6eLw3rMKKcbHa0eGOJ14NCTtFBe66FPCUu/m0Pqr1h2pDB65AhI7VmDxwUF+/R1B0xeMKp20rcDAlyZz0mhgfLsAlOA0rUIpSv/eJ4mMzxvNFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UL2pe0pi; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=rzh/eMII; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UL2pe0pi";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="rzh/eMII"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PKYPKc2166709
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=jF/0
	IFIoBqA2qUtirbDj0G496A1nIjjjXUVQ3bxOLPw=; b=UL2pe0piy9y2x4Bhhopn
	J1st+XpYXu7m2VufAILcqbBslZyqnOENXRlS9CX98SuNufd0BQwYXyD0ulAkNda2
	VrfoJrp9Ixyrh24De7jF6dMU/fE+QBXihRLX8EQ5rL45+jvP/ipooPVzMQtsfgsJ
	lrvM8IPzrvHtC+vNwjvXbX+stG0yCNOzUDOsqXnQafTcsEs56K1oSPDUSmoTMX59
	eGuDhzYGEnknNldSml9KVawhxdn47ngLa1NwjFtfP9ZWPYcUEMZoTKRSX+BJt5SQ
	AyrCaXet8jhmCZS0mNJ6ygtxHektGreZsoE+GtsnvjT0ITI9gdEBp8k5V0l3cjDQ
	xw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4g9ec7ahvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:45 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f0f45415cfso3508056d6.2
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787694524; x=1788299324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jF/0IFIoBqA2qUtirbDj0G496A1nIjjjXUVQ3bxOLPw=;
        b=rzh/eMIIX4BqVOxFz8Qo/xTiBrsOi4Zvvqwv/yEqBAEtPbsdKP8Chx2o5qQ6dPwq37
         2Pck9YticJqaS4/Yg3FORqCo8CNQKKB0wq8nUpVar5B0p8QKAOf/Qt1RHToVvgrOmUJI
         4Di1hGmXKpf5ESYvXoENUFL8gbu+lwZqLWkY7ru+BGEboY9KzwJffS4KBQstx7FXDxQN
         dmdfiC7Lr+bD7XfjLHDjjYTegBR4Mq/SPUhZcivJtm9YlGU+CgV13xxGEW6cMsQcLQCP
         xYssqA5ORCGTi4PnJfg/GzkpMEepFRXBmLVakx/Gvv5Gw9iBk5VbETtgdHLJ7bmMJvOc
         xJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694524; x=1788299324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jF/0IFIoBqA2qUtirbDj0G496A1nIjjjXUVQ3bxOLPw=;
        b=gL/JOy0WRLe0a9evv+/t9rYKWXTc/0co3/mxJC+D5/LX1m+pyCTWPOky1GPFULj052
         dkKDs0SJC0gVe6REt/JXQZfOx+TRyGg450gLx/JzPBF8nP0PAXAbrzkunjnmOeBbCWrB
         49rItjcuX8EA2/8naVFZn02CWo7VYc+jte6yReVel00I82Ye2eQR2khenlWvFRzV2g8i
         jm8J+A+lXHNjVoYukXNljvPk9h7quSgkgFlWkr5io9rLxSDQac74ghYEdbLx3NKvIOnp
         hsYKcgdCvGWi9/JbA4QaAkQWzHPaU+XVD/hUL2lJn/3PDn2WTITVr9kEfjn6Mg2eUm9k
         DnWg==
X-Forwarded-Encrypted: i=1; AHgh+RodN6BlnomqTZsL43xGbZqDJL09LvZGQXMOjUzwU7TgJUN95pqORwas1qOQ/J2ktTa8FyDGeLHQwfyK@vger.kernel.org
X-Gm-Message-State: AFuF++n/xrG3pkuRiPXFWVVf3l2j07+WdD+hyzX/4gvmoZA/pIfwHdIy
	B7an1kqBBkZyD9xKk1I/X+wa8jlFV/tsMRVRzTZFdGkXL+4LYZLuEGV6d/aFJhHIWfEsrAnTmfb
	i7KjfpOB2Rn6CTWqZHNghMNcDqLceRogUMlDTmYqXqrY/Z33nwXfQiDtRLmNdRO563CcDyw==
X-Gm-Gg: AR+sD119chr+R81iK/wstJNkYdAACme6NFjUUNzfmXuvA1094MBP0V0dPlLu+rCI3T8
	ZRznG01ynQWoZKbo3eL2IJ6fK00yNjSv5z3J1Oqe3IGsundFepS93+XH8vi9Lsuu/AXlZWXNNXT
	6p7FxJ/nZ0ZXywwN5cuQ7GP+QpvHo0xPR6+7N5wqqLZ53AVB8P+PoRCyW4l51NZhI7tqh0grHiT
	0326oJu/FcGJBXJSH7FbYAHriSOs474N34h9NGcISUy8RmKxeuxryn3rL0rEVailFyRvrLn6m3M
	62HP58MAvdAH+3/3xffbRRE7S0bWHf6hbvElmDJdOUFB8RYtCiUnCIDKGZWZpX/ccJy1UeXSSud
	1Xf3dT8LG6A==
X-Received: by 2002:a05:622a:6102:b0:52d:3ccc:968b with SMTP id d75a77b69052e-52e42235c7emr23131771cf.9.1787694524341;
        Tue, 25 Aug 2026 14:48:44 -0700 (PDT)
X-Received: by 2002:a05:622a:6102:b0:52d:3ccc:968b with SMTP id d75a77b69052e-52e42235c7emr23131351cf.9.1787694523902;
        Tue, 25 Aug 2026 14:48:43 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.157.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9ef8ffsm139207566b.60.2026.08.25.14.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:48:42 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 25 Aug 2026 17:48:13 -0400
Subject: [PATCH 6/6] ceph: use folios in put_bvecs()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ceph-inline-folio-v1-6-d2366fade152@columbia.edu>
References: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
In-Reply-To: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787694507; l=1018;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=wCXx6gySSVQtNNpiAcoYthUhph4w2HTEw7CB+d+HVVI=;
 b=o+zPcPS4z/LjHVF51j42qPs7iUB+fHLwm9Dfy/P+ZUmHOaqcaYay/CGS+M2ZgblvxofpLpGH9
 4s6jj/BLXNACybPsK+CBcYJuPsid66Q+FVs1u1RGufHQjHF0sTEbieC
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: UsnF3St2yVBQYg8Hhf3BQc5Y_NpTBCoQ
X-Proofpoint-GUID: UsnF3St2yVBQYg8Hhf3BQc5Y_NpTBCoQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX6cRuukuVKdSL
 xoz5OiWvC6Ww43+WJYh5zBI1NDxBaYBE8rGAJF10qjlLmaJPzsPyl+1yOfS0TTo3PgafVNVbZaM
 nDz3zI+W5uJUzJeumbsL0J8Ebfx77d7+VpoVE51Z3XzX4mTpLUTzb2UIZVIDCqaMfGJx8bi05vH
 Xu5EftKWZ7b8G9VTuWmWIqQj07hfOiKWY2USWVKFzisliUBslWNfL7JxBCVstXbL5Vbw6MkUSpo
 nANVJkSkbBmuhbprl5ewL2vFpDcQcw1dBL/IfZ4C6TdlcA+w1eJ0x/+iiTxb5eMHpMbezEPZfCB
 0i4p3hL5kRnOy7zyV6dwiqxW3GoVHgasUunXI7tVtywXeSaUVCFT/Lhavvhsi67q5jaLYpwvrhn
 JuEdcCNLylZniA774nteKE8d4YrB3cTwKdlgBv9AKD/EZkaNcDSqUnyIsDqfj7q+w56Rsb9ii0c
 1cSVsPSrRtVW9pfRG0g==
X-Authority-Analysis: v=2.4 cv=UspT8ewB c=1 sm=1 tr=0 ts=6a8e0dbd cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=VsYqNs1x6zyujO4rtox2PQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=NfI_OOiaZd5PfrAeB84A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX0e1pg1QJSa37
 nno7xRxueqiKMUMGkyu6URkWsSpKCVcR0++tjbhOPF8j8LsiWnl3JvWU4VxU5m9OXVvfa2jVmn6
 epY9zchN3GPJbWtDkTQ+8oA/h+3eFJ+tqy0ZN7KdxZcagnTvFlRI
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11886
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250185

Use bvec_folio() to dirty and release the pages as folios. This adds
one call to compound_head() per page, while folio_mark_dirty_lock() and
folio_put() each drop one, for a net saving of one call per page when
dirtying.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/file.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 0b6921293f27..89233c5905c9 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -182,11 +182,15 @@ static void put_bvecs(struct bio_vec *bvecs, int num_bvecs, bool should_dirty)
 	int i;
 
 	for (i = 0; i < num_bvecs; i++) {
-		if (bvecs[i].bv_page) {
-			if (should_dirty)
-				set_page_dirty_lock(bvecs[i].bv_page);
-			put_page(bvecs[i].bv_page);
-		}
+		struct folio *folio;
+
+		if (!bvecs[i].bv_page)
+			continue;
+
+		folio = bvec_folio(&bvecs[i]);
+		if (should_dirty)
+			folio_mark_dirty_lock(folio);
+		folio_put(folio);
 	}
 	kvfree(bvecs);
 }

-- 
2.39.5

