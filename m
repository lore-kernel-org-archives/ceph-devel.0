From: Loic Dachary <loic@dachary.org>
Subject: Interpreting rados / print order in teuthology output
Date: Thu, 26 Mar 2015 23:44:33 +0100
Message-ID: <55148BD1.2090800@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="E6DDuoNgmTIMa7Is2oJW9OW6DtP0M39oL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37432 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752847AbbCZWoi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Mar 2015 18:44:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zcerza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E6DDuoNgmTIMa7Is2oJW9OW6DtP0M39oL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

I'm trying to figure out why

  http://pulpito.ceph.com/loic-2015-03-26_21:18:14-upgrade:firefly-x:stre=
ss-split-erasure-code-hammer---basic-multi/822784/

failed when the same run succeeded at

  http://pulpito.ceph.com/loic-2015-03-26_15:22:43-upgrade:firefly-x:stre=
ss-split-erasure-code-hammer---basic-multi/822782/

I'm kind of blocked trying to figure out why the print statement is run b=
efore the first rados run completes at:

2015-03-26T13:33:38.178 INFO:teuthology.orchestra.run.burnupi31.stderr:os=
ds 0,1,2,3,4,5,6,7,8,9,10,11,12,13 instructed to deep-scrub
2015-03-26T13:33:38.189 INFO:teuthology.run_tasks:Running task rados...
2015-03-26T13:33:38.209 INFO:tasks.rados:Beginning rados...
2015-03-26T13:33:38.210 INFO:teuthology.run_tasks:Running task print...
2015-03-26T13:33:38.210 INFO:teuthology.task.print:**** done rados ec-cac=
he-agent (part 1)
2015-03-26T13:33:38.210 INFO:teuthology.run_tasks:Running task install.up=
grade...
2015-03-26T13:33:38.211 INFO:teuthology.task.install:project ceph config =
{'osd.0': None} overrides {'sha1': '6994648bc443429dc2edfbb38fbaaa9a19e2b=
dd1'}
2015-03-26T13:33:38.211 INFO:teuthology.task.install:extra packages: []
2015-03-26T13:33:38.211 INFO:teuthology.task.install:remote ubuntu@mira11=
9.front.sepia.ceph.com config {'sha1': '6994648bc443429dc2edfbb38fbaaa9a1=
9e2bdd1'}
2015-03-26T13:33:38.212 INFO:teuthology.orchestra.run.mira119:Running: 's=
udo lsb_release -is'
2015-03-26T13:33:38.213 INFO:tasks.rados:clients are ['client.0']
2015-03-26T13:33:38.213 INFO:tasks.rados:starting run 0 out of 1
2015-03-26T13:33:38.214 INFO:teuthology.orchestra.run.burnupi31:Running: =
'CEPH_CLIENT_ID=3D0 adjust-ulimits ceph-coverage /home/ubuntu/cephtest/ar=
chive/coverage ceph_test_rados --op read 100 --op write 100 --op delete 5=
0 --max-ops 4000 --objects 500 --max-in-flight 16 --size 4000000 --min-st=
ride-size 400000 --max-stride-size 800000 --max-seconds 0 --op copy_from =
50 --pool ecbase'
2015-03-26T13:33:38.229 INFO:tasks.rados.rados.0.burnupi31.stdout:adding =
op weight read -> 100
2015-03-26T13:33:38.230 INFO:tasks.rados.rados.0.burnupi31.stdout:adding =
op weight write -> 100
2015-03-26T13:33:38.230 INFO:tasks.rados.rados.0.burnupi31.stdout:adding =
op weight delete -> 50

although the config reads:

=2E..
    - ceph osd pool set eccache target_max_objects 250
- exec:
    client.0:
    - ceph osd deep-scrub '*'
- rados:
    clients:
    - client.0
    objects: 500
    op_weights:
      copy_from: 50
      delete: 50
      read: 100
      write: 100
    ops: 4000
    pools:
    - ecbase
- print: '**** done rados ec-cache-agent (part 1)'
- install.upgrade:
    osd.0: null
- ceph.restart:

=2E..

I'm kind of worried I'll make a fool of myself once more. This time it sp=
ells "task" and not "tasks" ;-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--E6DDuoNgmTIMa7Is2oJW9OW6DtP0M39oL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUUi9EACgkQ8dLMyEl6F20UNwCcDlFzLpvx9VENMQMYj3wkGb9o
n8AAn2XD/653MVD1xcFfD89CY3g8LMnP
=7RkG
-----END PGP SIGNATURE-----

--E6DDuoNgmTIMa7Is2oJW9OW6DtP0M39oL--
