From: Loic Dachary <loic@dachary.org>
Subject: Re: Adding a proprietary key value store to CEPH
Date: Tue, 24 Feb 2015 15:29:33 +0100
Message-ID: <54EC8ACD.7020402@dachary.org>
References: <C226B0AB34511445928D9882AA519F600A56972E@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4gDUX136LBvVPC0Ic90hm3OGoMBO58Jj2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48181 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753235AbbBXO3f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 09:29:35 -0500
In-Reply-To: <C226B0AB34511445928D9882AA519F600A56972E@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4gDUX136LBvVPC0Ic90hm3OGoMBO58Jj2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

I'm curious about the reasons why the key/value store you mention is not =
published as Free Software. Is it because it implements a proprietary int=
erface to a specific hardware ? Because it has additional functionalities=
 comparied to rocksdb etc. ? Because it performs better under some worklo=
ads ?

Cheers

On 24/02/2015 14:20, Varada Kari wrote:
> Hi Sage,
>=20
> We are trying to integrate a new proprietary key value store to CEPH. T=
o integrate this KV-store, which is a closed source shared library, we pr=
opose a new class to CEPH called PropDBStore which does a dlopen and impo=
rts the required symbols. This framework will help in integrating vendor =
specific extensions to CEPH.
>=20
> The gist of the implementation is as follows.
>=20
> 1. Implement a wrapper around the proprietary KVStore. Let us call it a=
s KVExtension. This is a shared library which implements all interfaces r=
equired by CEPH KeyValueStore.
> 2. A new class is derived from KeyValueDB called PropDBStore, which hon=
ors the semantics of KeyvalueStore and KeyValueDB. This class acts as med=
iator between CEPH and KVExtension.  This class transforms bufferlist etc=
=2E.. to const char pointers or strings for the extension to understand.
> 3. PropDBStore, loads (dlopen) the KVExtension during OSD initializatio=
n.  Path to the KVExtension can be mentioned in ceph.conf.
> 4. Interfaces that needs to be implemented in KVExtension, which are im=
ported by the PropDBStore are added in a new header called PropDBWrapper.=
h.  This header contains the signatures for the necessary interfaces like=
 init(), close(), submit_transaction(), get() and get_iterator(). Similar=
ly for Iterator functionality, PropDBIterator.h, which specifies the sign=
atures of seek_to_first (), seek_to_last(), lower_bound() and upper_bound=
() etc...  PropDBStore includes these headers to import the symbols, usin=
g dlsym().
> 5. Choosing the proprietary DB as Backend to the OSD is controlled/mana=
ged by config options of the ceph (/etc/ceph/ceph.conf) like rocksdb or l=
eveldb.
> 6. Rest of the existing functionality is not disturbed by this change. =
Changing the osd backend option will change backend implementation. But t=
his change is not dynamic. The type of the backend should be chosen at os=
d creation time and osd will continue use that backend till that osd is r=
eformatted again.
> 7. The new KVStore we are trying to integrate works on a raw partition,=
 so we divided the osd drive into two partitions. One partition is given =
to osd Meta data (super block, fsid etc...), and the other is given to th=
e new db to manage it. OSD partition is now not the entire disk, but 2-4G=
B which needed for the metadata.
>=20
> Please share your thoughts around this.
> Thanks,
> Varada
>=20
>=20
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. =
If the reader of this message is not the intended recipient, you are here=
by notified that you have received this message in error and that any rev=
iew, dissemination, distribution, or copying of this message is strictly =
prohibited. If you have received this communication in error, please noti=
fy the sender by telephone or e-mail (as shown above) immediately and des=
troy any and all copies of this message in your possession (whether hard =
copies or electronically stored copies).
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--4gDUX136LBvVPC0Ic90hm3OGoMBO58Jj2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTsis0ACgkQ8dLMyEl6F214eACghMjBKtI30y8cJuV7UB+f05p0
b4EAoL6RclwBI1vQIKltc/9T9ZsXiIC0
=r7A7
-----END PGP SIGNATURE-----

--4gDUX136LBvVPC0Ic90hm3OGoMBO58Jj2--
