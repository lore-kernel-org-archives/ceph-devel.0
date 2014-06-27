From: Loic Dachary <loic@dachary.org>
Subject: Re: ARM benchmarks for the erasure code plugin
Date: Fri, 27 Jun 2014 22:34:08 +0200
Message-ID: <53ADD540.3000802@dachary.org>
References: <53ADA5EC.5030302@dachary.org> <alpine.DEB.2.00.1406271016080.12946@cobra.newdream.net> <53ADA87F.8080808@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nS4W3ij6XojIWAacgiK4QOoC4NHmA8XmU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58993 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750831AbaF0UeP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jun 2014 16:34:15 -0400
In-Reply-To: <53ADA87F.8080808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sandon Van Ness <sandon@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nS4W3ij6XojIWAacgiK4QOoC4NHmA8XmU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 27/06/2014 19:23, Sandon Van Ness wrote:
> Yeah, they should be up and available as we are not testing them anymor=
e. They do have issues where they randomly went down before and if any of=
 them are down feel free to to hit me up and I can get them fixed up.
>=20
> says37->saya44 are the newer machines that have the faster CPU's and mo=
re ram and stuff (newer arch).

Thanks for the tip. I'll beg Mark to lend me one ;-)

>=20
> On 06/27/2014 10:16 AM, Sage Weil wrote:
>> The machine types are tala and saya; you should be able to grab one wi=
th
>> teuthology-lock.  Hopefully they are up...
>>
>> sage
>>
>> On Fri, 27 Jun 2014, Loic Dachary wrote:
>>
>>> Hi Sandon,
>>>
>>> Would it be possible to get access to an ARM based machine to run era=
sure code plugins benchmarks ? The idea is to get a baseline similar to w=
hat https://github.com/ceph/ceph/pull/1875 shows and figure out where we =
stand. At this point any ARM processor will do. Eventually we will want t=
o give NEON[1] enabled processors a try but right now we have nothing tak=
e advantage of that ;-)
>>>
>>> Cheers
>>>
>>> [1] http://en.wikipedia.org/wiki/NEON_%28instruction_set%29#NEON
>>>
>>> --=20
>>> Lo?c Dachary, Artisan Logiciel Libre
>>>
>>>
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--nS4W3ij6XojIWAacgiK4QOoC4NHmA8XmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOt1UEACgkQ8dLMyEl6F20ZawCgiRPiIyJdMQ8aIq4URQdOpPbN
x8cAn3P2mDJbQ0HR0QeZsJ6xBqsI7VYe
=wTpJ
-----END PGP SIGNATURE-----

--nS4W3ij6XojIWAacgiK4QOoC4NHmA8XmU--
