From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Different geoms for an rbd block device
Date: Tue, 30 Oct 2012 14:58:34 -0700
Message-ID: <50904D8A.80405@inktank.com>
References: <CABYiri_v2mP61oHOM0G9ndSOKn=i7fPGHir9pSCXg-2z_5s0RA@mail.gmail.com> <509041A4.8070508@inktank.com> <CABYiri8KcpMt=+1WHWvxkDuMF1=f-=oB7oJDNDhVgaAZF_PF7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:37819 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757791Ab2J3V6q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 17:58:46 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so304647dak.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 14:58:45 -0700 (PDT)
In-Reply-To: <CABYiri8KcpMt=+1WHWvxkDuMF1=f-=oB7oJDNDhVgaAZF_PF7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 10/30/2012 02:41 PM, Andrey Korolyov wrote:
> On Wed, Oct 31, 2012 at 1:07 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> On 10/28/2012 03:02 AM, Andrey Korolyov wrote:
>>>
>>> Hi,
>>>
>>> Should following behavior considered to be normal?
>>>
>>> $ rbd map test-rack0/debiantest --user qemukvm --secret qemukvm.key
>>> $ fdisk /dev/rbd1
>>>
>>> Command (m for help): p
>>>
>>> Disk /dev/rbd1: 671 MB, 671088640 bytes
>>> 255 heads, 63 sectors/track, 81 cylinders, total 1310720 sectors
>>> Units = sectors of 1 * 512 = 512 bytes
>>> Sector size (logical/physical): 512 bytes / 512 bytes
>>> I/O size (minimum/optimal): 4194304 bytes / 4194304 bytes
>>> Disk identifier: 0x00056f14
>>>
>>>        Device Boot      Start         End      Blocks   Id  System
>>> /dev/rbd1p1            2048       63487       30720   82  Linux swap /
>>> Solaris
>>> Partition 1 does not start on physical sector boundary.
>>> /dev/rbd1p2           63488     1292287      614400   83  Linux
>>> Partition 2 does not start on physical sector boundary.
>>>
>>> Meanwhile, in the guest vm over same image:
>>>
>>> fdisk /dev/vda
>>>
>>> Command (m for help): p
>>>
>>> Disk /dev/vda: 671 MB, 671088640 bytes
>>> 16 heads, 63 sectors/track, 1300 cylinders, total 1310720 sectors
>>
>>
>> I'm guessing the reported number of cylinders is the issue?
>> You can control that with a qemu option. I think
>>
>> -drive ...cyls=81
>>
>> will do it. You can also set the min/opt i/o sizes via
>> qemu device properties min_io_size and opt_io_size in
>> the same way you can adjust discard granularity:
>>
>> http://ceph.com/docs/master/rbd/qemu-rbd/#enabling-discard-trim
>>
>> Unfortunately min_io_size is a uint16 in qemu, so it won't
>> be able to store 4194304.
>>
>>
>>> Units = sectors of 1 * 512 = 512 bytes
>>> Sector size (logical/physical): 512 bytes / 512 bytes
>>> I/O size (minimum/optimal): 512 bytes / 512 bytes
>>> Disk identifier: 0x00056f14
>>>
>>>      Device Boot      Start         End      Blocks   Id  System
>>> /dev/vda1            2048       63487       30720   82  Linux swap /
>>> Solaris
>>> /dev/vda2           63488     1292287      614400   83  Linux
>>>
>>> The real pain starts when I try to repartition disk from after 'rbd
>>> map' using its geometry - it simply broke partition layout, for
>>> example, first block offset moves from 2048b to 8192. Of course I can
>>> specify geometry by hand, but before that I may need to start vm at
>>> least once or do something else which will print me out actual layout.
>>>
>>> Thanks!
>>
>>
>> Setting the geometry at qemu boot time should work, and is a bit easier.
>> qemu actually has code to try to guess disk geometry from a partition
>> table, but perhaps it doesn't support the format you're using.
>>
>> Josh
>
> So preferable geometry is one provided by kernel client, right? Is
> there any advantages of using large blocks for I/O with discard(ofc,
> not right now, I`ll wait for virtio bus support :) )?  At first sight,
> TCP transfers should not differ by resulting speed on typical
> workloads, but only on exotic ones - like delayed commit on the guest
> FS + intensive writes.

Generally larger I/Os are better, but the kernel in the guest will
probably restrict them to less than the full 4MB. I'm not sure how
large discard operations will get, but if they span an entire object
the object will be deleted instead of needing to zero out a chunk of it.
