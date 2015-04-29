From: Loic Dachary <loic@dachary.org>
Subject: Re: Firefly integration branch : OK
Date: Thu, 30 Apr 2015 00:35:42 +0200
Message-ID: <55415CBE.5050009@dachary.org>
References: <553DEDD3.2030202@dachary.org> <55415B8D.9050309@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2xnNKb3QXVKJKKLmfX8oBEGint4encirf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54855 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751252AbbD2Wfq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Apr 2015 18:35:46 -0400
In-Reply-To: <55415B8D.9050309@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2xnNKb3QXVKJKKLmfX8oBEGint4encirf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi again,

Sam reviewed the three backports you did and approved. They have been mer=
ged and the integration branch is now merged in firefly entirely.

git log --no-merges --oneline ceph/firefly..ceph/firefly-backports
(shows nothing)

We can begin another round of testing as soon as you have prepared the ne=
xt firefly-backports branch. Just let me know and I'll push it to the git=
builders on your behalf.

Cheers

On 30/04/2015 00:30, Loic Dachary wrote:
> Hi,
>=20
> I took the liberty of ping'ing Sam on IRC a few minutes ago on your beh=
alf (he is the original author of the three backports you did). He just g=
ot back from India, I could not miss the opportunity ;-)
>=20
> Cheers
>=20
> On 27/04/2015 10:05, Loic Dachary wrote:
>> Hi,
>>
>> I saw this morning the firefly integration branch passed rados and rbd=
 suites :-)=20
>>
>> http://tracker.ceph.com/issues/11090#rados
>> http://tracker.ceph.com/issues/11090#rbd
>>
>> The issue has been updated accordingly. It means the following pull re=
quests passed:
>>
>> $ git log --merges --oneline 12143ff9b25fdd96f8d1a9cecb1329c7f354d414.=
=2Eb91bbb434e6363a99a632cf3841f70f1f2549f79
>> b91bbb4 Merge 4245: librbd: snap_remove should ignore -ENOENT errors
>> 6245bed Merge 4206: librbd: acquire cache_lock before refreshing paren=
t
>> ef08aa9 Merge 4185: FAILED assert(soid < scrubber.start || soid >=3D s=
crubber.end)
>> ae1b18a Merge 3963: Rados.shutdown() dies with Illegal instruction (co=
re dumped)
>> 056db0f Merge 4385: osd: ENOENT on clone
>> e4b1fd1 Merge 4384: pg stuck stale after create with activation delay
>> 597124b Merge 4383: erasure-code-profile set races with erasure-code-p=
rofile rm
>> b7bbd43 Merge 4382: osd/PGLog.h: 279: FAILED assert(log.log.size() =3D=
=3D log_keys_debug.size())
>>
>> Ouf ot these, three are backports ready to be reviewed by their origin=
al authors:
>>
>> 056db0f Merge 4385: osd: ENOENT on clone https://github.com/ceph/ceph/=
pull/4385
>> e4b1fd1 Merge 4384: pg stuck stale after create with activation delay =
https://github.com/ceph/ceph/pull/4384
>> b7bbd43 Merge 4382: osd/PGLog.h: 279: FAILED assert(log.log.size() =3D=
=3D log_keys_debug.size())
>>
>> The simplest way would be to ask for their review with a comment in th=
e pull request, with a reference to the test suite results so they know i=
t passed the suites. Will you have time to do this today ? If you don't h=
ave time, just let me know and I'll do it for you.
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--2xnNKb3QXVKJKKLmfX8oBEGint4encirf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVBXL4ACgkQ8dLMyEl6F22gjwCgrwlRWr/iT03jJl0m0e8MOuZ+
O4wAoLmcGFJXnUNm+X72W2Sk30ssQMGi
=+RwV
-----END PGP SIGNATURE-----

--2xnNKb3QXVKJKKLmfX8oBEGint4encirf--
