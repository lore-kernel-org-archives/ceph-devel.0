From: Loic Dachary <loic@dachary.org>
Subject: Re: Storing cls and erasure code plugins in a pool
Date: Sun, 07 Sep 2014 18:13:20 +0200
Message-ID: <540C8420.7020103@dachary.org>
References: <540C169C.9030603@dachary.org> <CANP1eJG=5bDx3JeFNfUgfq7TCS7QvKnAsXD+=XzcJK2vm-Uyxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tnp5U1DWbe93UdLLbhK8mI6BT21X5UT2U"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46791 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752538AbaIGQN1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Sep 2014 12:13:27 -0400
In-Reply-To: <CANP1eJG=5bDx3JeFNfUgfq7TCS7QvKnAsXD+=XzcJK2vm-Uyxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tnp5U1DWbe93UdLLbhK8mI6BT21X5UT2U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 07/09/2014 15:38, Milosz Tanski wrote:
> If you're planning on having plugins that are not shipped with the
> host software you have to worry about both API and ABI stability.
> Traditionally (and in my personal experience) keeping a C++ ABI
> compatible is hard. For those reasons, I would strongly campaign for
> having the plugins interface be in C (or et least their interface
> would be C linkage).

Hi Milosz,

That's a good point indeed.

> Otherwise here's some things you can read read about C++ ABI stability
> (from the KDE people):
> https://techbase.kde.org/Policies/Binary_Compatibility_Issues_With_C++

Thanks, I did not even think C++ ABI compatibility was possible at all ;-=
) The web site is down at the moment but I'll take a look.

Cheers

>=20
> This are my 2 cents based on my past experience.
>=20
> On Sun, Sep 7, 2014 at 4:26 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Ceph,
>>
>> There is a need for a cluster to share code such as cls https://github=
=2Ecom/ceph/ceph/tree/master/src/cls or erasure code plugins https://gith=
ub.com/ceph/ceph/tree/master/src/erasure-code/.
>>
>> These plugins could have a life cycle independent of Ceph, as long as =
they comply to the supported API ( https://github.com/ceph/ceph/blob/mast=
er/src/erasure-code/ErasureCodeInterface.h ). For erasure code plugins it=
 currently works this way (or it will as soon as https://github.com/ceph/=
ceph/pull/2397 is merged):
>>
>> a) upgrade from Hammer to I* half the OSD nodes. The new I* have new e=
rasure code plugins
>> b) the MON will refuse to create an erasure coded pool using the new I=
* plugins, otherwise the Hammer nodes will find themselves unable to part=
icipate in the pool
>>
>> Instead it could work this way:
>>
>> a) upgrade from Hammer to I* half the OSD nodes. The new I* have new e=
rasure code plugins
>> b) the new erasure code plugins are uploaded to a "plugins" pool
>> c) an erasure coded pool is created using a new plugin from I*
>> d) the Hammer OSD downloads the plugin from the pool and can participa=
te in the pool
>>
>> It is easier said than done and there are a lot of details to consider=
=2E However it not different from maintaining an Operating System that in=
cludes shared libraries and the path to do so properly is well known.
>>
>> Thoughts ?
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--tnp5U1DWbe93UdLLbhK8mI6BT21X5UT2U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQMhCAACgkQ8dLMyEl6F23DTwCgpBA7uZM8x+w4fxhZxiIdVbhe
K1sAn0ylkzF0fqvaI4mdHDYke5nl3Ra1
=emIl
-----END PGP SIGNATURE-----

--tnp5U1DWbe93UdLLbhK8mI6BT21X5UT2U--
