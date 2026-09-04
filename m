Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3883D7D77
	for <ceph-devel@vger.kernel.org>; Fri,  4 Sep 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538383; cv=none; b=kqWT4OqoNNT9cDv+K1uGOEX9jvun0qI4mONlSWZbZNQ1O1BBNaUnrHpCRxcMJ7nWvxZNUIZwoqaRzygGmKcDjXToGWe2647wRqNL7pbtr8H8BwgaUVOAwmRfZF8lRSlOCjuQ5V4gPYwOM3ruUwgPAiKX2lNFcjfElSbJghFjZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538383; c=relaxed/simple;
	bh=UoZCBJEJ48AtsoX+cePdFOhj8lHWv/JhUC68WqhWb2o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EBClc5LUhWaoh71ZybUzZ5wxNApCuGTgyOdkhquEgfR9P72f2OCLRiKfYOXmc1h72yvnFN94t/u0cWZXfblpV74k4WE35WkfSef8oiUL1HKFd76qeD+ZPm0ud1xtJ8dENaGpVjJQb9f7WAyr9PBtCkiS3FE11kVKKopv/J5G2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cxLfS0IE; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=2Kuj2Ue9; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cxLfS0IE";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="2Kuj2Ue9"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684GA3522044591
	for <ceph-devel@vger.kernel.org>; Fri, 4 Sep 2026 12:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=pboSFoWbuc9qxOvDTstx6PBwiq
	1NobGPi9iLcZJMr2Q=; b=cxLfS0IECzAqWZP3+sulzXZx75sfkID6vcAspKPnts
	TcRj0Hm6iX6FMBYpvNhCHoCZ9jhiuIpPTf0zWzpEb4qFCX5Mnt5iUnZay+nVcEOJ
	hWTmrtheWmKgEn1T9vI5z7xoS8HN+BM9NGGLkW5keK5AvNRP6rubPk07fBQ1EeB7
	NW5Y1hPzwmlMghMJCsZdw7WJJAMMVtTf3VkvoJfiKNprOV54WNFhUGVpRdOjvFIi
	1grZz/4ATOiqHIhv3YPXCHKnZoLzuBPQszKjCXh9oX07aJghcAFuQ9G8XMYXqIXv
	RdBDn8M0MhSAhwO4iHPFF5Amj12mNY9TDFId7BlDuP9w==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gfq86v5x4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 12:12:59 -0400 (EDT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-86617faa2b2so17650967b3.2
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788538379; x=1789143179; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pboSFoWbuc9qxOvDTstx6PBwiq1NobGPi9iLcZJMr2Q=;
        b=2Kuj2Ue91pVK8maAkKwpmrvEYDwOwz0L4k3zmliyM2dsgU1NxG0Z0rF065fyTQi8Gy
         kOW/u61hQNVJib7HvLlDNCP8gH0OA5XJqKD3PmzvBxaz2iXjoEouLjFf2DXz8/rGCnVI
         U4gqOLYDRuG86xlN2fXhFNaH5UjdhZC4vE6E5gY0pSYnzVEQTAlfYT6uKL7boamQGghl
         630VLrtch/KhLBmfJQA82Bg2ltR6pL4Ki/t/2ViVdcaIlfi/ScCZwjZ820eCDIIrD9VO
         AdiIb1Iil/26hOc25BtGOsJ/pZpVtXKaI4vo1kYehy6rO5Z0JldBZyHFfth1HnDBiv4o
         dNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538379; x=1789143179;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pboSFoWbuc9qxOvDTstx6PBwiq1NobGPi9iLcZJMr2Q=;
        b=LhlF27yHHdaurszxQr4uCdgerpJlvKHSVRXYs6n+nosPtL1bJVrMMOwsWL0fvHxW29
         ySqGYPRWdSceg34Ac9tZZmZWAdhHh5mG5gEzrgsBdOZyHO0Z9GSigxteBwBE2MuVTbcq
         mdvx34t0BRHbqx7wtgfVwwpch+1LIp9zIGT0ZVcnadNPRW4W5eFiiDIVRuPRDEH21fRS
         prp2tUJE3/MYl3RHmAN+ORnwqIY7cN6hfLh3krwrbdKLJ5xa+i4IiCMpp8K47kpk3uY9
         hnBoeLzf5w/A7MmDYsoMSq16Cp7KympY8PpWOZ9G7PBDA3kWTNyZSIZmaEdYeF6rXkAU
         uIAw==
X-Gm-Message-State: AFuF++kZDCZjbTdgeuS2n68KUUCEpQdiJszaIBN28xRHdH46ZC02e4sF
	jdrbMchSrFiKnE+3gcFqItwWpiy9XXb0kmP7I8vppp/a13nvGy1fvyjjf4ub5/EjPSh9/WSi7cs
	4lCdqGN9ysYrq9oMhF2lW1+LoGDJ/SlGPVn7U/22Lthf392v5UJWL5YWiemk=
X-Gm-Gg: AYBFou3P6JsX+2a9vMxUIhf0ul6oeK3gZstWZNfdmKXLxj3gDa+vKKftdvo8DVYnUrs
	91aXpVBlClIv/LlY1dBkUsOjzOQDabz3KM3cnmK8UNdTjSXCjuOoX4IkRJcbSzSabwATawrDCPH
	rs7zCf97dZa8WGV1SnNlebl2bNI8nf6sIb/WHWkB1D44vADoWSQxK7tiVGbIWkKEK/xXWhQu3A1
	JfQC55UwqIwcpJothemg1ZUIrzet0pg4V7adGvhqszYDgCQtcx8Mzwja3ymd2XSZOfPWxPjaLQS
	Vmf1DuO+6yi7NFgBw+vY/fIQ1900aDm4utaW3NJ0IxrodyJ1u4RiLE+AVsJN9g1323QEVQ6v6KS
	L3zyzru6nt3jfaq1uvM7ib92g6jw43x7z9ilqfZHf3KBuyzu5
X-Received: by 2002:a05:690c:f15:b0:873:5bb2:6c26 with SMTP id 00721157ae682-8735bb26d34mr9487517b3.45.1788538378786;
        Fri, 04 Sep 2026 09:12:58 -0700 (PDT)
X-Received: by 2002:a05:690c:f15:b0:873:5bb2:6c26 with SMTP id 00721157ae682-8735bb26d34mr9487087b3.45.1788538378264;
        Fri, 04 Sep 2026 09:12:58 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-177-158.net.columbia.edu. [128.59.177.158])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fafbd99sm241625085a.7.2026.09.04.09.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:12:57 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] ceph: fix writeback congestion accounting
Date: Fri, 04 Sep 2026 12:12:37 -0400
Message-Id: <20260904-ceph-writeback-count-leak-v1-0-d41b070bac9b@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXtmmoC/yXMQQ6CMBBG4auQWTtJaUTEqxgXZfyREVNIW5SEc
 HeqLr/FeytFBEWkS7FSwFujjj6jPBQkvfMPsN6zyRp7Mo05smDq+RM0oXUysIyzT/yCG9i6qq5
 xlrLqGsr9FNDp8ntfb3/HuX1C0ndI27YDuyviqX0AAAA=
X-Change-ID: 20260904-ceph-writeback-count-leak-2a577e8c15f9
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Milind Changire <mchangir@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788538376; l=807;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=UoZCBJEJ48AtsoX+cePdFOhj8lHWv/JhUC68WqhWb2o=;
 b=/mQaFUBlpOmFGnLv8cGJ/cWVPlY9PhYbqmSJ+c6c7RCa5JIfWWfPLRdAkeFWek9TaGrveWboF
 2V76ITm4sGaD1Lz+LvPa6Hwt3ijHzUDGUcDyiutAfmoGUeLRNKGQuLP
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=XNIAjwhE c=1 sm=1 tr=0 ts=6a9aee0b cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=tLges04aSNaZGVAfhBIy2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=hBQv_Bx3k30cK9kbcesA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0NiBTYWx0ZWRfX6z3hU1Wv1kz+
 7A6LNrApmLEk50wGCA5u6emJKY6v/Wel404u2rI4NK3kL/03EHr8CzMMm6KDktfIlEWeqIqSHi7
 c5O/pVn9vxTAgOEhPEUAaewvbsLf0XvgOqm0RPJVo6P9Ltx2Xw5p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0NiBTYWx0ZWRfX5uGBtXVi7xZu
 6mEoA2wEMjUP2jQAv9YQf1gqij9uKy458JTPlpvGmKFeUJjIlxNhHBKIRWquR8p3Fx7+pk0ItAj
 401WR/lhwZ0D92qqOqt4c8uQPnXYx7GMZC9hjpU1YYcdkhWSW9Qxh5oozFS+JLJv7rB+3EIwhHz
 f46jsyiujUuc9/B8i3heJIw8gYqUqJHRT2WQy8YK3Rblk1qWDMdblmWE4cSfBuabVYboV9GCU3j
 gHOzIjKIN0vDqdEJYMHQcSNPDmosBJ7rrt66l/vkryYyS+Pj3BGEGKEMtffL2qe25l5ExR7wDtc
 ThQdPr3Dv6sC7StBLRy2G+H6Lm3Rpvu70gdAURG2p62dAIFlSALCP/PWI3581pj9eQB5Fnocn9D
 VbRQb8iQioVZWIplmG6xxR0gGD6z6IcXobly3YdxAvHPH6QGEE2PaghVVN1TElMCJMJsA5ZoXgu
 uquJGXYOa0SOMd09DEw==
X-Proofpoint-GUID: VGJqghEw-wFxsToX-pnBzS0blFS2kux8
X-Proofpoint-ORIG-GUID: VGJqghEw-wFxsToX-pnBzS0blFS2kux8
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11895
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 priorityscore=1501 spamscore=0 bulkscore=10
 phishscore=0 malwarescore=0 lowpriorityscore=10 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040146

Two fixes for the writeback congestion accounting in
ceph_process_folio_batch(), both found while reworking the writeback
path for folios.

Patch 1 fixes a writeback_count leak when an fscrypt bounce page
allocation fails, which can eventually leave the mount permanently
congested. Patch 2 restores the set-only semantics for write_congested
that the folio batch refactor lost.

---
Tal Zussman (2):
      ceph: fix writeback_count leak when a bounce page allocation fails
      ceph: don't clear write_congested when collecting folios

 fs/ceph/addr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
base-commit: ef063f72b23420b2889a8f631887fe0adae4af12
change-id: 20260904-ceph-writeback-count-leak-2a577e8c15f9

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

