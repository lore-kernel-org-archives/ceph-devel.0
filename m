Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1F4E4314;
	Mon, 19 Oct 2026 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409655; cv=none; b=icFPn/Zu8Jz15n72GPUhreNtwtQOdx/k8o96IUVti62zkqsgxAcA1WaGgy8QeErosvrYGbHTyr/yMaNV/PrSiwcEUmI3vA1zgFDYC6ueAr/clEtTcCRuiXKyybd9fw2wCsfLNQNR9/0X1MxccVrj7SI230LE7xTdUlyEMnRv/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409655; c=relaxed/simple;
	bh=lx8GDY6UuwwohGUgszSq0IXVmdTWy6dvIcmQip9mIy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNUzlZoAKa9vyJQEnEa8T4kyacWjFK5PjB7v2pmqkonHaZk39Pk93cKFGDpJzJlhgUw+7w0kigWCKLxrtlAPPg3aVRms/Fv93DcJpBHZ4UR3zQJwPs1rxQe0bgobx3RVhoCv8XRP8E9replx0I6tkV5Hn/8e6jq4KZQJ58+tvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1sVNqls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1sVNqls"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACED2C2BCFF;
	Mon, 19 Oct 2026 11:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792409654;
	bh=lx8GDY6UuwwohGUgszSq0IXVmdTWy6dvIcmQip9mIy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b1sVNqls6hyuig0dpmWG3DNegTC1r2kRDzZmcpm46DNAf490Hn5YN6Z1E+DD8Nkki
	 CHcCHOlUvBTsnjcLHdqz1v2yxm3W02DwaEuSiJZP8pL7nSJBglJWHPkj3ReVJnNiSV
	 idfgUGGnfq0pNl9HorqCDTzbd9ONY9cgzKseiYing7GBuqpU4yC6AIco97lcAGem+7
	 y1Ydwiz2TIYgV4YsZkdvORcf/TlSwIjl7C854PpBdj0CEjxwyD70mnp1hZdJq2S0fu
	 3Sk2ikVvbO3KQ9HzqUlnLjyieAdl/mUqEJg2yoCzyZUgewWM0y660p/SlWvnjY9crS
	 ouAyTsklUcjZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86901CCF2E3;
	Mon, 19 Oct 2026 11:34:14 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Mon, 19 Oct 2026 13:33:27 +0200
Subject: [PATCH v2 1/4] ceph: report the requested length in the netfs read
 metrics
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-ceph-metrics-percpu-v2-1-1fa5229b00b8@clyso.com>
References: <20261019-ceph-metrics-percpu-v2-0-1fa5229b00b8@clyso.com>
In-Reply-To: <20261019-ceph-metrics-percpu-v2-0-1fa5229b00b8@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan van der Ster <dan.vanderster@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792409634; l=1451;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=CzKRsfVGnXiWaBtWsr/Fqsu917e+WRvEXbKXVxY/rmA=;
 b=D3IIpAx4UkwduCGz3ETWsaXRSCBl5gQQhmehxEGZPmscvAXWF54I4egX4BD6RYhtZl/Yl4o7E
 DQr1eqvFAwjAwSt2SP8/dxB9PrxOujPBhmF9g3JIV1/exL8pF61gBVZ
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

finish_netfs_read() passes osd_data->length to
ceph_update_read_metrics(), but a buffered read of an unencrypted
file attaches its data as CEPH_OSD_DATA_TYPE_ITER, and
ceph_osd_iter_init() only sets the type and the iov_iter.  length
shares a union with the iov_iter, so the read size metrics record
some unrelated iov_iter field, which is normally 0, for every page
cache read, and metrics/size is useless for buffered reads.

Report op->extent.length, the length the OSD read asked for, which is
set for every data type and equals osd_data->length for the page
vector that encrypted files still use.

Fixes: 4de77f25fd85 ("ceph: use osd_req_op_extent_osd_iter for netfs reads")
Reported-by: Dan van der Ster <dan.vanderster@clyso.com>
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index dd2bd8ed2424..8500d72702d6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -236,7 +236,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	ceph_blog_enter_gfp(fsc, &__ji, GFP_ATOMIC);
 
 	ceph_update_read_metrics(&fsc->mdsc->metric, req->r_start_latency,
-				 req->r_end_latency, osd_data->length, err);
+				 req->r_end_latency, op->extent.length, err);
 
 	boutc(cl, "result %d subreq->len=%zu i_size=%lld\n", req->r_result,
 	      subreq->len, i_size_read(req->r_inode));

-- 
2.53.0


