From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Possible corruption with MSSQL on RBD
Date: Sat, 22 Oct 2016 17:30:55 +0200
Message-ID: <CABZ+qqkw4JrLko0bjjVWXF_o3nibDzVCRitnf8GUK+pZy+4pNA@mail.gmail.com>
References: <262972897.5995.1476280634060@ox.pcextreme.nl> <CAJ4mKGZx+PgcqAPVB0LSFxp1z=aZiKWt-H1hjnKJU5_hxAoxWg@mail.gmail.com>
 <439702971.6004.1476287822395@ox.pcextreme.nl> <2126451990.6086.1476439471715@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35833 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936614AbcJVPbj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Oct 2016 11:31:39 -0400
Received: by mail-wm0-f41.google.com with SMTP id c78so33656055wme.0
        for <ceph-devel@vger.kernel.org>; Sat, 22 Oct 2016 08:31:38 -0700 (PDT)
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com. [74.125.82.49])
        by smtp.gmail.com with ESMTPSA id 63sm4957333wmv.1.2016.10.22.08.31.36
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Oct 2016 08:31:36 -0700 (PDT)
Received: by mail-wm0-f49.google.com with SMTP id c78so37496800wme.1
        for <ceph-devel@vger.kernel.org>; Sat, 22 Oct 2016 08:31:36 -0700 (PDT)
In-Reply-To: <2126451990.6086.1476439471715@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Oct 14, 2016 at 12:04 PM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 12 oktober 2016 om 17:57 schreef Wido den Hollander <wido@42on.com>:
>>
>>
>>
>> > Op 12 oktober 2016 om 17:01 schreef Gregory Farnum <gfarnum@redhat.com>:
>> >
>> >
>> > On Wed, Oct 12, 2016 at 7:57 AM, Wido den Hollander <wido@42on.com> wrote:
>> > > Hi,
>> > >
>> > > I filed a issue in the tracker, but I'm looking for some feedback to diagnose this a bit further: http://tracker.ceph.com/issues/17545
>> > >
>> > > The situation is that with a Firefly or Hammer (haven't tested Jewel yet) a MSSQL server running on RBD will sometimes complain about corruption.
>> > >
>> > > Using SQLioSim we can reproduce the issue on a small Proxmox + Ceph cluster and after an hour or so it will yield:
>> > >
>> > > Expected FileId: 0x0
>> > > Received FileId: 0x0
>> > > Expected PageId: 0xCB19C
>> > > Received PageId: 0xCB19A (does not match expected)
>> > > Received CheckSum: 0x9F444071
>> > > Calculated CheckSum: 0x89603EC9 (does not match expected)
>> > > Received Buffer Length: 0x2000
>> > >
>> > > The issue only seems to happen with RBD caching enabled. When disabling the RBD cache or using cache=directsync we were not able to reproduce the issue.
>> > >
>> > > When using LVM/file based backends for Qemu the problem also didn't pop up.
>> > >
>> > > So this seems to be either a librbd issue or the RBD driver inside Qemu.
>> > >
>> > > Any hints on how to debug this further to find the root cause?
>> >
>> > If you've got control over the clients, try building with commit
>> > 9ec6e7f608608088d51e449c9d375844631dcdde backported to them (I believe
>> > it's also in the latest Hammer release, but maybe there hasn't been
>> > one cut since the backport?); tracked at
>> > http://tracker.ceph.com/issues/16002 but of course the web site is
>> > dead so you can't look at that right now. :(
>>
>> I verified, but 9ec6e7 is not in v0.94.9, but it is in the Jewel release.
>>
>> Tests are running with Jewel now and I will probably have the results tomorrow. If Jewel doesn't break the commit you send might indeed resolve it.
>>
>
> The tests have been running for over 24 hours and all still looks good. We will let it run for over the weekend to make sure it has been fixed.

Is there still some follow up needed on this? It seems that latest
hammer is still at risk for an RBD corruption bug, right?

I've understood that you don't see the problem any more with jewel,
but I didn't see any confirmation that 9ec6e7 is indeed the fix. Did
you run any more testing of hammer + 9ec6e7?

Cheers, Dan
