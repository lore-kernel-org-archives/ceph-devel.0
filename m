From: Loic Dachary <loic@dachary.org>
Subject: Re: testing the teuthology OpenStack backend
Date: Wed, 19 Aug 2015 12:23:41 +0200
Message-ID: <55D4592D.9060704@dachary.org>
References: <55C377B3.7050500@dachary.org> <55C6108C.7010803@ubuntukylin.com> <55C61F0C.3000903@dachary.org> <55D44D1A.10607@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IRU0rJvFDdqi6w9TqgXVsx1d5QKMW3jLu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40452 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750855AbbHSKXv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 06:23:51 -0400
In-Reply-To: <55D44D1A.10607@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IRU0rJvFDdqi6w9TqgXVsx1d5QKMW3jLu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

[cc'ing the ceph-devel list for Zack or Andrew's input]

On 19/08/2015 11:32, Li Wang wrote:
> Hi Loic,
>   we did a test, the results are attached. We found that the
> network may be the bottleneck, it seems it will fetch all
> the packages from ceph website on the fly, that does take time
> and cause many failed jobs, and there are also many dead
> jobs, what do those mean? Do you have some suggestions,
> if possible to enable it fetch the packages from configurable
> mirror or even private package repositories?

You can ssh to the teuthology instance (the host that runs pulpito) and m=
odify the ~/.teuthology.yaml with

   gitbuilder_host: gitbuilder.ubuntukylin.com

which will override the default of=20

   gitbuilder_host: gitbuilder.ceph.com

I've never done that however and maybe Zack or Andrew have advices on how=
 to establish a mirror properly.

I think having a private package repository that is useable by teuthology=
 is complicated because the package locations, naming conventions and bui=
ld methods are difficult to reproduce (and I don't fully understand what =
they are right now).

Cheers

>=20
> Cheers,
> Li Wang
>=20
> On 2015/8/8 23:23, Loic Dachary wrote:
>>
>>
>> On 08/08/2015 16:22, Li Wang wrote:
>>> Hi Loic,
>>>    Glad to talk with you on IRC about setting up
>>> the teuthology OpenStack backend. Once it is ready
>>> to run the test in private cloud, and the results
>>> could be exported and uploaded to a public place,
>>> please let me know asap :)
>>
>> I'm working on it, should be ready RSN.
>>
>>>
>>> Cheers,
>>> Li Wang
>>>
>>>
>>> On 2015/8/6 23:05, Loic Dachary wrote:
>>>> Hi,
>>>>
>>>> I'm looking into testing the OpenStack backend for teuthology on a n=
ew cluster to verify it's portable. I think it is but ... ;-) I'm told yo=
u have an OpenStack cluster and would be interested in running teuthology=
 workloads on it. Does it have a public facing API ?
>>>>
>>>> Cheers
>>>>
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--IRU0rJvFDdqi6w9TqgXVsx1d5QKMW3jLu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXUWS0ACgkQ8dLMyEl6F239bwCffxxVh+qArn1DJxrrWZqvoKLW
3tQAnAnspSmWu+0IT+AyqvrjdtVK4XA3
=6xl0
-----END PGP SIGNATURE-----

--IRU0rJvFDdqi6w9TqgXVsx1d5QKMW3jLu--
