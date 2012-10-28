From: Raghunandhan <raghunandhan.g@iihtcloudsolutions.com>
Subject: Re: [ceph-commit] Ceph Zfs
Date: Sun, 28 Oct 2012 11:49:49 +0630
Message-ID: <438def0896879b5f296464ab6bd48c9a@iihtcloudsolutions.com>
References: <441865dbf9e127f0b85193c512878a76@iihtcloudsolutions.com>
 <alpine.DEB.2.00.1210250834010.25762@cobra.newdream.net>
 <2a1583303809db2f73424d268d79e0ea@iihtcloudsolutions.com>
 <508AE6A9.3020104@inktank.com>
 <731607e6ab51c087aba7893a7e61ccee@iihtcloudsolutions.com>
 <alpine.DEB.2.00.1210271014340.23037@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from oproxy12-pub.bluehost.com ([50.87.16.10]:40549 "HELO
	oproxy12-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750882Ab2J1FTu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Oct 2012 01:19:50 -0400
In-Reply-To: <alpine.DEB.2.00.1210271014340.23037@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel@vger.kernel.org


On 27-10-2012 23:45, Sage Weil wrote:
> On Sat, 27 Oct 2012, Raghunandhan wrote:
>> Hi Dan,
>>
>> Yes once a zpool is created there is a way we can use the zpool and 
>> make a
>> partition out of it using "zfs create -V". The newly created 
>> partition will be
>> available on fdisk. Later the same partition can be formatted with 
>> ext4 and
>> used with ceph-osd.
>>
>> I have also tried using a zfs filesystem in the zpool and mapped it 
>> with osd.
>> When i run mkcephfs i get "error creating empty object store /osd.0: 
>> (22)
>> invalid argument
>>
>> == osd.0 ===
>> 2012-10-27 10:40:33.939961 7f6e6165d780 -1 filestore(/osd.0) 
>> mkjournal error
>> creating journal on /osd.0/journal: (22) Invalid argument
>> 2012-10-27 10:40:33.939981 7f6e6165d780 -1 OSD::mkfs: 
>> FileStore::mkfs failed
>> with error -22
>> 2012-10-27 10:40:33.940036 7f6e6165d780 -1  ** ERROR: error creating 
>> empty
>> object store in /osd.0: (22) Invalid argument
>> failed: '/sbin/mkcephfs -d /tmp/mkcephfs.3zqOx7Btvl --init-daemon 
>> osd.0'
>
> Can you generate a log with 'debug filestore = 20' of this happening 
> so we
> can see exactly which operation is failing with -EINVAL?  There is
> probably some ioctl or syscall that is going awry.
>
> Thanks!
> sage

Above issue was rectified with journal dio=false in ceph.conf

ceph status when used with zfs filesystem OSD dies on one node but its 
still up on other node.

# ceph -s
    health HEALTH_WARN 407 pgs degraded; 169 pgs down; 169 pgs peering; 
15 pgs recovering; 323 pgs stuck unclean; recovery 38/42 degraded 
(90.476%); 19/21 unfound (90.476%); 1/2 in osds are down
    monmap e1: 2 mons at {a=11.0.0.2:6789/0,b=11.0.0.3:6789/0}, election 
epoch 4, quorum 0,1 a,b
    osdmap e7: 2 osds: 1 up, 2 in
     pgmap v10: 576 pgs: 15 active+recovering+degraded, 169 
down+peering, 392 active+degraded; 8059 bytes data, 1004 MB used, 85683 
MB / 86687 MB avail; 38/42 degraded (90.476%); 19/21 unfound (90.476%)
    mdsmap e5: 1/1/1 up {0=a=up:active}, 1 up:standby

Log file generated when 2 osd's where up and later it went down.

2012-10-27 11:14:07.152741 mon.0 11.0.0.2:6789/0 27 : [INF] osdmap e5: 
2 osds: 2 up, 2 in
2012-10-27 11:14:07.192719 mon.0 11.0.0.2:6789/0 28 : [INF] pgmap v6: 
576 pgs: 576 creating; 0 bytes data, 0 KB used, 0 KB / 0 KB avail
2012-10-27 11:14:12.007671 mon.0 11.0.0.2:6789/0 29 : [INF] pgmap v7: 
576 pgs: 272 creating, 43 active, 253 active+clean, 8 active+recovering; 
1243 bytes data, 1003 MB used, 85684 MB / 86687 MB avail; 9/18 degraded 
(50.000%)
2012-10-27 11:14:32.014302 mon.0 11.0.0.2:6789/0 30 : [DBG] osd.0 
11.0.0.2:6801/24250 reported failed by osd.1 11.0.0.3:6801/8443
2012-10-27 11:14:37.033547 mon.0 11.0.0.2:6789/0 31 : [DBG] osd.0 
11.0.0.2:6801/24250 reported failed by osd.1 11.0.0.3:6801/8443
2012-10-27 11:14:42.060678 mon.0 11.0.0.2:6789/0 32 : [DBG] osd.0 
11.0.0.2:6801/24250 reported failed by osd.1 11.0.0.3:6801/8443
2012-10-27 11:14:42.060827 mon.0 11.0.0.2:6789/0 33 : [INF] osd.0 
11.0.0.2:6801/24250 failed (3 reports from 1 peers after 30.046376 >= 
grace 20.000000)
2012-10-27 11:14:42.157536 mon.0 11.0.0.2:6789/0 34 : [INF] osdmap e6: 
2 osds: 1 up, 2 in

osd.0 dies after a while:

2012-10-27 11:19:46.751562 mon.0 11.0.0.2:6789/0 40 : [INF] osd.0 out 
(down for 304.604259)
2012-10-27 11:19:46.785574 mon.0 11.0.0.2:6789/0 41 : [INF] osdmap e8: 
2 osds: 1 up, 1 in
2012-10-27 11:19:46.811588 mon.0 11.0.0.2:6789/0 42 : [INF] pgmap v12: 
576 pgs: 15 active+recovering+degraded, 169 down+peering, 392 
active+degraded; 8059 bytes data, 1004 MB used, 85683 MB / 86687 MB 
avail; 38/42 degraded (90.476%); 19/21 unfound (90.476%)
2012-10-27 11:19:49.591172 mon.0 11.0.0.2:6789/0 43 : [INF] pgmap v13: 
576 pgs: 15 active+recovering+degraded, 169 down+peering, 392 
active+degraded; 8059 bytes data, 1004 MB used, 85683 MB / 86687 MB 
avail; 38/42 degraded (90.476%); 19/21 unfound (90.476%)
2012-10-27 11:20:04.671337 mon.0 11.0.0.2:6789/0 44 : [INF] pgmap v14: 
576 pgs: 15 active+recovering+degraded, 169 down+peering, 392 
active+degraded; 8059 bytes data, 1004 MB used, 85683 MB / 86687 MB 
avail; 38/42 degraded (90.476%); 19/21 unfound (90.476%)

status of osd.1 as of now:
2012-10-28 10:48:54.022338 osd.1 11.0.0.3:6801/8443 396978 : [WRN] slow 
request 84884.436995 seconds old, received at 2012-10-27 
11:14:09.585282: osd_op(mds.0.1:28 200.00000001 [write 131~671] 
1.6e5f474 RETRY) v4 currently delayed
2012-10-28 10:48:54.022343 osd.1 11.0.0.3:6801/8443 396979 : [WRN] slow 
request 84851.874118 seconds old, received at 2012-10-27 
11:14:42.148159: osd_op(mds.0.1:29 200.00000000 [writefull 0~84] 
1.844f3494 RETRY) v4 currently delayed
2012-10-28 10:48:54.022346 osd.1 11.0.0.3:6801/8443 396980 : [WRN] slow 
request 81939.241084 seconds old, received at 2012-10-27 
12:03:14.781193: osd_op(mds.0.1:30 200.00000001 [write 802~183] 
1.6e5f474) v4 currently delayed
2012-10-28 10:48:54.022350 osd.1 11.0.0.3:6801/8443 396981 : [WRN] slow 
request 81939.240915 seconds old, received at 2012-10-27 
12:03:14.781362: osd_op(mds.0.1:31 200.00000000 [writefull 0~84] 
1.844f3494) v4 currently delayed

---
Regards,
Raghunandhan.G

>>
>> ---
>> Regards,
>> Raghunandhan.G
>> IIHT Cloud Solutions Pvt. Ltd.
>> #15, 4th Floor, 'A' Wing, Sri Lakshmi Complex,
>> St. Marks Road, Bangalore - 560 001, India
>>
>> On 27-10-2012 02:08, Dan Mick wrote:
>> > On 10/25/2012 09:46 PM, Raghunandhan wrote:
>> > > Hi Sage,
>> > >
>> > > Thanks for replying back, Once a zpool is created if i mount it 
>> on
>> > > /var/lib/ceph/osd/ceph-0 the cephfs doesnt recognize it as a 
>> superblock
>> > > and hence it fails,
>> >
>> > I assume you mean "once a zfs is created"?  One can't mount 
>> zpools, can one?
>> >
>> > > Im trying to build this on our cloud storage since
>> > > btrfs has not been stable nor they have come up with online 
>> dedup i have
>> > > no other choice for now to work with zfs ceph which makes sense.
>> > >
>> > > So what i exactly did was created a zpool store
>> > > 1 Then used the same store and made a block device from it using 
>> zfs
>> > > create
>> > > 2 Once the zfs create was successful i was able to format with 
>> ext4
>> > > using xattr
>> > > 3 On top of it was the ceph
>> > >
>> > > Following this process doesnt make sense because of multiple 
>> layer on
>> > > the storage and the ceph consumes a lot of RAM and cpu cycles 
>> which ends
>> > > up in kernel hung task. It would be great if there is a way i 
>> could
>> > > directly use the zfs pool with ceph and make it work.
>> >
>> > Have you actually tried making a zfs filesystem in the zpool, and
>> > using that as backing store for the osd?
>> >
>> > >
>> > > ---
>> > > Regards,
>> > > Raghunandhan.G
>> > > IIHT Cloud Solutions Pvt. Ltd.
>> > > #15, 4th Floor, 'A' Wing, Sri Lakshmi Complex,
>> > > St. Marks Road, Bangalore - 560 001, India
>> > >
>> > > On 25-10-2012 22:06, Sage Weil wrote:
>> > > > [moved to ceph-devel]
>> > > >
>> > > > On Thu, 25 Oct 2012, Raghunandhan wrote:
>> > > > > Hi All,
>> > > > >
>> > > > > I have been working around ceph quite a long and trying to 
>> stitch zfs
>> > > > > with
>> > > > > ceph. I was able to do it to certain extent as follows:
>> > > > > 1. zpool creation
>> > > > > 2. set dedup
>> > > > > 3. create a mountable volume of zfs (zfs create)
>> > > > > 4. format the volume with ext4 and enabling xattr
>> > > > > 5. mkcephfs on the volume
>> > > > >
>> > > > > This actually works and dedup is perfect. But i need to 
>> avoid
>> > > > > multiple layers
>> > > > > on the storage since the performance is very slow and the 
>> kernel
>> > > > > timeout
>> > > > > occurs often for a 8GB RAM. I want to test the performance 
>> between
>> > > > > btrfs and
>> > > > > zfs. I want to avoid the above multiple layering on storage 
>> and make
>> > > > > the ceph
>> > > > > cluster aware of zfs. Let me know if anyone has workaround 
>> this.
>> > > >
>> > > > I'm not familiar enough with zfs to know what 'mountable 
>> volume' means..
>> > > > is that a block device/lun that you're putting ext4 on?  
>> Probably the
>> > > > best
>> > > > results will come from creating a zfs *file system* (using the 
>> ZPL or
>> > > > whatever it is) and running ceph-osd on top of that.
>> > > >
>> > > > There is at least one open bug from someone having problems 
>> there, but
>> > > > we'd very much like to sort out the problem.
>> > > >
>> > > > sage
>> > >
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe 
>> ceph-devel" in
>> > > the body of a message to majordomo@vger.kernel.org
>> > > More majordomo info at  
>> http://vger.kernel.org/majordomo-info.html
>>
>>
