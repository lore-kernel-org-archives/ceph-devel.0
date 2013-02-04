From: charles L <charlesboy009@hotmail.com>
Subject: =?windows-1256?Q?RE:_Ceph_D?= =?windows-1256?Q?evelopment?=
 =?windows-1256?Q?_with_Ecli?= =?windows-1256?Q?pse=FE?=
Date: Mon, 4 Feb 2013 14:01:25 +0100
Message-ID: <DUB116-W124FC6A2EE7FCBDD873D42E0010@phx.gbl>
References: <DUB116-W12467CE5C3C0CAECA94D647E0030@phx.gbl>,<CBC0FE06F6854C9E8071A40270E28FA8@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1256
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dub0-omc4-s32.dub0.hotmail.com ([157.55.2.107]:4635 "EHLO
	dub0-omc4-s32.dub0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753996Ab3BDNB1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 08:01:27 -0500
In-Reply-To: <CBC0FE06F6854C9E8071A40270E28FA8@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: greg@inktank.com
Cc: ceph-devel@vger.kernel.org, post.the.reply@gmail.com


Hi Greg,

I guess setting Ceph up outside of Eclipse include doing the =A0followi=
ng on any linux system:

1. To prepare the source tree after it has been git cloned,
$ git submodule update --init

2. To build the server daemons, and FUSE client, execute the following:
$ ./autogen.sh
$ ./configure
$ make
3. Creating a C/C++ project on eclipse and importing the Makefile into =
Eclipse ...to put the ceph project under Eclipse control...

BUT its not working!!! Makefile not visible in Eclipse and wont import.=
=2E. I guess i have missed some steps in setting it up outside Eclipse =
or the process of importing ...


=2E.. I will appreciate your guidance and guidance from the community t=
oo...


Regards,

Charles.




> Date: Sat, 2 Feb 2013 18:16:08 -0800
> From: greg@inktank.com
> To: charlesboy009@hotmail.com
> CC: ceph-devel@vger.kernel.org; post.the.reply@gmail.com
> Subject: Re: Ceph Development with Eclipse=FE
>=20
> I actually still do this. Set it up Ceph outside of Eclipse initially=
, then import it as a project with an existing Makefile. It should pick=
 up on everything it needs to well enough. :)=20
> -Greg
>=20
>=20
> On Saturday, February 2, 2013 at 9:40 AM, charles L wrote:
>=20
> >=20
> >=20
> > Hi=20
> >=20
> > I am a beginner at c++ and eclipse. I need some startup help to dev=
elop ceph with eclipse. If you could provide your config file on eclips=
e, it will be a great starting point and very appreciated.
> >=20
> > Regards,
> >=20
> > Charles.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		 =20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
