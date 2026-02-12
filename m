Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6233C1F5834
	for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2026 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877578; cv=none; b=gqXM0Rgk79KzPvytRw3gOD8kcXXUt9SWTj++Oy6xoHVxylEQ6lT1+q48j6iw3KEDfWe3Jkvs4VXtkTNjMFVfOpMfjkAWb+Vs8xUJeeJQTnnF9scHpgIKdBBY2OgKTql4OiCaFiLOsKUzTdT33jauFpqP6IjEW+LprPRkjdtSBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877578; c=relaxed/simple;
	bh=PT9UZxFjtoe4ebmP2dnFzG7how2SbxVwW97G4L1iJfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XATIglHi5TVEO+LyUS97rLfljEPPYqP97aj4EapetuVLsNeeXmG1VDNkQnuzCbThYeLK34jlQxH6Te2nfJr7x3ZhXQ3ncyZfc9Jf20UiG9/TLZmSPrvxNP238WG4dGsBnI/D8UMIt2f9uLCt49Jp3cRunP0D9JivIc3273JAy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PNkTrCGg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PNkTrCGg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BFEfS1331321;
	Thu, 12 Feb 2026 06:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cahDA4
	fF4XBucMqLsxjTg9MNQJq6JTR9j/QHODx5fW8=; b=PNkTrCGgJ4Y9K0Ni2NpQTH
	3aDh9ndT7AVVn5mx4XrCzvYvFznKIsKIjJYjo1AyzrtbcYsYtTLwzOslImjFQKPf
	EDUx+xZGQG4BAJnl4brnhdZL/0AK5ZugQrKV2XLDDqo1Y6ap/u+/snDDRML4MHQt
	Af3519uoX4Y3TtMkyHCcgWOFRR6OqBRgEDz9yhl23hUtcgw0acFoHWkZiACYoSlB
	DgExQiWmSc3w8OEuAihQnHNyY54vdOcmHBCMMjU56c8vquWgtgXzwT93Lr4AZKIM
	uEd3Z9C7NwaAvUus6eqQ7G63iVmqAnfxJlSrPg0e7IWawc6/7yqcGRKTN7/VyRyA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696va3h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 06:26:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61C3qOhE008413;
	Thu, 12 Feb 2026 06:26:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3yh96j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 06:26:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61C6QC9e46596578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 06:26:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43D4C20043;
	Thu, 12 Feb 2026 06:26:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3485E20040;
	Thu, 12 Feb 2026 06:26:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Feb 2026 06:26:11 +0000 (GMT)
Date: Thu, 12 Feb 2026 11:56:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Patrick Donnelly <pdonnell@ibm.com>
Subject: Re: Exploring supporting fallocate() in ceph
Message-ID: <aY1ygDLN93Er4lnj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aYN-TBrwARmBBuHM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <d0325ea755f153558ac2c8e8501a3cd9980b4ea8.camel@ibm.com>
 <CAJ4mKGb1KZ75-j3ZZcqiUD+r_dwQ-zhxOi43Ub6qqHruOat0=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ4mKGb1KZ75-j3ZZcqiUD+r_dwQ-zhxOi43Ub6qqHruOat0=g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iuCLeRKWoMqWzm-1zirIS4Nv_ihZvs8F
X-Proofpoint-ORIG-GUID: iuCLeRKWoMqWzm-1zirIS4Nv_ihZvs8F
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698d7286 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=AiHppB-aAAAA:8 a=4u6H09k7AAAA:8 a=VnNF1IyMAAAA:8 a=s5EYnS1s_d1g-n8nX8MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA0NCBTYWx0ZWRfX00kJ3fh9GzvX
 EFUeQvUX/aegirIx5knVinJIaD7/ql6CLcr5tS1fILHqvD6bCZ2CWCOEUnsoBiUDj/evOouUK1G
 SlCGQDpzW9cyEcm9IRjv3Q+ulcSCu6NIWaDTlbMuxK5Fadidn87LifXbzLBnvDWY7v8SflkDtDn
 mTEkc4Ddtp2+zm8K/iLIfFSr3twbnjv70sCQ4vYoTLm5318BYgtPSeRNRRUFdSmpyZ95mgDxFBE
 jdR9AuAcAcUFb7PQMVlvZXyZ8Y8rGm7yPXUtel8UUR8roJ98umYJ9oNeSBxe1C2Sp00tHl2dMR4
 6CPd5gxQXUm79tKb4JEGX4NQllFZ/yykXyzD/XwSjkMtftH3G979tLW+Nw5Tp2ykiHjgTlGxGuM
 16ssTGmRf6Acd0pneICvrEoTrF3TIvPj+7VJDRTBQUtWQtP/t+5Dhz5jeS18yK4oaXMYa5VvwZW
 EEKou1qtn2fHXbU9K9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120044

On Mon, Feb 09, 2026 at 11:30:53AM -0800, Gregory Farnum wrote:
> On Thu, Feb 5, 2026 at 3:06 PM Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:
> >
> > cc Patrick Donnelly and Greg Greg Farnum
> >
> > On Wed, 2026-02-04 at 22:43 +0530, Ojaswin Mujoo wrote:
> > > Hi team,
> > >
> > > So I've been trying to understand ceph and cephFS and as a part
> > > of that I tried running xfstests on ceph. One thing that stood out immediately
> > > is the amount of tests (~150) that we skip just because we don't support
> > > fallocate() and fallocate(FALLOC_FL_ZERO_RANGE).
> > >
> > > Thinking in the direction of what would it take to enable this in ceph,
> > > I came across [1] which suggests that we disabled fallocate because
> > > it was not trivial to make the space reservations known to ceph.
> 
> Right. It's hard to even sensibly define what the various fallocate
> options should mean or do on Ceph, and then making them do those
> things is another challenge.
> But to be clear, we *do* support the FALLOC_FL_PUNCH_HOLE and
> FALLOC_FL_KEEP_SIZE flags.

Hi Greg,

Thanks for the background. I'm initially looking at the

1. fallocate(mode=0) - after fallocate, writes to this range should not
ENOSPC due to disk being full

2. fallocate(mode=FALLOC_FL_ZERO_RANGE) - same as 1. but after
fallocate, reads should read 0s from the range.

> 
> > > Seeing how fallocate is an operation commonly used by applications for various
> > > tasks, I'm just wondering that would it make sense to explore the possiblity of
> > > enabling fallocate() and FALLOC_FL_ZERO_RANGE again in ceph. A few approaches
> > > that I can think of are:
> > >
> > > 1. Explicitly write zeroes to reserve space. This is not ideal or performant
> > > but maybe with more and more hardware supporting optimized zeroing like
> > > nvme WRITE_ZERO or scsi WRITE_SAME commands, this might not be that bad.
> > > Also, it can be argued that this might be better than not having anything at
> > > all?
> > >
> >
> > I think it is not good idea. :) Because, storing zeros and keeping zeros in
> > storage device is not very good approach. Especially, it is not good for SSDs.
> 
> Everything in Ceph works hard to be sparsely-allocated on-demand. And
> unlike a local filesystem, which can handle fallocate by updating the
> allocation table but otherwise not touching the disk, Ceph doesn't
> have a central allocation state — every OSD handles its own data. So
> even though the RADOS wire protocol supports a "zero" op, all it
> actually does is truncate an existing object down. To actually
> zero-fill in response to fallocate, we'd need to transmit all those
> zeros out over the wire. For a small fallocate of 1MB or something,
> this is fine — but a common pattern we've observed is that if using eg
> a disk-on-file image, the software would fallocate the entire size of
> the disk image before writing. If we get an fallocate call for 4GB,
> that's (by default) 1000 objects we need to zero-fill, by transmitting
> 4GB of data, for an operation that most programs will assume is
> handled in constant time with bit-twiddling.

I agree that writing 0s might not be the best thing as applications
often falloc large sizes and it will add undesired latency. Maybe as
Ilya pointed out, we can explore and allocate operation in OSD itself.
Not sure how complex that would be to do though.

Also, what are your throughts on the newer
fallocate(FALLOC_FL_WRITE_ZEROES) flag [1], which was explicitly added
because for some applications, writing zeroes is faster than maintaining
unwritten extents and all the journalling that goes with it. I think
this can go well with the writesame OSD operation and since the user
explicitly asked for zeroes, they should be expecting an IO.

[1] https://lore.kernel.org/linux-fsdevel/20250604020850.1304633-1-yi.zhang@huaweicloud.com/

> 
> > > 2. Since the issue tracker is 7 years old, I'm just wondering if it is worth
> > > looking at the ceph infra to see if we can support fallocate in an alternate
> > > way.
> 
> Fallocate does occasionally grow new flags, and we definitely want to
> support the ones that make sense. I'm just worried that ZERO doesn't,
> and mapping the semantics to Ceph is difficult and sometimes
> undesirable. So it's not a question of "do we support fallocate()",
> but "which fallocate() flags do we support". And we need to talk about
> them all individually.
> Also, support for fallocate flags are widely fragmented, so most
> programs which make use of them are prepared to get NOTSUPP on any
> given call. That reduces the pressure for us to lie or do something
> terribly suboptimal. :)
> 
> (Note that I'm picking on the zero op here as it's one we've
> previously discarded, but that's not set in stone. Maybe there's an
> implementation or an argument we didn't look at last time around.)
> -Greg

Programs might have ways to mitigate falloc() not being supported
but I think, at times, it might make lives much simpler if they can just
use it. Not having to worry about constant ENOSPCs in between
performance critical paths can't hurt :D 

That being said, I see the point that we shouldn't silently write
zeroes when the applications have grown to expect constant time
falloc()s and doing it the "right way" would be better. I'll take some
time to understand OSD architecture and see if I get some ideas I can
share.

Regards,
ojaswin


> 
> > >
> >
> > Patrick, Greg,
> >
> > What is our position related to FALLOCATE? Why have we disable it?
> >
> > Thanks,
> > Slava.
> >
> > > I would be interested in exploring this however since I'm new to ceph I just
> > > want to reach for any insights or pointers from the community.
> > >
> > > cc @Slava since he has been helping me out with ceph
> > >
> > > [1] https://tracker.ceph.com/issues/36317
> > >
> > > Regards,
> > > ojaswin
> 
