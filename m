From: Loic Dachary <loic@dachary.org>
Subject: Re: Recommended teuthology upgrade test
Date: Fri, 27 Jun 2014 19:23:57 +0200
Message-ID: <53ADA8AD.7030507@dachary.org>
References: <53AD8AD9.8030809@dachary.org> <CAJBxG-uBrfRUs42Meheo0gEhaH_KquYcjQ8Jwa5AaG2mO6Cx0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9SqsEAmKTXEw1idAiViomGrp7Ml5LS8JV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58800 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751377AbaF0RYF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jun 2014 13:24:05 -0400
In-Reply-To: <CAJBxG-uBrfRUs42Meheo0gEhaH_KquYcjQ8Jwa5AaG2mO6Cx0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9SqsEAmKTXEw1idAiViomGrp7Ml5LS8JV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 27/06/2014 18:17, Yuri Weinstein wrote:
> Loic
>=20
> I don't intent to answer all questions, but some info, see inline
>=20
> On Fri, Jun 27, 2014 at 8:16 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Sam,
>>
>> TL;DR: what oneliner do you recommend to run upgrade tests for https:/=
/github.com/ceph/ceph/pull/1890 ?
>>
>> Running the rados suite can be done with :
>>
>>    ./schedule_suite.sh rados wip-8071 testing loic@dachary.org basic m=
aster plana
>>
>=20
> It was replaced with teuthology-suite, see --help for more info
>=20
>> or something else since ./schedule_suite.sh was recently obsoleted ( h=
ttp://tracker.ceph.com/issues/8678 ). Running something similar for upgra=
de will presumably run all of https://github.com/ceph/ceph-qa-suite/tree/=
master/suites/upgrade
>>
>> Is there a way to run minimal tests by limiting the upgrade suite so t=
hat it only focuses on a firefly cluster that upgrades to https://github.=
com/ceph/ceph/pull/1890 so that it checks the behavior when running a mix=
ed cluster (firefly + master with the change) ?
>=20
> You can run specifying argument with smaller suite, like this:
> dumpling-x/parallel

Hi Yuri,

Thanks for the hint :-) It is documented https://github.com/ceph/teutholo=
gy/commit/7d2388b42c75f4526bc34c6a4b1b16637d967527 but it looks like it s=
hould be more generic because any level of subdirectories can be used.

Cheers

>=20
>>
>> It looks like http://pulpito.ceph.com/?suite=3Dupgrade was never run (=
 at least that's what appears to cause http://tracker.ceph.com/issues/868=
1 ) Is http://pulpito.ceph.com/?suite=3Dupgrade-rados a good fit ? If so =
is there a way to figure out how it was created ?
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--9SqsEAmKTXEw1idAiViomGrp7Ml5LS8JV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOtqK0ACgkQ8dLMyEl6F23/BgCfaefyw0uqXSG20L9aVhuQNa3W
Ar4An3JZYcnZIk8vtK2rjNYAki5rdHFW
=TSqJ
-----END PGP SIGNATURE-----

--9SqsEAmKTXEw1idAiViomGrp7Ml5LS8JV--
