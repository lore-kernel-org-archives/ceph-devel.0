Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF3488214
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694527; cv=none; b=srbeI1sY3TaiJjEtLRbLvnZZHmLT+4oCQmwzhGVqO/vqCCFUgRMYB4TbwOqeZzTL7lmokQQAvLYv2ANPIejfR7m8zCTIvgqy+QfJPjQLnmeMEu5+m6w3pEpZrSiiPbfGCTjOA4R9ukc0zoVqc7rJlcg1b11sc5bWZeetm1JVl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694527; c=relaxed/simple;
	bh=eVi4hVfQOAmdT74LZh4G12m8a0ZZPIXZgkqKLZit6L4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BL3Fh+JWthvUuecm7pwlyquRmRLhQXQdT83neT+5VZGhLTlpRafz4ma0ih0Vne7gHqbXuNQ0Z24UUMG+3GhQq9wwzGnVxUSu1UMOcJXlfhglK2CQLPQqiiOWedlpc0Utl1ZNem1KgcIYBcwjjavRCHQIkERw5CU+KbQctGi/lwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=KOtjxM6s; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=r06fV4w0; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="KOtjxM6s";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="r06fV4w0"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PKYMrq2432305
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=W/4j
	oU22hrNn1ds0RKe5hAHiyMQzpcjM+eQV9U4XQPI=; b=KOtjxM6ssPTO1zepe6W+
	ZNV7Zr+ciSzk2il9qw6xgf1+Mux4NLjBCDMfyR6pGvMITCtpPRQTYRU5Lqh6NnrC
	1ZQo7Lqxa+A/sdIBohJdbpL5E5eK47aAWx4rVGyvL5DVy7CiC1wyzdQVaMbtUEaO
	coTFmAwi3yuERKhdUMTunoOOhF+SLkLgYPxDcB8rTMWbQ3/CknxdOLwLSqRmS7mU
	/DfOSQSYVNCJzz89x5kzJoiP8f9hg6uQM9UMDsqyplSgnDXgUWe2bSoiQH6lE9PA
	Sz1UetxRQmx2GBKe4QWlOr00fFAaFYwpLcZFdDgnLSIhHWPcRxxMtJh4ThFZXoIY
	ww==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g9c32uy31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:40 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9368f2b7b2bso22081585a.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787694520; x=1788299320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/4joU22hrNn1ds0RKe5hAHiyMQzpcjM+eQV9U4XQPI=;
        b=r06fV4w0cK2PMcdHMIiD4QkyqGU5uhnsOoB7bAqu0lFDIxEhP+JYzJIHBDwCv5bnht
         3EO3q6DN0pxJVz5CxcCtJdjNUFKTcUpTDgaMOzYih2p9vDSPHp4+uTMTNy7LtbCd0Bbw
         O8fYpkvMnPX4siLOIy35cTCz92G/hKnh0LTe6z/2aCXHN4NfaThvUh3d4s+9HCxHnZY9
         s/WLhhQZd9pd3g5Vy8qUHZitHXs+xJ0EAnyet2a3e84nLWRPmiDtNkCXNeYCn+PQt489
         OTY7PoPgYz7S6o8vV1l5PsC8t8C9deqEPh5wkljhvm8LMk8P0TDpFGSNXIpLLN2Tdjuf
         Bxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694520; x=1788299320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/4joU22hrNn1ds0RKe5hAHiyMQzpcjM+eQV9U4XQPI=;
        b=P4F8nrftTSkjTbxdouxJqVQhUUshZJF4RiDBXCmA48IR/zx2pDoHVOKPIVPfQivj/Z
         yt7PbjVm9uP8s+TeXBzMweAZds3trrhg7iAJA0HVQNJ5mRiYfmlzFm6uEOhs0rosk6Xz
         uY0BZnUsb/u5kqLDFKNuekiFa1rxOnWIe7Qsi+EivzbegYG0E99R34+2Q9yGaes5f9K1
         QJG8yDI+4Srp7gdsVB64VIjNcHYPGU3E+qfSWshhD2bOyEjW7lJL0e1XteIGOJwfCUzM
         z6l+Na9f68DFJbzP5tXrIk6Tbck3GGj+T1zGihoIVzQ7/SX55Abl4LCYVIyBaeunNj6l
         7lCg==
X-Forwarded-Encrypted: i=1; AHgh+RpGRCO4XZBWinHMNCf1npWihXNwF4/ZTyoKy3L/2/QhFLg9cijI7WPmXmCFeI+1c4FxV/8q+Ycfuhiu@vger.kernel.org
X-Gm-Message-State: AFuF++kORbcj/BsjODZ/7rtlMWSxcnApqWm68s+O+TGzPPJgoJp98Drv
	wURakLb+DzIXktSPa4mZmD2BL+0rYCNVqEngGMmkTZb3V75Ltl2eXAu0k9mOpwmZg65/dgpNBnf
	8jXmVF1U3mmoYOe78AIiaFSoe/zSkzxOKny2VL8JXD+Y6dOIdD5E6ctUbokfWogD9ScV+jw==
X-Gm-Gg: AR+sD120ArveQnCkmdbZe3CY9whgPwEQKZtXiBW7+k3+B7Jg4wzt1qgF8WwRnJ0d75F
	cTxzQWJVofdlZZVcJcjLWXzbq8TKUO4IWpCtJ088Xn8WaS028TJ9nPHwsvU9kA5G1Kg4sxQF1VA
	UBmAC/T+bVYuT7Tbpg/sJhoKz2+eAck8rdNGc9IlaDchKTjbJNmAswSkvuWC5zpyyJ9iGzVayP7
	UE0XkKO8Joqa5mFCfzziD2TYcEAtgAZU/15zpfMnHKMPit+I7OLPYs/Sij7m57W5fz7sohkZ1SL
	izZoaSaSM3H9zwbH10EKHZIfq8vnzmZHiRW4CNplklMvbe7Ex6sBeNjgCwmjYW8nARySH1YNmlI
	a02YZ0DjzuQ==
X-Received: by 2002:ac8:570e:0:b0:51c:2135:b00a with SMTP id d75a77b69052e-52e423da755mr21373981cf.40.1787694517683;
        Tue, 25 Aug 2026 14:48:37 -0700 (PDT)
X-Received: by 2002:ac8:570e:0:b0:51c:2135:b00a with SMTP id d75a77b69052e-52e423da755mr21373571cf.40.1787694517187;
        Tue, 25 Aug 2026 14:48:37 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.157.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9ef8ffsm139207566b.60.2026.08.25.14.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:48:36 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 25 Aug 2026 17:48:10 -0400
Subject: [PATCH 3/6] ceph: use a folio in the READ_INLINE path of
 ceph_read_iter()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ceph-inline-folio-v1-3-d2366fade152@columbia.edu>
References: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
In-Reply-To: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787694507; l=2358;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eVi4hVfQOAmdT74LZh4G12m8a0ZZPIXZgkqKLZit6L4=;
 b=mJU4OqkZVbuShezNNtqXVicPOJAUMeKRW06/6nCZHulPzAfk9vSO2uieNrxKNJjn9txMEO67m
 u4MSzskO/xpDIuHNDMMs3S9Har811xgOI1mcZTujPG92Mf6hwfD7J6A
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: JSxC0Q0bOVXZx1dO4cJlI7m4Q5TQ6D0n
X-Authority-Analysis: v=2.4 cv=D4937PRj c=1 sm=1 tr=0 ts=6a8e0db8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=VsYqNs1x6zyujO4rtox2PQ==:17
 a=lYjiPEibtFqA77pR:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=A0y_DWxS2BwA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=azVShVRs0zEubeQ0wG0L:22 a=lJkK8zq6xVIZ8jstRnwA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: JSxC0Q0bOVXZx1dO4cJlI7m4Q5TQ6D0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX8SIYofQQG5aR
 OOh5WAYtKICk/WfuA8p/Dhk2DLcYlRdu9IGMHZpcZ+ADlMakNL8IWotaJraE8BDmw9Ly+7y6sHZ
 JMetM5MxKd9s/G5yfuzWHkbxDxWvUZcRozR9RsFgVxV1gDDCaeSUj8meIOrc0X1WI6wnHDzAruf
 G4zZHy6cIdWJkeGVhIKQh6lQQRBmPTnMoXW7Eg9/+y0bjG1ZOpkPck9f/QSAwgaqJpm8Hv49pE4
 fNnm3nF4OfsyasjRbZNxmltA9clzoWTTC+Wya2gNgUjRiRIBKU+hdmmSJxpHZMPr6Kg9Hrz8ktY
 F1Df5ebFrrV2Lgyf5Rc9eF7megqmN43V8t0SFfgSzttgmm1bMK0yDxZmUe5nDWQUSNk+HOsTCeh
 EqA+VD9GWkzyLjhY4gGYR/30Zv6seVLshPDiGo/Zmt5V+CrTMoibQW1iP8EEP/FyN6A8imje3lq
 oXcpf1rq2f152OVzK0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfXyqRVC9V1N+oQ
 gIE0Q/nUJA7KJ6+pL1lcrQVphqClNBXn0wE6JKnJnHymi5+EFGmwUkZgvRr29k6Py5OA0tg29AL
 lS02G45BlP6dr9wty8BFSdqEAKpLNQunfEhHG1r0HM1m3YYyANKp
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11886
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=10 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250185

The inline data is read into a scratch buffer that never enters the page
cache, so allocate it with folio_alloc() instead of
__page_cache_alloc(). This drops the cpuset page spreading that
__page_cache_alloc() applies on NUMA systems, which only makes sense for
page cache pages. The temporary buffer here is better off node local.

The mismatched __free_page()/__free_pages() pair both become
folio_put(). The __ceph_do_getattr() locked page plumbing will be
converted in a later patch, so pass &folio->page for now.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f322ba42102d..592e32d1e2d4 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2264,21 +2264,22 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	if (retry_op > HAVE_RETRIED && ret >= 0) {
 		int statret;
-		struct page *page = NULL;
+		struct folio *folio = NULL;
 		loff_t i_size;
 		int mask = CEPH_STAT_CAP_SIZE;
 		if (retry_op == READ_INLINE) {
-			page = __page_cache_alloc(GFP_KERNEL);
-			if (!page)
+			folio = folio_alloc(GFP_KERNEL, 0);
+			if (!folio)
 				return -ENOMEM;
 
 			mask = CEPH_STAT_CAP_INLINE_DATA;
 		}
 
-		statret = __ceph_do_getattr(inode, page, mask, !!page);
+		statret = __ceph_do_getattr(inode, folio ? &folio->page : NULL,
+					    mask, !!folio);
 		if (statret < 0) {
-			if (page)
-				__free_page(page);
+			if (folio)
+				folio_put(folio);
 			if (statret == -ENODATA) {
 				BUG_ON(retry_op != READ_INLINE);
 				goto again;
@@ -2295,8 +2296,8 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 						   iocb->ki_pos + len);
 				end = min_t(loff_t, end, PAGE_SIZE);
 				if (statret < end)
-					zero_user_segment(page, statret, end);
-				ret = copy_page_to_iter(page,
+					folio_zero_segment(folio, statret, end);
+				ret = copy_folio_to_iter(folio,
 						iocb->ki_pos & ~PAGE_MASK,
 						end - iocb->ki_pos, to);
 				iocb->ki_pos += ret;
@@ -2309,7 +2310,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				iocb->ki_pos += ret;
 				read += ret;
 			}
-			__free_pages(page, 0);
+			folio_put(folio);
 			return read;
 		}
 

-- 
2.39.5

