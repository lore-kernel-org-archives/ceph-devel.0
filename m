Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DFE55A
	for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2026 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770876849; cv=none; b=nHF05j8LNrGg/lB4tYGL1UsCkPvthK092RvavJ1JvgGn7BfGXy3lGCpC714fB9ufTlD3vt+j/6DrhN9rZlQKByCEsEwOlpyYGM6LIeWxt4HBA0YSKRdDC9FdAIdGRy0AQpMZNP7+cPCrU+OKjbyWrLAdXbl59SpwwHxZtmpMiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770876849; c=relaxed/simple;
	bh=J36M20FtQK3cNfboCVtMwl1/8K6/qcPgDwJZRkRIypg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpoH+NBpoN2nJdLFLvUmqHee0Zt2ikUXRx1ywmjArMXZaHj6EnO2auqmtYa24pzY+ReIlbFompGvzRLZfT5LJDKS9P4mD5oqXNBp1aFTPv4/7JBy4cCPuT6z3Jqwe+dyH8m0shchawnfNEWpQ0tnLzSyMyckcgYnvrtnx1qMDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gLWL9JAY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gLWL9JAY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BGxVpO883546;
	Thu, 12 Feb 2026 06:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L4TffA
	JKMJPsC3Y3BeDpP/ziffzHnyeSNIMkhjb6bK4=; b=gLWL9JAYM3/BFLdNUkABXi
	zXyoAf6qSCTW2vO1WQ57Mq62XpXx6sWULzgghuXLP4OwbSjvAqpQtm93io7fmmnp
	PIwKbm+oWdhCT7c4HwSIRlDOU4bWXQacZvkhW7Lt2UcEc4wReG4G0wbLbi2pdXN0
	YQBXWNhPUfDEIjr9ap8HEP1fV9PLKmcc9lua0W2fNiwr3GZPbS2NR1gbeZDJluAu
	FdRLm69TizfCGUjJ4Geu5OwtX57L0jgLIMeNK66Z/JGdGmMLKZrGTVOwIImtD8I6
	UKGU3FIrvlNfsVEwC8amnYOq1mXJCZXwUSceSV3Tz9EV5BLeM/PnxEUdf7qmG4AA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696umtuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 06:14:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C4HxAu001407;
	Thu, 12 Feb 2026 06:14:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6gqn94x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 06:14:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61C6E11R40305082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 06:14:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C75E12004B;
	Thu, 12 Feb 2026 06:14:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EB3620040;
	Thu, 12 Feb 2026 06:14:00 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Feb 2026 06:14:00 +0000 (GMT)
Date: Thu, 12 Feb 2026 11:43:58 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Patrick Donnelly <pdonnell@ibm.com>
Subject: Re: Exploring supporting fallocate() in ceph
Message-ID: <aY1vpoZGY6p2QCdO@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aYN-TBrwARmBBuHM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <d0325ea755f153558ac2c8e8501a3cd9980b4ea8.camel@ibm.com>
 <CAJ4mKGb1KZ75-j3ZZcqiUD+r_dwQ-zhxOi43Ub6qqHruOat0=g@mail.gmail.com>
 <CAOi1vP9dgO-CFUpUdJ_w2OcAYq+YDKwJFk+R2uQXw_jyy3DTxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOi1vP9dgO-CFUpUdJ_w2OcAYq+YDKwJFk+R2uQXw_jyy3DTxw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698d6fad cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=VI7Y8nNxZ-Z0KgRpSUAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDAzOSBTYWx0ZWRfX2G5APFXWiQ9v
 WT5Jjs3QfHsofmADttGVeInzF8uBf0876qEl7H91BKWRuQodYmQ+avLuzsRYAlCVNciWPea1T7E
 PWWKpU1qurxDFxVrdhSvyMcxhBjcIKoWb7K3XqEqJn561MXMwabkDQYriAYJfL0FHGEO7WpZ2a9
 eD9D2AvDv0CxbXknERm24dL437nS2yy7Chuvt/OegMs4fo99S9ZWixA/7DukKsXCmxT7JDtpifz
 J3hCLGL51QJFqzKWhRL+djGPf9Ebb2pxa0Yi35OLwopvtfqbrvhQ03nMou3pGrEZef2YcTVjAbE
 rmjPDpVwwSUn0DC8PfbleBuo1JKvKue/tq2E9ath5WyY1ewryh6HAnY4GvTy7fYFQz2QRfoweEV
 1EsxEuDQmCFIj29Th/0xS1bXcqOM/lvOH6ub0t/rmpM6NxQhBmN2SzPfMtAG7lOxaNQQraMRkI+
 BJ6r7WoCFJUm1My2xtw==
X-Proofpoint-ORIG-GUID: U_eVr_R-Sv7aYsXW-WmDlWdb6bNkJj_4
X-Proofpoint-GUID: 9uRMemCFGa9cCfZRmxoDQiG_qt_BRxMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_01,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120039

On Tue, Feb 10, 2026 at 09:15:14AM +0100, Ilya Dryomov wrote:
> On Mon, Feb 9, 2026 at 8:31 PM Gregory Farnum <gfarnum@redhat.com> wrote:
> >
> > On Thu, Feb 5, 2026 at 3:06 PM Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > cc Patrick Donnelly and Greg Greg Farnum
> > >
> > > On Wed, 2026-02-04 at 22:43 +0530, Ojaswin Mujoo wrote:
> > > > Hi team,
> > > >
> > > > So I've been trying to understand ceph and cephFS and as a part
> > > > of that I tried running xfstests on ceph. One thing that stood out immediately
> > > > is the amount of tests (~150) that we skip just because we don't support
> > > > fallocate() and fallocate(FALLOC_FL_ZERO_RANGE).
> > > >
> > > > Thinking in the direction of what would it take to enable this in ceph,
> > > > I came across [1] which suggests that we disabled fallocate because
> > > > it was not trivial to make the space reservations known to ceph.
> >
> > Right. It's hard to even sensibly define what the various fallocate
> > options should mean or do on Ceph, and then making them do those
> > things is another challenge.
> > But to be clear, we *do* support the FALLOC_FL_PUNCH_HOLE and
> > FALLOC_FL_KEEP_SIZE flags.
> >
> > > > Seeing how fallocate is an operation commonly used by applications for various
> > > > tasks, I'm just wondering that would it make sense to explore the possiblity of
> > > > enabling fallocate() and FALLOC_FL_ZERO_RANGE again in ceph. A few approaches
> > > > that I can think of are:
> > > >
> > > > 1. Explicitly write zeroes to reserve space. This is not ideal or performant
> > > > but maybe with more and more hardware supporting optimized zeroing like
> > > > nvme WRITE_ZERO or scsi WRITE_SAME commands, this might not be that bad.
> > > > Also, it can be argued that this might be better than not having anything at
> > > > all?
> > > >
> > >
> > > I think it is not good idea. :) Because, storing zeros and keeping zeros in
> > > storage device is not very good approach. Especially, it is not good for SSDs.
> >
> > Everything in Ceph works hard to be sparsely-allocated on-demand. And
> > unlike a local filesystem, which can handle fallocate by updating the
> > allocation table but otherwise not touching the disk, Ceph doesn't
> > have a central allocation state — every OSD handles its own data. So
> > even though the RADOS wire protocol supports a "zero" op, all it
> > actually does is truncate an existing object down. To actually
> > zero-fill in response to fallocate, we'd need to transmit all those
> > zeros out over the wire. For a small fallocate of 1MB or something,
> > this is fine — but a common pattern we've observed is that if using eg
> > a disk-on-file image, the software would fallocate the entire size of
> > the disk image before writing. If we get an fallocate call for 4GB,
> > that's (by default) 1000 objects we need to zero-fill, by transmitting
> > 4GB of data, for an operation that most programs will assume is
> > handled in constant time with bit-twiddling.

> 
> RADOS also has a "writesame" op -- if used, zeros wouldn't need to be
> transmitted over the wire.  The operation would still be linear in the
> number of objects that need to be zero-filled instead of being constant
> time, but the constant factor would be a bit lower.

Hi Ilya,

I was thinking of something similar where we can use writesame sort of
features instead of transmitting zeroes but from the discussion on the
thread I understand that it might also not be ideal. 

> 
> Perhaps RADOS could grow an "allocate" op to also spare the actual
> zero-filling and a counterpart "deallocate" op?  Currently the "zero"
> op has implicit deallocate semantics which e.g. RBD relies on and it
> would be great to make that explicit.  (The "zero" op doesn't
> necessarily truncate the object -- that happens only if the specified
> range happens to overlap the end of the object.)

Hmm that's an interesting idea. I'll take some time to understand RADOS
better and see if this is feasible. 

Regards,
ojaswin
> 
> Thanks,
> 
>                 Ilya
