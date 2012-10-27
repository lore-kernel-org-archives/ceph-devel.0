From: Raghunandhan <raghunandhan.g@iihtcloudsolutions.com>
Subject: Re: [ceph-commit] Ceph Zfs
Date: Sat, 27 Oct 2012 12:20:46 +0630
Message-ID: <90df19a3c42ca43a1bc6afff2697e026@iihtcloudsolutions.com>
References: <441865dbf9e127f0b85193c512878a76@iihtcloudsolutions.com>
 <alpine.DEB.2.00.1210250834010.25762@cobra.newdream.net>
 <2a1583303809db2f73424d268d79e0ea@iihtcloudsolutions.com>
 <508AE6A9.3020104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from oproxy11-pub.bluehost.com ([173.254.64.10]:40889 "HELO
	oproxy11-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751538Ab2J0Fut (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Oct 2012 01:50:49 -0400
In-Reply-To: <508AE6A9.3020104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

ceph status when used with zfs filesystem osd dies.

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


---
Regards,
Raghunandhan.G


On 27-10-2012 02:08, Dan Mick wrote:
> On 10/25/2012 09:46 PM, Raghunandhan wrote:
>> Hi Sage,
>>
>> Thanks for replying back, Once a zpool is created if i mount it on
>> /var/lib/ceph/osd/ceph-0 the cephfs doesnt recognize it as a 
>> superblock
>> and hence it fails,
>
> I assume you mean "once a zfs is created"?  One can't mount zpools, 
> can one?
>
>> Im trying to build this on our cloud storage since
>> btrfs has not been stable nor they have come up with online dedup i 
>> have
>> no other choice for now to work with zfs ceph which makes sense.
>>
>> So what i exactly did was created a zpool store
>> 1 Then used the same store and made a block device from it using zfs 
>> create
>> 2 Once the zfs create was successful i was able to format with ext4
>> using xattr
>> 3 On top of it was the ceph
>>
>> Following this process doesnt make sense because of multiple layer 
>> on
>> the storage and the ceph consumes a lot of RAM and cpu cycles which 
>> ends
>> up in kernel hung task. It would be great if there is a way i could
>> directly use the zfs pool with ceph and make it work.
>
> Have you actually tried making a zfs filesystem in the zpool, and
> using that as backing store for the osd?
>
>>
>> ---
>> Regards,
>> Raghunandhan.G
>> IIHT Cloud Solutions Pvt. Ltd.
>> #15, 4th Floor, 'A' Wing, Sri Lakshmi Complex,
>> St. Marks Road, Bangalore - 560 001, India
>>
>> On 25-10-2012 22:06, Sage Weil wrote:
>>> [moved to ceph-devel]
>>>
>>> On Thu, 25 Oct 2012, Raghunandhan wrote:
>>>> Hi All,
>>>>
>>>> I have been working around ceph quite a long and trying to stitch 
>>>> zfs
>>>> with
>>>> ceph. I was able to do it to certain extent as follows:
>>>> 1. zpool creation
>>>> 2. set dedup
>>>> 3. create a mountable volume of zfs (zfs create)
>>>> 4. format the volume with ext4 and enabling xattr
>>>> 5. mkcephfs on the volume
>>>>
>>>> This actually works and dedup is perfect. But i need to avoid
>>>> multiple layers
>>>> on the storage since the performance is very slow and the kernel 
>>>> timeout
>>>> occurs often for a 8GB RAM. I want to test the performance between
>>>> btrfs and
>>>> zfs. I want to avoid the above multiple layering on storage and 
>>>> make
>>>> the ceph
>>>> cluster aware of zfs. Let me know if anyone has workaround this.
>>>
>>> I'm not familiar enough with zfs to know what 'mountable volume' 
>>> means..
>>> is that a block device/lun that you're putting ext4 on?  Probably 
>>> the
>>> best
>>> results will come from creating a zfs *file system* (using the ZPL 
>>> or
>>> whatever it is) and running ceph-osd on top of that.
>>>
>>> There is at least one open bug from someone having problems there, 
>>> but
>>> we'd very much like to sort out the problem.
>>>
>>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

