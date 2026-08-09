Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D5384228
	for <ceph-devel@vger.kernel.org>; Sun,  9 Aug 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287859; cv=none; b=AxG7NtOHbIX1UhQmkI1TjAQ09p0U46cckkg98rFFAkCG8UBGndaBTaHr0l3WG9aY4VZq7R4qnn4eYYwAW+LILjZEFM/+LMpzbXhXe0bkzPdQL1MRkAJ6AZ/BdpW1cFsXT/zK5jejXangc7AfSSnhFI4TAzUGSZUy1FguyeM3brM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287859; c=relaxed/simple;
	bh=SQubqO9s+SFQ+/u9mawBkGl4SqexqjyU9fvp4DUIUc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=djRtSn0TRFjxir3kxPBqHPsx73v4Zs+x9YT2B2aUdx9NDhDK0uHETNqMbKNVYVQsp9QLRS/80+5D09vbKI7uad2Np4bBrpdy7qS6S2qqHh7KyRcItLjNdkHnRkn3tnNa4CiLhSxJivxq+KHJr9JwL61x8CdZSA7uuc5ttNt8alo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=XYWhG7aN; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="XYWhG7aN"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679AxE151388009
	for <ceph-devel@vger.kernel.org>; Sun, 9 Aug 2026 11:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=e7MG7FcsFjAqmMigfCDPr1wrq2
	eq1+bdZSypJg/Psa4=; b=XYWhG7aN/SESWN+WZysRoKQQUtJBoHIj+jchDKEW36
	XTrhqYjHXq8yLMdRf9/KUcPtQbd57WD4wmLbwJbK41mPCKld+ZMvm0P45opEFTbP
	tT4cCac9ZK49ohYPTLGdHi6+8rxj9lIztUdloodqELl9CFS0eCOBtmtGpjiZRFR7
	0P+LNRXmjFZcixjXvG0J1flsoPgMyUhIkelJTdGGV5M7SN5QpGoaMHcUXJXVhPVa
	zH7q83FP38ins9aMYqq+UooSBFVjYQSNhzTzSoSlwlzxQXIUlc30Pfx9IKqzSrIx
	Gk7ELv+uAphrihFZjcoHZe8WrOvY1jQmYVbbV5Fe603g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fwwffnfwj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 09 Aug 2026 11:04:09 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5283fa0656dso43730011cf.1
        for <ceph-devel@vger.kernel.org>; Sun, 09 Aug 2026 08:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786287849; x=1786892649;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e7MG7FcsFjAqmMigfCDPr1wrq2eq1+bdZSypJg/Psa4=;
        b=ZicSU9gcMU7sTnJsKCauui4TXw0WyJ4+/8g0CuidCiQBLmfNqz4GBWsm9wFpHHi9TE
         Jc4xAAD5vwQqMGS5EydXh6DzPdESxNWkHFNePonaSqaUupCzOn0tssvMMwT5zYSmp4oA
         oUHGOy248SKpcc5XBcsrfseTVcGB6XhfWtP9XMtYTcxlh9FpJBozM669gM/q6Oa4xZ69
         Lk2sKQm3wKPox/hDOkrdNtrgz1YeaSVHHQL3WcCmqMcZqcGpx85sk5nmu/nwjW9eOjdD
         CLn2S8ObagzHN6jrKBrICfmHRfxXdoIvovxp3FKQHCnvb1WKV7BwiQc0rn2lipGsNDgY
         3Yqw==
X-Gm-Message-State: AOJu0YzwUYtf59w/YkHE4rjd0JFIUlRv7jeVMgxxr1d84P32DoxzkdPS
	VdOW4BdlLiRfvsvlbAdYttm71kNDGpGRKY2ayY8jVEU4uBlYl5dDfRfBhyq5bfAPImMnf6QBGIF
	tcNMs5vZxyMLZ+wf0sOPGOtjcsZW8TMKNtc0jpPL0vN0EFmO+yWznBufV/ZI=
X-Gm-Gg: AR+sD121oug1Ap3iWAJe1ijmDvD75Mu9/HNNTy8mQk5Um5rKOvxUMhiZ0KMrKqfBssb
	PU6xpKvutJIwZZYq1jK+9Jb+Sw/k7X3IO88idMcfNIxvuqYcwY/qmZCznI95Ff044wICY9B/0W5
	QAM9m4QhzvU+VLM02ndd9SGS6+cBA5ELb5M0NjXHCno61gejVjtvYqEjeuhPt2P009lTexhjhVS
	kP33LzRiXt9gdPOOzXbsIgykhU1Yy5eweh0YYnmXH9pnlr39gErmAoOE23THBHyesUPu/PHpTCy
	wTLKiz1ZYor3uIVTJxDNYIvFyD3du6fO3U7r4MPO98jCEe6532fqzQSgkqT9wBkUcRQ4LEAEssO
	uDeSO9xA=
X-Received: by 2002:a05:622a:1341:b0:51c:d1c:10e2 with SMTP id d75a77b69052e-52d237a7091mr127493101cf.12.1786287848974;
        Sun, 09 Aug 2026 08:04:08 -0700 (PDT)
X-Received: by 2002:a05:622a:1341:b0:51c:d1c:10e2 with SMTP id d75a77b69052e-52d237a7091mr127492151cf.12.1786287848537;
        Sun, 09 Aug 2026 08:04:08 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.73.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145966sm22739200f8f.5.2026.08.09.08.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:04:07 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 09 Aug 2026 11:04:01 -0400
Subject: [PATCH] libceph: remove the dead dirty path in
 ceph_put_page_vector()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-ceph-put-page-vector-v1-1-57ab2a08ec90@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAOCWeGoC/yWMQQ6DMAwEv4J8xlIKFFK+gjgkqVPMAaIEEBLK3
 3Hb42h35oJEkSlBX1wQ6eDE6yLwKAtwk1k+hPwWhkpVrdLqhY7ChGHfMBgZD3LbGrF5amtrY3T
 nWxA1RPJ8/rLD+Oe021nO3xbkfAOwTU6zeAAAAA==
X-Change-ID: 20260809-ceph-put-page-vector-458bb3aa87f6
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786287846; l=2359;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=SQubqO9s+SFQ+/u9mawBkGl4SqexqjyU9fvp4DUIUc0=;
 b=mmUDFWJpkw7shOltkrqGihujdrIK1G2QxItb8lvwMc0+pv5sCid9hWVTOLN9NEqA/t8wKEDUZ
 s3eKjyGB1glB2DiEWkiyZVCJ2avLwRyWhsS6R3V/uVCtfvjy46lhE27
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: D8JsIEDyCCboj9yMpV-Qo9Q8-B9mI-LM
X-Proofpoint-GUID: D8JsIEDyCCboj9yMpV-Qo9Q8-B9mI-LM
X-Authority-Analysis: v=2.4 cv=Ec/4hvmC c=1 sm=1 tr=0 ts=6a7896e9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=JbOfF7l4Ow3Rg3+6t581KQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=8TkoBnpJMLDG3-7EqBQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDEzNCBTYWx0ZWRfX0trNjz1kbKAI
 9GmsG1nCTNqXhUWh7BEwNFzLMWzGQVA9zZSU+pwVnbCCvIATQbggKKIcppX+DMvNhvyA0aw7XVG
 Q3KqG2lVGnxO0dj7QVEw27Nc/Rb0pSKCG3YvqvqDzOu1/Yn/buQeeZD8ItZFCRQtOlj0FpY0Dfb
 z11JW/QUeiU5v9c03NRJ+HXxn3qrZo5xvGGXw+skqMpou899i7EQDlf/i63Qf4Fx5X6Pa6wTNqK
 JsqyT1y/ske9oxcJTrmejaelHVvU7tmJytt/Lc9tTyIBwF6jeGhDOParcfo10ZG5/bdOz+5ZcEI
 bZhqhuR/YfVi/Y/clLD9jgYzo3/nM8h28nRIPxCISblzh3Fj5IXDL56UZ5sBujw3u5vQ4gsVlTl
 jRBx2+Pq1VVVvm3TMSb44w6tsDOPcSfRTrrsCPpgHR6ZDQMDLjCZdqSxmD1rYeOVNfvb2n+ptrN
 oR1whrI/CpQZF6LvLuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDEzNCBTYWx0ZWRfX2YzozVrPnBhW
 odkpjBDTQNsQuVoNHuEFqBfb14L+LkusHZ9ENPL7t7ux7q50uEf+pC/0LPXrUgPMVbCSkxleBze
 4CTvW+GAm6k79JVlHAiYq+R6mZeIQNJWD/6Y6+xriYQCYz8/LgRe
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11869
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=10
 lowpriorityscore=10 malwarescore=0 phishscore=0 bulkscore=10
 priorityscore=1501 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608090134

The only caller of ceph_put_page_vector() passes dirty = false, so the
branch is dead code. Remove it along with the parameter. This removes a
call to the deprecated set_page_dirty_lock().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c               | 2 +-
 include/linux/ceph/libceph.h | 3 +--
 net/ceph/pagevec.c           | 7 ++-----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e2da3ab9f808..83752f3688fa 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -257,7 +257,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
 		ceph_put_page_vector(osd_data->pages,
 				     calc_pages_for(osd_data->alignment,
-					osd_data->length), false);
+					osd_data->length));
 	}
 	if (err > 0) {
 		ceph_subvolume_metrics_record_io(fsc->mdsc, ceph_inode(inode),
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 63e0e2aa1ce9..3098306e6173 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -313,8 +313,7 @@ int ceph_wait_for_latest_osdmap(struct ceph_client *client,
 
 /* pagevec.c */
 extern void ceph_release_page_vector(struct page **pages, int num_pages);
-extern void ceph_put_page_vector(struct page **pages, int num_pages,
-				 bool dirty);
+void ceph_put_page_vector(struct page **pages, int num_pages);
 extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
 extern void ceph_copy_from_page_vector(struct page **pages,
 				    void *data,
diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index 858359873c4d..828b003aa2fc 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -10,15 +10,12 @@
 
 #include <linux/ceph/libceph.h>
 
-void ceph_put_page_vector(struct page **pages, int num_pages, bool dirty)
+void ceph_put_page_vector(struct page **pages, int num_pages)
 {
 	int i;
 
-	for (i = 0; i < num_pages; i++) {
-		if (dirty)
-			set_page_dirty_lock(pages[i]);
+	for (i = 0; i < num_pages; i++)
 		put_page(pages[i]);
-	}
 	kvfree(pages);
 }
 EXPORT_SYMBOL(ceph_put_page_vector);

---
base-commit: 30c0913a2b44a66dc17283a88489b3f3e12f4327
change-id: 20260809-ceph-put-page-vector-458bb3aa87f6

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

