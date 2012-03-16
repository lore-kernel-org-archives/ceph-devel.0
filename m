From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: Hadoop on ceph
Date: Sat, 17 Mar 2012 01:24:32 +0400
Message-ID: <CAADCt4LBvF-oKpWRx9WO1zFnCqPRr_8EPmnv-qZqWY4jLq0-AQ@mail.gmail.com>
References: <4F623EB9.1000901@genome.wustl.edu> <CAADCt4+npvtAYqshMKxtNedF+_UQrQPMS3VvG8Bd-Ughkhoqfg@mail.gmail.com>
 <Pine.LNX.4.64.1203160832570.31380@cobra.newdream.net> <DB33BD3B-B4FB-492F-B099-BECF0ED6764A@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55043 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab2CPVYy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Mar 2012 17:24:54 -0400
Received: by wibhq7 with SMTP id hq7so1449364wib.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Mar 2012 14:24:53 -0700 (PDT)
In-Reply-To: <DB33BD3B-B4FB-492F-B099-BECF0ED6764A@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, Matt Weil <mweil@genome.wustl.edu>, ceph-devel@vger.kernel.org

2012/3/16 Noah Watkins <jayhawk@cs.ucsc.edu>:
>
> On Mar 16, 2012, at 8:37 AM, Sage Weil wrote:
>
>> Hi Andrey,
>>
>> On Fri, 16 Mar 2012, Andrey Stepachev wrote:
>>
>> possible). =C2=A0I take it TestDSFIO is a standard hadoop benchmark?
>
> Yes, this is. There are a number of benchmarks that ship with Hadoop.=
 Although this is untested, one reason you might be seeing throughput i=
ssues is with the standard read/write interface that copies bytes acros=
s the JNI interface. On the short list of stuff for the next Java wrapp=
er set is to use the ByteBuffer interface (NIO) to avoid this copying.

I'm not sure, that problem on java side. All disks loaded at 100%, so
I think, that problem clearly on osd part. But i want to test your new
integration and see, if something changes. You maybe right, but I'm not=
=2E

>
> - Noah



--=20
Andrey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
