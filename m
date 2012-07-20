From: George Shuklin <shuklin@selectel.ru>
Subject: Re: Ceph write performance
Date: Fri, 20 Jul 2012 14:48:56 +0400
Message-ID: <50093798.9020903@selectel.ru>
References: <500931CF.9040407@selectel.ru> <20120720104150.GA16630@oder.kd-bie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37572 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2GTKtB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 06:49:01 -0400
Received: by lbbgm6 with SMTP id gm6so4846937lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 03:49:00 -0700 (PDT)
In-Reply-To: <20120720104150.GA16630@oder.kd-bie.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>, ceph-devel@vger.kernel.org

On 20.07.2012 14:41, Dieter Kasper (KD) wrote:

Good day.

Thank you for attention.

ramdisk size ~70Gb (modprobe brd rd_size=70000000)
journal seems be on same device as storage
size of OSD was unchanged (... means I create it by manual and do not 
make any specific changes)

During test I watch IO load closely, IO on MDS/MON was insignificant 
(most of the time zero, sometimes few very mild peaks).

Just in case, configs:

ceph.conf:

[osd]
         osd journal size = 1000
         filestore xattr use omap = true

[mon.a]
         host = srv1
         mon addr = 192.168.0.1:6789

[osd.0]
         host = srv1

[mds.a]
         host = srv1

fio.ini:
[test]
blocksize=4k
filename=/media/test
size=16g
fallocate=posix
rw=randread
direct=1
buffered=0
ioengine=libaio
iodepth=32


Thanks for advising, I'll recheck with new settings.

> George,
>
> please share more details of your config:
> - RAM size of your system
> - location of the journal
> - size of your OSD
>
> Can you try (just for the 1st test) to
> .. put the journal on RAM disk	
> .. put the MDS on RAM disk
> .. put the MON on RAM disk
> .. use btrfs for OSD
>
> As an alternative to isolate the bottleneck you can try to
> - run without a journal
> - use RBD instead Ceph-FS
>    + create a File System on top of the /dev/rbd0
>
> Regards,
> Dieter Kasper
>
>
> On Fri, Jul 20, 2012 at 12:24:15PM +0200, George Shuklin wrote:
>> Good day.
>>
>> I've start to play with Ceph... And I found some kinda strange
>> performance issues. I'm not sure if this is due ceph limitation or my
>> bad setup.
>>
>> Setup:
>>
>> osd - xfs on ramdisk (only one osd)
>> mds - raid0 on 10 disks
>> mon - second raid0 on 10 disks
>>
>> I've mount ceph share at localhost and run FIO (randwrite, 4k, iodepth=32)
>>
>> What I've got: 1900 IOPS on writing (4k block, 1Gb span).
>>
>> Normally fio shows about 200kIOPS writing on ramdisk.
>>
>> Why it was so slow? I've  done setup exactly like described here:
>> http://ceph.com/docs/master/start/quick-start/#start-the-ceph-cluster
>> (but one osd).
>>
>> Thanks.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

