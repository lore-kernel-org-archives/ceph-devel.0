Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A564A4AA404
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366944; cv=none; b=HFQwe9Ab+D+Em0JTx82w2MQxM/wQl2HYwtAMe4TcNl9VqbSC5DkhFU5a4Bkjl/uB/JjzumH7oElQ2f/7J6J8BaN6XuYqeB3+t+JkWBt/t9LPc2u6pAtgK/l6z01TW6JimnVNUbDptO67qV+6vPWK6ee+PnqZ4ZX/oE5IRWrzr2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366944; c=relaxed/simple;
	bh=A13FOnUVignJpbXasU9sCFVXtYmGVFkazU7rRABCu8E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A1MDUTA1uRCV3dAZRWxuu/fHPyW04ylBC+si60NRy2DH5n/5MTmNYwKaT4JNP0+x/OfXjoeWiWQYsfCaNKvwf5waGfsEgU0EWSoy+rZfWD0qEPBZ1OvGCO7FCQfwPOf6dJUX2uw41foUUOTUn5GbykBb97CvKH8ZocKI5+6gwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HV6h4lYF; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=smLS0dz/; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HV6h4lYF";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="smLS0dz/"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682GZ4SA506204
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=bWo0D08099QFy3kCZLoBK/vIKU
	Asrl1Rh6dsmdH3/1E=; b=HV6h4lYFmeEtO5zFU7Vv9mOtn9McOj54/xyW5OFW2w
	OiZFTwC1TksaVaOMIwS64wiCxEz1KvU9Dp5oX+D9rMIxe9pBDYUucJvW+P0a4kGo
	VyCd4P3kX1gZe+QFtz3tYXF0lF7gH+SKT0Q2tvpwEL7uHGHXo5FhGDVNwFtq+1G2
	OYcQb05lhWJ89/S5cDDlsdJX/NbE9Ku2pSiJOXRS0ToN5Js4eIk8dzC27jeLk9k0
	J9RZbx2angT3MHokW+ospQ9odj1O8WQT+9IZksF4QFtx1pUiFzLH0aeWL8nuVTwp
	bMC4DJidFZpPhbamtaUTeUA4Dnf/xuB27YKnD+gfFsTA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ge835d5a9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:35:40 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1d30035dso15569241cf.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788366940; x=1788971740; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bWo0D08099QFy3kCZLoBK/vIKUAsrl1Rh6dsmdH3/1E=;
        b=smLS0dz/ifYWtwT5+nDlO0K2jvVVERNysOHI9ZNpVRA5ZHZwzxgZ78bj/lSkYjbdS1
         4IPX2OCe3sWdg1+YylhkVZq6TXDDVu+nSjVNsWU8rPTaq7ABA/qPL51bGEnxlSjlmNJT
         kKHJaH44kGysudLOVyQW9OBYsDEDtHlqZD4TU2xzsGHLkpALqkwVzTJLUjYLo2mi2PTL
         EEfgYvfOj8A9Z3QGZYC+VUCnHVc9OFavs+dyaKr3TxKEnz4j3YmEw+octEPbZBsdIrjC
         K1N6+8on2gyfs2Mh4fheoySMaXYVOFTsMmSh63sFWCR6FOpR8KPU8fyqEneWhJTLVXGB
         XSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366940; x=1788971740;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bWo0D08099QFy3kCZLoBK/vIKUAsrl1Rh6dsmdH3/1E=;
        b=BZQ+Wb6/xYAtmHnDWjcduRmEH4R7TwIz6IFPp/2acEOXdpabW97Fov9q+NwP7gZyR/
         9PEqUNqSOK/5jgSw9tj3D6AKdoUSOGgosdZJMvaVzM+USi5iqSHEycB+/XlVd6C1SFa1
         cnFCFrRqtHMAlbRNZgzUrUegZtgYrRNTnXwIBWdtzEw0bRUZaPbquaI3YNt4msxNsCQK
         QhbpPQQqULjushdY3zaUDUkc9SjOqJlt+YGsROvmhGlo9k1pbgioCOVWefFK0SaEgpwt
         yNzYVNbENaCyHydJE5zm7H/0Siw9f7cX+cJbrE+AsjZhClJFeYPa7OzaPQVekfgvK3xt
         vwRw==
X-Forwarded-Encrypted: i=1; AHgh+RpnPjRI0Pqdah7tvwO5LbRUkCvdhQqT5/H9uDwM80KI506pX9wNAmXcTw4UZ3PyUJ/R6gtEipNRmuIu@vger.kernel.org
X-Gm-Message-State: AFuF++mSEfLlkAY0kq0INSybqTlu34ZsGiHyaCiULEH+UAn5owl24RIP
	CnA6VRJWE7YXzc5pmrGe9b1pdqQsHnnq7X3lsIquVdjeQVDxPDqgCd6PsPLM00bxJTKaffPNDq9
	mPSWNAEeEsvMvkhSS+pPRktGVOmCETPC8DHMdquOulnhfxOlqlC0my13inp0=
X-Gm-Gg: AR+sD10UXAKsJ7vynE21xiYwztP8B86tWRBFEm6NGmtAio7TlUgfXu4Wj1KYPaKdO2C
	mzUQaH+/fSHD4lG3xtktbyl+1KPQfJTm46OX3k4rLEtv+QNz61DzYJKKNUXDgY4NpfbU20ATyJK
	+Z0OytPda5A8svP6qZYwk+RfaFTF13dfr6A0Z15tX5XjPP/sb4rISIfe/ndlgUHcqPD/hqEdBEP
	tWXJq6sjTj9YAdsMMZ0GD8fjUz37JieO4J1DT7P3iEy0B7Ld6Jac8aZ8IrNkURRanV+eN6gyZaz
	kCiG7oJdSOWqSVt8ANzD8JLEGTjqsfB7jfmn1ir0PmCE494DKQGO576cINoYi2BOhrmdTKx3fFI
	fHV4h34j3rauRZE3ndR6yOTr6h7dRZQidCGB1cfyNlI2WvzHcrs4ahg==
X-Received: by 2002:ac8:7d51:0:b0:52d:824c:4856 with SMTP id d75a77b69052e-53036d12e8cmr62814721cf.31.1788366935511;
        Wed, 02 Sep 2026 09:35:35 -0700 (PDT)
X-Received: by 2002:ac8:7d51:0:b0:52d:824c:4856 with SMTP id d75a77b69052e-53036d12e8cmr62810051cf.31.1788366930328;
        Wed, 02 Sep 2026 09:35:30 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eef5067sm21805726d6.34.2026.09.02.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:35:29 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/5] ceph: convert the inline data paths to folios
Date: Wed, 02 Sep 2026 12:35:06 -0400
Message-Id: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADpQmGoC/32NQQ6CMBBFr0Jm7Zh2DEhceQ/CgraDjMGWtEA0h
 LsLuHf5kvffXyBxFE5wyxaIPEuS4DegUwa2a/yDUdzGQIoKVVKOlocOxffiGdvQS0B9NdYZUqr
 MFWy7IXIr76NZ1T9Ok3myHffQbnSSxhA/x+msd+9ff9ao0NGlKNrGsc7pbkM/vYw0Z3YT1Ou6f
 gHQfaPGxwAAAA==
X-Change-ID: 20260825-ceph-inline-folio-17bcdb200850
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubli@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788366929; l=2006;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=A13FOnUVignJpbXasU9sCFVXtYmGVFkazU7rRABCu8E=;
 b=YyUbIgdgtl75R6iMS+Sgr4Rptbj/zuzGmODLmCXYO5GUY1FeHeozg1PUB5NTTWtc7AGYjyA3D
 28TOEfD66ABCVHc8VdF0wMFD9DfX5bbwgGxYNktpJSaZlH667UxVxvz
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX8D7nUtNfXhJE
 aNVlKDl2OYepVoOZVYwq2zL0km3pG9Cq9jPwSG9azVV0y9wwrvoGZHDJqrFDL/MbTg8t6+WVPHq
 ppy40hqyCy11hvvRF76WYw0hDWfgg1u3HpTa5RSEWOY4Ebh5L2g6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfXx+vIbZOiMjAV
 YKq26I62QNHCPzLI28bYoJ/5OzTk/7UzvK5Kmv2DG8XxvEo+lyD/nYgNVUOCzpb3o3mGwqG0Tpu
 855bGqP3jm8CVHrhy1gkeJCopsCVFvv/0BGtrFsxG16UeXZ0EG/FK1vZBqZsbplttP9hnPjjLh1
 71kZpb95tJ+MZwiwVilNNBOlZF7Sr2nqqCJMbHKUMVwiD+1nvf7AfiAuJxljnbuxtJdSeFXfNTp
 5EGglVTVVTlrcvqsbK3k0uaPExhfa1HOAPVERBxi+s53LuLRtzBsHe9f4cZsZ0NagDj7fHz+loW
 4QDsHPd2E3IVbgKq4AvoHfkPvL1gMf9brer4FJLV6Jqk/8iXRArWFOy75CfXWD6/j9KrZw6Xs05
 T1iXMQxyNGm7PeNyBcG6m8VWAj6ITFESSz2sxP9BlddAenpcgMjDcNg0z81Nv9fpMx4l/Xi7rGf
 cYRYKViVCzaFf3FXqkA==
X-Authority-Analysis: v=2.4 cv=XY+5Co55 c=1 sm=1 tr=0 ts=6a98505d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=m4ctf-qRAAAA:8 a=2FfYK1p_f_zT-IZ44d8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=j2jfHXP1PwAwKcBWPe_Y:22
X-Proofpoint-ORIG-GUID: ZcYd8BKn44R8_e8TqnOnh48qfk2dwHuG
X-Proofpoint-GUID: ZcYd8BKn44R8_e8TqnOnh48qfk2dwHuG
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=10 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=10 lowpriorityscore=10 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020146

This removes the last ceph callers of find_or_create_page() and
find_get_page(), and one of the five remaining calls to
__page_cache_alloc().

The remaining inline data struct page use is the single-entry page array
in ceph_uninline_data(), due to the OSD client using page-based data
types.

Inline data support is deprecated and, as of the current testing
branch, gated behind CONFIG_CEPH_FS_INLINE_DATA ahead of its eventual
removal [1]. The conversions are still worth doing in the meantime, as
they remove the last ceph users of some deprecated mm APIs that we'd
like to remove next cycle.

Compile-tested only, with CONFIG_CEPH_FS_INLINE_DATA both enabled and
disabled.

[1] https://lore.kernel.org/ceph-devel/20260729-b4-ceph-remove-inline-data-v2-1-db0c92dab8ee@clyso.com/

---
Changes in v2:
- Rebase onto the latest ceph-client testing branch
- Patch 4: Convert the CONFIG_CEPH_FS_INLINE_DATA=n stub of
  ceph_fill_inline_data() as well
- Drop the put_bvecs() patch, as it was unrelated and could underflow
  the refcount of slab pages, per Sashiko
- Link to v1: https://lore.kernel.org/r/20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu

---
Tal Zussman (5):
      ceph: use a folio in ceph_get_caps()
      ceph: use a folio in the inline read branch of ceph_filemap_fault()
      ceph: use a folio in the READ_INLINE path of ceph_read_iter()
      ceph: convert ceph_fill_inline_data() to take a folio
      ceph: convert r_locked_page to r_locked_folio

 fs/ceph/addr.c       | 70 +++++++++++++++++++++++++---------------------------
 fs/ceph/caps.c       | 10 ++++----
 fs/ceph/file.c       | 18 +++++++-------
 fs/ceph/inode.c      | 14 +++++------
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.h      | 12 ++++-----
 6 files changed, 61 insertions(+), 65 deletions(-)
---
base-commit: 6b039a71d37a39bb90a64c4e271f90ee0588ac4a
change-id: 20260825-ceph-inline-folio-17bcdb200850

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

