From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph tag v0.94.1.1 etc.
Date: Mon, 04 May 2015 17:56:02 +0200
Message-ID: <55479692.9040800@dachary.org>
References: <5545F3F3.8030206@dachary.org> <1294313931.8466302.1430752677295.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QtuNcusLxG5QOeoJOM5K1LoroMCtSismm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57093 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750887AbbEDP4E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 May 2015 11:56:04 -0400
In-Reply-To: <1294313931.8466302.1430752677295.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QtuNcusLxG5QOeoJOM5K1LoroMCtSismm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

It's great that the Ceph release published in Red Hat products is availab=
le in this way. It would be quite difficult to reverse engineer that from=
 the sources distributed with the Red Velvet product. This is what I see =
at the moment:

$ git log --oneline --no-merges tags/v0.80.8..tags/v0.80.8.1
00b6fb0 0.80.8.1
c7fdbab osdc: Constrain max number of in-flight read requests
ec711a9 Revert "Enforce cache size on read requests"
0ccd1d3 Revert "rbd: ObjectCacher reads can hang when reading sparse file=
s"
f38b7b4 init-radosgw*: don't require rgw_socket_path to be defined
2cbe4fb init-radosgw.sysv: set ulimit -n before starting daemon
d75a9e3 build: remove LIBPERFGLUE from LIBMDS

$ git log --oneline --no-merges tags/v0.94.1..tags/v0.94.1.1
f4f12a6 0.94.1.1
235e555 init-radosgw: run RGW as root
85faf5f rgw: remove meta file after deleting bucket The meta file is dele=
ted only if the bucket meta data is not synced
0420c89 Move ceph-dencoder build to client
32589dd Rework mds/Makefile.am to support a dencoder client build
e6911ec rgw/Makefile.am: Populate DENCODER_SOURCES properly
46e85f7 Dencoder should never be built with tcmalloc

and I'd like to make sure this is going to be taken into account for the =
next v0.80.10[1] and v0.94.2[2].=20

As of today all of v0.94.1.1 is in the hammer branch upstream:

$ git --no-pager cherry -v ceph/hammer tags/v0.94.1.1
- 46e85f72a26186963836ee9071b93417ebc41af2 Dencoder should never be built=
 with tcmalloc
- e6911ec0730b2786fe7b4b1345cd847140b3c0eb rgw/Makefile.am: Populate DENC=
ODER_SOURCES properly
- 32589dd39c54e494364967a99db8bd11983c1998 Rework mds/Makefile.am to supp=
ort a dencoder client build
- 0420c8923696e624e41175e5354bcabdc2b362a8 Move ceph-dencoder build to cl=
ient
- 85faf5fd5b557f826dad8914f5c1751ff1658375 rgw: remove meta file after de=
leting bucket The meta file is deleted only if the bucket meta data is no=
t synced
- 235e5556ddfde5114a79e54f061ea4accd613fc5 init-radosgw: run RGW as root
+ f4f12a634b0a92938d54d77910134dbbcdf864e6 0.94.1.1

and all but one of v0.80.8.1 are in the firefly branch upstream:

$ git --no-pager cherry -v ceph/firefly tags/v0.80.8.1
+ d75a9e374e6581c57461018952ed125c929aeb30 build: remove LIBPERFGLUE from=
 LIBMDS
- 2cbe4fb6436dc959eb54cbcc5226b5ebff974d8d init-radosgw.sysv: set ulimit =
-n before starting daemon
- f38b7b407325d14868c2798035282f1e29e92485 init-radosgw*: don't require r=
gw_socket_path to be defined
- 0ccd1d379d02da5371cebf962465757b0ac741ab Revert "rbd: ObjectCacher read=
s can hang when reading sparse files"
- ec711a9f30ac829f6504038063babd51f4b50488 Revert "Enforce cache size on =
read requests"
- c7fdbabb237a78aa7a7c282725ce438f60bc4d75 osdc: Constrain max number of =
in-flight read requests
+ 00b6fb027bb6fccda6716ef577464d30d96959cc 0.80.8.1

What process do you suggest we put in place to converge our efforts ? It =
would set a good example that others can follow.

[1] Firefly v0.80.10 preparation http://tracker.ceph.com/issues/11090
[2] Hammer v0.94.2 preparation http://tracker.ceph.com/issues/11492

Cheers

On 04/05/2015 17:17, Ken Dreyer wrote:
> Hi Loic,
>=20
> These are tags on the rhcs-* branches. These branches and tags more-or-=
less indicate what we're shipping Red Hat's "Ceph Storage" product downst=
ream, which is basically a fork of 0.80.8 and 0.94.1.
>=20
> Instead of keeping these branches in an internal repository behind Red =
Hat's firewall I figured I would push them to the public GitHub repositor=
y instead, since that fits with certain aspects of the way that Inktank u=
sed to build its downstream product. (Re-using the same Jenkins build sys=
tem upstream and downstream).
>=20
> I don't know how long we'll keep to this model; it's just the one that =
works for the moment. I realize this mixes downstream and upstream in a w=
ay that's a bit unconventional.
>=20
> - Ken
>=20
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Sunday, May 3, 2015 4:09:55 AM
>> Subject: Ceph tag v0.94.1.1 etc.
>>
>> Hi,
>>
>> At https://git.ceph.com/?p=3Dceph.git there are tags such as
>>
>> v0.94.1.1
>> v0.80.8.1
>>
>> etc.
>>
>> What are they ?
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QtuNcusLxG5QOeoJOM5K1LoroMCtSismm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVHlpIACgkQ8dLMyEl6F23qYgCdGaZu/HbE6Mm85kadKNqpt7Ey
Q0QAnissn+BWtHHjxauQOIp0Yo+nrpvK
=6ZhH
-----END PGP SIGNATURE-----

--QtuNcusLxG5QOeoJOM5K1LoroMCtSismm--
