From: Loic Dachary <loic@dachary.org>
Subject: Re: ARM benchmarks for the erasure code plugin
Date: Fri, 27 Jun 2014 19:34:59 +0200
Message-ID: <53ADAB43.6050702@dachary.org>
References: <53ADA5EC.5030302@dachary.org> <alpine.DEB.2.00.1406271016080.12946@cobra.newdream.net> <53ADA87F.8080808@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9OifSQHjVJAql4M2rqCwPre01a8Jf8tK4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58815 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751953AbaF0RfG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jun 2014 13:35:06 -0400
In-Reply-To: <53ADA87F.8080808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sandon Van Ness <sandon@inktank.com>, Sage Weil <sage@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9OifSQHjVJAql4M2rqCwPre01a8Jf8tK4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Works ! Thanks :-)

$ ./virtualenv/bin/teuthology-lock --lock-many 1 --machine-type saya --ow=
ner loic@dachary.org
=2E..

processor	: 3
model name	: ARMv7 Processor rev 0 (v7l)
BogoMIPS	: 2793.47
Features	: swp half thumb fastmult vfp edsp neon vfpv3 tls vfpd32
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x3
CPU part	: 0xc09
CPU revision	: 0

Hardware	: Highbank
Revision	: 0000
Serial		: 0000000000000000
ubuntu@saya001:~$

On 27/06/2014 19:23, Sandon Van Ness wrote:
> Yeah, they should be up and available as we are not testing them anymor=
e. They do have issues where they randomly went down before and if any of=
 them are down feel free to to hit me up and I can get them fixed up.
>=20
> says37->saya44 are the newer machines that have the faster CPU's and mo=
re ram and stuff (newer arch).
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

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--9OifSQHjVJAql4M2rqCwPre01a8Jf8tK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOtq0MACgkQ8dLMyEl6F23ZkACgpZH63B9dPb07ImRRWbdNEJxx
TUYAn0OvvoxoeqFpKFDn1lypM4ImTTFX
=aHXA
-----END PGP SIGNATURE-----

--9OifSQHjVJAql4M2rqCwPre01a8Jf8tK4--
