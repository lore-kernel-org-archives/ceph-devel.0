Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682C30D3FA
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994973; cv=none; b=MVIgQjlxERFg4but03zcl9d84nHbgevkr30Sdv+I47UlHORGy2hiPMybKkxuMEoUGfTbGStodbOwUMKNz6lFSUFVxi5LUIicoUn3zGRGWXkuY0RcYlxfO6jqZU7wP/eQEkXi3YSIUNK79hMYR8LuRE9Hly2jh/PQT6ABc2kk2/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994973; c=relaxed/simple;
	bh=sQa7UCD0szsYuQ5e/aenabYsYKMOIzSf4csEoE48M9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dxcauF/uiCFIHPReoamAnk9T7whchmkf/RO/n/cfWEI4YYPLJGlow7kMXWtMV0MKV8kvRBSHOjjZPDx4nKGgqToetuxwvk9uvipvp3pHfrlHDQ97GiIhmxA46/Il5txU6HQAmva522OzunGCh0nQu9yc8RHqKKbAP3xXN/ul8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Ml6JzkNA; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=x1E5sDz6; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Ml6JzkNA";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="x1E5sDz6"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIw29r3692618
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=tCSIsrM7OmCnAlwZ/2327BIkvY
	40J+xCImoJUZ21VW8=; b=Ml6JzkNAZ4RpelKuMPr8FfHzGhTszj4acrOcKVBNbd
	3yOyJuV5U6A4IskJVSL8oZ8BoOUv+dQx6/O2MS86TcSi4V5015fq7sKs8m5DkMXK
	z+OUmSNF8gJvl5XEuGNWX1ZracHm0nILwlvwHtP/lqAyaihZBSrBECsbjBN+Q1lg
	9VHwCmTuGoReAtL6FBnOAjJOF1wu28SQytXhPiZRF7xJgUatrgI6I3geO7lSDgJK
	atKO/6NWiH3RdAByaKuOac0tRISESogdmtmtFFwJuvDjUE2knpKTuigufNYWUQ6o
	WGBNkIcAwykaGbf1sWWPbtQYGlWKWSx6Yn/5d+rFDCmQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g481r88h5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:29:28 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934979ee9f1so483096085a.2
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994968; x=1787599768; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tCSIsrM7OmCnAlwZ/2327BIkvY40J+xCImoJUZ21VW8=;
        b=x1E5sDz6ZdunL6LAF8cFWXRB3mKu+EMiCZ0x9ZwYRgAMjXkadoN+E+S2XklDBE4OGB
         uSwoAgW7CgX9luIU303BsNL6lxF+OvUHvyvnrAqr/SfKRaGHJg4sYMcqwX9MP3JM/rZ3
         IeiZZh5RdTL168Qgwy6ecgT2qJwVeB8S34gKvV8nKE69wfru5mSgwYUPU7bNaJRP0Zmi
         XVYu3Keqe6j1vYWvokzSSntJ3+kATPTmqAvYDeSSDqN8HSwDrh+c/dkTSCSL13Bl+8Qq
         lnu4PxEpFo0HnPCB99EkNdKA5cJE0tbA6x1tIJtCn8JJEC0CTj7Yt/JvfW2PhARoGIgj
         tvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994968; x=1787599768;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tCSIsrM7OmCnAlwZ/2327BIkvY40J+xCImoJUZ21VW8=;
        b=GfqWVjXe80abSpZW0sSeS4FCXMCbujj1hwDsgvmE9E8UU2Bncng03njJfo6YTYKKbQ
         J4EFCI4BVT0wrWJMCiEkjzFy2iTNmIMa/vsxkTbX/jLcfgDG6s417fk7OnWXwTwjtufL
         jYS0r+O9RE38IaBCPC0WAU3PfoUpFdJf8fysuDY5In0qRbR0+GtlNUw3Qy+D4lqH3tO7
         zB9Wm5CKJDYSmC0UotSqp4nMzFW7X8Abv6Z/5Fpe3tyL3IuFmhj8uRZToZ+RxA8BEWld
         8UWthUc4tjE4+A1JyBPCcATh3OnADqsr/PDu5i8OnQNW+P6GRSNmFXHTEmFG8/JXd9u4
         Y23Q==
X-Gm-Message-State: AOJu0YzfKJ8rZxauN0BgJk1OaKuTHlzWVqp9+IEU+PTCCtnVgGvgccdB
	UlpT/DRu/SItcegwV4TH22+LZgEadh3nt6l4yhhMIWU4UVT8lIEX6uztB7ESVDoqlmOSn5n3ywI
	NV8fJg+oN7h1cGZvM++nRMhQGxnPhpLOQS7R+Bbc3O/+af8fHOrWmlyarXvE=
X-Gm-Gg: AR+sD12mnraB2zYwpQqVuMKLhDmNd1AzHFyxESEuVFTI6EOF4iITDcsglw/qwlNBVhk
	uAtrpga81FcaVjIgMT5zj/8R/uEI2oCnRqAZwzPJj+WkJoBHdOz5FDSs6Ret7gLeY7XreGeR41P
	gQInOgWxGvFFlBWS6tWrcjaK3eDfpsCk5RWbnvDQeb10L0F1h8eXPUq+KWoTAH/huWyGeJCpq2e
	zuH9QLwf5KU5wA5AMiam3n82xI9HcAoGpOWvmnbFSTQj9k5e+AExFRBf6T9PUNZ0MdN3pRV3+61
	GqovczO64ZdY3CLPOhi9uoJcV7nWiS2X0UU8Imohou1N92bxsrP5lp/Xa/R2qy6gMpQx94tMlXq
	IolbdfXJW
X-Received: by 2002:a05:620a:720a:b0:936:695a:185a with SMTP id af79cd13be357-936d2356e91mr2453562985a.44.1786994968409;
        Mon, 17 Aug 2026 12:29:28 -0700 (PDT)
X-Received: by 2002:a05:620a:720a:b0:936:695a:185a with SMTP id af79cd13be357-936d2356e91mr2453557085a.44.1786994967795;
        Mon, 17 Aug 2026 12:29:27 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c57fsm5972617f8f.22.2026.08.17.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:29:26 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 15:29:17 -0400
Subject: [PATCH v2] libceph: remove ceph_put_page_vector()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ceph-put-page-vector-v2-1-477dce5372dc@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAxhg2oC/4WNQQ6CMBREr0K69ptSBYor72FYtOUj3yhtWtpoC
 He34AFcvsybmYUF9ISBXYqFeUwUyE4ZxKFgZlTTHYH6zExwUXPJWzDoRnBxBqdymNDM1sO5klq
 flJLNULNcdR4Heu+zt+7HIepHlretzRgp5OJn/03l5v25SCWUUDVKC8UlmpZfjX3GlyZ1xD6yb
 l3XLzL8p6DNAAAA
X-Change-ID: 20260809-ceph-put-page-vector-458bb3aa87f6
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786994966; l=3080;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=sQa7UCD0szsYuQ5e/aenabYsYKMOIzSf4csEoE48M9s=;
 b=6R7TZmrHc+YmdrSyvO3WLU9j2dvmPV77Hm1eZprfueiqbEnzKZzHaN5TQitXcEp+wrJ4jY2rO
 PenEP2NzQjBCr10xQZ34bIB65MEN06UDqk4lpDrgS9zyU1+O+i2YArC
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0OCBTYWx0ZWRfXzkS/zIrE+f4c
 scmKgXwzn9L9AiekVbedqUvov+rIBxrWOAK0EPCnspYkaDnPNeIAW631OMuDPBTMf0zxN1pdMf8
 LzftfnR+pQ21XUpjpOdmDMrEO3G7M0hhAB9BrVHBWCWX1jmmL5lw
X-Authority-Analysis: v=2.4 cv=MOpQXsZl c=1 sm=1 tr=0 ts=6a836119 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=9oKN_-3_2LoZvJdpknsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ofAX5nXhjZAPesWiEdNPSKTE-yr5gzft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0OCBTYWx0ZWRfX5qAgv79xPC+1
 zFntHOaHJZdf4TGs5gWTuKpQDnKbJLaNEMGtgZHELdfhPF2tiBiSfhLJGhX+o4Go2NK5l5WuTDi
 XctJk876WuGi4QYSbhfwXtP2m9JnV1qq9iZYYH5sxLl7mh9wgOIFGhwHtOMKM0SL97lAT+cj+wd
 W4OK7brRmg2R5kq8i0adGO19jXlHwgwsdscwtUP3tXL6rjbtrmF/J2DE1fYv80dQnqtm+7YY/0g
 SIWFC073IK6tJ7b8u9kYRDqnFfeOHXydgMSJGmCSkX/r/y0GjMT/rHXPkgDu6tSCUyw78PND7au
 9/bxAVoPjRdP7vHT/8BrI8Q6HED9v1tD8C6mRg8lgVB2HK3G4/0ZV+GQ28h/jKIs5beCHHHGDzt
 Th5HSAKUInF/OEpPQCxc1DHk6D5PKxnW5EwgdTf2ARCQUfFk68UikGrUb5AuRxQGEtCR9Z8NYs5
 YfwVnIJdl8FEqjk8GuQ==
X-Proofpoint-GUID: ofAX5nXhjZAPesWiEdNPSKTE-yr5gzft
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 adultscore=0 phishscore=0 lowpriorityscore=10
 impostorscore=10 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170148

ceph_put_page_vector() was paired with ceph_get_direct_page_vector(),
which was removed in commit 97a385e55829 ("libceph: remove
ceph_get_direct_page_vector()"). Its only remaining caller,
finish_netfs_read(), uses it to put a page vector allocated with
iov_iter_get_pages_alloc2(), which is confusing. Open-code the
put_page() loop and kvfree() there instead.

The caller passed dirty = false, so this also removes the dead dirty
branch and with it a call to the deprecated set_page_dirty_lock().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Changes in v2:
- Remove ceph_put_page_vector() entirely instead of only the dead
  dirty path, open-coding the cleanup in finish_netfs_read(), per Ilya
- Rebase onto ceph/for-linus
- Link to v1: https://lore.kernel.org/r/20260809-ceph-put-page-vector-v1-1-57ab2a08ec90@columbia.edu
---
 fs/ceph/addr.c               |  9 ++++++---
 include/linux/ceph/libceph.h |  2 --
 net/ceph/pagevec.c           | 13 -------------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ecf33b66610c..0af7387ce7ec 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -255,9 +255,12 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	}
 
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
-		ceph_put_page_vector(osd_data->pages,
-				     calc_pages_for(osd_data->alignment,
-					osd_data->length), false);
+		int num_pages = calc_pages_for(osd_data->alignment,
+					       osd_data->length);
+
+		for (int i = 0; i < num_pages; i++)
+			put_page(osd_data->pages[i]);
+		kvfree(osd_data->pages);
 	}
 	if (err > 0) {
 		ceph_subvolume_metrics_record_io(fsc->mdsc, ceph_inode(inode),
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 63e0e2aa1ce9..691e1bdece49 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -313,8 +313,6 @@ int ceph_wait_for_latest_osdmap(struct ceph_client *client,
 
 /* pagevec.c */
 extern void ceph_release_page_vector(struct page **pages, int num_pages);
-extern void ceph_put_page_vector(struct page **pages, int num_pages,
-				 bool dirty);
 extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
 extern void ceph_copy_from_page_vector(struct page **pages,
 				    void *data,
diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index 858359873c4d..a6aa5b3b7a1e 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -10,19 +10,6 @@
 
 #include <linux/ceph/libceph.h>
 
-void ceph_put_page_vector(struct page **pages, int num_pages, bool dirty)
-{
-	int i;
-
-	for (i = 0; i < num_pages; i++) {
-		if (dirty)
-			set_page_dirty_lock(pages[i]);
-		put_page(pages[i]);
-	}
-	kvfree(pages);
-}
-EXPORT_SYMBOL(ceph_put_page_vector);
-
 void ceph_release_page_vector(struct page **pages, int num_pages)
 {
 	int i;

---
base-commit: 91880e4a7fac45bc407771bc57bbaf4f37e9b4c3
change-id: 20260809-ceph-put-page-vector-458bb3aa87f6

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

