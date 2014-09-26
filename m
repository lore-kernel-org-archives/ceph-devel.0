From: Loic Dachary <loic@dachary.org>
Subject: Re: Weekly performance meeting
Date: Fri, 26 Sep 2014 09:25:18 +0200
Message-ID: <542514DE.6070807@dachary.org>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="s4332EU0dwMxdqKwrwotOUHuMxD9TUd68"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60421 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753683AbaIZHZY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Sep 2014 03:25:24 -0400
In-Reply-To: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, "Zhang, Jian" <jian.zhang@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s4332EU0dwMxdqKwrwotOUHuMxD9TUd68
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I added a section to http://pad.ceph.com/p/performance_weekly about the c=
urrent efforts to optimize/benchmark erasure code plugins. @Zhang, Jian :=
 the ISA erasure code plugin Andreas Peters worked on is not mentioned be=
cause it does not need any optimization, as far as I can tell ;-)

Cheers

On 25/09/2014 20:27, Sage Weil wrote:
> Hi everyone,
>=20
> A number of people have approached me about how to get more involved wi=
th=20
> the current work on improving performance and how to better coordinate =

> with other interested parties.  A few meetings have taken place offline=
=20
> with good results but only a few interested parties were involved.
>=20
> Ideally, we'd like to move as much of this dicussion into the public=20
> forums: ceph-devel@vger.kernel.org and #ceph-devel.  That isn't always =

> sufficient, however.  I'd like to also set up a regular weekly meeting =

> using google hangouts or bluejeans so that all interested parties can=20
> share progress.  There are a lot of things we can do during the Hammer =

> cycle to improve things but it will require some coordination of effort=
=2E
>=20
> Among other things, we can discuss:
>=20
>  - observed performance limitations
>  - high level strategies for addressing them
>  - proposed patch sets and their performance impact
>  - anything else that will move us forward
>=20
> One challenge is timezones: there are developers in the US, China, Euro=
pe,=20
> and Israel who may want to join.  As a starting point, how about next=20
> Wednesday, 15:00 UTC?  If I didn't do my tz math wrong, that's
>=20
>   8:00 (PDT, California)
>  15:00 (UTC)
>  18:00 (IDT, Israel)
>  23:00 (CST, China)
>=20
> That is surely not the ideal time for everyone but it can hopefully be =
a=20
> starting point.
>=20
> I've also created an etherpad for collecting discussion/agenda items at=

>=20
> 	http://pad.ceph.com/p/performance_weekly
>=20
> Is there interest here?  Please let everyone know if you are actively=20
> working in this area and/or would like to join, and update the pad abov=
e=20
> with the topics you would like to discuss.
>=20
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--s4332EU0dwMxdqKwrwotOUHuMxD9TUd68
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQlFN4ACgkQ8dLMyEl6F20uZgCfZRabB61io8IZ7sdQ693EsLtm
WOcAoJS0TbUPqDr5i9E4/XL05uZv0NUS
=F5ax
-----END PGP SIGNATURE-----

--s4332EU0dwMxdqKwrwotOUHuMxD9TUd68--
