From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph backfilling explained ( maybe )
Date: Sat, 25 May 2013 19:37:29 +0200
Message-ID: <51A0F6D9.8080905@dachary.org>
References: <51A0A6B2.9060105@dachary.org> <20130525123315.GA13595@apia.perrit.net> <51A0CA44.5000609@dachary.org> <20130525144818.GC32615@apia.perrit.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig259B37FFC4020B0201F6F8C2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:32997 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757390Ab3EYRhd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 May 2013 13:37:33 -0400
In-Reply-To: <20130525144818.GC32615@apia.perrit.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: leen@consolejunkie.net
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig259B37FFC4020B0201F6F8C2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 05/25/2013 04:48 PM, Leen Besselink wrote:
> On Sat, May 25, 2013 at 04:27:16PM +0200, Loic Dachary wrote:
>>
>>
>> On 05/25/2013 02:33 PM, Leen Besselink wrote:
>> Hi Leen,
>>
>>> - a Cehp object can store keys/values, not just data
>>
>> I did not know that. Could you explain or give me the URL ?
>>
>=20
> Well, I got that impression from some of the earlier talks and from thi=
s blog post:
>=20
> http://ceph.com/community/my-first-impressions-of-ceph-as-a-summer-inte=
rn/
>=20
> But I haven't read it in while.
>=20
> But at this time I only see something like:
>=20
> http://ceph.com/docs/master/rados/api/librados/?highlight=3Drados_getxa=
ttr#rados_getxattr
>=20
> Which looks like it is storing it in filesystem attributes.
>=20
> So maybe an object can be a piece of data or a key/value store.

Thanks for explaining: I did not know about the works of Eleanor Cawthon.=
 I knew about the objects xattributes but I thought you meant that the da=
ta inside of the object could be structured as key/value pairs. My bad :-=
)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig259B37FFC4020B0201F6F8C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGg9toACgkQ8dLMyEl6F20k6QCgtVHK7gykpmfsfoB3xk0YPUjL
IYIAnj1j9bWCLi5k22g5JGSTdSe+7D/y
=7u6Y
-----END PGP SIGNATURE-----

--------------enig259B37FFC4020B0201F6F8C2--
