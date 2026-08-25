Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6633481A92
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672513; cv=none; b=QVk5ZSv23n5Fk3z75t0+JTCxKG/bi/SbszPtnQ5jcaJp6DZ7CZVK7d8q2P/e00P5Pf+bpIxQaKhc4Aly4cD553oJR4LT8eGlOrV/cGYIi61wfss1qEenGP0tu0Li79mImmnKdVw0tX7viA3pweXzDmQi3rPU9/fJ9+HiiW7Mpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672513; c=relaxed/simple;
	bh=4U6b4lMIo9YhLUUS4w31/FBKnGIHgEqeIFYMnxkJ3x4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kXyHw9f3Ja6uylP49zN+/Cxt+6b2OAbpXtYolsxuQi69xqNd+U6VL1XCQBF3DgwvryIHv838aONdo7Iq6HSUZGNryHIMt0SrYrv/dmlmvPZHUE3tdcKCXQHxk/5qiqXjnToPpkFoQiDZE0ODy8ldrcx9dFaPQT9qeJvNYqIIkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=E/vpUPHM; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=IgfTzrAR; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="E/vpUPHM";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="IgfTzrAR"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PFPlRv1730528
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 11:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=QwLCRXh5uHyDOTTjOuOoMoQZ5E
	jBHO2U2Wq2PbXccnM=; b=E/vpUPHMGDX4mzoaM1ksetBjwuidUdTfmE3t1/RoT0
	MM5VKa2cOXBsOejTwhESCjxJk5tOZRY8VuIpkApfAuNB0tr8uXiXzHZavjaYZLJ3
	HxeNkk9ggJttaVYJp4kpAZ+6Xjtals8Hmgzu94NbT9e6wd7XgUB/Dg/dpGIwJ7Oe
	xv9HJczLcyIzbZNReM/n0JY+w2P0PhYQqfwPzuWuJIOyeVTdXucl78xva10/RANN
	FXK5b0DiFijYYfUHPyMSaOXBhAdt1fImtKfIcL7Z3e3z6WkmD8s7l3h5fg9uO7ah
	cBesYgosn3JEZ2NGQNvS2vkSrz/BKDQLuCYBvRS+IUTg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g9c32s2s5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 11:41:49 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5283df62d68so65998241cf.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787672509; x=1788277309; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QwLCRXh5uHyDOTTjOuOoMoQZ5EjBHO2U2Wq2PbXccnM=;
        b=IgfTzrARxwddOh0PH7L1s7tFU3XkN4b688Xh/2V6v53yafGH6OX/+d3l3yNFawO6s1
         5oSkcJcjeDYzOujW4zjoeH2FDLvczj43EMokSCJ+FMTch88jcXjsD61i7QQhkl2XbkyX
         8+LETc2kawwPE1DBfhauFo34U5ZF89a+fImluaYWi/gu+7IzQ8Bev1cctvEWu8NjDx8X
         SxPSZPnvmEyaj60NHDO2hHjt2+7NKTIbluuENqnxVxvmvv9+byWt/Ckq1tJK/LhHg7jJ
         aFeQ4GGuenwYaYZ0N+sBgoNkHX1/mV42U4Kl8WWJY1XztSPpg17TdQEXlM9ZnP7ckAxn
         C7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787672509; x=1788277309;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QwLCRXh5uHyDOTTjOuOoMoQZ5EjBHO2U2Wq2PbXccnM=;
        b=ekIUE4eLi1/h1P3S5D2EDFlvo+PDMVKBfvtonlZcZKzEQwk8ltR7Y0Sh+6OTqaWGnT
         V4SGaW9SfEOjzGZudRnPpVFibOjbKUEgmTmIRKXNmxvvkXEhJz78cUSIzI993aw3uyoM
         aYH7IFaWmDyEUTknOpiocWbzlIZ/5Q/tJMYyTf85VtEGOGGAenp/E1AiTb7i1RPHvTDv
         jqsHsT5zSYh4SCjJLEWxtUErBJWinTdQ/dLN6MOsF2TMxaaamOWug1KAmzEzoDOdNRXb
         hn3o/0SrNf2WHyOuOcAt2Z+FpwXzSlnLxRfk6pJKKLwt67ZZLmCmM2N+WNdUrV0AIRG7
         McGQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/E7SVnEcX4rE7sgARNnehjeN52nLLL82oTa8PIJws+PEhY4+cbjPmULrs252IOpbsMHbSRqW0QY6p@vger.kernel.org
X-Gm-Message-State: AFuF++kHgsevb9dp+fz/mv0hw5iZXrRgC1BsUNWAKYWBD0BInaK4y6mz
	BQzktbKABMdcEGJq/ClA3C9IpvZQGlt6jMtgqnaQgNrQmLxD8Up17fnV4A0OVL6mXOe3CeLtK1C
	XIeNn557ykZE1kQ0Q4bDKvj4hVScn2tR/Ncy2IEVF1+DGycSs1/xhVGVYDU8=
X-Gm-Gg: AR+sD10k958mw+8XLMashxD1DsEUC2Dee+AgZDg61CJgVxmaIksuzI/bJ8eefCqhtvy
	d9InyUJIlC2Wn3fav9/qiwmpb0mpvliRXFG6iZcIPQvfAkn9HcOlMx5+pDTxUEbxewiQcxr1ZXS
	yf4T5Vf/xmwz5pYC9lKP7Tm7lWrKTgPQPFdeTmCohqQBTix8QPmk21jDWDohw2ZByB5iW9iDIAa
	JRW+Dpok1FIRIVJczsPzWZmUsRGiBvdiAvOyYlYjUZE01uDE2b0nMMAJXXseknTPjJoy0IGve1A
	IToXgPsuCapo1ErtmKKkvwCtaHhFCJZa+behiG38V9/BqcU1u3suUPlhC49l4OUHeXCFBG4Dvya
	JmHydfZu9Ww==
X-Received: by 2002:a05:622a:2304:b0:52d:825f:e53b with SMTP id d75a77b69052e-52df5be1347mr364493741cf.39.1787672508636;
        Tue, 25 Aug 2026 08:41:48 -0700 (PDT)
X-Received: by 2002:a05:622a:2304:b0:52d:825f:e53b with SMTP id d75a77b69052e-52df5be1347mr364492811cf.39.1787672507964;
        Tue, 25 Aug 2026 08:41:47 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.157.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d62f7sm13523166b.2.2026.08.25.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 08:41:46 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 25 Aug 2026 11:41:38 -0400
Subject: [PATCH v2] libceph: remove pinning assertion in
 ceph_msg_data_iter_next()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ceph-msgr-writeback-v2-1-840ef541b0c2@columbia.edu>
X-B4-Tracking: v=1; b=H4sIALG3jWoC/22Nyw6CMBBFf4XM2pq2vKor/8OwaMsAo0JJC6gh/
 LuALl2e5N5zZgjoCQOcoxk8ThTIdSvIQwS20V2NjMqVQXKZccUVs9g3rA21Z09PAxpt70xneSl
 TlKoSCOuz91jRa7deiy+H0dzQDptqWzQUBuffe3YS2+5XEPnfwiSYYLGq4jxNeJyY08W6x9ga0
 kcsRyiWZfkAzVQMR8sAAAA=
X-Change-ID: 20260808-ceph-msgr-writeback-a67d25e28f1e
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787672505; l=1910;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=4U6b4lMIo9YhLUUS4w31/FBKnGIHgEqeIFYMnxkJ3x4=;
 b=J8rUOJi+qDcSqLzDz1UgDBe9qfIvhiQLPgUoj7vXWevZemD4rWIc6A7rKsIcnDnZGatFdbGzs
 r8cg6xe6BDsDj1kJmzGQyRmtEd+h9esjcsSJYLW8D1wGxP6vjvEkUkc
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 8f_bVBOtPqRSrD_6vK9R1bbXMqZV5Ax6
X-Authority-Analysis: v=2.4 cv=D4937PRj c=1 sm=1 tr=0 ts=6a8db7bd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=VsYqNs1x6zyujO4rtox2PQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=oCklooxHT9tjbPDfpeQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 8f_bVBOtPqRSrD_6vK9R1bbXMqZV5Ax6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzMyBTYWx0ZWRfX5YwFBN2P3k2Y
 O+izzC+Z3AXK3+W8P9SanbeBs41lXMFWZPuRAeQA3/xK2bEUWFQIVcnAQg9/mH944QILTqum2IZ
 Fq1DddJH5PLVH6+4l3hzCYW0RSbZeBqllm7IT2CZ6WLovz578K+AZf/g5xkTrBkKB+vcIDlT+Kk
 QQagG1SO48NRrd1y9INxdsyFUz5PLWaDIsVq2tu8G6DwXlJeiUaTaBy7gPBDjYEn8NHntPc32sb
 y8zuRCw2LHfsrwYpHvHNZtKwWUntU8gHBerHWSAqVUS+PXXk0DXjNmGe07md0p39I2UhxrQgkpj
 g1ZQetM01g0ndDXrE9K2iiRLBgfdCU45I/ZTH2xxkdlRCbLiHd6u7sogjYH9/fpvukyMvuJ+2ja
 bDeKjl1m+3jZv5Sgfsw9NcRvLeg4rzE4prlWqK4d1wk9pHzOKLdTs+Dnmqir1LdGBxc1oteoFkM
 lRlf5mZYYAZxjHw6opQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzMyBTYWx0ZWRfX30xGVgdiQ/60
 vO7FWP3e5WYmWVzEKnyw8RSXK5PMACE4ZyyGQc97Uoo7F4M2IzYFgxG61X5lcJU/0AYhF7e4ReP
 6ljBbOUWc5lpZjvabAQb8GB+7+TM9gwKDT7W2ijDN9nI82DkmanZ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11886
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=10 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250133

ceph_msg_data_iter_next() gets a page reference from
iov_iter_get_pages2() only to immediately drop it, asserting that the
page is pinned some other way. The assertion is the last caller of
PageWriteback() in the tree, blocking removal of the PG_writeback page
flag accessors.

Remove the assertion, as it is a CONFIG_DEBUG_VM-only check of an
assumption the FIXME comment already documents. Converting to
iov_iter_extract_pages() instead was considered, but the messenger never
releases what it extracts, so it would still rely entirely on the caller
holding the pages. That would be just as much of an abuse of the API, so
leave it as-is for now.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
The assertion is the last caller of PageWriteback() in the tree. The
removal of the PG_writeback page flag accessors will be sent
separately.

Changes in v2:
- Only delete the assertion and leave the rest as-is, per Christoph.
- Rebase onto latest ceph for-linus branch, as v1 was applied to the
  testing branch.
- Link to v1: https://lore.kernel.org/r/20260817-ceph-msgr-writeback-v1-1-38f3754034b9@columbia.edu
---
 net/ceph/messenger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 34b3097b4c7b..95929eeb1f85 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1003,7 +1003,6 @@ static struct page *ceph_msg_data_iter_next(struct ceph_msg_data_cursor *cursor,
 	 *	  we'll get an iov_iter_get_pages2 variant that doesn't take
 	 *	  page refs. Until then, just put the page ref.
 	 */
-	VM_BUG_ON_PAGE(!PageWriteback(page) && page_count(page) < 2, page);
 	put_page(page);
 
 	*length = min_t(size_t, len, cursor->resid);

---
base-commit: 91880e4a7fac45bc407771bc57bbaf4f37e9b4c3
change-id: 20260808-ceph-msgr-writeback-a67d25e28f1e

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

