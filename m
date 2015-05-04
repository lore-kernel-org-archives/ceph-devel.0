From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Ceph tag v0.94.1.1 etc.
Date: Mon, 4 May 2015 11:17:57 -0400 (EDT)
Message-ID: <1294313931.8466302.1430752677295.JavaMail.zimbra@redhat.com>
References: <5545F3F3.8030206@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:45054 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbbEDPTC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 11:19:02 -0400
In-Reply-To: <5545F3F3.8030206@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

These are tags on the rhcs-* branches. These branches and tags more-or-=
less indicate what we're shipping Red Hat's "Ceph Storage" product down=
stream, which is basically a fork of 0.80.8 and 0.94.1.

Instead of keeping these branches in an internal repository behind Red =
Hat's firewall I figured I would push them to the public GitHub reposit=
ory instead, since that fits with certain aspects of the way that Inkta=
nk used to build its downstream product. (Re-using the same Jenkins bui=
ld system upstream and downstream).

I don't know how long we'll keep to this model; it's just the one that =
works for the moment. I realize this mixes downstream and upstream in a=
 way that's a bit unconventional.

- Ken

----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Sunday, May 3, 2015 4:09:55 AM
> Subject: Ceph tag v0.94.1.1 etc.
>=20
> Hi,
>=20
> At https://git.ceph.com/?p=3Dceph.git there are tags such as
>=20
> v0.94.1.1
> v0.80.8.1
>=20
> etc.
>=20
> What are they ?
>=20
> Cheers
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
