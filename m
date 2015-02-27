From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph versions
Date: Fri, 27 Feb 2015 01:58:25 +0100
Message-ID: <54EFC131.8080402@dachary.org>
References: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net> <54EFAE77.3020101@dachary.org> <567942662.11970131.1424995195896.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="UhbWBnQwbWG0LfeUWN3WP1xXkm8nOSftV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49722 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751422AbbB0A62 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 19:58:28 -0500
In-Reply-To: <567942662.11970131.1424995195896.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UhbWBnQwbWG0LfeUWN3WP1xXkm8nOSftV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 27/02/2015 00:59, Yehuda Sadeh-Weinraub wrote:
>=20
>=20
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
>> Sent: Thursday, February 26, 2015 3:38:31 PM
>> Subject: Re: ceph versions
>>
>> Hi Sage,
>>
>> I prefer Option D because it's self explanatory. We could also drop th=
e
>> names. I became attached to them but they are confusing to the new use=
rs who
>> is required to remember that firefly is 0.80, giant is 0.87 etc.
>>
>> Cheers
>>
>> On 27/02/2015 00:12, Sage Weil wrote:
>>> -- Option D -- "labeled"
>>>
>>> X.Y-{dev,rc,release}Z
>>>
>>>  - Increment Y on each major named release
>>>  - Increment X if it's a major major named release (bigger change
>>> than usual)
>>>  - Use dev, rc, or release prefix to clearly label what type of relea=
se
>>> this is
>>>  - Increment Z for stable updates
>>>
>>>  1.0-dev1 first infernalis dev release
>>>  1.0-dev2 another dev release
>>>  ...
>>>  1.0-rc1 first rc
>>>  1.0-rc2 next rc
>>>  1.0-release1 final release
>>>  1.0-release2 stable update
>>>  1.0-release3 stable update
>>>  1.1-dev1 first cut for j-release
>>>  1.1-dev2 ...
>>>  ...
>>>  1.1-rc1
>>>  1.1-release1 stable
>>>  1.1-release2 stable
>>>  1.1-release3 stable
>>>
>>> Q: How do I tell what kind of release this is?
>>> A: Look at the string embedded in the version
>>>
>>> Q: Will these funny strings confuse things that sort by version?
>>> A: I don't think so.
>>
>> dev < rc < release : good pick ;-)
>>
>=20
> This is the one I lean towards, with one slight variation. I'd drop the=
 'release' tag and have X.Y[.Z] format for the formal releases, e.g.,
> 2.0-dev1 first infernalis dev release
> 2.0-dev2
> ..
> 2.0-rc1
> 2.0-rc2
> ...
> 2.0 # infarnalis
> 2.0.1 # first dot release
> ...
> 2.1-dev1 # first j dev release
> ...
> 2.1 # j release
>=20
> Then after a few release move to 3.0 to avoid the dreadful big numbers.=

>=20
> Sage did mention that this might have some issues in certain environmen=
ts to sort correctly. Possibly replacing the dash with a tilde solves thi=
s?
>=20

The lexicographic order of ~ is modified in debian and that may create co=
nfusion:

http://man.he.net/man5/deb-version

       lexical comparison is a comparison of ASCII values modified so tha=
t all
       the letters sort earlier than all the non-letters and so that  a  =
tilde
       sorts  before  anything, even the end of a part.  For example, the=
 fol-
       lowing parts are in sorted order: '~~', '~~a',  '~',  the  empty  =
part,
       'a'.

The - is lower than the . so it should be good provided the major release=
s are X.Y.0 instead of X.Y, i.e.:

2.0-rc3
2.0.0 # infarnalis
2.0.1 # first dot release

etc.

Dropping the "release" word for stable releases is a good idea.

Cheers

> Yehuda
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--UhbWBnQwbWG0LfeUWN3WP1xXkm8nOSftV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTvwTEACgkQ8dLMyEl6F20OHQCgjvGZ8Tz3vHqLUSbIZzRRLHBI
TcQAn0R56NVHiREVA2lWFp0pF6t4cOH5
=LrUd
-----END PGP SIGNATURE-----

--UhbWBnQwbWG0LfeUWN3WP1xXkm8nOSftV--
