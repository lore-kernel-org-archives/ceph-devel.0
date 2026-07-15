Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099648095F
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126229; cv=none; b=Oo87jF5WTxxBou8qIc9twrcbe1W2Z4nYNMvNKwd3FYAImZ1MNsLyIAYYakc566Ou/fKCpKPCLLXIU3Tw68OtLxRZXgZNHcj80DW46Nk7fVV+g6YXrERc06kxP3YAliwKDSjahUPQ43I8IA7dC0SIxPqdlBnYo0/qYTLGYBaA904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126229; c=relaxed/simple;
	bh=QHlAcyhY3qbJdc8EpVKuySc+CLEQ45GK88npe2CgNGI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9Crp5USSsltj6tMUCqzeOtmBjCDF/dj1Rg5NhM5RttJf+Vala62RLPj4Jcg918Z/EPBufa0lbj5bsDxWeaZb4lFAubwfuvecb+7daIvL+92gGjN6Uv91grHn866JxQwIbCIGsCdwb0aM3ZKGbp3xFWNWOobUKRMeHy5v9J5nnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2xJYI0c; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2xJYI0c"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2395158a91.2
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784126227; x=1784731027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQmdLX5tvY3UqorwHkfxKBPQI7i/9/6KxbDE+/LuHoY=;
        b=X2xJYI0cBf5jkF+qsumiTdvfJzbFqXPNFtgM9guN3LFeQ2pWWEqK4fAwir0kvDVi2O
         MhZkawv/WYxDO3mdrIC9Ey1nLzSnPrS7fHAoK8A3B0dML57CZhU3hiRx+lz8RlIiohwl
         NJfQVHo0DMVJ8WnExImqU9ycqlOo+Zmh3AO5t370PV3GywwpqMYxU/b7XMOyGhrJPkq7
         lmIhrCBAdRPRCk7JCqdGSWl1sPTn3BpgeJy2hr2vPDvLeX3tDVF1au/NBs71ipgEUCo+
         WPELxF728CglTFrCJrUFFJnlOPithU5Z0qLNuw8xOQbAAkzDVvLiEuE9ER1wkpxFyo8u
         cuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126227; x=1784731027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rQmdLX5tvY3UqorwHkfxKBPQI7i/9/6KxbDE+/LuHoY=;
        b=hrfhRSR2pgQdD14WEmrHiK10uSjZSoWE46H59pAU5kFmGW27jqoysUMRw97GXHqEm1
         dve/wW6ksI0FO0cpn2KzZDR/sVaadHRj7s9j5Z7wIxmebwYA9syeqz3633W/91Hkh6gg
         duEXQlxZVxGzLvuGwfvleJKjqYHsq+qQ/RFgDiFraCuOs/U7TPsEsWQcTasOHGtD0H0Y
         cM4pQM+mporCAwl5TGlUXXQs5eDy+kUL0ZLMQcY3ixwvQgm9Oe7X+CIoz5AINVuZ1DKq
         EV/e8ks1vEZ5E+DqjjjgAzM5Hz5t7gUu8igPki71/CCfSWiOxlBBC5/oend26Zg0hFkt
         CcBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfsayELNCR/0ONxqjcBe+JfCFfWcE4pJmCMh1uJLHp8ezPlYZyAgkNvGmV1NTN64II9U1vDs7PO5bi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jB78IgVWh1NLjE2kXfn1+cpa0bWgSxmXyijZ2XVqmws9p468
	JTVPr67uy+1GgXleLYh9Xj26/BSs19IlnNrLIN6qx4FYo2Kkj4dTi2Izvga5dC7U
X-Gm-Gg: AfdE7ck/3dhp8YjA2V606e2VIwGGPCVis6Z1gJd7fLyuSOLdFZUdyB/HXAcdLaY1XY6
	PbxdIMcaZJjhvRXzvBQPzlBknynHgPswlxpMr7J09OiJ+g/+5ZGjXiHwMZmDsSX+Q42RjQTOtoZ
	sP0ttc49egMCoh0AujlUxrU7JeeZtTD4mtIE7TDD3Up79aC5pE56MSQkAV3tfaKqWWLWdvraiCx
	OukGv+NfDN8yUihwbNMSFEfJyMk/il3Hd9yLdDaO11zP47Dy4oNchixrsHKH97xWrV2H/q0SiSj
	aus36+8zxT6U+kbT0f+N6dj6el2z3BGpeffwptTma5vzDXNNiT5fnbtzbIp3lJdP6ydR87iT+jD
	9KEF5Spqvs6A6U1M0ALhgg5pP9xeHQLd6xwbVraqXDlfUZs6ybH98//0NqaGbWySHkinJKTRT/l
	OF68MMKO4zs3PaKrJ4/uEAMC5bTN7TKbAClJwnnrabWfTrkHbiP4g=
X-Received: by 2002:a17:90b:35c4:b0:381:21c1:75c0 with SMTP id 98e67ed59e1d1-38dc74cfa71mr16782817a91.15.1784126227181;
        Wed, 15 Jul 2026 07:37:07 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:90:2db1:3066:c473:74d2:497d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fd3e9sm2020161eec.1.2026.07.15.07.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:37:06 -0700 (PDT)
Sender: Deepak Rao Gaikwad <deepaksraog@gmail.com>
From: deepakraog <gaikwad.dcg@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ceph: release unused cap reservation on readdir error
Date: Wed, 15 Jul 2026 20:06:44 +0530
Message-ID: <20260715143646.15828-4-gaikwad.dcg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715143646.15828-1-gaikwad.dcg@gmail.com>
References: <20260715143646.15828-1-gaikwad.dcg@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_readdir_prepopulate() can exit with an error after partially
consuming the request's cap reservation. Return unused reserved caps to
the MDS client pool on the error path so they are not held until request
teardown.

Signed-off-by: deepakraog <gaikwad.dcg@gmail.com>
---
 fs/ceph/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 61d7c0b81..2d6a80054 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2188,6 +2188,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		dput(dn);
 	}
 out:
+	if (err)
+		ceph_unreserve_caps(req->r_mdsc, &req->r_caps_reservation);
 	if (err == 0 && skipped == 0) {
 		set_bit(CEPH_MDS_R_DID_PREPOPULATE, &req->r_req_flags);
 		req->r_readdir_cache_idx = cache_ctl.index;
-- 
Deepak Rao Gaikwad

