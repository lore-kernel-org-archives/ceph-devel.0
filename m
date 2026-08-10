Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E486F3FE66F
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371706; cv=none; b=Js6YUHxeBFmWcZkYnAvFlyjOtXNPwYFrIOrcQLZgr0FaVmTQgavfIDcsPt4xP3EwO1WK58S9tbLKLenl62vhvl13us/Yj+trVHeVsSUpm0c6Fi33T75z+EQMubHVaES01kahFt9b1M/hdeIJ9nwquKz9OravvZfq28gU1ulLmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371706; c=relaxed/simple;
	bh=ar+8uUIKlAkAAFvZ1bMinInPdLeZqUCbyUCUmYHyjco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IG2E7NjnoCLUM+bNA4kBml07KQFpzeyF7PFEEN6KIKmyhrhVT/rVFUCcb+tPlKfHqqFrENx5Gghls11s0NIXyyJLNtIlxJaRwFNilq6LIf2/A2Yvg6/k9OI2qPmQRt8N9tKU6HFUa+hKbISbfms53GPBNlD3sRtIkvLKxJxaTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=EkS2ZwV6; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="EkS2ZwV6"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaK3i2990578
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=IS2K
	dOnhS+pv529qUIIXEsI3D6umDLAIzYcLLhsfZ9U=; b=EkS2ZwV6b0f6O3aHEd2i
	RANZAvOHFeRb++OZt8dEvJ9SYK6C6bR+Z3Fge/Llme7CX+RLXehAh2eHaxcIDAWP
	qPoweieRpg7zjREbedTtlOdIRp5LDL+B0NE3WnO5pe1b+vmynjIHoSwZXqPvHYof
	k0Xg+94f1zCZHd2NHGouhJGEL3poCkMLZDsCvV6amfAvAly1QOVo65vxtx8KN8Gi
	xfVMTaR8tF1idnY/zoWMWja+gY9um/BYVaBv3bB/Fav/WxU7gvQQ069ZXpCLvAWt
	qxaYENigWI2V5jr+KF3sYtmWbrCw5Vs34qiCQtGiQUOHVpAlBoTTS09RhvLOoka1
	wQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fxykwujhs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:31 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5283df62d68so23088511cf.0
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371691; x=1786976491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IS2KdOnhS+pv529qUIIXEsI3D6umDLAIzYcLLhsfZ9U=;
        b=JyYEu/5fjLun5YjEFOL8YnCdPaKmZMTiA2kiAtaTbH/Wi7r6hI2Wbdl9n9kzeaTQze
         V6XJhs31Wdx8cDTn0Qigyq0ZU6+v7UPq9M6YAz8ge5feRlXfwAIRm70WAbG0CAfzfIa0
         wfE8XWwt2tzc6p47OYPivrFWAjBxqzuVwYKu7+vTiwqFKeeOQ1bfstczAke96GKBy75K
         fKBf9oGYRCLfAec6BP7XoeWBdf0Eq5i295ILhGClAB70WkzDb6sawJAxL6wEL4Gbc9i6
         Y5zYaXLQlSVqwqqT+1uRdAWPVQyQlHxtPIdzPchDjzrdA0LUzRIznzv+UDYJ7DKmCRk2
         1NkQ==
X-Gm-Message-State: AOJu0YxJrBjpstHF7DcER90OWhr2yCO9taWH1MAeAaYMW16pfaPKQ5OM
	/Z1aWNwIv4D2sh3TEJzqTFwSIxcmucc0voU5OigR2ndpOaItv3zOcWPU81+5QSVR2YjHbrzFDA/
	gamSihh+IgE05YhFq0G0ZlTV3xkZOtQ8h+r5fAxMxdgi8JxJylUEH/lBAY9w=
X-Gm-Gg: AR+sD13kt3QCSmadA6d7iSL4G8hvYbfiNLh7F/UrtQNsoXJvl6fF6VziwLEy//KFGhl
	wvY0p2aG6m0IZDqotC7M2pmcoEu9jga61pLi6ydO8kMbHlCiTX3i+q6fa4XDD8aTwPDBcTd9099
	frBJUPsw0h8B65NH3muKydXpTNPih7XrwSR16D2wqVa/vDBvOhudg9t9a0EPKDIKy2Gc6j5CEWS
	q4MrmMUvrVVy2lEhTf2h90rwEY/SoosAO9YbpEzm5h65R7WMr9zznLyDhVTUXUIpmgPXHu+Gp2b
	4BD1CPD+V+CoXjDRp/agoJC+BdTOoSXapOnUWLNA/tPF1W7Nl5lDkUbZc5LYkUjfLrDQMcY2GGg
	+wATBYNSn
X-Received: by 2002:ac8:5803:0:b0:516:dbf6:f8e7 with SMTP id d75a77b69052e-52d4bb7c738mr23828111cf.17.1786371691359;
        Mon, 10 Aug 2026 07:21:31 -0700 (PDT)
X-Received: by 2002:ac8:5803:0:b0:516:dbf6:f8e7 with SMTP id d75a77b69052e-52d4bb7c738mr23827171cf.17.1786371690810;
        Mon, 10 Aug 2026 07:21:30 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:29 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:21 -0400
Subject: [PATCH v3 10/12] ceph: convert page cleanup loop in
 writepages_finish() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-10-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=2393;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ar+8uUIKlAkAAFvZ1bMinInPdLeZqUCbyUCUmYHyjco=;
 b=ghqy9OZjRc9FePPnWqoKALFu+1yEbRsD9SmCqfkGncI6FOr+Ae3idCTnHhOGXi1vizO9BKSFX
 eZ1AFKyjHVlDx2T3q4hy/XrfPLIc+/L7SleRQUkxj9VLrFPVOhA3JyX
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: kd9Er0j0u2NrC6SQzfICvgUZs2tzYedh
X-Authority-Analysis: v=2.4 cv=S43pBosP c=1 sm=1 tr=0 ts=6a79de6c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=PHYVD-oPFUEr7kX-Mb8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX4lrnScK28qBS
 DtcLatcuirvNGEJ4PVk6lnUkFamXnITsOmLgP9O9xCDSRofWubJzamV2tVCT22Ujyw8ZR1F4O3c
 717lQahasidiTK1mkXwSrKGUZGmZcwMKTyj0JGY/aYtI01vDqtTjIw5D60fyUO+Uq3sZot3DElO
 umqk7RuB8DGgFfi9alKUjkft4uxVq0ylNEvlZpjhj9SzkfqVBpRCFkJaXWbZJbU6FS4uiXHxvcy
 36/2ml9fBpBxMHY4wkIZoXUWk93YbDOLy4aiIcHK5OM3Pw0wSQ3yGGie6pQnfkG5fU571s3hWB0
 rqpdKiK2TEown9htZI90ufjCfLsgC2SI5Pk1aFqhF+SuaCiSQet1PLdQr/YCbWofgx5wGkP0Czk
 XtEq0AloHpQceQTRy20sDZDW6Wdbdo2zjhb5VKY867wSII0+xroZZavOBOnOQh8/d+b5Xy2PS0y
 tBiFe8a6cl/TBJvN1yw==
X-Proofpoint-GUID: kd9Er0j0u2NrC6SQzfICvgUZs2tzYedh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX/fIT6V6VSFyk
 VRwKLDHT0rcki7dcuPWfiQOSk7oPVocju5KBb98rH4QSZMHWceQT4lMHihgq8c+2z6HkBm7BgU+
 7vIYWlU1MDub+6DN8GNgGvpyMHMTFCsS9KKB6+JYDfTEXgehpMvm
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=10 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=10
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

Convert the page cleanup loop in writepages_finish() to work on folios,
resolving the folio directly after fscrypt_finalize_bounce_page() has
replaced any bounce page with its pagecache page.

This removes a use of detach_page_private() and five calls to
compound_head() per page, while adding one back via page_folio().

While at it, remove the BUG_ON() in the num_pages loop, as it cannot be
triggered.

No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ddb12fccdcff..708343a8bf35 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -908,7 +908,6 @@ static void writepages_finish(struct ceph_osd_request *req)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_osd_data *osd_data;
-	struct page *page;
 	int num_pages, total_pages = 0;
 	int i, j;
 	int rc = req->r_result;
@@ -955,31 +954,32 @@ static void writepages_finish(struct ceph_osd_request *req)
 					   (u64)osd_data->length);
 		total_pages += num_pages;
 		for (j = 0; j < num_pages; j++) {
+			struct folio *folio;
+
 			fscrypt_finalize_bounce_page(&osd_data->pages[j]);
-			page = osd_data->pages[j];
-			BUG_ON(!page);
-			WARN_ON(!PageUptodate(page));
+			folio = page_folio(osd_data->pages[j]);
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

