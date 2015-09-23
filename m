From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: perf counters from a performance discrepancy
Date: Wed, 23 Sep 2015 13:52:58 -0700
Message-ID: <CAJ4mKGYiZtaGZqRnG+r+sfhONNBkCukRrOXE6tX84orSzdwCLA@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9192500992@SATLEXDAG01.amd.com>
	<CAJ4mKGap3+xK5yecofei-H7upgt4waiRH2fAPmVLEXdrAmUxjQ@mail.gmail.com>
	<BC97738F8E7C8742BABED7F06FB9DF9192500C22@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33970 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910AbbIWUw7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 16:52:59 -0400
Received: by wicfx3 with SMTP id fx3so1717642wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 13:52:58 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9192500C22@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Sep 23, 2015 at 1:51 PM, Deneau, Tom <tom.deneau@amd.com> wrote:
>
>
>> -----Original Message-----
>> From: Gregory Farnum [mailto:gfarnum@redhat.com]
>> So if you've got 20k objects and 5 OSDs then each OSD is getting ~4k reads
>> during this test. Which if I'm reading these properly means OSD-side
>> latency is something like 1.5 milliseconds for the single client and...144
>> milliseconds for the two-client case! You might try dumping some of the
>> historic ops out of the admin socket and seeing where the time is getting
>> spent (is it all on disk accesses?). And trying to reproduce something
>> like this workload on your disks without Ceph involved.
>> -Greg
>
> Greg --
>
> Not sure how much it matters but in looking at the pools more closely I
> was getting mixed up with an earlier experiment with pools that just used 5 osds.
> The pools for this example actually distributed across 15 osds on 3 nodes.

Okay, so this is running on hard drives, not SSDs. The speed
differential is a lot more plausibly in the drive/filesystem/total
layout in that case, then...

>
> What is the recommended command for dumping historic ops out of the admin socket?

"ceph daemon osd.<N> dump_historic_ops", I think. "ceph daemon osd.<N>
help" will include it in the list, though.
