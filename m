From: Lenz Grimmer <lenz@grimmer.com>
Subject: Re: Ceph Manager brag module
Date: Thu, 14 Dec 2017 12:44:39 +0100
Message-ID: <c55c2c37-22cc-543a-5950-b48add10bbb7@grimmer.com>
References: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Jls7lKPm442EJdVxmNUgPQ3k0O4ekGT1h"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:53898 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752247AbdLNLos (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 14 Dec 2017 06:44:48 -0500
In-Reply-To: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: lvaz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jls7lKPm442EJdVxmNUgPQ3k0O4ekGT1h
Content-Type: multipart/mixed; boundary="T5iD6RTw5Dkx2kKpBdedg5cRbgwgKWOX9";
 protected-headers="v1"
From: Lenz Grimmer <lenz@grimmer.com>
To: ceph-devel@vger.kernel.org
Cc: lvaz@redhat.com
Message-ID: <c55c2c37-22cc-543a-5950-b48add10bbb7@grimmer.com>
Subject: Re: Ceph Manager brag module
References: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
In-Reply-To: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>

--T5iD6RTw5Dkx2kKpBdedg5cRbgwgKWOX9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hey Wido,

On 12/14/2017 10:24 AM, Wido den Hollander wrote:

> After discussing with Sage I started to work [0] on a 'brag' module for=

> Ceph Manager.

Nice!

> The intention of this module is to send (after a opt-in!) statistics
> about a Ceph cluster back to the project every few days.
>=20
> My intention is to include:
>=20
> - fsid (as identifier)
> - number of MONs
> - number of OSDs
> - FileStore / BlueStore
> - number of pools / PGs
> - data used in bytes
> - data free
> - number of objects,
> - version(s)

Not sure if that could actually be extracted, but how about "Services
enabled", e.g. "RGW", "CephFS" or "RBD", with some additional insight
(e.g. how many RBDs/buckets)?

I think it would be valuable to obtain some (optional) insight into what
that cluster is actually used for.

> A admin can also say that the report is allowed to be 'public' where yo=
u
> can then visit (for example) https://brag.ceph.com/public/<fsid> and
> show off your Ceph cluster.
>=20
> You could then add a description and we could compile top lists about
> Ceph systems.
>=20
> How do people think about this? Would this be interesting?

Absolutely. One challenge I can see here (in addition to users actually
enabling it) is networking - I'd assume that many customers have
restricted their networks, so the MGR cannot easily establish an
outgoing connection without going through a proxy or before the admin
has poked a hole into the firewall. This might require configuration
options or corresponding documentation.

> I would try to convince most of my customers to send this information
> back to the project. The more information we get, the better Ceph can
> become.
>=20
> Wido
>=20
> [0]: https://github.com/wido/ceph/commits/mgr-brag

Nice work!

Lenz


--T5iD6RTw5Dkx2kKpBdedg5cRbgwgKWOX9--

--Jls7lKPm442EJdVxmNUgPQ3k0O4ekGT1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iG8EARECAC8WIQRwnM6QdoQNrjll2jdJUOEqsnKR8gUCWjJkKBEcbGVuekBncmlt
bWVyLmNvbQAKCRBJUOEqsnKR8og0AJ9MjI/51X7PG+Y2qaQQ5WkYkjcCZACfdcVR
1CRU2+2/97domQiEYi5fy5Q=
=1jwI
-----END PGP SIGNATURE-----

--Jls7lKPm442EJdVxmNUgPQ3k0O4ekGT1h--
