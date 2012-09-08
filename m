From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: Ceph benchmarks / ceph osd tell X bench
Date: Sat, 8 Sep 2012 20:16:45 +0200
Message-ID: <20120908181645.GA30875@oder.kd-bie.de>
References: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:37412 "EHLO
	smtpa2.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab2IHSRH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Sep 2012 14:17:07 -0400
Content-Disposition: inline
In-Reply-To: <CAOLwVUn-Xs=3c4YDizYPcRfWaKpf79zgpjRp=52ge3nZEusrLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?iso-8859-1?Q?S=E9bastien?= Han <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi S=E9bastien,

when running 'ceph osd tell $i bench'
who/where will I see the results:
osd.0 [INF] bench: wrote 1024 MB in blocks of 4096 KB in 19.109900 sec =
at 54870 KB/sec
osd.1 [INF] bench: wrote 1024 MB in blocks of 4096 KB in 20.755279 sec =
at 50520 KB/sec
osd.2 [INF] bench: wrote 1024 MB in blocks of 4096 KB in 19.347267 sec =
at 54197 KB/sec
?

Which logging do I have to active for it ?

Thanks,
-Dieter


On Mon, Aug 27, 2012 at 10:47:06PM +0200, S=E9bastien Han wrote:
> Hi community,
>=20
> For those of you who are interested, I performed several benchmarks o=
f
> RADOS and RBD on different types of hardware and use case.
> You can find my results here:
> http://www.sebastien-han.fr/blog/2012/08/26/ceph-benchmarks/
>=20
> Hope it helps :)
>=20
> Feel free to comment, critic... :)
>=20
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
