Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FDF4908B0
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694536; cv=none; b=q8n+BUmnThVaIsF14vGRLN7HUYuveFGmpBqeKNnBSskplvcmzmtF7K4vlnoc5BRw7C8xIJe7NugmBD7vUvbU7ZRjQqLRffihhsfgDxbFexGoPiV3iR3+BPIL09/VfaL8HNOH+ZIGcfFUQhs2oEYnQyGr3j+PC4gKqRZETBxhKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694536; c=relaxed/simple;
	bh=o8yPRAgB+O6vycgAKR5Qjn0SvBVNLIHTB35zWJ9VYOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zwg9NVN6jAq4DmFhg3RqUWp0QEhYndcwmDAb0iZwupMQykog7jpK4FyTEct0QVgXiT6D4l6Oa7JTQpbWc0lNKIoALStUfwBNZoFLbXlwYfel74qtF5x2fYUkfwaaS5lq2Xo0mAJwszXwNa3Ot5fWugryT1iEpR4NOxTx6Jo/Z9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=TrXmDkcI; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=xPYPSNK1; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="TrXmDkcI";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="xPYPSNK1"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PKYQ8M2167018
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CIBu
	m0R8f6BY9lRRhGuW3Okr6prk5O1cGQ58Yp0bXnc=; b=TrXmDkcIPCZhUyxs0vLB
	6Pr6XvdoWeIOf5uf1W0OYFjufLtC/Z0iTzn7OCz5VxtlU/+UmSZsSLCcilHSTzlP
	5GjVErq2VRRGqB7pSEEIocBQb2fv1Ca6RgU709ww3oYzZCokz6Yd3Q8RZZ4jI/l3
	xKJVZnrAJPxMY8Fjz5ypH82EMn0z48yhnQ8SMPhtf8x6gVa38Vh1hoZSXkvgQkOh
	ns4qRKf0BbokyCiebeiTFrlIqvW4gawyhSdkJj+QykLpzggRhMvhyL7qun/orocE
	JeYJAx9w+7YHIr8zTfCTwXDKrm5REKhrHa5/HaqoDwoDfLjRe2urJMOLGNjEXdlX
	Dg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4g9ec7ahwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:47 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso5643691cf.3
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787694527; x=1788299327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CIBum0R8f6BY9lRRhGuW3Okr6prk5O1cGQ58Yp0bXnc=;
        b=xPYPSNK1PtFdxTSmzR55q15a9Dak8X0I3AwhsAHVtbk05S1LvzJVhEPMNenvrw31pt
         s6LlftT3w2K+JmzD90FibcxF8MGtJnxX36h/rcsFiO/bgdkTpFlwGTlXJ/l5uS6gZvZI
         SGweIY/I+yFCC+YNdxnVrWPkkY6DlPwvazA2m+OjqMCrIKe1fORB5tvW0IJJJkbXdjwu
         MIc0RQelAYJwItODFhgamHP25sfCJVJRLLwpAoiyeBUBHpGuy2N7aXLl4/f0Kyhmu+5V
         uTRZHq83xNHFkCE1uHm7QIjdZt70JMCMhlzSGrxA6iPAtll4GHYE8riMViOimoYuHM/8
         k1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694527; x=1788299327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CIBum0R8f6BY9lRRhGuW3Okr6prk5O1cGQ58Yp0bXnc=;
        b=YxmyHH7BySzciOpqSsXKEjLi7P55hs8LxjhIziVFvxQrwwd32rTnlQxF+6s1MmRYtR
         d89YGgou1DRhzsenbLZd/SNBs9PcC9UUMDu749jOVs2k5ZBDeaNCyomjMBc+E7vaQSYH
         nH4QoHiwFlaJUkZVxjWeLAh6xL3jRm/uceXO/M2nGZ9U32gVBL6Q6C/J8bHRUIbDBBmG
         hYdXkF0ZW7G9M55GGPRuWrk2XYJchP/VlrIyN56iW7fH2XzhUlVJiTtwLIHP68TkuAqY
         ffKjlQTtVg8s5CIWcSZmJcpOBxSPPvClmHtiMnhYrplBVUSyd1j1w0Jo+tisK60flg+O
         UxPw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4MNqH9XRnk2SUKPX5VxjsVsSgJKmmJLNYNv3yQxXUH0Lp4ori8Dae8GP1DO9MlbchErwNJMRSpsjd@vger.kernel.org
X-Gm-Message-State: AFuF++k9uye6+d2vxnpHGr7cNAflvAdTr13YXJz0kvmo84sH3oVKd/mQ
	fqN/JXIYGorVKw7BWqb6lL/iwBpv/39UDlavHvUDldNLu+7maWTgiaN8m+oVx1jjy6hq9L2Sx7e
	eaZ99PP9wiZgqp+pPv7sdUIfGEEkSyu7/3RvTl/vxoJ+kww60bnPN/bLzQeVceCZfOB9A9w==
X-Gm-Gg: AR+sD118XIkb+fpfXHLiuOiqMs8hWTDgMWIznpCtKroSTG3ITMWAVwbIe5j0ZqwxYUv
	bjx06t2zaz1+nkm2mVCADWNVrDaWwl6RCeL4wqDj3bOE30KJfnfNH4IgsEIEenE9DMi4sFVGbBU
	arg8n1KlsepA1UKs16nC/avXOvunpN23UANPMu98WCSTIKyjWXY3K062nXrGCZ9jxX6dPzB3VRs
	4phh3HvPYr7sQ2awOIhDOr/rsKFy4k1nb0JiS+NgLnjv6Hv8V6Jr9kdzyCOuPYThl8zvnnaknQL
	EFnNn5b5iBgv6VrMhYkboqXF5O9pvuFnQq6rHyLpOPlij0whTYyVmXdc4LBkR7PnJMJmorIGgKz
	mLvYvNg2wrQ==
X-Received: by 2002:a05:622a:1ccf:b0:527:7027:cc1b with SMTP id d75a77b69052e-52e423d17d5mr24384681cf.32.1787694526789;
        Tue, 25 Aug 2026 14:48:46 -0700 (PDT)
X-Received: by 2002:a05:622a:1ccf:b0:527:7027:cc1b with SMTP id d75a77b69052e-52e423d17d5mr24379441cf.32.1787694521631;
        Tue, 25 Aug 2026 14:48:41 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.157.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9ef8ffsm139207566b.60.2026.08.25.14.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:48:40 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 25 Aug 2026 17:48:12 -0400
Subject: [PATCH 5/6] ceph: convert r_locked_page to r_locked_folio
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ceph-inline-folio-v1-5-d2366fade152@columbia.edu>
References: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
In-Reply-To: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787694507; l=5910;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=o8yPRAgB+O6vycgAKR5Qjn0SvBVNLIHTB35zWJ9VYOE=;
 b=jYrBgSpKI/QpctdxBAdaw2dg9d5vedmDv/ahTQ8bOgL53TCG19VC14YVBMvY/DSXDTLcJpVWn
 RcH0PSiE1NhA9fw0cLS32Gm97qGUYwl8VEMFK8i2oU87cJxWe/6rM+0
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: ucRhCiQhjRF8f3166eMM46rHE-pvUR14
X-Proofpoint-GUID: ucRhCiQhjRF8f3166eMM46rHE-pvUR14
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX4lkCY22LXG6q
 wqYIiF8NTt9iqQ1FcXkZvvQI4qXLiiWf0KL7uu0JMDe1z0C9rVa4NP5tVW8QXy3jhOqT0jBjjMx
 XCp3ZJn/zFt/zRHEbV+mwbnGwdvlcmU8DuMGnkVsgOVc3vmQMCrj5VkPHqc3uVWpqQz6a0DAFDW
 EN5Zb3SE+M5f1H+Y/b5w+A1LE47tjEuSY7nTODkB1c8IoJsKTZSm+GbIbW9DMbTj6NZ2NmYhaUB
 TT26fodEAtue8pEZGVEUM9KVFupV7I8EJd0kclc1aTwaTGH9wQGBrQP3ShpqBFN25YHh2C9XRTY
 dk7R9hE5SakDsH4RhSaRdkFA5eK8d0nf2HjW33Fg1vQBk5VskDbVL8yFotXIl1+RhuY1G+/8pJG
 ktDi0wDqWkBC1JJS0A44ZUmgzkEM/UXCclSSy40NypcG67EidYpeALymgXA7OsSYmSrokc1CaLy
 m7mcA3Jn4ZOCW7RXPUg==
X-Authority-Analysis: v=2.4 cv=UspT8ewB c=1 sm=1 tr=0 ts=6a8e0dc0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=VsYqNs1x6zyujO4rtox2PQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=945u1j8887UpmP1-4VoA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX4I97tSbAUeLn
 kUiSmDoWkY5g2esZSs1QX1RArlrbk8vQoJtRlcDHvg6Jl6L+yaX1SCbCdguvgUuYYu0dscZd8zg
 KsIpO7NvSQCUF5/Tc6P9Od/hof69QKZN3qVgWIakA8ViqtjAa4Mg
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11886
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250185

Pass a folio through the inline data plumbing: __ceph_do_getattr(),
struct ceph_mds_request, and ceph_fill_inode(). No callers pass a page
anymore, so this removes the &folio->page conversions in the fault and
READ_INLINE paths and the page_folio() call in ceph_fill_inode().

Remove externs from function declarations while at it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c       |  2 +-
 fs/ceph/file.c       |  3 +--
 fs/ceph/inode.c      | 15 +++++++--------
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.h      |  6 +++---
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2ff90b891fc9..95e889020db7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2064,7 +2064,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 			ret = VM_FAULT_OOM;
 			goto out_inline;
 		}
-		err = __ceph_do_getattr(inode, &folio->page,
+		err = __ceph_do_getattr(inode, folio,
 					 CEPH_STAT_CAP_INLINE_DATA, true);
 		if (err < 0 || off >= i_size_read(inode)) {
 			folio_unlock(folio);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 592e32d1e2d4..0b6921293f27 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2275,8 +2275,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			mask = CEPH_STAT_CAP_INLINE_DATA;
 		}
 
-		statret = __ceph_do_getattr(inode, folio ? &folio->page : NULL,
-					    mask, !!folio);
+		statret = __ceph_do_getattr(inode, folio, mask, !!folio);
 		if (statret < 0) {
 			if (folio)
 				folio_put(folio);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index b91125567cf0..0876752c90dd 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1010,7 +1010,7 @@ static int decode_encrypted_symlink(struct ceph_mds_client *mdsc,
  * Populate an inode based on info from mds.  May be called on new or
  * existing inodes.
  */
-int ceph_fill_inode(struct inode *inode, struct page *locked_page,
+int ceph_fill_inode(struct inode *inode, struct folio *locked_folio,
 		    struct ceph_mds_reply_info_in *iinfo,
 		    struct ceph_mds_reply_dirfrag *dirinfo,
 		    struct ceph_mds_session *session, int cap_fmode,
@@ -1367,7 +1367,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		int cache_caps = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
 		ci->i_inline_version = iinfo->inline_version;
 		if (ceph_has_inline_data(ci) &&
-		    (locked_page || (info_caps & cache_caps)))
+		    (locked_folio || (info_caps & cache_caps)))
 			fill_inline = true;
 	}
 
@@ -1383,8 +1383,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	ceph_fscache_register_inode_cookie(inode);
 
 	if (fill_inline)
-		ceph_fill_inline_data(inode,
-				      locked_page ? page_folio(locked_page) : NULL,
+		ceph_fill_inline_data(inode, locked_folio,
 				      iinfo->inline_data, iinfo->inline_len);
 
 	if (wake)
@@ -1714,7 +1713,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 
 		in = req->r_target_inode;
 		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
-		err = ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
+		err = ceph_fill_inode(in, req->r_locked_folio, &rinfo->targeti,
 				NULL, session,
 				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
 				 !test_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags) &&
@@ -2993,7 +2992,7 @@ int ceph_try_to_choose_auth_mds(struct inode *inode, int mask)
  * Verify that we have a lease on the given mask.  If not,
  * do a getattr against an mds.
  */
-int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
+int __ceph_do_getattr(struct inode *inode, struct folio *locked_folio,
 		      int mask, bool force)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
@@ -3022,9 +3021,9 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 	ihold(inode);
 	req->r_num_caps = 1;
 	req->r_args.getattr.mask = cpu_to_le32(mask);
-	req->r_locked_page = locked_page;
+	req->r_locked_folio = locked_folio;
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
-	if (locked_page && err == 0) {
+	if (locked_folio && err == 0) {
 		u64 inline_version = req->r_reply_info.targeti.inline_version;
 		if (inline_version == 0) {
 			/* the reply is supposed to contain inline data */
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 3c62e3c3530b..c0c72a41ef46 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -398,7 +398,7 @@ struct ceph_mds_request {
 	int r_err;
 	u32               r_readdir_offset;
 
-	struct page *r_locked_page;
+	struct folio *r_locked_folio;
 	int r_dir_caps;
 	int r_num_caps;
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 30e625e02398..6df62b51a6a4 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1120,7 +1120,7 @@ extern void ceph_fill_file_time(struct inode *inode, int issued,
 				u64 time_warp_seq, struct timespec64 *ctime,
 				struct timespec64 *mtime,
 				struct timespec64 *atime);
-extern int ceph_fill_inode(struct inode *inode, struct page *locked_page,
+int ceph_fill_inode(struct inode *inode, struct folio *locked_folio,
 		    struct ceph_mds_reply_info_in *iinfo,
 		    struct ceph_mds_reply_dirfrag *dirinfo,
 		    struct ceph_mds_session *session, int cap_fmode,
@@ -1161,8 +1161,8 @@ static inline void ceph_queue_flush_snaps(struct inode *inode)
 }
 
 extern int ceph_try_to_choose_auth_mds(struct inode *inode, int mask);
-extern int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
-			     int mask, bool force);
+int __ceph_do_getattr(struct inode *inode, struct folio *locked_folio,
+		      int mask, bool force);
 static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
 {
 	return __ceph_do_getattr(inode, NULL, mask, force);

-- 
2.39.5

