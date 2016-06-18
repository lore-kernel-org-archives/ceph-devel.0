From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: using discard from qemu guest when snapshot exist, fill the rbd
 layer with zeroes and use more space
Date: Sat, 18 Jun 2016 09:40:40 +0200 (CEST)
Message-ID: <883325327.16929202.1466235640463.JavaMail.zimbra@oxygem.tv>
References: <1498621012.13671278.1466154654173.JavaMail.zimbra@oxygem.tv> <CA+aFP1A9a5ZEUzsJ_4_dRd_Ok7Ob4yk6PjaQNnrwWQbUmK6V3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:52318 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbcFRHkn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Jun 2016 03:40:43 -0400
In-Reply-To: <CA+aFP1A9a5ZEUzsJ_4_dRd_Ok7Ob4yk6PjaQNnrwWQbUmK6V3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>>There is a "rbd_skip_partial_discard" configuration option which can=20
>>be set to true. When enabled, discard will avoid zeroing holes if the=
=20
>>discard extent is in the middle of an object.=20

Thanks Jason . I had tried it some week ago, and my fstrim was hanging.
It'll do more test next week.

It must be defined on client right ?

[client]
rbd_skip_partial_discard =3D true



----- Mail original -----
De: "Jason Dillaman" <jdillama@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Vendredi 17 Juin 2016 15:21:53
Objet: Re: using discard from qemu guest when snapshot exist, fill the =
rbd layer with zeroes and use more space

There is a "rbd_skip_partial_discard" configuration option which can=20
be set to true. When enabled, discard will avoid zeroing holes if the=20
discard extent is in the middle of an object.=20

On Fri, Jun 17, 2016 at 5:10 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:=20
> Hi,=20
>=20
> I'm using fstrim inside my qemu guests to remove unused space from th=
e rbd storage.=20
>=20
> This is working fine, but I just notice that if a snapshot exist,=20
>=20
> It just do the reverse, it's filling the snasphot with zeroes, and th=
e total cluster space is growing.=20
>=20
> It's is possible to avoid that ?=20
>=20
>=20
> Regards,=20
>=20
> Alexandre=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20
Jason=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
