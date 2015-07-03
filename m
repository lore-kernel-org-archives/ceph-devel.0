From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: Transaction struct Op
Date: Fri, 3 Jul 2015 10:52:19 -0400 (EDT)
Message-ID: <1440963926.6.1435935139406.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <90559C83A9C7FA45B5846C975DFA612DDB4DD4E243@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1024 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755460AbbGCOwY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jul 2015 10:52:24 -0400
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB4DD4E243@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Piotr_Da=C5=82ek?= <Piotr.Dalek@ts.fujitsu.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I tend to support (++)

----- "Piotr Da=C5=82ek" <Piotr.Dalek@ts.fujitsu.com> wrote:

> > -----Original Message-----
> > From: Haomai Wang [mailto:haomaiwang@gmail.com]
> > Sent: Thursday, July 02, 2015 7:26 PM
> >=20
> > Yes, some fields only used for special ops. But union may increase
> the
> > complexity of stuct.
>=20
> Not by that much, actual changes would be only in coding and encoding=
,
> rest of the code should remain the same.
> =20
> > And the extra memory may not a problem because "Ops"  in one
> transaction
> > should be within ten.
>=20
> This equals to at least around 720 bytes that must be stored in RAM
> and transferred through the wire.=20
>=20
> With best regards / Pozdrawiam
> Piotr Da=C5=82ek
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD

--=20
Matt Benjamin
CohortFS, LLC.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://cohortfs.com

tel.  734-761-4689=20
fax.  734-769-8938=20
cel.  734-216-5309=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
