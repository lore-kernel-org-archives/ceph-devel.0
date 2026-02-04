Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A5E311C38
	for <ceph-devel@vger.kernel.org>; Wed,  4 Feb 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225241; cv=none; b=EZ75tfwYeSdVEB93t0uMU83s5DcKTD9YSFakm8Itmbve/jpKcZAugYG3Kvnf5Ul52bzIc7YTaEzstITdgVMrPpuP7xpwmoYT2HHLUwrXy+C8w/Msgtg+Vospo+b+sDw+YHClhaMiI+A1jgyQyjPZBtPiLH42SLHl8MlbWn5SOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225241; c=relaxed/simple;
	bh=n5waYjwFpnbMceID07XVYaN730Q9VtFQp1RJ/NmL3oo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MD3qVJRoLKNuPsA3kD0Bxdfwpw2DKP1E57A2fr/jnziYjau3wYhsICjZR++KYu5Rt1qv7+Hg17+Ac1u5tK7fscJEzNERRtQOaW7nZVQtECLf2LTnwI26N4R33Bh9d0YygxEnkPLD7zk0qV7rexnqd2n9aQGNqj2dhTH68PQLE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SgDI9hrV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SgDI9hrV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 614FIFtx029800
	for <ceph-devel@vger.kernel.org>; Wed, 4 Feb 2026 17:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=FaCV9DMByATZgNpO+t+lFh3q4/W2k7tJr01sGGHQ4NE=; b=SgDI9hrV
	BfAcHZAH4X2nBR6s01VS3Ar72ZPzfBzM7kb2Npw8/iHoQXE+JSbuKZLEeURD9Ers
	2cv26vW9wqeK3TSOa1zk8n2V14g6or0pos6SvN4s3RWkiiVG0TYPmdurrt5TZYJ6
	mxauaso140A26yTg4L59XYoe/BLp4y0o9gRyUaJmSMkgMBe+k3AhfqAxpEFodo97
	AWIWsJODdY+fRlWQudN7yzpVrvb+xNP2Kv6BRfqRSdVVvht5kH/saMz5D8wE+1fx
	OYgFAK4O1yFA+p2ytbbz8IKaCcTSN2OU86lF1TLNShFjhZo97RI4XzSSOEsr11SF
	fPTioq30331EDw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dtb0vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 04 Feb 2026 17:13:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 614FZulI029421
	for <ceph-devel@vger.kernel.org>; Wed, 4 Feb 2026 17:13:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2sea9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 04 Feb 2026 17:13:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 614HDpsV50397658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Feb 2026 17:13:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7A9B20043;
	Wed,  4 Feb 2026 17:13:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 081A52004B;
	Wed,  4 Feb 2026 17:13:51 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.199])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Feb 2026 17:13:50 +0000 (GMT)
Date: Wed, 4 Feb 2026 22:43:48 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: ceph-devel@vger.kernel.org
Cc: slava.Dubeyko@ibm.com
Subject: Exploring supporting fallocate() in ceph
Message-ID: <aYN-TBrwARmBBuHM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyOCBTYWx0ZWRfX/LovbYHraIJr
 Lk1NwW0Oc17V6MBrgyDzWG0Mi6XYPl4XnH7yCuxMCPPfH9r8ls+nRdUgahA655m86T26mkLj8hV
 avNnONKWJARBgQQlqU+1vLgV/bn+sJeHB2hzfs8jKnpkixYVIobhVGEZcITTUTn4LRFhxoHlm9G
 9otXnX23ADoyTA9K5M+bEmPyICc1TUP+MUmguWp52q4VFZCSQ/O9uXi+J/OTke4TFrWIwNDmg4V
 8ATSApHq6yx71s7bf6vuXAatRYblGw6mZxD5OcyhzYKgtC0NAG3xphLl5JSJpgarRuHdntRYGTF
 sy2ZZFdSg+Gk0moZ4aNLkc5QhC8wM8lqaz5xoLS0oYVilHoJa0s3+vf/B5uR3Ebbw/qmrb0+j1N
 eQLn601XhKrQFEDYnIjOjPKtR8vA8oUXqMFrQfjNv4gQdiviIOkOig79zcWwinRz4nSJYz8sF2k
 tKW9AW3MycE2fs5XNEg==
X-Proofpoint-GUID: TQIrkJmeoEhuLlbqniKAs1eAA8S1mh7L
X-Proofpoint-ORIG-GUID: TQIrkJmeoEhuLlbqniKAs1eAA8S1mh7L
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=69837e52 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4u6H09k7AAAA:8 a=H94BSP_3aYvwz9x5s6cA:9 a=CjuIK1q_8ugA:10
 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602040128

Hi team,

So I've been trying to understand ceph and cephFS and as a part
of that I tried running xfstests on ceph. One thing that stood out immediately
is the amount of tests (~150) that we skip just because we don't support 
fallocate() and fallocate(FALLOC_FL_ZERO_RANGE). 

Thinking in the direction of what would it take to enable this in ceph,
I came across [1] which suggests that we disabled fallocate because
it was not trivial to make the space reservations known to ceph.

Seeing how fallocate is an operation commonly used by applications for various
tasks, I'm just wondering that would it make sense to explore the possiblity of
enabling fallocate() and FALLOC_FL_ZERO_RANGE again in ceph. A few approaches
that I can think of are:

1. Explicitly write zeroes to reserve space. This is not ideal or performant
but maybe with more and more hardware supporting optimized zeroing like
nvme WRITE_ZERO or scsi WRITE_SAME commands, this might not be that bad.
Also, it can be argued that this might be better than not having anything at
all?

2. Since the issue tracker is 7 years old, I'm just wondering if it is worth
looking at the ceph infra to see if we can support fallocate in an alternate 
way.

I would be interested in exploring this however since I'm new to ceph I just 
want to reach for any insights or pointers from the community.

cc @Slava since he has been helping me out with ceph

[1] https://tracker.ceph.com/issues/36317

Regards,
ojaswin
