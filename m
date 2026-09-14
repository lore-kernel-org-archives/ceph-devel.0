Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488F40855
	for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789344220; cv=none; b=QtB7AkmhvFHjyNO1/1JjdoS4WHGhKYghqspt835+HnfDV5UuBkG5i31im6fk9w6noetHHgcARnBOOfzEBQJgv33HOfw8Uhl2J72/3s4S0oFXnQit1GfiqGKwD0dw4Imlq28fyUhBOfrFOMY+p34W7oS/YEI4w23uepfHXo7FNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789344220; c=relaxed/simple;
	bh=OGD1TNkSOwBr1B9et/VubXRxEUrkia2Ij71PDKyP+CM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CSnr5v2idc9ESxr431eszHcJJvPu165zbyw6hDEpHzgU5X/kJgrGm3fVAcfIIQgaie8di42iYHAmyCY7GWEz6/+E7CdAb9XzEJcs+YEG9HLdMQlPeGOyCpH65b9CTRufkyZWu6l2+jBqhImded/slo8wcECLSDoRfzvdjJBHtkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QKkZgBnx; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=oJarUBPG; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QKkZgBnx";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="oJarUBPG"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DMZne4435518
	for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 20:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=su0eIYIxXWYmEoMLuLyzaQN4bD
	wmzz65OiZLQZEIHSI=; b=QKkZgBnx+yQlH4szLgHouY/WFb/SblZI/FS2ju+M8R
	C2Ir6QhYlLgLm9jkyIxtXljXkJDjG2/wgOLZd7RqqvApaQFEc+fG/jwXM4VDqVCI
	BboWyT717M9S8gQbOU7MmIskrUy3E8Be25hQP/av5exRJGq4vutVYysvcQUfrqoC
	ZYM0wlXnLENIas0tAuA1xAmGbW6PcF21BW10Z3UjJEFcCNLXRYH/a8X+j11g3uLn
	1Csbmaf1Wg1ukwVv3ozozpTZ8EwC2vHVXv1+kDqEiVo4z/VqPBsVI38X+axJzFVr
	XZkfdOf3Y7VoN4+bvlAJ/K2KNN5VFltSuDp8WUr/6dyg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gnyfg1jb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 20:03:38 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90c8da50f4fso41078936d6.0
        for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2026 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789344217; x=1789949017; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=su0eIYIxXWYmEoMLuLyzaQN4bDwmzz65OiZLQZEIHSI=;
        b=oJarUBPG8yjQVysPOFkhA0mUgZwf4msRAmrtfNLRrxKafhHaT4ajcelr0LMBwG7ym6
         WYi2E6b6kYEpciOAOOST9wVLxNoh95WQV5DCo4ILzMhfmlfVvKKszWRrNPWIz/XBv13B
         zMDMtgHlFPrTfr4PklD4DV3m9NcQyM+OL8NdlgD0hV8E7Pb64auVp77TJ4PfPq9kH2tY
         /L2eRWpC7MFp6dzISr2O8nkHRiOcBmFxnd2zcws7Ijrb9YJDEvOgLMDYhvMDzRcI3qvN
         lgjqyrZhpAFi7c3qwHxNN7GnEemiWzI/f42hkai9fgZzkkfNjhxi7/sQ57VLXprnh2mq
         meSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789344217; x=1789949017;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=su0eIYIxXWYmEoMLuLyzaQN4bDwmzz65OiZLQZEIHSI=;
        b=Fv3jVXR8QtuP9rmg4+BHsyw6NAN1AYnMe2at3SaEvNjl8HNNlNrmv/L1A/epVsrGbb
         YBIzW/NKRohBk4lCkt5r1hTQ0sNN+c+wJ9yzffe3Vgkg5e2q+yukW4xeeJItZfGH1SYJ
         57ys/RSDMRvbeetoMIkccxpcinlp7aGtYUyqhTyqtti6XnLIuC79VfATDZz8OfGaI+M2
         ncdtajPGhOU99xin1ecpUoQYst8LhAN7TW3CA49sxWX3YBWq1IintRWQ5ENiHRxPo2Cm
         ULWWRFuu7cSztOeD0CSq8X6RlAmw4umoNZPc9nTok6rHaAb6Q+hTc9f1R7PAX8oqzwQJ
         vLjQ==
X-Gm-Message-State: AFuF++mnVux8g9oTsQm/nFaHIY5QxNysGXk5q+4LfUNOrMtj+UnHCaot
	hwoKeW3B7Z62MBWGg5lMm7q69mr6dCKF0TTxGuRGQWGXj0Ei/U1A9gY7+B2sWhIwVmLtkud2kug
	6NT3ZTpfXnlDmbgRdW7sQPu2HEaQlj2bfeJq2hGU/c8tGhCGppncJhPchusk=
X-Gm-Gg: AYBFou1LAZ4PhmiNplFj/c1Zv7JOAkbEgiZpLhpObGDPzWl+X5fO3+IEF3X8E5/cdpw
	4I6a2OOUFSgfiMwCgJJ/aWKPJXBRg6jtk5bKEn8jtOZ5lrFzGG+DnlHVWqWbl9NcmawmmRpZDIb
	ccvlnXJxyQk1x8zLI96KEJQqVh5rKf/Y/CVcjwpt9kgy3yPPLIncpGqlkEcoM0FDoCB7vMwlC06
	CEq3AHA5svEcBEh+XWy3AacORZqTZp2GhE0bhTJaDKrtzT4Y3U5zeuUThb7cQmJl/bk9SJbWLks
	aTkU0rnguyBjlCwQLDlxXvFoqK/26q8yhKWiTGNysEred6+IoghUQEvcqTBdoZMXyKwBFY807dt
	w0B8jLqfBVCx4J88bABlWbWVoYx83l564ZlkRw21ui3Zg+aDG2mQWnQ==
X-Received: by 2002:a05:620a:6892:b0:939:8ecf:6025 with SMTP id af79cd13be357-93a297bbc66mr53262285a.20.1789344216848;
        Sun, 13 Sep 2026 17:03:36 -0700 (PDT)
X-Received: by 2002:a05:620a:6892:b0:939:8ecf:6025 with SMTP id af79cd13be357-93a297bbc66mr53256885a.20.1789344216397;
        Sun, 13 Sep 2026 17:03:36 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-179-215.net.columbia.edu. [128.59.179.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f19291sm872250985a.10.2026.09.13.17.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 17:03:35 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] ceph: remove two users of __page_cache_alloc()
Date: Sun, 13 Sep 2026 20:03:04 -0400
Message-Id: <20260913-ceph-alloc-page-v1-0-c436f2f4c068@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALg5p2oC/yXMQQ5AMBCF4avIrDVBUVxFLGoMRoSmRSTi7orll
 5f3X+DIMjmoggssHex4XTziMAAc9TKQ4M4bkijJozKWAsmMQs/zisJoP+eFVKiytO1VAf5lLPV
 8fsW6+e32diLc3gzc9wN7gNhVcwAAAA==
X-Change-ID: 20260913-ceph-alloc-page-6837c754bf78
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789344215; l=561;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=OGD1TNkSOwBr1B9et/VubXRxEUrkia2Ij71PDKyP+CM=;
 b=+9D8Qse6yTUumDumxi3Vs2q/FN/sxn5/sqXItEBDygzcrEZhZknBx6ENddeqW5xMtXKuwT6p6
 nQUYcMofG6cApRNJT+DympQxgxQCmfbRcTaNdxX5dIz9SLurTkW3oZP
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDM0NSBTYWx0ZWRfXykFnPlmWgdVI
 +9CdZ8g5GA4Yuz7sdSW8+7jV9+Tb8++KdCMAKo7Am5h2/bDkZeN/h3Bfz+sn9PzzzQoCy8x2lwk
 uBiDMDwv4VPsz3uaxKuLaU2v/TasBk0J3Tqfnf2aCwveCE1RuHFi
X-Authority-Analysis: v=2.4 cv=bOODs/+Z c=1 sm=1 tr=0 ts=6aa739da cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=2jelXx5xVcRIF5zNctN5Qg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=keSSM9zJSnSKbyYQy00A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDM0NSBTYWx0ZWRfX/H6nR17X93WT
 F57lDobNVJQEWRVv8xtZ3WhODOxYumUA3UxbxCY2/RkToLaZvbYqPLgpqw/5XckFi80Gb0+zz9B
 5c+XuPPcTihtbt8gR1cJ5IgZ9hcZ2EAdBBxznVs/+28ykA+L8SNQ1G8reQcO6vSFedAaeMw7X5V
 /wPp2lopfvpvI3vY3cdFakK7CG6rAiuCl/xATCqnpM8erunLCyBmYC5Im3i9XJAyBrUz7gx+Ni2
 i4oc6FDv3n7s0wCvyAHCyrbotWJIfBt1adXFj+aQCJQwRXLJZNK35qaPy90NBSI8wS/vxS6hB2K
 +8gn3pd/maHs3XHV5xYYBdSqbMeVtvrS75GbJVL/FZ7iKor6zb3OKTv0WAv0SmueKHHaT8wgzPZ
 JzqamyXzOjf7YwPXwp4SZhI+hc/MUgX56+k7Y2NcJuZpu/qMyZAn70f8iGyNrWahc/Qww2aFfP/
 J+l9esa4CXl3bNvT8eg==
X-Proofpoint-ORIG-GUID: zbh6OhtieGhMxZ5pbP9uQKwT8Gthd22l
X-Proofpoint-GUID: zbh6OhtieGhMxZ5pbP9uQKwT8Gthd22l
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11904
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 bulkscore=10
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=10
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130345

__page_cache_alloc() is slated for removal. Switch over two of its
callers that do not need a page cache page to use alloc_page() instead.

---
Tal Zussman (2):
      libceph: use alloc_page() in ceph_alloc_page_vector()
      ceph: use alloc_page() in fill_fscrypt_truncate()

 fs/ceph/inode.c    | 2 +-
 net/ceph/pagevec.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 4d584eadc178349f4d2b4f37ff71d025b4ad1921
change-id: 20260913-ceph-alloc-page-6837c754bf78

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

