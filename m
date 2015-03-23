From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-releases
Date: Mon, 23 Mar 2015 11:09:21 -0400 (EDT)
Message-ID: <995426416.1709433.1427123361564.JavaMail.zimbra@redhat.com>
References: <550E832E.6040004@dachary.org> <1042516820.1185244.1427041005119.JavaMail.zimbra@redhat.com> <550F5FC7.3040400@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:41598 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbbCWPK0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 11:10:26 -0400
In-Reply-To: <550F5FC7.3040400@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

"How will that go for the next run of upgrade/giant-x ?"

I was thinking that as soon as for example this suite passed, #11189 ge=
ts resolved as thus indicates that it's ready for for the hammer releas=
e cut.=20


Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Sage Weil" <sweil@redhat.com>, "Ceph Development" <ceph-devel@vger=
=2Ekernel.org>
Sent: Sunday, March 22, 2015 5:35:19 PM
Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-rele=
ases



On 22/03/2015 17:16, Yuri Weinstein wrote:
> Loic, I think the idea was to do more process driven approach for rel=
easing hammer, e.g. keep track of suites vs. results and open issues, s=
o we can have a high level view on status at any time before the final =
cut day.
>=20
> Do you have any suggestions or objections?

Reading http://tracker.ceph.com/issues/11189 I see it has one run, and =
a run of failed tests, and got resolved because all passed. The title i=
s hammer: upgrade/giant-x. How will that go for the next run of upgrade=
/giant-x ?

I use a python snippet to display the errors in a redmine format (http:=
//workbench.dachary.org/dachary/ceph-workbench/issues/2)

$ python ../fail.py teuthology-2015-03-20_17:05:02-upgrade:giant-x-hamm=
er-distro-basic-vps
** *'mkdir -p -- /home/ubuntu/cephtest/mnt.1/client.1/tmp && cd -- /hom=
e/ubuntu/cephtest/mnt.1/client.1/tmp && CEPH_CLI_TEST_DUP_COMMAND=3D1 C=
EPH_REF=3Dgiant TESTDIR=3D"/home/ubuntu/cephtest" CEPH_ID=3D"1" PATH=3D=
$PATH:/usr/sbin adjust-ulimits ceph-coverage /home/ubuntu/cephtest/arch=
ive/coverage timeout 3h /home/ubuntu/cephtest/workunit.client.1/cls/tes=
t_cls_rgw.sh'*
*** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/gia=
nt.yaml 2-workload/parallel_run/{ec-rados-parallel.yaml rados_api.yaml =
rados_loadgenbig.yaml test_cache-pool-snaps.yaml test_rbd_api.yaml test=
_rbd_python.yaml} 3-upgrade-sequence/upgrade-mon-osd-mds.yaml 4-final-w=
orkload/{rados-snaps-few-objects.yaml rados_loadgenmix.yaml rados_mon_t=
hrash.yaml rbd_cls.yaml rbd_import_export.yaml rgw_swift.yaml} distros/=
rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology-2015-03-20_17:05:02-=
upgrade:giant-x-hammer-distro-basic-vps/814081
** *"2015-03-20 23:04:51.042345 mon.0 10.214.130.49:6789/0 3 : cluster =
[WRN] message from mon.1 was stamped 14400.248297s in the future, clock=
s not synchronized" in cluster log*
*** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/gia=
nt.yaml 2-workload/sequential_run/test_rbd_api.yaml 3-upgrade-sequence/=
upgrade-all.yaml 4-final-workload/{rados-snaps-few-objects.yaml rados_l=
oadgenmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_import_export.yam=
l rgw_swift.yaml} distros/centos_6.5.yaml}":http://pulpito.ceph.com/teu=
thology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814=
155
** *Could not reconnect to ubuntu@vpm169.front.sepia.ceph.com*
*** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/gia=
nt.yaml 2-workload/sequential_run/ec-rados-default.yaml 3-upgrade-seque=
nce/upgrade-mon-osd-mds.yaml 4-final-workload/{rados-snaps-few-objects.=
yaml rados_loadgenmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_impor=
t_export.yaml rgw_swift.yaml} distros/rhel_7.0.yaml}":http://pulpito.ce=
ph.com/teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-bas=
ic-vps/814108
** *Could not reconnect to ubuntu@vpm166.front.sepia.ceph.com*
*** "upgrade:giant-x/stress-split-erasure-code/{0-cluster/start.yaml 1-=
giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/defa=
ult.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-next-mon/mo=
nb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Djerasure-k=3D=
3-m=3D1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology=
-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814194
** *'sudo adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/co=
verage daemon-helper kill ceph-mon -f -i a'*
*** "upgrade:giant-x/stress-split-erasure-code-x86_64/{0-cluster/start.=
yaml 1-giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thra=
sh/default.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-next=
-mon/monb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Disa-k=3D=
2-m=3D1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology=
-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814197
** *timed out waiting for admin_socket to appear after osd.13 restart*
*** "upgrade:giant-x/stress-split/{0-cluster/start.yaml 1-giant-install=
/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/default.yaml 4-mo=
n/mona.yaml 5-workload/{rbd-cls.yaml rbd-import-export.yaml readwrite.y=
aml snaps-few-objects.yaml} 6-next-mon/monb.yaml 7-workload/{radosbench=
=2Eyaml rbd_api.yaml} 8-next-mon/monc.yaml 9-workload/{rbd-python.yaml =
rgw-swift.yaml snaps-many-objects.yaml} distros/rhel_6.5.yaml}":http://=
pulpito.ceph.com/teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-=
distro-basic-vps/814186

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Sage Weil" <sweil@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Sunday, March 22, 2015 1:54:06 AM
> Subject: hammer tasks in http://tracker.ceph.com/projects/ceph-releas=
es
>=20
> Hi Sage,
>=20
> You have created a few hammer related tasks at http://tracker.ceph.co=
m/projects/ceph-releases/issues . What did you have in mind ?
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
