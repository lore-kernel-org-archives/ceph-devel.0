From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] Monitor upgrade issue when running "ceph osd pool
 set ..." commands
Date: Tue, 19 Nov 2013 08:12:36 +0100
Message-ID: <528B0F64.2010301@dachary.org>
References: <CAPYLRzgn7EaC28ePFentZiZqbhv15ruoL=Dy2JXmCHPmj5yzVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:42033 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab3KSHMi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Nov 2013 02:12:38 -0500
In-Reply-To: <CAPYLRzgn7EaC28ePFentZiZqbhv15ruoL=Dy2JXmCHPmj5yzVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>



On 19/11/2013 03:19, Gregory Farnum wrote:
> All,
>=20
> We've just discovered an issue that impacts some users running any of
> the "ceph osd pool set" family of commands while some of their
> monitors are running Dumpling and some are running Emperor. Doing so
> can result in the commands being interpreted incorrectly and your
> cluster being accidentally misconfigured (eg, accidentally setting
> extremely large pg_num values).
>=20
> The solution is simple: don't run "ceph osd pool set" commands while
> your monitors are running different versions. We will have a point
> release out in the next few days to resolve this issue. For more
> information, you can refer to http://tracker.ceph.com/issues/6796.
>=20
> Relatedly, I'm proud to announce this issue was discovered by our
> automated upgrade testing and we have not seen reports of it from any
> users. Thank you to our dedicated Q/A developers and testers! :)

Hi Greg,

This is great news ! From the point of view of my compan ( and I suspec=
t any company which is not Inktank ), the completness of the integratio=
n tests ( do upgrade tests count as integration tests ? ) means both a =
more robust product but also a framework to diagnose and fix problems t=
hat are otherwise difficult to track down independently.

Cheers

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
