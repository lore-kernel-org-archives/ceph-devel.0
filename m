From: Loic Dachary <loic@dachary.org>
Subject: Re: testing the teuthology OpenStack backend
Date: Mon, 10 Aug 2015 15:09:40 +0200
Message-ID: <55C8A294.9050405@dachary.org>
References: <55C377B3.7050500@dachary.org> <55C6108C.7010803@ubuntukylin.com> <55C61F0C.3000903@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EjhidwPVkxnf07gh5Iks5skaLCcEWsiei"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35915 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751117AbbHJNJm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Aug 2015 09:09:42 -0400
In-Reply-To: <55C61F0C.3000903@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EjhidwPVkxnf07gh5Iks5skaLCcEWsiei
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

You should be able to follow the instructions at

   https://github.com/dachary/teuthology/tree/wip-6502-v3-dragonfly#opens=
tack-backend

on your OpenStack cluster. I expect it to be portable accross OpenStack i=
mplemenations back to Havana. Please let me know if your OpenStack cluste=
r has a non standard behavior and we will figure out a workaround. By usi=
ng (note the --upload flag)

   teuthology-openstack --key-filename myself.pem --key-name myself \
                        --suite dummy --upload --teardown

the results of the teuthology run will be uploaded to=20

    http://integration.ceph.dachary.org/

Cheers

On 08/08/2015 17:23, Loic Dachary wrote:
>=20
>=20
> On 08/08/2015 16:22, Li Wang wrote:
>> Hi Loic,
>>   Glad to talk with you on IRC about setting up
>> the teuthology OpenStack backend. Once it is ready
>> to run the test in private cloud, and the results
>> could be exported and uploaded to a public place,
>> please let me know asap :)
>=20
> I'm working on it, should be ready RSN.
>=20
>>
>> Cheers,
>> Li Wang
>>
>>
>> On 2015/8/6 23:05, Loic Dachary wrote:
>>> Hi,
>>>
>>> I'm looking into testing the OpenStack backend for teuthology on a ne=
w cluster to verify it's portable. I think it is but ... ;-) I'm told you=
 have an OpenStack cluster and would be interested in running teuthology =
workloads on it. Does it have a public facing API ?
>>>
>>> Cheers
>>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--EjhidwPVkxnf07gh5Iks5skaLCcEWsiei
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXIopQACgkQ8dLMyEl6F205XgCgszR2c+ug9aFbnjic31M0MEdE
19kAn0+kQvKYTCHMCmILC+tXeWGGeKjs
=sC5o
-----END PGP SIGNATURE-----

--EjhidwPVkxnf07gh5Iks5skaLCcEWsiei--
