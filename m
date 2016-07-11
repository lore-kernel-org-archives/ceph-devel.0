From: Wido den Hollander <wido@42on.com>
Subject: Re: drop i386 support
Date: Mon, 11 Jul 2016 09:47:12 +0200 (CEST)
Message-ID: <1382742234.736.1468223238352@ox.pcextreme.nl>
References: <CAJE9aONDn6S+8e7GNDpLX+6YaqSSEpQcFUDH_WeCXZrHfePAhg@mail.gmail.com>
 <20160711073205.GA14502@predictor>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:40738 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbcGKHrW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2016 03:47:22 -0400
In-Reply-To: <20160711073205.GA14502@predictor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Piotr_Da=C5=82ek?= <branch@predictor.org.pl>, ceph-devel@vger.kernel.org


> Op 11 juli 2016 om 9:32 schreef Piotr Da=C5=82ek <branch@predictor.or=
g.pl>:
>=20
>=20
> On Mon, Jul 11, 2016 at 02:57:12PM +0800, kefu chai wrote:
> > Hi Cephers,
> >=20
> > I am proposing drop the support of i386. as we don't compile Ceph w=
ith
> > any i386 gitbuilder now[1] and hence don't test the i386 builds on
> > sepia on a regular basis. Also, based on the assumption that people
> > don't use i386 in production, I think we can drop it from the minim=
um
> > hardware document[2]?
> >=20
> > And we won't explicitly disable the i386 build in code if we decide=
 to
> > drop the i386 support, as we always try to be portable if possible.
> > But just don't claim the i386 as the officially supported arch
> > anymore.
> >=20
> > What do you think?
>=20
> +1 from my side. Regular users are on amd64, and those willing to run=
 on
> small devices are using ARM anyway.
>=20

Indeed. In my experience I have never seen a cluster run on i386.

+1 from my side to drop i386.

> --=20
> Piotr Da=C5=82ek
> branch@predictor.org.pl
> http://blog.predictor.org.pl
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
