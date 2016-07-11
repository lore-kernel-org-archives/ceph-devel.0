From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: drop i386 support
Date: Mon, 11 Jul 2016 09:32:06 +0200
Message-ID: <20160711073205.GA14502@predictor>
References: <CAJE9aONDn6S+8e7GNDpLX+6YaqSSEpQcFUDH_WeCXZrHfePAhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:43300 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030311AbcGKHcF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Jul 2016 03:32:05 -0400
Content-Disposition: inline
In-Reply-To: <CAJE9aONDn6S+8e7GNDpLX+6YaqSSEpQcFUDH_WeCXZrHfePAhg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jul 11, 2016 at 02:57:12PM +0800, kefu chai wrote:
> Hi Cephers,
>=20
> I am proposing drop the support of i386. as we don't compile Ceph wit=
h
> any i386 gitbuilder now[1] and hence don't test the i386 builds on
> sepia on a regular basis. Also, based on the assumption that people
> don't use i386 in production, I think we can drop it from the minimum
> hardware document[2]?
>=20
> And we won't explicitly disable the i386 build in code if we decide t=
o
> drop the i386 support, as we always try to be portable if possible.
> But just don't claim the i386 as the officially supported arch
> anymore.
>=20
> What do you think?

+1 from my side. Regular users are on amd64, and those willing to run o=
n
small devices are using ARM anyway.

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
