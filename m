From: Loic Dachary <loic@dachary.org>
Subject: reconciliation between hammer and v0.94.1.2
Date: Thu, 28 May 2015 12:21:15 +0200
Message-ID: <5566EC1B.9030005@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="saB8r9actLnG4NgROCJNdsKga6Kj1N9O9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52362 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751529AbbE1KVW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 06:21:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--saB8r9actLnG4NgROCJNdsKga6Kj1N9O9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ken,

The commits with a + are found in v0.94.1.2 and are not in hammer

$ git rev-parse ceph/hammer
eb69cf758eb25e7ac71e36c754b9b959edb67cee
$ git --no-pager cherry -v ceph/hammer tags/v0.94.1.2
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

* rgw: send X-Copied-From-Last-Modified header of Swift API is https://gi=
thub.com/ceph/ceph/commit/d54ab2a8ff754dfddb13ae0bd5c0806706f2a9a7 which =
is a backport for http://tracker.ceph.com/issues/10663. It has been backp=
orted differently in hammer : https://github.com/dachary/ceph/commit/b034=
511fa79996415640b4aca3e8747340f2a127 as part of https://github.com/ceph/c=
eph/pull/4568.=20

* common/admin_socket: close socket descriptor in destructor is https://g=
ithub.com/ceph/ceph/commit/7347e31a8712515792ea55acad8c47d373b6ebd6 which=
 is a backport for http://tracker.ceph.com/issues/11535. It has been back=
ported in the same way at https://github.com/ceph/ceph/pull/4657 as shown=
 by=20

$ git show 0b6d442  | git patch-id=20
cdd3afe1bc8952cfbc9a096acd1d093a326c1959 0b6d4427ac7234fd509a9541adf45e30=
3e40cb16
$ git show 7347e31a8712515792ea55acad8c47d373b6ebd6  | git patch-id=20
cdd3afe1bc8952cfbc9a096acd1d093a326c1959 7347e31a8712515792ea55acad8c47d3=
73b6ebd6

however you marked https://github.com/ceph/ceph/pull/4657 as DNM. Is it r=
eady to merge now ?

* init-radosgw: etc. (https://github.com/ceph/ceph/commit/c8db30b9873625f=
eef5b0b418b39f3994b997ed2 https://github.com/ceph/ceph/commit/8527d885966=
c72d35ccb98387be8579c65fb4890and https://github.com/ceph/ceph/commit/0d9d=
d0f5749bb28e6403616b55f0c0ca1b9eaf0e) which are backports for http://trac=
ker.ceph.com/issues/11686. It is being backported at http://tracker.ceph.=
com/issues/11735 and unless you have a different opinion, I think the bac=
kport from v0.94.1.2 can be re-used as-is.

I find this branch and the v0.94.1.x tags are a good way to reconcile the=
 backports, we should keep doing this :-) The only thing that is annoying=
 is the divergence on "rgw: send X-Copied-From-Last-Modified header of Sw=
ift API". Although it could have been avoided, it's not a big deal and I =
guess it will happen again. I'm not sure what's the best way to remember =
"this divergence happened, we looked at it and it's not too much of a pro=
blem". Any idea ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--saB8r9actLnG4NgROCJNdsKga6Kj1N9O9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVm7BsACgkQ8dLMyEl6F20PugCdHyCkQ0xZsUKFkAcCr0bS2x41
angAn2IYRkd5rCPt1hZcvav+L8yGQtou
=AG00
-----END PGP SIGNATURE-----

--saB8r9actLnG4NgROCJNdsKga6Kj1N9O9--
