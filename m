From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: partprobe or partx or ... ?
Date: Mon, 21 Sep 2015 13:23:50 +0300
Message-ID: <CAOi1vP_Nz=c+sOWA44q6kvtiLCtZBTJZNaSNCPx5Qoyat=V+MQ@mail.gmail.com>
References: <55FD7DF8.7060601@dachary.org>
	<55FDC0C4.6050103@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33157 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509AbbIUKXw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Sep 2015 06:23:52 -0400
Received: by wiclk2 with SMTP id lk2so139163998wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Sep 2015 03:23:51 -0700 (PDT)
In-Reply-To: <55FDC0C4.6050103@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Sep 19, 2015 at 11:08 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 19/09/2015 17:23, Loic Dachary wrote:
>> Hi Ilya,
>>
>> At present ceph-disk uses partprobe to ensure the kernel is aware of the latest partition changes after a new one is created, or after zapping the partition table. Although it works reliably (in the sense that the kernel is indeed aware of the desired partition layout), it goes as far as to remove all partition devices of the current kernel table, only to re-add them with the new partition table. The delay it implies is not an issue because ceph-disk is rarely called. It however generate many udev events (dozens remove/change/add for a two partition disk) and almost always creates border cases that are difficult to figure out and debug. While it is a good way to ensure that ceph-disk is idempotent and immune to race conditions, maybe it is needlessly hard.
>>
>> Do you know of a light weight alternative to partprobe ? In the past we've used partx but I remember it failed to address some border cases in non-intuitive ways. Do you know of another, simpler, approach to this ?
>>
>> Thanks in advance for your help :-)
>>
>
> For the record using /sys/block/sdX/device/rescan sounds good but does not exist for devices created via devicemapper (used for dmcrypt and multipath).

Hi Loic,

Yeah, partprobe loops through the entire partition table, trying do
delete/add every slot.  As an aside, the in-kernel way to do this
(blockdev --rereadpt) is similar in that it also drops all partitions
and re-adds them later, but it's faster and probably generates less
change events.  The downside is it won't work on busy device.

I don't think there is any alternative, except for using partx --add
with --nr, that is targeting specific slots in the partition table.  If
all you are doing is adding partitions and zapping entire partition
tables, that may work well enough.

That said, given that the resulting delay (which can be in the seconds
range, especially if your disk happens to have a busy partition) isn't
a problem, what difference does it make?  What are you listening to
those events for?

/sys/block/sdX/device/rescan is sd only, and AFAIK it doesn't generally
trigger a re-read of a partition table.

Thanks,

                Ilya
