From: Loic Dachary <loic@dachary.org>
Subject: Re: Proposal for a Backport tracker
Date: Fri, 22 May 2015 12:45:16 +0200
Message-ID: <555F08BC.7040106@dachary.org>
References: <555DC080.8050508@dachary.org> <555ED569.2090604@suse.cz> <555ED98F.8020402@dachary.org> <555EE989.5070009@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tkunMtXp4mgwxuEURKhLkFrSxfkNFAaO2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49108 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751688AbbEVKpV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 06:45:21 -0400
In-Reply-To: <555EE989.5070009@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tkunMtXp4mgwxuEURKhLkFrSxfkNFAaO2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/05/2015 10:32, Nathan Cutler wrote:>> We can probably keep the orig=
inal ticket in the "Pending Backport" status until all backports are reso=
lved, as we currently do.
>>
>>> So the question is, what will the original ticket's status be changed=
 to? Resolved?
>>
>> When all backports are resolved, then we can also resolve the original=
 ticket. Do you forsee a problem with that ?
>>
>=20
> Yes and no. It's a scripting problem, not a workflow problem. I'll try =
to describe the scenario I'm envisioning:
>=20
> We have a simple script that loops over all tickets with status "Pendin=
g Backport". We run it once per week. The first week we run it, the scrip=
t finds 3 such tickets. For each one it creates a ticket in the Backport =
tracker.
>=20
> A week goes by, during which developers marked 4 more tickets "Pending =
Backport". It's time to run the script again. Since it is looping over al=
l tickets marked "Pending Backport", it now finds 7 such tickets: 3 from =
last week and the 4 new ones. For each one it dutifully creates a new tic=
ket in the Backport tracker. Now we have duplicate Backport tickets for 3=
 bugfixes.
>=20
> But I guess it will be trivial to make the script check if a Backport t=
icket is already open and refrain from opening a new one in this case.

Yes, by investigating the "Related issues" and finding those that belong =
to the Backport tracker, we should be able to do that.

>=20
> The same script could also check further: if Backport tickets already e=
xist for the bugfix and all of them are marked Resolved, then automatical=
ly mark the original ticket Resolved as well.

Absolutely :-)

>=20
> Nathan

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--tkunMtXp4mgwxuEURKhLkFrSxfkNFAaO2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVfCLwACgkQ8dLMyEl6F203QACffV+uG6fVbs8PF+D2WKXwNcOZ
oqQAn0MG43sX4Qs3qr3cHJd9VGUIMOdM
=OtOa
-----END PGP SIGNATURE-----

--tkunMtXp4mgwxuEURKhLkFrSxfkNFAaO2--
