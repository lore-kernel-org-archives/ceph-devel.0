Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570893D413F
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118479; cv=none; b=pHw5rEFr8+p+syI93NoGgxZPTgWJ63Zs6NRz35t7idTIY6cf0OMx3jo8ai6DVSu+KLHt/4d/vksg2vYtQGqrkL/Czi4BEDDyjkuV7fihcTThVSFaaYZyz4Z3oVSkbKNREGaBnGUEW/UNf3Qj0sI4yJ4/F87gRaQsBkl2c+51Ktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118479; c=relaxed/simple;
	bh=Syhtu1MFxEXvzL+Nm7n8Vdllt9WD/VVEQ8bkt1BxG/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHKeUrHTTIUY8XN3XqgX6RNUC1vlN+ObjT9T687feDIyqPuG+s4FTkLz+yVg6gGhvdxbfxb3WkdOPwT3Fk96SLLtYXNi2EOAZby1oDQTk/mhMCfpOiOwGMcEmChJjqsC51rpL34WL+WhyNZia8TqIFCFSfyLux2DJHLTeHOPexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=bRjwPRpW; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="bRjwPRpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1772118476; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=Syhtu1MFxEXvzL+Nm7n8Vdllt9WD/VVEQ8bkt1BxG/o=;
 b=bRjwPRpWBgE1vkF1ekB3cxG8/E+kGRXUYj8Zfk32FQDTkdMDYNjnGcXUFni41Q0kHGUz3
 eII3941qQuQd3ysI64mrxdlbyE/JtfyEaC8vOTzjJHhbAlJre30RsmIwhGRhhECXOwY2mRb
 zfnIITiCEGGafDd20rlKgs34wHqWunYOrezeEYPeB4QPziSx/wvRmz/+YxHiPuVogXupN/e
 P1PUNB7jLzf8NdZeyIGehiFdMnPbq5ciZMb9+H9IWurbggpuoyDeIFSOvaO52hg/aelt+Uv
 w+OIB4G1PQ2dycfThDgdOvXaXdvkGzL4PepbUyUUAbU4mtdrff2qSYhygDqA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 6FECB5FC04;
	Thu, 26 Feb 2026 16:07:56 +0100 (CET)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 578A75FCB4;
	Thu, 26 Feb 2026 16:07:56 +0100 (CET)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v3] libceph: Use u32 for non-negative values in ceph_monmap_decode()
Date: Thu, 26 Feb 2026 16:07:31 +0100
Message-ID: <20260226150731.1257332-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes unnecessary implicit conversions that change signedness
of blob_len and num_mon in ceph_monmap_decode().
Currently blob_len and num_mon are (signed) int variables. They are used
to hold values that are always non-negative and get assigned in
ceph_decode_32_safe(), which is meant to assign u32 values. Both
variables are subsequently used as unsigned values, and the value of
num_mon is further assigned to monmap->num_mon, which is of type u32.
Therefore, both variables should be of type u32. This is especially
relevant for num_mon. If the value read from the incoming message is
very large, it is interpreted as a negative value, and the check for
num_mon > CEPH_MAX_MON does not catch it. This leads to the attempt to
allocate a very large chunk of memory for monmap, which will most likely
fail. In this case, an unnecessary attempt to allocate memory is
performed, and -ENOMEM is returned instead of -EINVAL.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/mon_client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index fa8dd2a20f7d..94a7a82ca475 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -72,8 +72,8 @@ static struct ceph_monmap *ceph_monmap_decode(void **p, void *end, bool msgr2)
 	struct ceph_monmap *monmap = NULL;
 	struct ceph_fsid fsid;
 	u32 struct_len;
-	int blob_len;
-	int num_mon;
+	u32 blob_len;
+	u32 num_mon;
 	u8 struct_v;
 	u32 epoch;
 	int ret;
@@ -112,7 +112,7 @@ static struct ceph_monmap *ceph_monmap_decode(void **p, void *end, bool msgr2)
 	}
 	ceph_decode_32_safe(p, end, num_mon, e_inval);
 
-	dout("%s fsid %pU epoch %u num_mon %d\n", __func__, &fsid, epoch,
+	dout("%s fsid %pU epoch %u num_mon %u\n", __func__, &fsid, epoch,
 	     num_mon);
 	if (num_mon > CEPH_MAX_MON)
 		goto e_inval;
-- 
2.47.3

