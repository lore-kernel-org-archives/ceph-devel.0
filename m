From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Performance benchmark of rbd
Date: Sat, 23 Jun 2012 07:53:51 +0200 (CEST)
Message-ID: <318b9228-b40f-494f-8070-008c6d3588d8@mailpro>
References: <8512670932FB654F81AF0FEF1BE6D49D018390EB@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:45787 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2FWFyQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jun 2012 01:54:16 -0400
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D018390EB@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric YH Chen <Eric_YH_Chen@wiwynn.com>
Cc: ceph-devel@vger.kernel.org, Chris YT Huang <Chris_YT_Huang@wiwynn.com>, Victor CY Chang <Victor_CY_Chang@wiwynn.com>, mark nelson <mark.nelson@inktank.com>

Hi Eric,

Do you have find any clue about slow random write iops ?

I'm doing some benchmark from a kvm guest with fio, random 4K block,
fio --filename=3D$DISK --direct=3D1 --rw=3Drandwrite --bs=3D4k --size=3D=
200G --numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1

journal is on tmpfs and storage is 15k drive

I can't have more than 1000-2000 iops.

I Don't understand why I don't have a lot more iops.=20
If journal is on tmpfs, it should be around 30000iops on a gigabit link=
 (using all the bandwith)

I also try use rbd_caching on my kvm guest, didn't change nothing.

sequential write with 4MB block can use the full the gigabit link (arou=
nd 100MB/S)


Is the bottleneck the in rbd protocol ?


----- Mail original -----=20

De: "Eric YH Chen" <Eric_YH_Chen@wiwynn.com>=20
=C3=80: "mark nelson" <mark.nelson@inktank.com>=20
Cc: ceph-devel@vger.kernel.org, "Chris YT Huang" <Chris_YT_Huang@wiwynn=
=2Ecom>, "Victor CY Chang" <Victor_CY_Chang@wiwynn.com>=20
Envoy=C3=A9: Jeudi 14 Juin 2012 03:26:12=20
Objet: RE: Performance benchmark of rbd=20

Hi, Mark:=20

I forget to mention one thing, I create the rbd at the same machine and=
=20
test it. That means the network latency may be lower than normal case.=20

1.=20
I use ext4 as the backend filesystem and with following attribute.=20
data=3Dwriteback,noatime,nodiratime,user_xattr=20

2.=20
I use the default replication number, I think it is 2, right?=20

3.=20
On my platform, I have 192GB memory=20

4. Sorry about the column name is left-right reversal. Here is the=20
correct one=20
Seq-write Seq-read=20
32 KB 23 MB/s 690 MB/s=20
512 KB 26 MB/s 960 MB/s=20
4 MB 27 MB/s 1290 MB/s=20
32 MB 36 MB/s 1435 MB/s=20

5. If I put all the journal data on a SSD device (Intel 520).=20
The sequence write performance would reach 135MB/s instead of=20
27MB/s in original. (object size =3D 4MB). And others are no different,=
=20
including random-write. I am curious why the SSD device doesn't=20
help the performance of random-write.=20

6. For the random read write, the data I provided before was correct.=20
But I can give you the detail. Is it too high than what you expected?=20

rand-write-4k rand-write-16k=20
bw iops bw iops=20
3,524 881 9,032 564=20

mix-4k (50/50)=20
r:bw r:iops w:bw w:iops=20
2,925 731 2,924 731=20

mix-8k (50/50)=20
r:bw r:iops w:bw w:iops=20
4,509 563 4,509 563=20

mix-16k (50/50)=20
r:bw r:iops w:bw w:iops=20
8,366 522 8,345 521=20


7.=20
Here is the hw raid cache policy we used now.=20
Write Policy Write Back with BBU=20
Read Policy ReadAhead=20

If you are interested in how HW raid help the performance, I can do for=
=20
little help, since we also want to know what is the best configuration=20
on our platform. Any test you want to know?=20


=46urthermore, is there any suggestion for our platform that can improv=
e=20
the performance? Thanks!=20



-----Original Message-----=20
=46rom: Mark Nelson [mailto:mark.nelson@inktank.com]=20
Sent: Wednesday, June 13, 2012 8:30 PM=20
To: Eric YH Chen/WYHQ/Wiwynn=20
Cc: ceph-devel@vger.kernel.org=20
Subject: Re: Performance benchmark of rbd=20

Hi Eric!=20

On 6/13/12 5:06 AM, Eric_YH_Chen@wiwynn.com wrote:=20
> Hi, all:=20
>=20
> I am doing some benchmark of rbd.=20
> The platform is on a NAS storage.=20
>=20
> CPU: Intel E5640 2.67GHz=20
> Memory: 192 GB=20
> Hard Disk: SATA 250G * 1, 7200 rpm (H0) + SATA 1T * 12 , 7200rpm=20
> (H1~ H12)=20
> RAID Card: LSI 9260-4i=20
> OS: Ubuntu12.04 with Kernel 3.2.0-24=20
> Network: 1 Gb/s=20
>=20
> We create 12 OSD on H1 ~ H12 with the journal is put on H0.=20

Just to make sure I understand, you have a single node with 12 OSDs and=
=20
3 mons, and all 12 OSDs are using the H0 disk for their journals? What=20
filesystem are you using for the OSDs? How much replication?=20

> We also create 3 MON in the cluster.=20
> In briefly, we setup a ceph cluster all-in-one, with 3 monitors=20
and=20
> 12 OSD.=20
>=20
> The benchmark tool we used is fio 2.0.3. We had 7 basic test case=20
> 1) sequence write with bs=3D64k=20
> 2) sequence read with bs=3D64k=20
> 3) random write with bs=3D4k=20
> 4) random write with bs=3D16k=20
> 5) mix read/write with bs=3D4k=20
> 6) mix read/write with bs=3D8k=20
> 7) mix read/write with bs=3D16k=20
>=20
> We create several rbd with different object size for the=20
benchmark.=20
>=20
> 1. size =3D 20G, object size =3D 32KB=20
> 2. size =3D 20G, object size =3D 512KB=20
> 3. size =3D 20G, object size =3D 4MB=20
> 4. size =3D 20G, object size =3D 32MB=20

Given how much memory you have, you may want to increase the amount of=20
data you are writing during each test to rule out caching.=20

>=20
> We have some conclusion after the benchmark.=20
>=20
> a. We can get better performance of sequence read/write when the=20
> object size is bigger.=20
> Seq-read Seq-write=20
> 32 KB 23 MB/s 690 MB/s=20
> 512 KB 26 MB/s 960 MB/s=20
> 4 MB 27 MB/s 1290 MB/s=20
> 32 MB 36 MB/s 1435 MB/s=20

Which test are these results from? I'm suspicious that the write=20
numbers are so high. Figure that even with a local client and 1X=20
replication, your journals and data partitions are each writing out a=20
copy of the data. You don't have enough disk in that box to sustain=20
1.4GB/s to both even under perfectly ideal conditions. Given that it=20
sounds like you are using a single 7200rpm disk for 12 journals, I woul=
d=20

expect far lower numbers...=20

>=20
> b. There is no obvious influence for random read/write when the=20
> object size is different.=20
> All the result are in a range not more than 10%.=20
>=20
> rand-write-4K rand-write-16K mix-4K=20
> mix-8k mix-16k=20
> 881 iops 564 iops=20
> 1462 iops 1127 iops 1044 iops=20
>=20
> c. It we change the environment, for every 3 hard drive, we bind=20
> them together by RAID0. (LSI 9260-4i RAID card)=20
> So the ceph cluster becomes 3 MONs and 4 OSD (3T for each)=20
> We can get better performance on all items, around 10% ~ 20%=20
> enhancement.=20

Those IOPs numbers are more what I would expect. Using HW raid0 may=20
provide some benefit depending on the number of OSDs per node. It's=20
something we haven't had time to look at yet in detail, but is on our=20
list.=20

>=20
> d. If we change H0 to a SSD device, and we also put all journal=20
> on it. We can get better performance on sequence-write.=20
> It would reach 135MB/s. However, there are no different for=20
other=20
> test items.=20
>=20
> We want to check with you, if all the conclusion are reasonable=20
for=20
> you? Or any seems strange? Thanks!=20

When you say that using an SSD device increases the sequence-write=20
speeds to 135MB/s, what are you comparing that to? Incidentally that=20
level of performance is entirely believable with 12 OSDs sharing a=20
single SSD for journals.=20

The write results with the 7200rpm journal disk do look strange to me,=20
but it's tough to say what's going on. If the numbers are accurate, I'd=
=20

say writes aren't getting to the disks. If they are mislabeled (IE=20
1.435MB/s or 1435Mb/s instead 1435MB/s), then things are more believabl=
e=20

and I'd try putting your journals on a small partition on each disk=20
(causes some extra seek behavior and lower OSD throughput, but better=20
than stacking the journals up on a single slow disk).=20

>=20
> =3D=3D=3D=3D=20
>=20
> Here is some data if I use command provided by rados.=20
> rados -p rbd bench 120 write -t 8=20
>=20
> Total time run: 120.751713=20
> Total writes made: 930=20
> Write size: 4194304=20
> Bandwidth (MB/sec): 30.807=20
>=20
> Average Latency: 1.03807=20
> Max latency: 2.63197=20
> Min latency: 0.205726=20
>=20
> [INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.219819 sec=20
> at 79318 KB/sec=20

That looks much closer to what I would expect if you have 12 journals=20
all sharing a single 7200rpm drive.=20

>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20

Mark=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
