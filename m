From: Loic Dachary <loic@dachary.org>
Subject: Re: crc32 for erasure code
Date: Mon, 23 Sep 2013 19:10:31 +0200
Message-ID: <52407607.7040307@dachary.org>
References: <523FFD1B.4030801@dachary.org> <CAPYLRzib=_3JdtZdrAr0xHbAXCcR--ZJHX1cMR1oRvADBwpCWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig12B640064F4051468717D076"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:42952 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab3IWRKd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 13:10:33 -0400
In-Reply-To: <CAPYLRzib=_3JdtZdrAr0xHbAXCcR--ZJHX1cMR1oRvADBwpCWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12B640064F4051468717D076
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 23/09/2013 18:59, Gregory Farnum wrote:
> On Mon, Sep 23, 2013 at 1:34 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi,
>>
>> Unless I'm mistaken, ceph_crc32() is currently used in master via the =
crc32c() method of bufferlist to:
>>
>> * encode_with_checksum/decode_with_checksum a PGLog entry
>> * Message::decode_message/Message::encode_message a message via calc_*=
_crc
>> * FileJournal::do_read_entry/FileJournal::prepare_single_write a journ=
al entry
>> * for information in the report monitory command ( Monitor.cc )
>>
>> Erasure coded chunks ( i.e. files ) will need checksums. Should this b=
e implemented as an optional feature in ceph/src/os/FileStore.{h,cc} ? If=
 the underlying filesystem does not provide this feature, FileStore would=
 call ceph_crc32 each time the object is modified. A verification method =
would be exposed and used when scrubbing erasure coded pools.
>=20
> You mean should checksums be optional in the FileStore, or should we
> provide a plugin framework for using things other than crc32, or...?
> :)

Not really. I was under the impression that crc32 is good enough. I'm not=
 sure where ( in the code path ) it should be used for erasure coded pool=
s. In the FileStore ? Or in the erasure code PG to set an attribute of th=
e object ? The FileStore seems to be more sensible but ... I'm not sure h=
ence the mail ;-)

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig12B640064F4051468717D076
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlJAdgcACgkQ8dLMyEl6F20BswCgrpmjfPZ+lyvsvi8UuB++lLWT
WjsAoMHI7zflQy96Qs5/bav/MPuipJK9
=aNYn
-----END PGP SIGNATURE-----

--------------enig12B640064F4051468717D076--
