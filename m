From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: Ceph benchmarks / ceph osd tell X bench
Date: Mon, 10 Sep 2012 19:07:49 +0200
Message-ID: <CAOLwVU=A1jz56qZrv88CxE=vOirtnvdJepF7-oGpgFwxWGZc_Q@mail.gmail.com>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
 <20120908181645.GA30875@oder.kd-bie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54461 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495Ab2IJRIL convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Sep 2012 13:08:11 -0400
Received: by lagy9 with SMTP id y9so1269891lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 10:08:09 -0700 (PDT)
In-Reply-To: <20120908181645.GA30875@oder.kd-bie.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dieter Kasper <d.kasper@kabelmail.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Dieter,

Simply run a "ceph -w" and wait for the output.

Cheers.


On Sat, Sep 8, 2012 at 8:16 PM, Dieter Kasper <d.kasper@kabelmail.de> w=
rote:
>
> Hi S=E9bastien,
>
> when running 'ceph osd tell $i bench'
> who/where will I see the results:
> osd.0 [INF] bench: wrote 1024 MB in blocks of 4096 KB in 19.109900 se=
c at 54870 KB/sec
> osd.1 [INF] bench: wrote 1024 MB in blocks of 4096 KB in 20.755279 se=
c at 50520 KB/sec
> osd.2 [INF] bench: wrote 1024 MB in blocks of 4096 KB in 19.347267 se=
c at 54197 KB/sec
> ?
>
> Which logging do I have to active for it ?
>
> Thanks,
> -Dieter
>
>
> On Mon, Aug 27, 2012 at 10:47:06PM +0200, S=E9bastien Han wrote:
> > Hi community,
> >
> > For those of you who are interested, I performed several benchmarks=
 of
> > RADOS and RBD on different types of hardware and use case.
> > You can find my results here:
> > http://www.sebastien-han.fr/blog/2012/08/26/ceph-benchmarks/
> >
> > Hope it helps :)
> >
> > Feel free to comment, critic... :)
> >
> > Cheers!
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
