From: Loic Dachary <loic@dachary.org>
Subject: reconciliation between hammer and v0.94.1.3
Date: Thu, 02 Jul 2015 00:33:42 +0200
Message-ID: <55946AC6.3050105@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gwNmUffpMkeghsvEAAm61bvBcSf2uhI6m"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43343 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754019AbbGAWdu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jul 2015 18:33:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gwNmUffpMkeghsvEAAm61bvBcSf2uhI6m
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ken,

The commits with a + are found in v0.94.1.3 and are not in hammer (the pr=
evious mail related to v0.94.1.2 can be found at http://www.spinics.net/l=
ists/ceph-devel/msg24489.html)

$ git rev-parse ceph/hammer
72ecd522941156c8a7e5303531944b0735dcbeb8
$ git --no-pager cherry -v ceph/hammer tags/v0.94.1.3
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
- 9dc831ffa7d9d45a8e7d7e40e1f2ba0b1655d297 rgw: send ETag, Last-Modified =
in response for copying Swift cobject.
- c429d1ac348e9f981a92fd8f94bb9cefa52cae53 rgw: add support for X-Copied-=
From{-Account} headers of Swift API.
- 3805ee3a2db2994100fd3bc6b74e4da01a24fa09 rgw: refactor dumping metadata=
 of Swift objects.
- ddbfbd25909225edd5839c9a71a7141998c81ece rgw: dump object metadata in r=
esponse for COPY request of Swift API.
+ d54ab2a8ff754dfddb13ae0bd5c0806706f2a9a7 rgw: send X-Copied-From-Last-M=
odified header of Swift API.
- a52fe7a376b4dbfc65b635a3f0b92881caa17b93 civetweb: update max num of th=
reads
- ee5858906d5d903db7b04be665dfa3ede3395134 rgw: update keystone cache wit=
h token info
- 10013a90b03ff317f7cae7944b2561a504c4718d rgw: generate new tag for obje=
ct when setting object attrs
- d6f35ae36a3b97b28407aaa5f220c3917e47b2e7 ceph_json: add decode / encode=
r for multimap
- 62a99817559bcac6d1c48af27a0f0a0081ad248d cls_rgw: use multimap to keep =
pending operations in bucket index
- 52fc446528c12b305ed0df5aee03a35dd536a110 rgw: don't use rgw_socket_path=
 if frontend is configured
- 3d005b7d868aa17f0707e4ad9bb1694f64d3867e rgw-admin: a tool to fix objec=
t locator issue
- ce4b31966a0af942a1360caddc52b361b726226a rgw: set a special object loca=
tor if object starts with underscore
- 92ee7e7519bef206d88417e04b6308b76785e773 OSD: handle the case where we =
resurrected an old, deleted pg
+ 7347e31a8712515792ea55acad8c47d373b6ebd6 common/admin_socket: close soc=
ket descriptor in destructor
- 01681d0b16cfadbce78fbf2a253630b3b5aaf1f0 rgw: restore buffer of multipa=
rt upload after EEXIST
- 9431633e5225c9cba210087aafd7c3f14490214c rgw: merge manifests correctly=
 when there's prefix override
+ 0d9dd0f5749bb28e6403616b55f0c0ca1b9eaf0e init-radosgw: look in /var/lib=
/ceph/radosgw
+ 8527d885966c72d35ccb98387be8579c65fb4890 init-radosgw: unify init-rados=
gw[.sysv]
+ c8db30b9873625feef5b0b418b39f3994b997ed2 init-radosgw.sysv: remove
+ bf63aea024cb660dd4841dcf9b4da40e05db26b3 0.94.1.2
- f76a6728f9a100a25646565b42eebdbf67673817 packaging: include ceph_perf_o=
bjectstore
+ 4070e1ec08073330dfa4ec4d43e51ea4dfd7e527 WorkQueue: add new ContextWQ w=
ork queue
+ d255f5e8c6ae627938e31da50c59203638080ea4 WorkQueue: added virtual destr=
uctor
+ 5e7c60a59c6f2e91ea3c8c7b6c39d879d604ca89 librbd: add task pool / work q=
ueue for requests
+ c6d730072a2f147c2779c343d9930efd539f5387 librbd: avoid blocking AIO API=
 methods
+ 07d9ffe2f1cc343ac95e7489a97b363de7b9cdd7 librbd: add new fail method to=
 AioCompletion
+ 59b3db9d3f4c762f5c45b65202ebdce42184bc35 librbd: internal AIO methods n=
o longer return result
+ ced43a31d2695fc75668a1d7d7b01ac4132ef196 Throttle: added pending_error =
method to SimpleThrottle
+ 09a78bee7ea8978019d043709e7fdb182dd1fb80 tests: update librbd AIO tests=
 to remove result code
+ c73e583b86b8757305af1ee9523aa6a7fd541e34 librbd: AioRequest::send no lo=
nger returns a result
+ a6c08ba2ed086a7db0493adb14ffa17e14dad906 librbd: new rbd_non_blocking_a=
io config option
+ 2cbd855f3a734dda2031f6363c0ab4fb42f691dd tests: verify librbd blocking =
aio code path
+ ec254c28ba87bbbd0b9958ddb981611b2395c30e rgw: fix reset_loc()
- 22311b7470fd5246c5c16f8560be2b088b5af385 rgw: use correct oid when crea=
ting gc chains
- de024da2c2c527fcca13616b4756dd568d01b669 rgw: civetweb should use uniqu=
e request id
+ 6658e832d7dc36447155d8a375c503febe29c3ef rgw: Swift API. Allows setting=
 attributes with COPY object operation.
- 952611513fa8a6714f81980d66e27bc5ef8466a8 rgw: improve code formatting O=
NLY.
- 20bfa0792212ebd5957e3006944eaa97e16f062b rgw: improve metadata handling=
 on copy operation of Swift API.
+ bf27f12f4fc57103d817d9d17490327815633777 rgw: fix assignment of copy ob=
j attributes
+ 54a88ce2214f9d2ff48df2dcc0ed51a48c7ac809 0.94.1.3

Up to 0.94.1.2 the following have not seen progress in the past month:

* rgw: send X-Copied-From-Last-Modified header of Swift API same as http:=
//www.spinics.net/lists/ceph-devel/msg24489.html=20
* common/admin_socket: close socket descriptor in destructor same as http=
://www.spinics.net/lists/ceph-devel/msg24489.html
* init-radosgw: etc. same as http://www.spinics.net/lists/ceph-devel/msg2=
4489.html

=46rom 0.94.1.2 to 0.94.1.3=20

* librbd: * from https://github.com/ceph/ceph/commit/4070e1ec08073330dfa4=
ec4d43e51ea4dfd7e527 to https://github.com/ceph/ceph/commit/2cbd855f3a734=
dda2031f6363c0ab4fb42f691dd belong to http://tracker.ceph.com/issues/1105=
6 "librbd: aio calls may block" which is scheduled to be in 0.94.3 as des=
cribed at http://tracker.ceph.com/issues/11770
* rgw: fix reset_loc() https://github.com/ceph/ceph/commit/ec254c28ba87bb=
bd0b9958ddb981611b2395c30e is http://tracker.ceph.com/issues/11974 which =
is not scheduled to be in 0.94.3 yet
* rgw: Swift API. Allows setting attributes with COPY object operation is=
 http://tracker.ceph.com/issues/10662 "RGW swift API: Providing custom me=
tadata header in COPY operation does not add custom metadata in the new o=
bject." and is already backported by https://github.com/ceph/ceph/pull/45=
68 and in in hammer v0.94.2. It shows because the context of the two comm=
its is different even though the modified lines are the same and that giv=
es them a different patch id.
* rgw: fix assignment of copy obj attributes https://github.com/dachary/c=
eph/commit/bf27f12f4fc57103d817d9d17490327815633777 is http://tracker.cep=
h.com/issues/11563 which is not scheduled to be in 0.94.3 yet (http://tra=
cker.ceph.com/issues/12199 tracks the backport)

Tracking the differences between hammer and v0.94.1.XX gives us valuable =
information. Do you have suggestions on how we could better organize this=
 ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--gwNmUffpMkeghsvEAAm61bvBcSf2uhI6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWUasYACgkQ8dLMyEl6F22aRgCgwWyYeqAe5BGQi3FsBibLcHN6
feMAoMM4B/1yw5kQb7bvDY/T5gLNcFCv
=/Irh
-----END PGP SIGNATURE-----

--gwNmUffpMkeghsvEAAm61bvBcSf2uhI6m--
