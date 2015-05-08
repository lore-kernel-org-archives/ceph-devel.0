From: Loic Dachary <loic@dachary.org>
Subject: Re: Nightlies and dumpling
Date: Sat, 09 May 2015 00:04:00 +0200
Message-ID: <554D32D0.1090608@dachary.org>
References: <554D2081.7040503@dachary.org> <CAC6JEv-sa-aMqLtMxvqv=au6jDRnDEy4VeNkY6phRRLb-adYAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="W2VxuNFqm2Q9JoXIVw5Nj1Eqr10PE64v4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60195 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752981AbbEHWEV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 18:04:21 -0400
In-Reply-To: <CAC6JEv-sa-aMqLtMxvqv=au6jDRnDEy4VeNkY6phRRLb-adYAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alistair Israel <aisrael@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W2VxuNFqm2Q9JoXIVw5Nj1Eqr10PE64v4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/05/2015 22:49, Gregory Farnum wrote:
> On Fri, May 8, 2015 at 1:45 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi,
>>
>> I was going through the checklist to retire a release, to verify nothi=
ng was left behind for Dumpling
>>
>>    http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_retire_a_=
stable_release
>>
>> and from the nightlies crontab that you published, I found
>>
>> http://tracker.ceph.com/projects/ceph-releases/wiki/Typica
>>
>> 10 18 * * 0,4 teuthology-suite -v -c giant -k distro -m typica -s upgr=
ade/dumpling-firefly-x --filter ubuntu_
>>
>> and
>>
>> http://tracker.ceph.com/projects/ceph-releases/wiki/Sepia
>>
>> 10 17 * * 2,4,7 teuthology-suite -v -c next -k distro -m plana,burnupi=
,mira -s upgrade/dumpling-firefly-x --filter ubuntu_
>>
>> 13 19 * * 7 teuthology-suite -v -c firefly -k distro -m vps -s upgrade=
/dumpling-x ~/vps.yaml
>>
>> 15 18 * * 3,6 teuthology-suite -v -c giant -k distro -m vps -s upgrade=
/dumpling-firefly-x ~/vps.yaml
>=20
> You'll notice that these are all tests which upgrade from dumpling to
> something else. We want to keep testing that to make sure we aren't
> missing something in the upgrade paths =E2=80=94 which would be bad, ev=
en
> though we're about ready to stop supporting dumpling. ;)

Indeed :-) Say a problem is found, how is it going to be resolved ?

> -Greg
>=20
>>
>>
>> You can also remove from Sepia the lines commented out:
>>
>> #removed the line below b/c the suite 'upgrade/dumpling-firefly-x' on =
vps runs out of memory on hammer, YuriW 3/29/15
>> #15 17 * * 1,3 teuthology-suite -v -c hammer -k distro -m vps -s upgra=
de/dumpling-firefly-x --suite-branch hammer ~/vps.yaml
>>
>> #removed the line below b/c the suite 'upgrade/dumpling-firefly-x' on =
vps runs out of memory on next, YuriW 3/29/15
>> #15 17 * * 0,2,4,6 teuthology-suite -v -c next -k distro -m vps -s upg=
rade/dumpling-firefly-x --suite-branch hammer ~/vps.yaml
>>
>> Maybe there is a reason for scheduling them, even though Dumpling is r=
etired. But in case it was just overlooked, maybe you can save some compu=
ting power in the labs :-0
>>
>> Cheers
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--W2VxuNFqm2Q9JoXIVw5Nj1Eqr10PE64v4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVNMtAACgkQ8dLMyEl6F22XHQCfXhQuuNlUcaILDONb3rJx2fgR
+yoAn2sk94RZmIJWGiXmUpPPiDSJyPjL
=4UFX
-----END PGP SIGNATURE-----

--W2VxuNFqm2Q9JoXIVw5Nj1Eqr10PE64v4--
