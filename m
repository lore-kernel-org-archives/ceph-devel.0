From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: is rados block cluster production ready ?
Date: Fri, 18 May 2012 11:58:44 +0200 (CEST)
Message-ID: <b8e35866-361b-4fb2-9273-4c29017158d0@mailpro>
References: <CAJafhzR2PLsH1B3Wwz5c=WAmVNsA1+GeTVKR4o7uLJVoeC_Ubw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:52060 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762250Ab2ERJ7G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 05:59:06 -0400
In-Reply-To: <CAJafhzR2PLsH1B3Wwz5c=WAmVNsA1+GeTVKR4o7uLJVoeC_Ubw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <christian@brunner-muc.de>
Cc: ceph-devel@vger.kernel.org

Hi Christian,
thanks for your response.

>>We are using 0.45 in production. Recent ceph versions are quite stabl=
e=20
>>(although we hat some troubles with excessive logging and a full log=20
>>partition lately which caused our cluster to halt).=20

excessive logging because of a configuration error ?=20


>>For the moment I would definitely recommend using XFS as the=20
>>underlying filesystem. At least until there is a fix for the=20
>>orphan_commit_root problem. XFS comes with a slight performance=20
>>impact, but it seems to be the only filesystem that is able to handle=
=20
>>heavy ceph workload for the moment.=20

What's the benefit of using btrfs ? snapshots ? (I would like to be abl=
e to do snapshots, maybe clones)


>>We are running a small ceph cluster (4 Servers with 4 OSDs each) on a=
=20
>>10GE network. Servers are spread across two datacenters with a 5km (3=
=20
>>mile) long 10GE fibre-link for data replication. Our servers are=20
>>equipped with 80GB Fusion-IO drives (for the journal) and traditional=
=20
>>3,5'' SAS drives in a RAID5 configuration (but I would not reccommend=
=20
>>this setup).=20

>>From a guest we can get a throughput ~ 500MB/s.=20

Great ! (And from multiple guests ? do you have more throughput ?)

Also about latencies, do you have good latencies with you fusion-io jou=
rnal?
I currently use zfs storage, and writes are going to fast journal nvram=
 then flushed to disk 15K.
It is the same behaviour with ceph ?

>>This is probably the best hardware for a ceph cluster money can buy.=20
>>Are you planning a single SAS drive per OSD?=20

Yes, on osd by drive.=20
So if something goes wrong with brtfs or xfs, I'll have only 1 failed d=
isk and not the whole raid.
Is it the right way for osd ?


>>I still don't know the cause exactly, but we are not able to saturate=
=20
>>10GE (maybe it's the latency on the WAN link or some network=20
>>configuration problem).=20

yes maybe. (I would like to have money for this kind of setup ;)

>>I did some artificial tests with btrfs with large metadata enabled=20
>>(e.g. mkfs.btrfs -l 64k -n 64k) the performance degradation seems to=20
>>be gone.=20

Great! (I'm very scary about this kind of bugs)


>>We are using bonding. The rados-client is doing a failover to another=
=20
>>osd node after a few seconds, when there is no response from the OSD.=
=20
>>(You should read about CRUSH in the ceph docs).=20


Thanks again for all your reponse. (Ceph community seem to be great :)

Regards,

Alexandre


----- Mail original -----=20

De: "Christian Brunner" <christian@brunner-muc.de>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Vendredi 18 Mai 2012 10:45:48=20
Objet: Re: is rados block cluster production ready ?=20

2012/5/18 Alexandre DERUMIER <aderumier@odiso.com>:=20
> Hi,=20
> I'm going to build a rados block cluster for my kvm hypervisors.=20
>=20
> Is it already production ready ? (stable,no crash)=20

We are using 0.45 in production. Recent ceph versions are quite stable=20
(although we hat some troubles with excessive logging and a full log=20
partition lately which caused our cluster to halt).=20

> I have read some btrfs bugs on this mailing list, so I'm a bit scary.=
=2E.=20

=46or the moment I would definitely recommend using XFS as the=20
underlying filesystem. At least until there is a fix for the=20
orphan_commit_root problem. XFS comes with a slight performance=20
impact, but it seems to be the only filesystem that is able to handle=20
heavy ceph workload for the moment.=20

> Also, what performance could I expect ?=20

We are running a small ceph cluster (4 Servers with 4 OSDs each) on a=20
10GE network. Servers are spread across two datacenters with a 5km (3=20
mile) long 10GE fibre-link for data replication. Our servers are=20
equipped with 80GB Fusion-IO drives (for the journal) and traditional=20
3,5'' SAS drives in a RAID5 configuration (but I would not reccommend=20
this setup).=20

=46rom a guest we can get a throughput ~ 500MB/s.=20

> I try to build a fast cluster, with fast ssd disk.=20
> each node : 8 osds with "ocz talos" sas drive + stec zeusram drive (8=
GB nvram) for the journal + 10GB ethernet.=20
> Do you think I can saturate the 10GB ?=20

This is probably the best hardware for a ceph cluster money can buy.=20
Are you planning a single SAS drive per OSD?=20

I still don't know the cause exactly, but we are not able to saturate=20
10GE (maybe it's the latency on the WAN link or some network=20
configuration problem).=20

> I also have some questions about performance in time.=20
> I have had somes problems with my zfs san and zfs fragmentation and m=
etastab problem.=20
> How does btrfs perform in time ?=20

I did some artificial tests with btrfs with large metadata enabled=20
(e.g. mkfs.btrfs -l 64k -n 64k) the performance degradation seems to=20
be gone.=20

> About network, does the rados protocol support some kind of multipath=
ing ? Or does I need to use bonding/lacp ?=20

We are using bonding. The rados-client is doing a failover to another=20
osd node after a few seconds, when there is no response from the OSD.=20
(You should read about CRUSH in the ceph docs).=20

Regards,=20
Christian=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
