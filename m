From: Loic Dachary <loic@dachary.org>
Subject: Re: Call for participants : teuthology weekly meeting
Date: Tue, 13 Aug 2013 14:56:46 +0200
Message-ID: <520A2D0E.9060709@dachary.org>
References: <52028301.70301@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig85AB7F5A1CCB137565F8411E"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:55340 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757989Ab3HMM4t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 08:56:49 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 7358F26394
	for <ceph-devel@vger.kernel.org>; Tue, 13 Aug 2013 14:56:47 +0200 (CEST)
In-Reply-To: <52028301.70301@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85AB7F5A1CCB137565F8411E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Teuthology was successfully installed & run as described here:

http://dachary.org/?p=3D2204

with only two minor glitches:

"teuthology : ulimit: error" http://thread.gmane.org/gmane.comp.file-syst=
ems.ceph.devel/16421
"do not check the jobid if check-locks is False" https://github.com/ceph/=
teuthology/pull/27

Cheers

On 07/08/2013 19:25, Loic Dachary wrote:
> Hi Ceph,
>=20
> During the Emperor summit this week, running and installing teuthology =
with a minimum effort was discussed ( see http://youtu.be/hrQuYzyXvVg?t=3D=
1h21m49s and http://pad.ceph.com/p/cds-teuthology ) I've installed it onc=
e, back in January 2013 and that was not too difficult but required a few=
 hours and exchanging a few mails. More importantly, I soon discovered th=
at the Inktank developers are modifying teuthology quite often and don't =
really have the bandwidth to make sure any third party can install or upg=
rade. It is still very much a tool internal to inktank.
>=20
> There are a number of Ceph developers who, like me, would like to be ab=
le to run teuthology on their own machines. But none of us has the time t=
o make that happen on his / her own. However, if we get together, we may =
be able to do it. The trick is to keep up with Inktank changes and we may=
 have found a way : meet online with the Inktank's teuthology developers =
on a weekly basis to bridge the gap. That would not be forever : just unt=
il there are enough teuthology users and Inktank is just one of them.
>=20
> Of course that will require some work on our part ( non Inktank employe=
es ) but the overall benefit of running integration tests is worth it. At=
 least it's enough incentive for me to dedicate at least 4 hours on a wee=
kly basis.=20
>=20
> This is an open discussion, nothing is set except the commitment of Ink=
tank to participate in these meetings and my own commitment of at least 4=
 hours / week i.e. half a day doing just this. Including the meeting  ;-)=

>=20
> Who's willing to join this effort ? Do you think there is a better way =
?
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig85AB7F5A1CCB137565F8411E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIKLQ4ACgkQ8dLMyEl6F23engCfQYyomkbk8vmUDDkW/Hfk0bUk
a9cAn0QDKRnzyzpkn9Q4mIFN5ijJxnNI
=aRsS
-----END PGP SIGNATURE-----

--------------enig85AB7F5A1CCB137565F8411E--
