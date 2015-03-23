From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-releases
Date: Mon, 23 Mar 2015 01:35:19 +0100
Message-ID: <550F5FC7.3040400@dachary.org>
References: <550E832E.6040004@dachary.org> <1042516820.1185244.1427041005119.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MFmXEnf3cBBXXdW4J7rNoRxlHiG1lR10D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34643 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752045AbbCWAfa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Mar 2015 20:35:30 -0400
In-Reply-To: <1042516820.1185244.1427041005119.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MFmXEnf3cBBXXdW4J7rNoRxlHiG1lR10D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/03/2015 17:16, Yuri Weinstein wrote:
> Loic, I think the idea was to do more process driven approach for relea=
sing hammer, e.g. keep track of suites vs. results and open issues, so we=
 can have a high level view on status at any time before the final cut da=
y.
>=20
> Do you have any suggestions or objections?

Reading http://tracker.ceph.com/issues/11189 I see it has one run, and a =
run of failed tests, and got resolved because all passed. The title is ha=
mmer: upgrade/giant-x. How will that go for the next run of upgrade/giant=
-x ?

I use a python snippet to display the errors in a redmine format (http://=
workbench.dachary.org/dachary/ceph-workbench/issues/2)

$ python ../fail.py teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer=
-distro-basic-vps
** *'mkdir -p -- /home/ubuntu/cephtest/mnt.1/client.1/tmp && cd -- /home/=
ubuntu/cephtest/mnt.1/client.1/tmp && CEPH_CLI_TEST_DUP_COMMAND=3D1 CEPH_=
REF=3Dgiant TESTDIR=3D"/home/ubuntu/cephtest" CEPH_ID=3D"1" PATH=3D$PATH:=
/usr/sbin adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/cove=
rage timeout 3h /home/ubuntu/cephtest/workunit.client.1/cls/test_cls_rgw.=
sh'*
*** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/giant=
=2Eyaml 2-workload/parallel_run/{ec-rados-parallel.yaml rados_api.yaml ra=
dos_loadgenbig.yaml test_cache-pool-snaps.yaml test_rbd_api.yaml test_rbd=
_python.yaml} 3-upgrade-sequence/upgrade-mon-osd-mds.yaml 4-final-workloa=
d/{rados-snaps-few-objects.yaml rados_loadgenmix.yaml rados_mon_thrash.ya=
ml rbd_cls.yaml rbd_import_export.yaml rgw_swift.yaml} distros/rhel_7.0.y=
aml}":http://pulpito.ceph.com/teuthology-2015-03-20_17:05:02-upgrade:gian=
t-x-hammer-distro-basic-vps/814081
** *"2015-03-20 23:04:51.042345 mon.0 10.214.130.49:6789/0 3 : cluster [W=
RN] message from mon.1 was stamped 14400.248297s in the future, clocks no=
t synchronized" in cluster log*
*** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/giant=
=2Eyaml 2-workload/sequential_run/test_rbd_api.yaml 3-upgrade-sequence/up=
grade-all.yaml 4-final-workload/{rados-snaps-few-objects.yaml rados_loadg=
enmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_import_export.yaml rgw_=
swift.yaml} distros/centos_6.5.yaml}":http://pulpito.ceph.com/teuthology-=
2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814155
** *Could not reconnect to ubuntu@vpm169.front.sepia.ceph.com*
*** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/giant=
=2Eyaml 2-workload/sequential_run/ec-rados-default.yaml 3-upgrade-sequenc=
e/upgrade-mon-osd-mds.yaml 4-final-workload/{rados-snaps-few-objects.yaml=
 rados_loadgenmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_import_expo=
rt.yaml rgw_swift.yaml} distros/rhel_7.0.yaml}":http://pulpito.ceph.com/t=
euthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814=
108
** *Could not reconnect to ubuntu@vpm166.front.sepia.ceph.com*
*** "upgrade:giant-x/stress-split-erasure-code/{0-cluster/start.yaml 1-gi=
ant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/default.=
yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-next-mon/monb.yam=
l 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Djerasure-k=3D3-m=3D1.=
yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology-2015-03-2=
0_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814194
** *'sudo adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/cove=
rage daemon-helper kill ceph-mon -f -i a'*
*** "upgrade:giant-x/stress-split-erasure-code-x86_64/{0-cluster/start.ya=
ml 1-giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/d=
efault.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-next-mon/m=
onb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Disa-k=3D2-m=3D=
1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology-2015-03=
-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814197
** *timed out waiting for admin_socket to appear after osd.13 restart*
*** "upgrade:giant-x/stress-split/{0-cluster/start.yaml 1-giant-install/g=
iant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/default.yaml 4-mon/mo=
na.yaml 5-workload/{rbd-cls.yaml rbd-import-export.yaml readwrite.yaml sn=
aps-few-objects.yaml} 6-next-mon/monb.yaml 7-workload/{radosbench.yaml rb=
d_api.yaml} 8-next-mon/monc.yaml 9-workload/{rbd-python.yaml rgw-swift.ya=
ml snaps-many-objects.yaml} distros/rhel_6.5.yaml}":http://pulpito.ceph.c=
om/teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps=
/814186

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Sage Weil" <sweil@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Sunday, March 22, 2015 1:54:06 AM
> Subject: hammer tasks in http://tracker.ceph.com/projects/ceph-releases=

>=20
> Hi Sage,
>=20
> You have created a few hammer related tasks at http://tracker.ceph.com/=
projects/ceph-releases/issues . What did you have in mind ?
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--MFmXEnf3cBBXXdW4J7rNoRxlHiG1lR10D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUPX8cACgkQ8dLMyEl6F21cIgCgnq8b4zJ6iNQ8ql6hYV0AwImh
8oQAnAvJKfsLNwMB7nChYCpYI6g4i8Di
=Dhl0
-----END PGP SIGNATURE-----

--MFmXEnf3cBBXXdW4J7rNoRxlHiG1lR10D--
