Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AA4AA00B
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365512; cv=none; b=G6fwW8XZhEEi0rpYY2uv5S/0l1+7qFNFe2rJLvkVHDHTKZpJHKIeoDCgoSLgoT0E/d9bNt9lbzfQ7LFQWc+uUlJzpcBn8B2xG3b0hLIoO5mZ8gtgOg3ZkvNzFCSwEXPC4Yafss/q7fpCZWDZPhdsJ2txx3l2chhVUD15omt6RK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365512; c=relaxed/simple;
	bh=kZHRgcKVIkMiGl7gg97Bj8D31InPWvfamVltkToMnuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+xBD2Li7/EtCJOgOvyd6Jb6FidItYZTVj0Tb7LFD+eYgItucrJYOnLsI82lOPFfn1xSa8Ty9SHEjt6HWiDeezIi+hyRO29X05jrtOhEpbe6BoZh8hXem1vtQ8SeFD7R1zjBQVF5Q2FVOEFsF72EaKiZ+gbx0qHo0aQ8dp+NFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=NliUBfSP; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=xmNBtrTE; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="NliUBfSP";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="xmNBtrTE"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FPfAp450142
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=0c55
	qEw56DA3X6mui1f7k1LUvSGQjzCm1wrmsoYpdRU=; b=NliUBfSPbDLKPdXIOaQ6
	tX9MV7c6M2XqErWJHDi5IJq5+iRTuvfIOVjNhCPoHw6bZhW/bmbKODbRjauTUxRo
	jR6Q6+s0tG4JMuAJG8U83VTJ6rk+AnZvnlxuLfnekomhF8Mw4szh0p5ybOE7LeYU
	PluAbIoeSo3O3nkhvbZlX837jS+rF11yIWTySroE4DKVG3lMwCYmZBbLNt8HFn0m
	6o7ZSOFSPGiostVY18+xguXfj2BhhodiJT3IP/7dlec1dAetBz8xolnJQfUcRRAS
	3M4SKvD9pZWAerL2IJzN1oWDPhnOIsU6+2Hd6x4mydRBoAmIr4w76zbOOKp2Ihce
	AQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gec25kxat-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:11:46 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53033887f50so29509011cf.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788365506; x=1788970306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0c55qEw56DA3X6mui1f7k1LUvSGQjzCm1wrmsoYpdRU=;
        b=xmNBtrTEWpIx36hkLfFBxlyrzuqN5GvWv/SbOZDfXXuu0p40DCwswd274LgA/6pIaQ
         5lsccPy/uxtdewxd3PYFZu9zlhUu2dYYBKB5XW6zFskTDY8PTJ1RM6rOFiLYz8RYIzXR
         stKTaf/RuKznrATxjQGn82YrZEc1oPQLwIqaa+Hua459pj9s+ygkzWgxQlzX3cJVrKL1
         PHEY6Df+yPexSowWKmfOL5iK9ujX+3TxlkD8V8cYvAeu6vvOdmUlI94fl5QYIs+OiZrI
         Lp7V9oAqGiOPuhkOKpbeXqrsAsj/0u5o7DuR2mBzuoX7Kwai4vR5oe+Bt21epyZ/PPIA
         0oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365506; x=1788970306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0c55qEw56DA3X6mui1f7k1LUvSGQjzCm1wrmsoYpdRU=;
        b=YOc+iaPkojObRSpvDsaFQuSntGjvfvmA5w6fta2eQJf3d7rd7yf4alIxm02TTb7COo
         IxrgKy3DUcHdkIi6Bi0vYhXGTCnDEa/EPETm762j3WUw4+7Kqua8zCj8PSvLwiMAxeMV
         X7T9rue7Kkq4xYXqN7cWGw8G0FSgWYlBR8/3RKLLpQyQrh1rMxCO6hawca7caNWFsESI
         QLUeQ8qQGYvDPhmVcKiylK7yMmCxqXXMSobBvz42ALTOYR+Kc/uOvVjX+MlIY0Dn5mBo
         j4YLN8QuktHIUddK7JWZcoudCZgVFBqCiuFrgH6drO8wSm5Y1ds3WHRYYzt1zIxz4o6I
         sXjA==
X-Gm-Message-State: AFuF++ltHpUqiUW5zI+6i6GMBTnCeqV4CsG7zPWShAWmxJDCwODQfH9I
	wYMZu9caJc4T36cnmEHZ7y10jm2QbYHHcJqj5OBw0gfWHG8jk0pszfjsLh+zdUESKbZS1HjWj7V
	l7k1hHK8gSr1pnvBsK4W9v+Mi2J8Fwb6jBJhDimUopLZIA+Oa1AvrEkJHefg=
X-Gm-Gg: AR+sD10Y+Q2yxkEbkbSq9o54xdgW7IIfgqgsVcVjLEBQKxzx3OsRuXXB6ql2eeVSR/S
	AB6052UQL2J8H0YdutrF8lQ6Q2uDrzIS+KfzR0D36t4zLPakctrkngxaHrPHUyWvDthqvWFwDDQ
	GCScnG9LO+vQFnIPIXZbDJsxJr5qWZZV+hujsyoE/lYtmKuLKBwEAXXCGW1AeTWSX/nDRxWusaN
	9RaWvKmYjELv82t6bXYZscfknNKxHa4Ru5spk4JvWB0Adk/QFxmHxTgNeHjaDQxg3Ub9QRpKLml
	Wvu3MfkHImiWFBg7uHm7bVCtjJ/LRDUApz9ECMGnV8SK/mcJKCEGfHLEjMSp546YbO+ypUzoKkl
	2VaawHFLVoMKZHav/W4ILIGZc8dFZbkb828t/lO56zJhfvrWjPLOV2w==
X-Received: by 2002:a05:622a:2c6:b0:52e:2d4f:2219 with SMTP id d75a77b69052e-53036bf5bdcmr61748381cf.9.1788365506186;
        Wed, 02 Sep 2026 09:11:46 -0700 (PDT)
X-Received: by 2002:a05:622a:2c6:b0:52e:2d4f:2219 with SMTP id d75a77b69052e-53036bf5bdcmr61747571cf.9.1788365505547;
        Wed, 02 Sep 2026 09:11:45 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec7608sm21172636d6.26.2026.09.02.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:45 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:11:32 -0400
Subject: [PATCH v5 08/10] ceph: convert page cleanup loop in
 writepages_finish() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-remove-wait-on-page-writeback-v5-8-0b512e77e75b@columbia.edu>
References: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
In-Reply-To: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788365497; l=2655;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=kZHRgcKVIkMiGl7gg97Bj8D31InPWvfamVltkToMnuw=;
 b=p49kerf8+Rs4LgGbNOFMKqTx1K6T4uIz36u0S5w/3/+LDW6e7lp4qxnrc8gLOeAEXW0FN3LH5
 3vJ40cTGAoKC5IJdZRcHp+nAbdYIXiT9rw38ytzfBEGd0XOtMmNINfl
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX8Ow4bKDy6bJ9
 i6bjoNHRzjcnQykspDZUiBUSXoH/QDiV+gDkZ2pGWPZrotEvlttBJ+NN3ZTfFpMm2ucWQjJFv9a
 3dnPf5QzyQd1YjCY3J3fMpSwrPHa72XF2hUAy2ko29zDa+aF3+Ko
X-Proofpoint-GUID: VAxGnHbwoQV40kFbmsU-VrjKhECEmG9S
X-Proofpoint-ORIG-GUID: VAxGnHbwoQV40kFbmsU-VrjKhECEmG9S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX+GrEZF0Ng2JV
 BTdCAB0eipFPw7onp47WBHc9PFkhrPIgx8/SKSecI38PZ9urWyKB+aHQaHFpCaYems0I7w3Fi59
 RObsUnSpi9ANWLHFB4K3fWgKOT1EpVYaGTnhCRvEjaj1qSwu4fa9k3sstIYDg0zB11pMmQw3E80
 uQRzgPIawEM1A6IcZ6xhsqKiVFa2Wn04BQEpBks8SRRNR1xMoyLriaFkvj5XBa8wTWb0UYeLV/9
 m/o46rouTfWSoezo/CRKzdnoF+abekXyW6I2ThRkQiaY/B+kTS0tTxly1NfsT7RStiKJR9EUf1n
 UwQ5TP3wQbW4fv3BCTqHFhK+2pGhFV+5wOOU11CZCA0aoKy6MfE/H9scfbFIYbwDv8KDg9UBXMF
 flX9HcUZ7xgc6sTGRUuAeAK/A8Ba0aS5HEJoTSqVrI01eDRGsoZCV0OdtV9JJn6Iksy7eMIpHI+
 0oGZTISvZMQI/iyYSbQ==
X-Authority-Analysis: v=2.4 cv=BpWtB4X5 c=1 sm=1 tr=0 ts=6a984ac2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=PHYVD-oPFUEr7kX-Mb8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=10
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020143

Convert the page cleanup loop in writepages_finish() to work on folios.
Resolve the folio up front and unwrap any fscrypt bounce folio to its
page cache folio, storing the page cache page back into the array.

This removes a use of detach_page_private() and five calls to
compound_head() per page, while adding one back via page_folio().

While at it, remove the BUG_ON() in the num_pages loop, as it cannot be
triggered.

No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8e761144e8fb..f9741812e8a9 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -913,7 +913,6 @@ static void writepages_finish(struct ceph_osd_request *req)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_osd_data *osd_data;
-	struct page *page;
 	int num_pages, total_pages = 0;
 	int i, j;
 	int rc = req->r_result;
@@ -960,35 +959,35 @@ static void writepages_finish(struct ceph_osd_request *req)
 					   (u64)osd_data->length);
 		total_pages += num_pages;
 		for (j = 0; j < num_pages; j++) {
-			page = osd_data->pages[j];
-			if (fscrypt_is_bounce_page(page)) {
-				page = fscrypt_pagecache_page(page);
+			struct folio *folio = page_folio(osd_data->pages[j]);
+
+			if (fscrypt_is_bounce_folio(folio)) {
+				folio = fscrypt_pagecache_folio(folio);
 				fscrypt_free_bounce_page(osd_data->pages[j]);
-				osd_data->pages[j] = page;
+				osd_data->pages[j] = &folio->page;
 			}
-			BUG_ON(!page);
-			WARN_ON(!PageUptodate(page));
+			WARN_ON(!folio_test_uptodate(folio));
 
 			if (atomic_long_dec_return(&fsc->writeback_count) <
 			     CONGESTION_OFF_THRESH(
 					fsc->mount_options->congestion_kb))
 				fsc->write_congested = false;
 
-			ceph_put_snap_context(detach_page_private(page));
-			end_page_writeback(page);
+			ceph_put_snap_context(folio_detach_private(folio));
+			folio_end_writeback(folio);
 
 			if (atomic64_dec_return(&mdsc->dirty_folios) <= 0) {
 				wake_up_all(&mdsc->flush_end_wq);
 				WARN_ON(atomic64_read(&mdsc->dirty_folios) < 0);
 			}
 
-			doutc(cl, "unlocking %p\n", page);
+			doutc(cl, "unlocking %p\n", folio);
 
 			if (remove_page)
 				generic_error_remove_folio(inode->i_mapping,
-							  page_folio(page));
+							  folio);
 
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 		doutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n",
 		      ceph_vinop(inode), osd_data->length,

-- 
2.39.5

