From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: problems creating new ceph cluster when using journal on block device
Date: Thu, 8 Nov 2012 10:01:41 -0500
Message-ID: <CACkq2mr=dmHX+Z6fTMUvct78pa9RWeGid5vHK1vNw1_S-NWgDw@mail.gmail.com>
References: <CACkq2mozdJackj__AB_ZJnN5KR9mdqN_LRG8RPu0hN1qh_8e_g@mail.gmail.com>
 <509B6883.4010406@widodh.nl> <509B6C2E.2050708@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:45161 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab2KHPCD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 10:02:03 -0500
Received: by mail-yh0-f46.google.com with SMTP id m54so578265yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 07:02:02 -0800 (PST)
In-Reply-To: <509B6C2E.2050708@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

>>> [osd]
>>>          osd journal size = 4000
>>
>>
>> Not sure if this is the problem, but when using a block device you don't
>> have to specify the size for the journal.

So happy to know that, Wido!  I had hoped there was a way to skip that.

Tried without it -- only difference in the logs was seeing that it
picked up the full size of the partition.  So, same result.

> Also might be useful to know make/model of ssd, plus motherboard make/model
> (in case commenting out size does not fix)!

It's an Intel X25-E, 64GB.  It's a place-holder until some bigger ones
we have on order show up.

The mother board is a SuperMicro X8DT6.  SSDs are connected to onboard
SATA ports, data drives are connected to LSI 9211-8i (SAS2008)

Maybe there is a special way I need to do the partition?  My goal was
to throw 6 journals on this disk, and it is partitioned like so:

Model: ATA SSDSA2SH064G1GC (scsi)
Disk /dev/sda: 64.0GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start   End     Size    Type      File system  Flags
 1      1049kB  512MB   511MB   primary                raid
 2      512MB   2511MB  2000MB  primary                raid
 3      2511MB  6512MB  4000MB  primary                raid
 4      6512MB  64.0GB  57.5GB  extended
 5      6513MB  15.1GB  8590MB  logical
 6      15.1GB  23.7GB  8590MB  logical
 7      23.7GB  32.3GB  8590MB  logical
 8      32.3GB  40.9GB  8590MB  logical
 9      40.9GB  49.5GB  8590MB  logical
10      49.5GB  58.1GB  8590MB  logical


So, sda5-10 are my journal partitions.  I know that I have consumed
most of the drive here, and that is bad for the SSD and such, but it
really is a temporary setup.

 - Travis

On Thu, Nov 8, 2012 at 3:24 AM, Mark Kirkwood
<mark.kirkwood@catalyst.net.nz> wrote:
> On 08/11/12 21:08, Wido den Hollander wrote:
>>
>>
>>
>> On 08-11-12 08:29, Travis Rhoden wrote:
>>>
>>> Hey folks,
>>>
>>> I'm trying to set up a brand new Ceph cluster, based on v0.53.  My
>>> hardware has SSDs for journals, and I'm trying to get mkcephfs to
>>> intialize everything for me. However, the command hangs forever and I
>>> eventually have to kill it.
>>>
>>> After poking around a bit, it's clear that the problem has something
>>> to do with the journal.  If I comment out the journal in ceph.conf,
>>> the commands proceed just find.  This is the first time I've tried to
>>> throw a journal on a block device rather than a file, so maybe I've
>>> done something wrong with that.
>>>
>>> Here is the info from ceph.conf:
>>>
>>>
>>> [osd]
>>>          osd journal size = 4000
>>
>>
>> Not sure if this is the problem, but when using a block device you don't
>> have to specify the size for the journal.
>
>
> Also might be useful to know make/model of ssd, plus motherboard make/model
> (in case commenting out size does not fix)!
>
> Regards
>
> Mark
>
