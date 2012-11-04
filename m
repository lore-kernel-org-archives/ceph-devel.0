From: Yann ROBIN <yann.robin@youscribe.com>
Subject: RE: RGW: Pools .rgw .rgw.control .users.uid .users.email .users
Date: Sun, 4 Nov 2012 13:38:14 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C53F681E8F@DB3PRD0311MB416.eurprd03.prod.outlook.com>
References: <CAF6-1L48MVb724sP6=msrd2ry2T38Psu+d+FnuqnTW0cFekSgA@mail.gmail.com>
 <CAC-hyiHke+pw17Xrf04nK95hQqUDRwDX_M2UzzxpbUfMsOSnTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [213.199.154.206] ([213.199.154.206]:52710 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752313Ab2KDNj2 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 4 Nov 2012 08:39:28 -0500
Received: from mail110-am1 (localhost [127.0.0.1])	by
 mail110-am1-R.bigfish.com (Postfix) with ESMTP id DBD46E0222	for
 <ceph-devel@vger.kernel.org>; Sun,  4 Nov 2012 13:38:20 +0000 (UTC)
Received: from AM1EHSMHS016.bigfish.com (unknown [10.3.201.239])	by
 mail110-am1.bigfish.com (Postfix) with ESMTP id 3EF95C00CB	for
 <ceph-devel@vger.kernel.org>; Sun,  4 Nov 2012 13:38:18 +0000 (UTC)
In-Reply-To: <CAC-hyiHke+pw17Xrf04nK95hQqUDRwDX_M2UzzxpbUfMsOSnTA@mail.gmail.com>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Does it mean that we should destroy those pool and recreate them with h=
igher pgnum ?

--=20
Yann

-----Message d'origine-----
De=A0: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.k=
ernel.org] De la part de Yehuda Sadeh
Envoy=E9=A0: vendredi 2 novembre 2012 20:20
=C0=A0: Sylvain Munaut
Cc=A0: ceph-devel@vger.kernel.org
Objet=A0: Re: RGW: Pools .rgw .rgw.control .users.uid .users.email .use=
rs

On Fri, Nov 2, 2012 at 8:20 AM, Sylvain Munaut <s.munaut@whatever-compa=
ny.com> wrote:
> Hi,
>
> I've just started RGW and it created some pools automatically :
> .rgw .rgw.control .users.uid .users.email .users
>
> But when looking at them, they used PG_NUM=3D8 which is a bit low.
> Now, I noticed it and created .rgw.buckets myself with an appropriate=
=20
> PG_NUM, I assume it will work or is there some special setup done by=20
> rgw beside just creating the pool ?

No. Just creating them.

>
> Also, I assume those pools will actually be pretty small and so I can=
=20
> just leave them with PG_NUM=3D8 without much issue ?
>

Data will not be distributed evenly across the cluster, and there may b=
e a high contention on these pgs so it'd affect performance.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
