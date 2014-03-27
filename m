From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Thu, 27 Mar 2014 08:48:56 +0100
Message-ID: <1395906536.28805.9.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
		<1395780835.2076.15.camel@localhost>	<1395781847.2076.21.camel@localhost>
		<CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>
		<1395782577.2076.23.camel@localhost>
		<CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>
		<1395783675.2076.26.camel@localhost>
		<CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>
		<1395784476.2076.28.camel@localhost>	<1395785839.2076.30.camel@localhost>
		<5332075F.8080105@ieee.org>	<1395788695.2076.35.camel@localhost>
		<53321896.1080606@ieee.org>	<1395797596.2076.43.camel@localhost>
		<1395798658.2076.45.camel@localhost>	<5332339A.8030000@ieee.org>
		<1395801625.2076.52.camel@localhost>	<53323EA5.6010506@ieee.org>
		<1395801940.2076.54.camel@localhost>	<53324F79.1080108@ieee.org>
		<1395806447.2076.70.camel@localhost>	<53325F09.7000306@ieee.org>
		<5332B643.5040403@ieee.org>
	 <CALFYKtCAwE0kX5Z7z-tUp6aDGY8jF3Mj2CVW3SM5YBCB40ebLQ@mail.gmail.com>
	 <53333F73.709@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:43076 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbaC0HtD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 03:49:03 -0400
In-Reply-To: <53333F73.709@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Le mercredi 26 mars 2014 =C3=A0 15:58 -0500, Alex Elder a =C3=A9crit :
> Olivier reports that with the simple patch I provided
> (which changed a "<" to a "!=3D" and removed an assertion)
> he is running successfully.
>=20
> To me this is fantastic news, and you can see I posted
> a patch with the fix.
>=20
> There remains a race condition though, one which I described
> in a separate message earlier today.  I don't think it will
> prove to be a problem in practice, but I agreed to work on
> a fix to ensure the race condition is eliminated.  It will
> require some work with reference counting image and object
> requests.
>=20
> The fix won't be coming today.  But I aim to provide it
> in a matter of several days.
>=20
> 					-Alex
>=20

One question from one of my customers : why am I the only one to
complain about that problem ?=20
I know that Ceph users often use qemu/librbd instead of kernel client,
but what is the trigger of those =C2=ABrace condition=C2=BB ? Having "m=
ultiple
requests" per RBD image ? It should be a normal use, no ?

If someone can help me give an explanation, thanks :)

Olivier

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
