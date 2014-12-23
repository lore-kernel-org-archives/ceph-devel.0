From: Loic Dachary <loic@dachary.org>
Subject: RFC: new rados whereis command
Date: Tue, 23 Dec 2014 23:22:52 +0100
Message-ID: <5499EB3C.2040602@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qgASrmcSVUl4Dd4FVp5NJosBOTBPmjDH9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57507 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751022AbaLWWWy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Dec 2014 17:22:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qgASrmcSVUl4Dd4FVp5NJosBOTBPmjDH9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

I took a closer look at https://github.com/ceph/ceph/pull/2730 implementi=
ng rados whereis [--dns] and I think it deserves a discussion here. If I =
understand correctly, it relies on a new function of the rados API:

  typedef struct whereis {
    int64_t osd_id;                              //< ID of the OSD hostin=
g this object
    std::string osd_state;                       //< state of the OSD - e=
ither 'active' or 'inactive'
    int64_t pg_seed;                             //< Seed of the PG hosti=
ng this object
    std::string ip_string;                       //< Ip as string
    std::vector<std::string> host_names;         //< optional reverse DNS=
 HostNames
    std::map<std::string, std::string> user_map; //< optional user KV map=

    void resolve();                              //< reverse DNS OSD IPs =
and store in HostNames
  } whereis_t;

  static int whereis(IoCtx &ioctx, const std::string &oid, std::vector<wh=
ereis_t> &locations);

which needs to be added there because the rados API does not expose some =
details that are needed to fill the fields of the whereis_t structure.

It looks fine to me but ... I'm not used to maintaining or developing the=
 rados API and someone else may have a more informed opinion.

There is a technical detail that also needs to be sorted out : the curren=
t implementation exposes the RadosWhereis class (for dump) and this shoul=
d either be moved to rados.cc or be part of the rados API (which probably=
 is not the best option because it would also expose Formatter as a conse=
quence).

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--qgASrmcSVUl4Dd4FVp5NJosBOTBPmjDH9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSZ6zwACgkQ8dLMyEl6F21PfwCeJGPUzQYrYQ3/YHurFE/iguaO
SJ4AnimPkTlH51nTQ3TIWPHY6yNpOFZP
=9ei0
-----END PGP SIGNATURE-----

--qgASrmcSVUl4Dd4FVp5NJosBOTBPmjDH9--
