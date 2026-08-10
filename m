Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90493FBB5A
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371676; cv=none; b=qgzp27wyk49S1vbFAnpjSKDuAuJ+qfaRTjsjJ6eWpIq4NJKk4Xcvisx/Stsb7ov5lmSDy/9bwcBn+VoJC+OGszL68to18Yk+uY7ibU6HFW2AH0M27SLeBm+TS+w5s/heeRbz/B3mndeAudTQTmkDVlhgNkLKBBEM9XL22sDVRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371676; c=relaxed/simple;
	bh=bC/X5LUNCwcfzqxhGB05BNOZAidcTm2p6b14nFOUhtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRrPOm+SumoqFW8B/lercXBqpCeUvYfy96Mhx9Ka2KtCf3Sh61r++q5rZwENt7DMJmxdQD0NSiNtuTrNpH/tsdWTYaIa970yahOl0HtfDcFwu1m9qUvaCige74zo6KYI7cujxWDGDMGtzaBiXDmRxPEYm/fXyjPmo5Hl2NKpYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ccHuRGEe; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ccHuRGEe"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaCZC2933136
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=lUdJ
	8GftPVQWe/bytIhh9qzgnz0Y4e69yuiSB69qTBw=; b=ccHuRGEeALBOBGJMKv6L
	A5Til3j2/Eu/yO/cO8rSg5+O05x+lVf11ATFBAh+1d8SkfsYyLcuM0taPN8BRW7h
	Ihj3MmagLVOT/uSeoL8BH91px9Pzph+LZ2Hl+263w6kka3H9tK6BR1TLpJTNAazs
	x+pz84aOE4pSka49HRgte8Hp+KH3UiuinLP4FiVwIfxcrM/i7WwrFrR29/GjiiRE
	NRCtBDXC95QVSifxpU3sgrL7T0dK3HMcnFqlCYyyZZjDMvLrIRf4nhTpNNV2yRO8
	ewO4Txvzcfu+W7mt9oUdEAXr+7vcv5qJNF9sAYMGhbVFDjv23ELqkbTM7K1INQcU
	Yg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fy0rmkcep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:06 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-907a1e04111so21176536d6.2
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371666; x=1786976466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUdJ8GftPVQWe/bytIhh9qzgnz0Y4e69yuiSB69qTBw=;
        b=cdbOspkzm/2RRNsx+k5ZndtupZoku9qlsLJ7gmLrSBC/JnPXEU7gVmSlv1J4AbUFXT
         uj4w3sgaQP4APOD49MxsvjvZ64GMG2oqECqi32YD3kfQNLZ67GrA0Sf54liVOynnQkHR
         mpdPX0dBudSnmTYSb0lQrPhNEyXOQxaHNh+JpVAaJqpbHYSY47mfygj3EOOdqKaIndfv
         kTuc8MbJ0lhE9Sy2jv4e6+f3LIPo+8wzL+OJbRAgJs1dhyJljGSUKIh8HmAYwGKIwLju
         H5sXCOqHz4maX9kSiiP7T8f+3emNr7DWAwX6r8C/vH/7Lkqp1Herh/bsssa63eJZ0/VY
         LzNw==
X-Gm-Message-State: AOJu0YwGv0PiWtix8uxBdsMCQcxt8QVaaDEFa6OXR5e3MF2weQir8Xt8
	Bpz29CYhz3F09yeA1+nrAs9zHhPOrnjq657nuT51GO6HYF8Jznwq4lvSfO31f2/lbxMvs3aoL2J
	n8AfRMXuumZ/m3yqtzAcFg6MgTOrmzbvG+9q4//uoLQk9m1I9OyUC8YU6oWo=
X-Gm-Gg: AR+sD11NtRFVxnFpbAi0h7Co3y3W1xoDnMQnIX78XDMDTvJtKDtHEqcmJmR1N5DZru7
	GYNmdfJRS2sICDLqDxsg/BsKyn3GAWzfhLUJCxtrWafeFjb4cbVcPCKbE0SdIdVE8JAyZlkQPnK
	83pdXKBTeqq/WCFxpG2WiyGzqZrU0ghERk/NgvHf9duQZi3VwmiukchtA6SCX5pOc6/jT0gkUT7
	3qmt+EAqhE9AUPN7OEyDPx2W9SDuI1kyvdpL5sBx6IWXXNRqn7z14hAua5TXmfR4epXQXxA/bvE
	k5fLD9exE61ACypv1iplTm9tswkd8DjJwo6AqpRbmZnycVg/EZJ/k8JajijJjlhiw8D34NQy1sO
	tQ334SAT9
X-Received: by 2002:a05:622a:a0f:b0:50e:635b:5579 with SMTP id d75a77b69052e-52d20975cb7mr245780171cf.19.1786371665998;
        Mon, 10 Aug 2026 07:21:05 -0700 (PDT)
X-Received: by 2002:a05:622a:a0f:b0:50e:635b:5579 with SMTP id d75a77b69052e-52d20975cb7mr245778981cf.19.1786371665399;
        Mon, 10 Aug 2026 07:21:05 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:04 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:13 -0400
Subject: [PATCH v3 02/12] ceph: wait for pending fscache write in
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-2-dd7531704f26@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=2136;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=bC/X5LUNCwcfzqxhGB05BNOZAidcTm2p6b14nFOUhtA=;
 b=p/ml+Ve4lftJD+H+kNATKF2FjQfAQG2I6SrAiFbDZQLHfjVFfFFrODbMCdfNhfz5ZM35qVRfQ
 /xPdai/ySDxCiFP5iaL/zocXJ2PC6z8jt9HKL1MXrWU9AH1wPz/l1MU
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=6a79de52 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=zYp62tllrndxtlEyWVMA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX8eeKF79DPXgq
 JVrvdbPtFFQO4qS9W+c/+5m7h2DWAhn8930p8fOCyEGBceuDNRiNi+tTY2h/VzgkMeZDhNzQ0Ll
 QMqxc9ZV4thgmSDlCZqcvkly3UdU1+h7uz6b2uayrsZtR/bMBlKb
X-Proofpoint-ORIG-GUID: fAfbHxyi5HwhuYh0lb-SWswN2jr1n2dz
X-Proofpoint-GUID: fAfbHxyi5HwhuYh0lb-SWswN2jr1n2dz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX3MnhnjyrOIro
 wzEsJ/ZQls6oUyM4oWCW3WXbSJxMwC1v5TTRfgmWtlMVhiMlO8H3XxYmBie769dXR7/QDLchFSG
 zVE2k42Q8yR90i9FIG4ev4D6psFDk/iE6tNmBYPnN7xCVX/QcUaqa48b+NGbIO+5ZAeuNpix3Bx
 gsRjCu+xRM0PhmQ+vIkh06eNHQvjYfw4BCl6EI8wuA9kFdeOFH3IyAdOAotCBBNCo80hiwm5jS3
 VmvBWLcqo0v/4mwBGT2G7Nt6b0mLUmZ+GNyEarzf+WPdeaeuIeAHpyrRQL4ImK84IRnYCYwPHQR
 pUGLf9Y0v86vCQxYY5RJrJwmoswo+cnwxCQGS0Agi2e1TtXhGmPsckTFNJ2JtJ7Ey9yGPodihIW
 Qbltolt2TcBrZGBkhS1CpIlpOVlmNgoKTYskQeSP2Vxtaq5WRbUMM3/pdWIuF6Isahy/0DVai9t
 wfzRmE9VAaXD9BgkeiA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=10 bulkscore=10 lowpriorityscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100123

write_folio_nounlock() marks the folio with PG_private_2 via
ceph_set_page_fscache() and starts an async write to the cache via
ceph_fscache_write_to_cache(). PG_private_2 is only cleared once that
write completes.

If the OSD write fails, the error paths return without waiting for the
cache write. On retry, ceph_find_incompatible() would wait for
writeback, but not for PG_private_2, before calling
write_folio_nounlock() again, which would trip the VM_BUG_ON_FOLIO() in
folio_start_private_2().

Wait for any pending cache write before starting writeback on the folio.
Add ceph_folio_wait_fscache(), a wrapper for folio_wait_private_2(), and
use it.

Fixes: 1702e7973410 ("ceph: add fscache writeback support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284%40columbia.edu?part=7
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8cd24f66c981..de0113b23940 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -559,6 +559,11 @@ static void ceph_set_page_fscache(struct page *page)
 	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
 }
 
+static void ceph_folio_wait_fscache(struct folio *folio)
+{
+	folio_wait_private_2(folio); /* [DEPRECATED] */
+}
+
 static void ceph_fscache_write_terminated(void *priv, ssize_t error)
 {
 	struct inode *inode = priv;
@@ -580,6 +585,10 @@ static inline void ceph_set_page_fscache(struct page *page)
 {
 }
 
+static inline void ceph_folio_wait_fscache(struct folio *folio)
+{
+}
+
 static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
 {
 }
@@ -803,6 +812,9 @@ static int write_folio_nounlock(struct folio *folio,
 	if (wlen < len)
 		len = wlen;
 
+	/* wait for a cache write left pending by a previously failed attempt */
+	ceph_folio_wait_fscache(folio);
+
 	folio_start_writeback(folio);
 	if (caching)
 		ceph_set_page_fscache(&folio->page);

-- 
2.39.5

