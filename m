Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB7214A84
	for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2026 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085950; cv=pass; b=TFOxm8+FyDs5UI+qZSjamEEx44KSJtK8XnYXJa7AfIm27i8oRyb71doG31rsZC+xFftBQbiq9u7N14RgHZSv8MKXT3ZvIrB4ro+gSe+Ber4X8ZaTyZGroOts1u3FbJwFli2c8wMOUjkyVqExnq4VDEjyG7ST+S6CoLCI7EC6K5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085950; c=relaxed/simple;
	bh=gN6p4BHMJu7wezAEoh+ZWimR6M9/A3O/vdPPB3p5BGk=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=JPdl9pfXHVE+BaVsNcu3sAcFk4N7R49soGhb8KL2Cc+Bf8oV3MxY6MCKhfUMSQOpZlNggy0t/iZinGsXQ6Jj3//RUXxcOtA+XojS6Fn7sXfO5DXBHXKXcrKMJ0aXoIX8Mo3sjGh6bUL2cSAJx0I//K6hhPGAyFt9CIHqCuDR6J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=JAseW34j; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="JAseW34j"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-851cbd64814so260406b3a.1
        for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2026 17:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789085947; cv=none;
        d=google.com; s=arc-20260327;
        b=e+7eCAeQI+64MPPvzu6kf1loMP6u5X09WZwUOYPw3Mo9K/JaEtLT+ENLTYCrB4SenE
         szVdNPw48904g1JuaxobZLPjdQH0i14nc2BucgKV6t+dBWdNyI9H7+OFbk86csRXBFbQ
         fp6ckVIxJ45DJ/3Rl2yHSCf628V7+Qq9W5EQQsy0Hbdykeph4DRawU+0fi7Wv7ZYqp7g
         GSOWZX1GC/4wr6/KPPEu/qawiRsg4aMKCOSNxNPh5oSBmXy32nu7emRtVGM/vdMQvIpM
         F83lUyKOZAnOFGf5zE6a+RfPNOwMArUmA8KL/u6TTXrRo27Rny1G5uXFxbUogro4ziRX
         rvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=DRWY7TGKlrDE8BUJYREHI/zhjMrn8auFwGi8zbFwJIM=;
        fh=jdSjtpPaKp/mCVMgfCvgcXA59WDCO1+lYfMoM1oRsmQ=;
        b=m3gRdkDIkFtBBDFY9WHkI9WxeWcULzKx9YGb7fhMihk5tpvui5ZgiUfVoo7URo34Gj
         dy/+F/JqKajMK1foJeOp4YXZgNy8gZC2bi91MkXAY24OjDwUDi55Ttt6UMMgzK3H5T4T
         l8kPttlZFmusiX7Hdc45XhTvcbzXd57A51gtKqq048Q8dwpI0UWQfzZ9fLIUGaRmoC3h
         2Pa80zaVjXThYTNs8p4xozyND2cgZzmcF2OYeWjMGk7CIb4Jg2CaY5E1N0QytwLIZdaw
         JHEdE1iyPDC6RHX9ck/CSY1nnClcOBml44COLUD152mKOWhSg913rXiTpC5jWEMdAs9E
         CX5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789085947; x=1789690747; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DRWY7TGKlrDE8BUJYREHI/zhjMrn8auFwGi8zbFwJIM=;
        b=JAseW34jbtEjb0h3l5jfliToWd1c7hzf6HPMG+cq/Dxu4IUVMZrtmlRw90ip0yyocJ
         D4PGZU3wy289NXrEp4MaBiC1NtsMKh/W9Y0ntUL1U/d5ERaLEb82bjfkhAcUA15imlpD
         Ee/HR0Ec0FswO7eDWwEShikaga554Rur7h6yb1CH6uNCv0VajhWHp7rD+alX0LxH5jE2
         bbZWJY65btCbSND2f/O8doDrPZia4VyGoL+7iw+pd7QUcLLECnO3JN5nERqSJM1qEl0p
         Pb5GblVJq+54p+smc6vEerSg+AKdpRXeVhMGXtVMevOj2oNRvBaslLvtTTVNhR+QYdW4
         C5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789085947; x=1789690747;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DRWY7TGKlrDE8BUJYREHI/zhjMrn8auFwGi8zbFwJIM=;
        b=G9h83rv4r49WuaL7RpXIsVggSwjQ7soq1r+3ygxT5v+HWwfiqPdoFXknOriTQB7xNn
         QEJ8cwhAfDjY/kz7uTc3zn1oHs2gh2O0qXuJEb7mlsBro3RNesZFbezRCA2VS+g3PKiv
         U+yj+m2SbUc+fbBE/xvK6XbFzzLYuttHuJoTvAPRYJypM4tH1mRRHEZRer5E24firw33
         oV1e6gOU14R1OBwVhOEHyUHJGrZJAhb81GWvv3ugujpXMAhjSCHQwP/jsOUSePTIox4N
         r5xopEmXFqBOqDSwK05mhZUuKyBkhLjhnTe89ZE1kxga9M2/LAdkIJsV+JMI7eEJQ73q
         u8fw==
X-Forwarded-Encrypted: i=1; AKwUvBwjhurO0dQx2MNZSSTJBpGfn99T3NxoVtUpFAnttXi3qFR/iA6Z1HfIQ7k4R71B7EoxzO2Dl/xi4wJd@vger.kernel.org
X-Gm-Message-State: AFuF++lQGrbcEmpfR847rzuTbvI7EGEm+/uDo8BNUa22YqfriBb6iwOv
	aOQRMuc2XMrInSZJRs7DyDcvfwfh8QgynOAm5HPw1taAkS69YPPUMlprTreQzxaV6hv7Dh2h1mu
	hTu9tR4qg9rongf5gBZ80u/skAFSWttV1H57pp0SD
X-Gm-Gg: AYBFou2VlhD5v8QRgk3BxQ8/zEUuv+EYqOWsECRXH9dner2gln5sCTrYoBg/GAeB5/N
	wRCxIwgJG+PvUIl9qvaMdGnbz2NF3UkfUUTqkfgw2lEyCmo8q8Im03ZSISTm9uWvf80pBhDBsGV
	feO98oJc3J6ApQ3zIV/Wp5eGti8F2dezC8zPabA+DyY2L89gLsDq/2BkjnXgEum8jSlMj+C0EMi
	6xVqCLPBg3Uhr0asaeI6Y0Py1ay3zksuV6lYD+x3OzGuPz1HialcpKlTdNuyBDkU9ydFiGooGvI
	b5CBfuJ21P9bCajT9FTjrcn75IRnMAHjfie8qf2GsoMGAr/V9laiGi6x+X8dZ0e3Aa5Cyw3R0EK
	6h4AZyBfRUaOChSqFWqd71ywiE/CNgGSFT/eUyYqtkN8=
X-Received: by 2002:a05:6a00:889:b0:869:4484:ed98 with SMTP id
 d2e1a72fcca58-86b336da391mr2179665b3a.20.1789085946510; Thu, 10 Sep 2026
 17:19:06 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:19:05 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:19:05 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 00:19:05 +0000
X-Gm-Features: AcwNN1VhQHuDmyfmr7G_3qRfSsnT9lX_ogCYHM0LoLiDwCGK4kVN5SmNeoy2eZA
Message-ID: <CA+0ovCiUaccnL7U89TZs2GOBGxp2E6OCfU_KMwre9Fnfv4BE4Q@mail.gmail.com>
Subject: [PATCH] ceph: fix NULL dereference of filelock_reply in ceph_lock_message()
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: falemi@asu.edu, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ceph_lock_message() dereferences req->r_reply_info.filelock_reply
unconditionally once a CEPH_MDS_OP_GETFILELOCK request completes
successfully, but a reply with a zero-length extra section leaves it NULL,
because parse_reply_info() calls parse_reply_info_extra() only when that
section is non-empty.  parse_reply_info_extra() also selects the parser
from info->head->op, the opcode the MDS echoes back rather than the one the
client sent, so a GETFILELOCK reply naming READDIR, LSSNAP, CREATE or
GETVXATTR is parsed as that op and leaves filelock_reply either NULL or,
since the extra results are a union, aliased onto the member that parser
wrote.  Reject a successful GETFILELOCK reply that left filelock_reply
NULL.  Select the parser from req->r_op instead, since only the op the
client sent identifies the live member of that union.

Closes: https://lore.kernel.org/all/CA+0ovCgZoX5yG35yvU1S2D0Fc35TYeEZKAFUnO-tFMqeXubfdw@mail.gmail.com/
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -822,7 +822,8 @@ static int parse_reply_info_extra(void **p, void *end,
 				  u64 features, struct ceph_mds_session *s)
 {
 	struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
-	u32 op = le32_to_cpu(info->head->op);
+	/* The extra section is a union; only our own op names the live member. */
+	u32 op = req->r_op;

 	if (op == CEPH_MDS_OP_GETFILELOCK)
 		return parse_reply_info_filelock(p, end, info, features);
@@ -872,6 +873,11 @@ static int parse_reply_info(struct
ceph_mds_session *s, struct ceph_msg *msg,
 			goto out_bad;
 	}

+	/* ceph_lock_message() dereferences filelock_reply on a success reply. */
+	if (req->r_op == CEPH_MDS_OP_GETFILELOCK &&
+	    !le32_to_cpu(info->head->result) && !info->filelock_reply)
+		goto bad;
+
 	/* snap blob */
 	ceph_decode_32_safe(&p, end, len, bad);
 	info->snapblob_len = len;
