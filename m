From: Daniel Hoang <daniel_m_hoang@yahoo.com>
Subject: Re: Questions on some minor issues when upgrading from 0.48 to 0.56
Date: Thu, 14 Feb 2013 09:34:21 -0800 (PST)
Message-ID: <1360863261.46568.YahooMailNeo@web162602.mail.bf1.yahoo.com>
References: <1360783561.14929.YahooMailNeo@web162602.mail.bf1.yahoo.com> <511C8FAF.1080102@42on.com>
Reply-To: Daniel Hoang <daniel_m_hoang@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm30.bullet.mail.bf1.yahoo.com ([98.139.212.189]:34604 "EHLO
	nm30.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934247Ab3BNReX convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Feb 2013 12:34:23 -0500
In-Reply-To: <511C8FAF.1080102@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



Thanks Wido for the clarifications.=A0

I guessed this means that I can update the OSD cluster to 0.56, and cli=
ent that was compiled with the old librados2 0.48 should still be able =
to access the cluster without any change. Client that compiled with the=
 new librados2 0.56 (API level 0.48) has to fix that rados_pool_list be=
fore it can access the cluster.

DanielH


----- Original Message -----
=46rom: Wido den Hollander <wido@42on.com>
To: Daniel Hoang <daniel_m_hoang@yahoo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Sent: Wednesday, February 13, 2013 11:18 PM
Subject: Re: Questions on some minor issues when upgrading from 0.48 to=
 0.56

Hi,

On 02/13/2013 08:26 PM, Daniel Hoang wrote:
>
>
> Hi All,
>
> Just in case these issues have not been reported yet, I am on ubuntu =
12.04, upgrade librados2/librados-dev from 0.48 to 0.56, and I notice t=
he following issues:
>
> 1. librados2 / librados-dev still reports minor version as 48
>
> Should minor version changed to 56?

No. From what I understand the librados version is only bumped when the=
=20
API actually changes.

This indicates that the API is still the same as 0.48

>
> 2. In 0.48, rados_pool_list(cluster, NULL, 0) can be used like a buff=
er size query, and it would return the buffer size required for the poo=
l list buffer string. In 0.56, this call now returns error -22 instead,=
 and I have to pass in a tmp_buf[32] and len =3D 32 in order for the ca=
ll to return successfully. I check the current rados_pool_list API, and=
 it does not mention anything about buffer and len should not be NULL, =
0.
>
> May be this was a bug in 0.48, that we should not pass in NULL, 0 ?
>

Take a look at this commit:=20
https://github.com/ceph/ceph/commit/a677f47926b9640c53fbd00c94d6eb7a590=
a94fc

I ran into this with phprados as well:=20
https://github.com/ceph/phprados/commit/ee8b87fe93f87f92a7c3fa197a33b3d=
2de2fc4b6

Wido

> Thanks for your help,
> DanielH
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>


--=20
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
