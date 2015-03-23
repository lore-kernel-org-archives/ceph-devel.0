From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-releases
Date: Mon, 23 Mar 2015 12:27:30 -0400 (EDT)
Message-ID: <1870188374.1796251.1427128050935.JavaMail.zimbra@redhat.com>
References: <550E832E.6040004@dachary.org> <1042516820.1185244.1427041005119.JavaMail.zimbra@redhat.com> <550F5FC7.3040400@dachary.org> <995426416.1709433.1427123361564.JavaMail.zimbra@redhat.com> <551033D2.2030109@dachary.org> <618219498.1762834.1427125479056.JavaMail.zimbra@redhat.com> <55103AEC.209@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:40540 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbbCWQ2d convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 12:28:33 -0400
In-Reply-To: <55103AEC.209@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Loic, done, pls review and edit.

Thx
YuriW

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Yuri Weinstein" <yweinste@redhat.com>
Cc: "Sage Weil" <sweil@redhat.com>, "Ceph Development" <ceph-devel@vger=
=2Ekernel.org>
Sent: Monday, March 23, 2015 9:10:20 AM
Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-rele=
ases



On 23/03/2015 16:44, Yuri Weinstein wrote:
>=20
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Sage Weil" <sweil@redhat.com>, "Ceph Development" <ceph-devel@vg=
er.kernel.org>
> Sent: Monday, March 23, 2015 8:40:02 AM
> Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-re=
leases
>=20
> Hi Yuri,
>=20
> On 23/03/2015 16:09, Yuri Weinstein wrote:
>> "How will that go for the next run of upgrade/giant-x ?"
>>
>> I was thinking that as soon as for example this suite passed, #11189=
 gets resolved as thus indicates that it's ready for for the hammer rel=
ease cut.=20
>=20
> If the following happens:
>=20
> * hammer: upgrade/giant-x runs and passes
> * a dozen more commits are added because problems are fixed
> * hammer: upgrade/giant-x runs and passes
>=20
> That leaves us with two issues with the same name but with different =
update dates. So if I look at the "hammer: upgrade/giant-x" issues in c=
hronological order, I have a complete history of the successive runs an=
d I can check the latest one to see how it went. Or older ones if I nee=
d to dig the history.=20
>=20
> This is good :-)
>=20
> After hammer is released, the same will presumably happen for point r=
eleases. Instead of naming them "hammer: upgrade/giant-x" which would b=
e confusing, I guess we could name them "v0.94.1: upgrade/giant-x" inst=
ead.=20
>=20
> Does that sound right ?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Yes, we can alternatively name the set of those tasks as hammer v0.94=
=2E1

Great !

Would you like me to add a section at http://tracker.ceph.com/projects/=
ceph-releases/wiki/Wiki to summarize this conversation ?

>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yuri Weinstein" <yweinste@redhat.com>
>> Cc: "Sage Weil" <sweil@redhat.com>, "Ceph Development" <ceph-devel@v=
ger.kernel.org>
>> Sent: Sunday, March 22, 2015 5:35:19 PM
>> Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-r=
eleases
>>
>>
>>
>> On 22/03/2015 17:16, Yuri Weinstein wrote:
>>> Loic, I think the idea was to do more process driven approach for r=
eleasing hammer, e.g. keep track of suites vs. results and open issues,=
 so we can have a high level view on status at any time before the fina=
l cut day.
>>>
>>> Do you have any suggestions or objections?
>>
>> Reading http://tracker.ceph.com/issues/11189 I see it has one run, a=
nd a run of failed tests, and got resolved because all passed. The titl=
e is hammer: upgrade/giant-x. How will that go for the next run of upgr=
ade/giant-x ?
>>
>> I use a python snippet to display the errors in a redmine format (ht=
tp://workbench.dachary.org/dachary/ceph-workbench/issues/2)
>>
>> $ python ../fail.py teuthology-2015-03-20_17:05:02-upgrade:giant-x-h=
ammer-distro-basic-vps
>> ** *'mkdir -p -- /home/ubuntu/cephtest/mnt.1/client.1/tmp && cd -- /=
home/ubuntu/cephtest/mnt.1/client.1/tmp && CEPH_CLI_TEST_DUP_COMMAND=3D=
1 CEPH_REF=3Dgiant TESTDIR=3D"/home/ubuntu/cephtest" CEPH_ID=3D"1" PATH=
=3D$PATH:/usr/sbin adjust-ulimits ceph-coverage /home/ubuntu/cephtest/a=
rchive/coverage timeout 3h /home/ubuntu/cephtest/workunit.client.1/cls/=
test_cls_rgw.sh'*
>> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/=
giant.yaml 2-workload/parallel_run/{ec-rados-parallel.yaml rados_api.ya=
ml rados_loadgenbig.yaml test_cache-pool-snaps.yaml test_rbd_api.yaml t=
est_rbd_python.yaml} 3-upgrade-sequence/upgrade-mon-osd-mds.yaml 4-fina=
l-workload/{rados-snaps-few-objects.yaml rados_loadgenmix.yaml rados_mo=
n_thrash.yaml rbd_cls.yaml rbd_import_export.yaml rgw_swift.yaml} distr=
os/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology-2015-03-20_17:05:=
02-upgrade:giant-x-hammer-distro-basic-vps/814081
>> ** *"2015-03-20 23:04:51.042345 mon.0 10.214.130.49:6789/0 3 : clust=
er [WRN] message from mon.1 was stamped 14400.248297s in the future, cl=
ocks not synchronized" in cluster log*
>> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/=
giant.yaml 2-workload/sequential_run/test_rbd_api.yaml 3-upgrade-sequen=
ce/upgrade-all.yaml 4-final-workload/{rados-snaps-few-objects.yaml rado=
s_loadgenmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_import_export.=
yaml rgw_swift.yaml} distros/centos_6.5.yaml}":http://pulpito.ceph.com/=
teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/=
814155
>> ** *Could not reconnect to ubuntu@vpm169.front.sepia.ceph.com*
>> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/=
giant.yaml 2-workload/sequential_run/ec-rados-default.yaml 3-upgrade-se=
quence/upgrade-mon-osd-mds.yaml 4-final-workload/{rados-snaps-few-objec=
ts.yaml rados_loadgenmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_im=
port_export.yaml rgw_swift.yaml} distros/rhel_7.0.yaml}":http://pulpito=
=2Eceph.com/teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distr=
o-basic-vps/814108
>> ** *Could not reconnect to ubuntu@vpm166.front.sepia.ceph.com*
>> *** "upgrade:giant-x/stress-split-erasure-code/{0-cluster/start.yaml=
 1-giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/d=
efault.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-next-mon=
/monb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Djerasure-k=
=3D3-m=3D1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthol=
ogy-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814194
>> ** *'sudo adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive=
/coverage daemon-helper kill ceph-mon -f -i a'*
>> *** "upgrade:giant-x/stress-split-erasure-code-x86_64/{0-cluster/sta=
rt.yaml 1-giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-t=
hrash/default.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-n=
ext-mon/monb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Disa=
-k=3D2-m=3D1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuth=
ology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/81419=
7
>> ** *timed out waiting for admin_socket to appear after osd.13 restar=
t*
>> *** "upgrade:giant-x/stress-split/{0-cluster/start.yaml 1-giant-inst=
all/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/default.yaml 4=
-mon/mona.yaml 5-workload/{rbd-cls.yaml rbd-import-export.yaml readwrit=
e.yaml snaps-few-objects.yaml} 6-next-mon/monb.yaml 7-workload/{radosbe=
nch.yaml rbd_api.yaml} 8-next-mon/monc.yaml 9-workload/{rbd-python.yaml=
 rgw-swift.yaml snaps-many-objects.yaml} distros/rhel_6.5.yaml}":http:/=
/pulpito.ceph.com/teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer=
-distro-basic-vps/814186
>>
>>>
>>> Thx
>>> YuriW
>>>
>>> ----- Original Message -----
>>> From: "Loic Dachary" <loic@dachary.org>
>>> To: "Sage Weil" <sweil@redhat.com>
>>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>>> Sent: Sunday, March 22, 2015 1:54:06 AM
>>> Subject: hammer tasks in http://tracker.ceph.com/projects/ceph-rele=
ases
>>>
>>> Hi Sage,
>>>
>>> You have created a few hammer related tasks at http://tracker.ceph.=
com/projects/ceph-releases/issues . What did you have in mind ?
>>>
>>> Cheers
>>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
