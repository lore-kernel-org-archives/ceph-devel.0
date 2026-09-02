Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D64ACC94
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366945; cv=none; b=Mi7rLdcIBeWfntYaT14SKqANe13uCcO1dm0sXjrYzCzPxapWtQSZwWactS2KUvnF1RAbEp/gv/TRcRFjlfXNAOwJHG9ZWrVS9ynTmaAqsIXDIDlksZ0QiSysmK+JCHoE6ak6wOaKWEJ0u29Fenq376S1E5EpyNMzKUy+FTbw4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366945; c=relaxed/simple;
	bh=WEHlyr4Efxhk5teTrx1ZhLj53CZbT4uxkhVjxj4C5YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/LgApA4H0WXa9NrR5e7E1qmzNpPKsMjYzDyo0sm9JSRPjKCIMa6VPiuku1s0d/dyQk1D2mqPQErmbbRT5XYsILjnm7ilbluBHZ04t7K/Sgbl10Sn+WUj0B3VN3pq+EItVhxz6RZ2W5RrP1mIhQPAfnICSJrtPWDYr0OkY6Ie48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=nvGJgtg1; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=YBil9B73; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="nvGJgtg1";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="YBil9B73"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682GYuB0606347
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=UFiN
	X9OJ9AlNvX71DGEWb4R21Djm99DB5fOLNXEMpJo=; b=nvGJgtg185Lja6OGb+3d
	QsAPKWRCWlum3i9LwVvviIXOCgWYq08/nk8EsF+5Frd3nYwJ7h3PpCO6n9JNXpxt
	8M1J6lpfBa4kGa+SwmHDzIffg2YmhAQb+r5hL2bXyrZRuLtwYM0UvtRO7RD4QUpY
	OFC65akkVQAcMX11BL8WPrVycGxaPHOAD+1CfzsSn3KnL81QpaCGgQ9iBwYNlPWj
	Ube8wrwJnRkOwyOxvc7+hgfT7fGtmBW/Py6osniuWJ5FLK1lJeJKDBwkSJHR7ue0
	NXqgr/UB716iPhjkIOtWBwHu/1f5IqleMS+YZxBL6V7L53sNo/8ovNes3KNktFWs
	+w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gec25m586-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:35:40 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90d98d229d2so23276836d6.3
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788366940; x=1788971740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UFiNX9OJ9AlNvX71DGEWb4R21Djm99DB5fOLNXEMpJo=;
        b=YBil9B73x7PcmLt2d50hdYFtzD7pCJpuuegchWhFZ0qzGf9bbHUVY+57KSi37CkUfN
         b552JwhSqGAT2/F/QP+vk38Go/Ypoi+W57NfprMaTr4MkcweTug6M1vJ84i6gfMMydT/
         sar0Huv9B2SF9ssUYtd5Txuodf0HLaStHO4KJOehwQLilX1ebwHvHHmrF8GFTo7NSTtO
         vy2X4KI1QiR2jUa/lm4srazZFmVq/ohdGvHvUskF+/ogkI6fnt3Xyz9UfiM74fliMvit
         wMmwjKZ3gf7hCtJAVH6wVIp1cf2P05hrZG6kiY0b4oAAqyFOrp7dhm5qbxJgwEWHjenP
         WcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366940; x=1788971740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UFiNX9OJ9AlNvX71DGEWb4R21Djm99DB5fOLNXEMpJo=;
        b=FlId+NaZjNHqyradx89KjAk+JMTzDSxSGpzK7iskBta/arvPVr8kA/mDhgwL8RylPZ
         JtwHNrkEhqXvsf3/FFShGRgUpGbv9jjgwBxyy6s4TKXXaN8X19hzTBMpzjL4dt9opxHy
         qwcX4C/pqPQFjWhohN42xpxXfKoPIAmc470rNMForkHNq3FORv7X6QT5G3EwZclzIGmb
         MwmXfGQPlOCgCuK+yvCVetOB8W+jl2zGvA5jKyeKZ9IWHndr/vLhfUKlWde9LQxI3xPh
         2D8CNCN+i4ZqtAlIl8UY2yzNETlrhMHupaalBje1xy61oeIbNJhOI6gx9Tx7rwvALgEX
         lVtg==
X-Forwarded-Encrypted: i=1; AKwUvBzN5h5w2SRd6spJJcs184P/Pf9eBBPvpU7j+Z1U5Uh69qiWDtGt+oOdL0dhLcFh48fa1UTM31kG38HC@vger.kernel.org
X-Gm-Message-State: AFuF++nVJCiDrdvAenivBXA2PLc8MfAfT4uV3mobWxWUHwq6UIvI7YW7
	d5/CCXAiHSiryNFMr2LWxVFr3oEhRWuzqeZrjYo4UMowlV1MVSTVIWn2//h8pjlqsPPLyp1PU6A
	ENCbZ6bh3ry9Hgoi7yHe7Te/wb32EoQiAPPDh3XdPS+0o38qdGp0adB3bFWU=
X-Gm-Gg: AYBFou00IVA00mXS/SXkrQQiMtdTJq0r/ZIcpM4stwM2veXiYoSazX19QZwLFvWDhtB
	FPZhyNNytXj8j3/RwGSddjWhBobZe+ZZCYfAyrINyKE9Atwea4DfMbGr5P2bRgI1dVEQlxwewbX
	1XeWNh6B6qNN8GlqTPWWJLbemRVQCgfe11ANOYIJ2Ig3AbwZKIFx9tpTHNGFu86vHm5fePIMw0D
	Ogg47FkLL+8jA4J1Af5gtjKEskg9cuWqdFA2X5DhjUhvEPFM8SvA/YidKGq411iodKEWkfYSCGY
	KA3ewtMT0vB+yLaNjSewHGC07ajrbfzqkOeZDHtAIBHwPwum1fTF+1ZDOmVLUsx9WaEj8hyjy1m
	YQZ74rLPp79wmvZR8h2N5Yz9DInjOcQu2vgRO6ugls2d6HQsWv3hxWg==
X-Received: by 2002:ad4:5d69:0:b0:90d:3322:4e1a with SMTP id 6a1803df08f44-90ebafc70a3mr80095216d6.4.1788366935384;
        Wed, 02 Sep 2026 09:35:35 -0700 (PDT)
X-Received: by 2002:ad4:5d69:0:b0:90d:3322:4e1a with SMTP id 6a1803df08f44-90ebafc70a3mr80094466d6.4.1788366934737;
        Wed, 02 Sep 2026 09:35:34 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eef5067sm21805726d6.34.2026.09.02.09.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:35:34 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:35:11 -0400
Subject: [PATCH v2 5/5] ceph: convert r_locked_page to r_locked_folio
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ceph-inline-folio-v2-5-6c9098112352@columbia.edu>
References: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
In-Reply-To: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubli@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788366929; l=5916;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=WEHlyr4Efxhk5teTrx1ZhLj53CZbT4uxkhVjxj4C5YA=;
 b=XauyQTbxlRlgKNE1mh+cat/5ZOb1R+XGfML7xNzgZnPcv1Z7ktxRH7oWHbX5e0FkZX/v+vmOZ
 Mu1Q1HJRdpdD8yZyuZtMyvNUZvtL5c/Ty6mFO0TUQtLG8YCQUJ56fHG
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX4qFFM8HYH2Mz
 kxq1sYs6PYSSM+aVi+9DFvkQi8SmH0Q/AO7nK1rgLiLVQ7c2wnO0JOGdWDptKUBpRSqiBFd1UBm
 PMVRaa+8rOGnO4mUP4d3x0CMhWMfQsHvpHh/kYydIhLMw7anr7bN
X-Proofpoint-GUID: GRIGaDGxYOYRzNDV5LJ9xn4t125JF63O
X-Proofpoint-ORIG-GUID: GRIGaDGxYOYRzNDV5LJ9xn4t125JF63O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX+CDAFfv+yh9/
 ABYd/yBMnmFABclX28lW09eqiGsWUOCcRRoBd55hdc+RVKtbcEgD2htOd8ECU0+2iJCiGFtLSEG
 XNKpD7hZJrj3rggdHV1+T/3YhiJV6o+a5EaZf/KA2ElYktosSrC4DYtj2St7vLQGhTu5IE8Tx8P
 HnSDMP35NAd7wI1DdXNpomjBvnwOKArOkGpACHbJWxog5peIwZ/gOG01rvi7vnL6fs5v0rjQi1l
 qKoYZWA2FVPLvdtRfsk9v+WguLxqmwT5IdrcR9LR2pIuTOq5SAsI3jS7jmZyjQYuZPRu9AsD3mm
 tgpZuWGtmNc9vWEg8X2lyMsMgTzSRwO631wdoRdjM2E5WLfT5B/2Q3GM/K9v3NnBDje4b6t7Efh
 txPW9j5HzezDmyD9Y2ODlMG3VDVFjF2ILswiMIInpFGTL66e1/gjxnUa1rCJcra3/TnrBgaOBql
 +tR0b13jRCWETcM7GcA==
X-Authority-Analysis: v=2.4 cv=BpWtB4X5 c=1 sm=1 tr=0 ts=6a98505c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=945u1j8887UpmP1-4VoA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=10
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020146

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
index 71d9f7bdb0c6..9ea44ae8dd6a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2057,7 +2057,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 			ret = VM_FAULT_OOM;
 			goto out_inline;
 		}
-		err = __ceph_do_getattr(inode, &folio->page,
+		err = __ceph_do_getattr(inode, folio,
 					 CEPH_STAT_CAP_INLINE_DATA, true);
 		if (err < 0 || off >= i_size_read(inode)) {
 			folio_unlock(folio);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f0e77a1ab4d1..7ec5d3192974 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2258,8 +2258,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			mask = CEPH_STAT_CAP_INLINE_DATA;
 		}
 
-		statret = __ceph_do_getattr(inode, folio ? &folio->page : NULL,
-					    mask, !!folio);
+		statret = __ceph_do_getattr(inode, folio, mask, !!folio);
 		if (statret < 0) {
 			if (folio)
 				folio_put(folio);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 21d72b7667bc..149a82f0b3c8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1081,7 +1081,7 @@ static int decode_encrypted_symlink(struct ceph_mds_client *mdsc,
  * Populate an inode based on info from mds.  May be called on new or
  * existing inodes.
  */
-int ceph_fill_inode(struct inode *inode, struct page *locked_page,
+int ceph_fill_inode(struct inode *inode, struct folio *locked_folio,
 		    struct ceph_mds_reply_info_in *iinfo,
 		    struct ceph_mds_reply_dirfrag *dirinfo,
 		    struct ceph_mds_session *session, int cap_fmode,
@@ -1438,7 +1438,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		int cache_caps = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
 		ceph_set_inline_version(ci, iinfo->inline_version);
 		if (ceph_has_inline_data(ci) &&
-		    (locked_page || (info_caps & cache_caps)))
+		    (locked_folio || (info_caps & cache_caps)))
 			fill_inline = true;
 	}
 
@@ -1454,8 +1454,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	ceph_fscache_register_inode_cookie(inode);
 
 	if (fill_inline)
-		ceph_fill_inline_data(inode,
-				      locked_page ? page_folio(locked_page) : NULL,
+		ceph_fill_inline_data(inode, locked_folio,
 				      iinfo->inline_data, iinfo->inline_len);
 
 	if (wake)
@@ -1785,7 +1784,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 
 		in = req->r_target_inode;
 		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
-		err = ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
+		err = ceph_fill_inode(in, req->r_locked_folio, &rinfo->targeti,
 				NULL, session,
 				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
 				 !test_bit(CEPH_MDS_R_ASYNC, &req->r_req_flags) &&
@@ -3064,7 +3063,7 @@ int ceph_try_to_choose_auth_mds(struct inode *inode, int mask)
  * Verify that we have a lease on the given mask.  If not,
  * do a getattr against an mds.
  */
-int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
+int __ceph_do_getattr(struct inode *inode, struct folio *locked_folio,
 		      int mask, bool force)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
@@ -3093,9 +3092,9 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
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
index e7a262c9c2ab..d4d620fb8417 100644
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
index ed750ea73d85..d3dad07470ba 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1172,7 +1172,7 @@ extern void ceph_fill_file_time(struct inode *inode, int issued,
 				u32 time_warp_seq, struct timespec64 *ctime,
 				struct timespec64 *mtime,
 				struct timespec64 *atime);
-extern int ceph_fill_inode(struct inode *inode, struct page *locked_page,
+int ceph_fill_inode(struct inode *inode, struct folio *locked_folio,
 		    struct ceph_mds_reply_info_in *iinfo,
 		    struct ceph_mds_reply_dirfrag *dirinfo,
 		    struct ceph_mds_session *session, int cap_fmode,
@@ -1213,8 +1213,8 @@ static inline void ceph_queue_flush_snaps(struct inode *inode)
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

