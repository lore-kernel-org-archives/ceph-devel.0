From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology consumability
Date: Thu, 07 Nov 2013 23:28:16 +0800
Message-ID: <527BB190.2010302@dachary.org>
References: <alpine.DEB.2.00.1311070711080.17943@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RFc7XHtNXjNedsD2CvAhQhgJD3N2jjOI1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58846 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab3KGP2X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 10:28:23 -0500
In-Reply-To: <alpine.DEB.2.00.1311070711080.17943@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org
Cc: hugh.saunders@rackspace.co.uk

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RFc7XHtNXjNedsD2CvAhQhgJD3N2jjOI1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hi Sage,

On 07/11/2013 23:21, Sage Weil wrote:
> Hey all,
>=20
> I've had a couple different conversations with week with organizations =

> that want to ramp up their ceph development efforts, as a big piece of =

> that, spin up their own teuthology environments.  There has been a lot =

> going on here, and I haven't been on the weekly calls, but I suspect=20
> things that will help them move forward include:
>=20
> - documenting a teuthology install-from-scratch.  this would include=20
> setting up the databases, lock server, workers, etc., and will initiall=
y=20
> be long and ugly but will hopefully shrink over time.
>=20
> - adding support for euca2ools or some other cloud client that does=20
> openstack and ec2 for creating/destroying test machines.  hopefully mos=
t=20
> of the integration points are mapped out from the downburst integration=
=20
> work.
>=20

I'm including Hugh Saunders on this thread : we discussed this topic duri=
ng the OpenStack summit this week in relation to the associated ticket:

http://tracker.ceph.com/issues/6502

> - ongoing work to collapse the locking and queuing and reporting into a=
=20
> unified and/or cohesive service.

It looks like it could be associated with http://wiki.ceph.com/01Planning=
/02Blueprints/Firefly/Ceph-Brag for performance related tasks. Does that =
sound sensible ? I'm midly drunk tonight and possibly writing nonsense ;-=
)

Cheers

>=20
> I'm probably missing things and/or vastly oversimplifying, but hopefull=
y=20
> others can chime in an improve this list.  I think the better roadmap w=
e=20
> have here, the easier it will be for new people to come online and focu=
s=20
> their efforts where they will make the most difference.
>=20
> Of course the upcomign CDS is a good place to discuss this, but somethi=
ng=20
> should be written down first to guide/frame that discussion.
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--RFc7XHtNXjNedsD2CvAhQhgJD3N2jjOI1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJ7sZAACgkQ8dLMyEl6F21l2QCfZh/BVaMDYb5HRovP48sA0Li3
PCAAnRQDKeZ4dNZp+95Fw8l79GwVeYNk
=zn+0
-----END PGP SIGNATURE-----

--RFc7XHtNXjNedsD2CvAhQhgJD3N2jjOI1--
