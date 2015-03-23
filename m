From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-releases
Date: Mon, 23 Mar 2015 11:44:39 -0400 (EDT)
Message-ID: <618219498.1762834.1427125479056.JavaMail.zimbra@redhat.com>
References: <550E832E.6040004@dachary.org> <1042516820.1185244.1427041005119.JavaMail.zimbra@redhat.com> <550F5FC7.3040400@dachary.org> <995426416.1709433.1427123361564.JavaMail.zimbra@redhat.com> <551033D2.2030109@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:35477 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbbCWPpl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 11:45:41 -0400
In-Reply-To: <551033D2.2030109@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>



Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Sage Weil" <sweil@redhat.com>, "Ceph Development" <ceph-devel@vger=
=2Ekernel.org>
Sent: Monday, March 23, 2015 8:40:02 AM
Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-rele=
ases

Hi Yuri,

On 23/03/2015 16:09, Yuri Weinstein wrote:
> "How will that go for the next run of upgrade/giant-x ?"
>=20
> I was thinking that as soon as for example this suite passed, #11189 =
gets resolved as thus indicates that it's ready for for the hammer rele=
ase cut.=20

If the following happens:

* hammer: upgrade/giant-x runs and passes
* a dozen more commits are added because problems are fixed
* hammer: upgrade/giant-x runs and passes

That leaves us with two issues with the same name but with different up=
date dates. So if I look at the "hammer: upgrade/giant-x" issues in chr=
onological order, I have a complete history of the successive runs and =
I can check the latest one to see how it went. Or older ones if I need =
to dig the history.=20

This is good :-)

After hammer is released, the same will presumably happen for point rel=
eases. Instead of naming them "hammer: upgrade/giant-x" which would be =
confusing, I guess we could name them "v0.94.1: upgrade/giant-x" instea=
d.=20

Does that sound right ?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Yes, we can alternatively name the set of those tasks as hammer v0.94.1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Sage Weil" <sweil@redhat.com>, "Ceph Development" <ceph-devel@vg=
er.kernel.org>
> Sent: Sunday, March 22, 2015 5:35:19 PM
> Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-re=
leases
>=20
>=20
>=20
> On 22/03/2015 17:16, Yuri Weinstein wrote:
>> Loic, I think the idea was to do more process driven approach for re=
leasing hammer, e.g. keep track of suites vs. results and open issues, =
so we can have a high level view on status at any time before the final=
 cut day.
>>
>> Do you have any suggestions or objections?
>=20
> Reading http://tracker.ceph.com/issues/11189 I see it has one run, an=
d a run of failed tests, and got resolved because all passed. The title=
 is hammer: upgrade/giant-x. How will that go for the next run of upgra=
de/giant-x ?
>=20
> I use a python snippet to display the errors in a redmine format (htt=
p://workbench.dachary.org/dachary/ceph-workbench/issues/2)
>=20
> $ python ../fail.py teuthology-2015-03-20_17:05:02-upgrade:giant-x-ha=
mmer-distro-basic-vps
> ** *'mkdir -p -- /home/ubuntu/cephtest/mnt.1/client.1/tmp && cd -- /h=
ome/ubuntu/cephtest/mnt.1/client.1/tmp && CEPH_CLI_TEST_DUP_COMMAND=3D1=
 CEPH_REF=3Dgiant TESTDIR=3D"/home/ubuntu/cephtest" CEPH_ID=3D"1" PATH=3D=
$PATH:/usr/sbin adjust-ulimits ceph-coverage /home/ubuntu/cephtest/arch=
ive/coverage timeout 3h /home/ubuntu/cephtest/workunit.client.1/cls/tes=
t_cls_rgw.sh'*
> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/g=
iant.yaml 2-workload/parallel_run/{ec-rados-parallel.yaml rados_api.yam=
l rados_loadgenbig.yaml test_cache-pool-snaps.yaml test_rbd_api.yaml te=
st_rbd_python.yaml} 3-upgrade-sequence/upgrade-mon-osd-mds.yaml 4-final=
-workload/{rados-snaps-few-objects.yaml rados_loadgenmix.yaml rados_mon=
_thrash.yaml rbd_cls.yaml rbd_import_export.yaml rgw_swift.yaml} distro=
s/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology-2015-03-20_17:05:0=
2-upgrade:giant-x-hammer-distro-basic-vps/814081
> ** *"2015-03-20 23:04:51.042345 mon.0 10.214.130.49:6789/0 3 : cluste=
r [WRN] message from mon.1 was stamped 14400.248297s in the future, clo=
cks not synchronized" in cluster log*
> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/g=
iant.yaml 2-workload/sequential_run/test_rbd_api.yaml 3-upgrade-sequenc=
e/upgrade-all.yaml 4-final-workload/{rados-snaps-few-objects.yaml rados=
_loadgenmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_import_export.y=
aml rgw_swift.yaml} distros/centos_6.5.yaml}":http://pulpito.ceph.com/t=
euthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/8=
14155
> ** *Could not reconnect to ubuntu@vpm169.front.sepia.ceph.com*
> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/g=
iant.yaml 2-workload/sequential_run/ec-rados-default.yaml 3-upgrade-seq=
uence/upgrade-mon-osd-mds.yaml 4-final-workload/{rados-snaps-few-object=
s.yaml rados_loadgenmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_imp=
ort_export.yaml rgw_swift.yaml} distros/rhel_7.0.yaml}":http://pulpito.=
ceph.com/teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-b=
asic-vps/814108
> ** *Could not reconnect to ubuntu@vpm166.front.sepia.ceph.com*
> *** "upgrade:giant-x/stress-split-erasure-code/{0-cluster/start.yaml =
1-giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/de=
fault.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-next-mon/=
monb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Djerasure-k=3D=
3-m=3D1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology=
-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814194
> ** *'sudo adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/=
coverage daemon-helper kill ceph-mon -f -i a'*
> *** "upgrade:giant-x/stress-split-erasure-code-x86_64/{0-cluster/star=
t.yaml 1-giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-th=
rash/default.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-ne=
xt-mon/monb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Disa-=
k=3D2-m=3D1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teutho=
logy-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814197
> ** *timed out waiting for admin_socket to appear after osd.13 restart=
*
> *** "upgrade:giant-x/stress-split/{0-cluster/start.yaml 1-giant-insta=
ll/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/default.yaml 4-=
mon/mona.yaml 5-workload/{rbd-cls.yaml rbd-import-export.yaml readwrite=
=2Eyaml snaps-few-objects.yaml} 6-next-mon/monb.yaml 7-workload/{radosb=
ench.yaml rbd_api.yaml} 8-next-mon/monc.yaml 9-workload/{rbd-python.yam=
l rgw-swift.yaml snaps-many-objects.yaml} distros/rhel_6.5.yaml}":http:=
//pulpito.ceph.com/teuthology-2015-03-20_17:05:02-upgrade:giant-x-hamme=
r-distro-basic-vps/814186
>=20
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Sage Weil" <sweil@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Sunday, March 22, 2015 1:54:06 AM
>> Subject: hammer tasks in http://tracker.ceph.com/projects/ceph-relea=
ses
>>
>> Hi Sage,
>>
>> You have created a few hammer related tasks at http://tracker.ceph.c=
om/projects/ceph-releases/issues . What did you have in mind ?
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
