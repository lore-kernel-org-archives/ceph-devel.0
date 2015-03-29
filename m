From: Loic Dachary <loic@dachary.org>
Subject: Re: Status update for the last Giant release 0.87.2
Date: Sun, 29 Mar 2015 11:31:59 +0200
Message-ID: <5517C68F.1020401@dachary.org>
References: <55168C18.9060307@dachary.org> <87y4mg2z4s.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fifpSL6X8pDmkT5DRvorqhvMgnkWlpM7S"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38353 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751012AbbC2JcF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Mar 2015 05:32:05 -0400
In-Reply-To: <87y4mg2z4s.fsf@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fifpSL6X8pDmkT5DRvorqhvMgnkWlpM7S
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


Hi Abhishek,

On 29/03/2015 06:42, Abhishek L wrote:
>=20
> Loic Dachary writes:
>=20
>> Hi Abhishek,
>>
>> Looking at the last two issues marked as needing backport to giant:
>>
>> http://tracker.ceph.com/projects/ceph/issues?query_id=3D68
>>
>> (this link is at the top of http://tracker.ceph.com/projects/ceph-rele=
ases/wiki/HOWTO) I'm not sure what to do about http://tracker.ceph.com/is=
sues/10643. The problem is that it consistently shows up when testing upg=
rades that involve giant. We want to be sure Giant can be upgraded to Ham=
mer, therefore we need to keep testing the upgrades at least for a month =
or two after Hammer is released to catch border cases. I think issue 1064=
3 needs to be fixed and included in 0.87.2 so that we can have clean upgr=
ade tests, otherwise it will mean more work for people watching over the =
upgrade suites (I mean Yuri here ;-). And wif 10643 is included we can sq=
ueeze http://tracker.ceph.com/issues/10153 in as well, I think.
>>
>> Once this is dealt with and you're done with http://tracker.ceph.com/i=
ssues/11259 that you found when running the rgw suite at http://tracker.c=
eph.com/issues/11153#rgw, 0.87.2 should be good, from our point of view (=
the point of view of backporters) and we can move to the "asking approval=
" step of the workflow ( http://tracker.ceph.com/issues/11153#Workflow ).=
=20
>=20
> For this issue, I haven't been able to find out the cause yet, there
> seemed to be only one patch that landed in giant related to quotas,
> however the test seemed to have failed even before that. I've updated
> the tracker with this.

It would be interesting to schedule this test once again to check if it s=
hows up consistently or not (see http://tracker.ceph.com/projects/ceph-re=
leases/wiki/HOWTO_run_integration_and_upgrade_tests#Re-scheduling-failed-=
or-dead-jobs-from-an-existing-suite for information about doing that).

>>
>> What do you think ?
>=20
> Overall sounds good.=20
>=20

Cool :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--fifpSL6X8pDmkT5DRvorqhvMgnkWlpM7S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUXxo8ACgkQ8dLMyEl6F20tSgCfd6Nn0W8lYk+KnNDE1rkmDjGr
/8sAnjB6NtgISxmngtH8qnr0J/U5qjWA
=OSsl
-----END PGP SIGNATURE-----

--fifpSL6X8pDmkT5DRvorqhvMgnkWlpM7S--
