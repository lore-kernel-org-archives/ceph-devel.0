From: Loic Dachary <loic@dachary.org>
Subject: Preparing the suites to run with the OpenStack backend
Date: Wed, 14 Oct 2015 12:19:27 +0200
Message-ID: <561E2C2F.8050804@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="E8JT7pA1rtnodeO8kSjNPwxq2OBiRKR99"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42861 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751257AbbJNKTa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Oct 2015 06:19:30 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, Yehuda Sadeh <yehuda@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E8JT7pA1rtnodeO8kSjNPwxq2OBiRKR99
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Josh, Yehuda and Greg,

It is my understanding that there is a chance we may need to use the Open=
Stack teuthology backend as a backup while machines in the sepia lab migr=
ate from one data center to another. Zack has setup a new teuthology clus=
ter that will transparently behave as the cluster in the sepia lab does: =
the only difference being that you would --machine-type openstack instead=
=2E Or the new teuthology-openstack command could be used if one feels li=
ke learning about it.

Despite our best efforts, OpenStack provisionning is not 100% transparent=
=2E In the past few months we made various attempts at running suites on =
OpenStack to verify that they do not massively fail and identify possible=
 show stoppers. When possible the OpenStack backend was adapted but in so=
me cases the suites themselves had to be modified. For instance, a number=
 of jobs in the rados suite run fine with no attached disks, which is the=
 default. But all jobs in rados/thrash need three attached disks per targ=
et and that had to be set in the ceph-qa-suite files as follows[1]:

openstack:
  machine:
    disk: 40 # GB
    ram: 8000 # MB
    cpus: 1
  volumes: # attached to each instance
    count: 3
    size: 30 # GB

The rados suite for hammer now runs cleanly on OpenStack [2] and I'll wor=
k on making it run on infernalis as well [3]. The rbd suite for hammer ru=
ns cleanly (no changes :-) on OpenStack [4] but needs work to run on infe=
rnalis: an inventory of the problems was made[5].

A similar verification needs to be done for the rgw and fs suites (the up=
grade / ceph-deploy / ceph-disk are not a concern as they already run on =
virtual machines). The first problem that need attention for the rgw suit=
e is http://tracker.ceph.com/issues/12471#note-4 (which also happens with=
 the infernalis rados suite because it has some rgw workload). AFAIK, the=
re are no other outstanding issues.

I will not be able to run and fix all the suites all by myself, it's too =
much work and would divert me for too long from my rados duties. I'm howe=
ver available to help as much as you need to make it work :-)

Cheers


[1] resource hint for rados/thrash https://github.com/ceph/ceph-qa-suite/=
blob/wip-12329-resources-hint-hammer/suites/rados/thrash/clusters/opensta=
ck.yaml
[2] running the rados suite on OpenStack virtual machines (hammer) http:/=
/tracker.ceph.com/issues/12386
[3] running the rados suite on OpenStack virtual machines (infernalis) ht=
tp://tracker.ceph.com/issues/12471
[4] running the rbd suite on OpenStack virtual machines (hammer) http://t=
racker.ceph.com/issues/13265
[5] running the rbd suite on OpenStack virtual machines (infernalis) http=
://tracker.ceph.com/issues/13270

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre



--E8JT7pA1rtnodeO8kSjNPwxq2OBiRKR99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYeLC8ACgkQ8dLMyEl6F22ILgCfdn05EWaDBg45LKoPc67IjLeY
+cEAn0OqameFJ0bX9Wp2kl6QRwMU0vR1
=Sjs5
-----END PGP SIGNATURE-----

--E8JT7pA1rtnodeO8kSjNPwxq2OBiRKR99--
