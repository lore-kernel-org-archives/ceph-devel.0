From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: scrub loadavg too high
Date: Wed, 6 Jul 2011 11:24:13 -0700
Message-ID: <CAORUGqBquWmc1WomehAC7JWLevWGyrvk449DotWXcZx4A8tuuA@mail.gmail.com>
References: <CABAwU-aaJE10=ZtbkXn-OyEmMpO3Nz8BvpS=x39mSr6y0JZQyQ@mail.gmail.com>
 <CAORUGqBVzN2dYdBcPJ8s9qMfYW5GQeLROmwKe2KHRpT9xz4z9w@mail.gmail.com> <CABAwU-Yf_oUvKbtbbnDiRB-cXQbOVh+RepAT2XkEjOsErqiauA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54290 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab1GFSYe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jul 2011 14:24:34 -0400
Received: by eyx24 with SMTP id 24so61068eyx.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jul 2011 11:24:33 -0700 (PDT)
In-Reply-To: <CABAwU-Yf_oUvKbtbbnDiRB-cXQbOVh+RepAT2XkEjOsErqiauA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

[*Really* re-added ceph-devel to Cc, it got dropped accidentally.
Sorry for the trouble, I'm fighting with a new mail client.]

2011/7/5 huang jun <hjwsm1989@gmail.com>:
> thanks=EF=BC=8CTommi
> now, we have solved this problem, but another occurs.
> if use osd_journal, the performance goes down heavily.
> we use rados to bench write performance.
> =C2=A0rados -p data bench 30 write
> use osd journal on ext3 :
> Total time run: =C2=A0 =C2=A0 =C2=A0 =C2=A032.213428
> Total writes made: =C2=A0 =C2=A0 216
> Write size: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04194304
> Bandwidth (MB/sec): =C2=A0 =C2=A026.821
>
> Average Latency: =C2=A0 =C2=A0 =C2=A0 2.32526
> Max latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3.6743
> Min latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.105108
>
> and not use osd journal:
> =C2=A0Total time run: =C2=A0 =C2=A0 =C2=A0 =C2=A031.057457
> Total writes made: =C2=A0 =C2=A0 452
> Write size: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04194304
> Bandwidth (MB/sec): =C2=A0 =C2=A058.215
>
> Average Latency: =C2=A0 =C2=A0 =C2=A0 1.07141
> Max latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.23193
> Min latency: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.927193
>
> i can not figure out what slow down the write procedure,
> so can you give some direction/tips to find it out.

Journal mode means you end up doing twice as many writes (once in the
journal, once in the final location). The writes to the journal will
be streaming writes, the writes to the final locations are most likely
seeking around the disk. In average use, the journal can consume a
burst of writes, and then do the final location writes at a more idle
time. When your write burst exceeds the size of the journal, you end
up bottlenecked by the writes, but now you have the writes to the
journal in addition. The abilities of different disk systems to handle
this kind of writing varies a lot.

Note that you need the journal for data integrity purposes, either way.

We are not yet focused on this kind of performance tuning, but it's
highly likely you will get better performance with btrfs. On btrfs, we
can use the internals of the filesystem to do the journaling for us.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
