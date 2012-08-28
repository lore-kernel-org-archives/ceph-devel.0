From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Ceph benchmarks
Date: Mon, 27 Aug 2012 21:18:46 -0500
Message-ID: <503C2A86.8080503@inktank.com>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63960 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2H1CSv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 22:18:51 -0400
Received: by ialo24 with SMTP id o24so9644636ial.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 19:18:50 -0700 (PDT)
In-Reply-To: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/27/2012 03:47 PM, S=E9bastien Han wrote:
> Hi community,
>

Hi!

> For those of you who are interested, I performed several benchmarks o=
f
> RADOS and RBD on different types of hardware and use case.
> You can find my results here:
> http://www.sebastien-han.fr/blog/2012/08/26/ceph-benchmarks/
>
> Hope it helps :)
>
> Feel free to comment, critic... :)

A couple of thoughts:

1) With so few OSDs going from 1000 to 10000 pgs shouldn't make too muc=
h=20
of a difference.  It would be concerning if it did!

2) Were the commodity results with SSDs using replication of 3?  Also,=20
was that test with the flusher on or off?  I'd hope that with 15k drive=
s=20
you'd see a bit better throughput with journals on the SSDs.

3) It would be interesting to try these tests without the raid1 and see=
=20
if you can max out the bonded interface.

4) I think the R520 backplane is using SAS expanders like in the R515s=20
we have.  We've had some performance problems caused either by them or=20
by something goofy going on with our H700 controllers.

5) rados bench tests with smaller requests could be interesting on 15k=20
drives.  I typically see about 1-2MB/s per OSD for 4k requests with=20
7200rpm SATA disks.

Mark

>
> Cheers!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
