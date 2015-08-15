From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: /sys/block and /dev and partitions
Date: Sat, 15 Aug 2015 20:42:56 +0300
Message-ID: <CAOi1vP-0Kz6x=nEO=9yijNfS1QzN9hEa0GMQR94Ggv-KCrM=cw@mail.gmail.com>
References: <55CF1F99.5050807@dachary.org>
	<alpine.DEB.2.00.1508150727060.32106@cobra.newdream.net>
	<55CF5C4B.2010406@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38036 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbbHORm5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Aug 2015 13:42:57 -0400
Received: by igfj19 with SMTP id j19so30960543igf.1
        for <ceph-devel@vger.kernel.org>; Sat, 15 Aug 2015 10:42:56 -0700 (PDT)
In-Reply-To: <55CF5C4B.2010406@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Aug 15, 2015 at 6:35 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sage,
>
> On 15/08/2015 16:28, Sage Weil wrote:
>> On Sat, 15 Aug 2015, Loic Dachary wrote:
>>> Hi,
>>>
>>> Is there a portable and consistent way to figure out if a given /dev/XXX
>>> path (for instance /dev/dm-1) is a partition of a whole device ?
>>> Although checking /sys/block/dm-1/dm/name for a number at the end (like
>>> mpatha1 or mpatha2) would probably work, it feels like a fragile hack.
>>> Looking into /sys/block/dm-1/slaves will lead to
>>> /sys/block/dm-1/slaves/dm-0 and we can check that
>>> /sys/block/dm-*/subsystem is class/block. But that does not necessarily
>>> mean dm-1 is a partition of dm-0, just that it's a slave of dm-0.
>>
>> Take a look at is_partition in ceph-disk, whih is the best I came up with.
>> Basically it checks if the device name appears as /sys/block/*/$foo...

For regular devices, you can access() /sys/dev/block/maj:min/partition.
If it's there, it's a partition - no need to iterate over /sys/block.

>
> That is consistently updated for /dev/sdb or /dev/vdb but things are different when using multipath. I'll rely on /sys/block/dm-?/dm/name instead until a better solution is found.

A better way might be to rely on the fact that a dm partition will
necessarily have its uuid prefixed by "part".  In that case, it should
be safe to assume that the thing in slaves is a whole disk - I think
that's what various util-linux tools do.  However, IIRC the dm uuid is
optional, so that won't work on a dm device without a uuid.

Thanks,

                Ilya
