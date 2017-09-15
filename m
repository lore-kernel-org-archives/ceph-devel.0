From: Eric Eastman <eric.eastman@keepertech.com>
Subject: Re: snapshots
Date: Fri, 15 Sep 2017 12:59:27 -0600
Message-ID: <CA+9C14Yk=p8wEPj8Z0mK81jAt6mtr-r=oFWdvndWoBeSw8w_yw@mail.gmail.com>
References: <CAKRxpuukift+7ovzeDnTbNtAzKM6=sBEmoQyLbQUebLJ9rwCQQ@mail.gmail.com>
 <alpine.DEB.2.11.1709151734310.16664@piezo.novalocal> <CAKRxputBSva77sH_xhHKoHZL6xKY+Hp0jdzMFnGgn0Z4Udrz=g@mail.gmail.com>
 <alpine.DEB.2.11.1709151825080.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:46491 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdIOS7t (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 14:59:49 -0400
Received: by mail-wr0-f176.google.com with SMTP id o42so2502267wrb.3
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 11:59:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709151825080.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Two Spirit <twospirit6905@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Just watch how many snapshots you create.  We hit an issues around
4,700 snapshots of a singe file system.  See:
https://www.spinics.net/lists/ceph-devel/msg38203.html

Eric

On Fri, Sep 15, 2017 at 12:25 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 15 Sep 2017, Two Spirit wrote:
>> Excellent. Yes  was takling about CephFS. So basically it tags and
>> versions all objects and their corresponding metadata. Doesn't
>> actually replicate anything, and keeps the old objects around in the
>> OSDs?
>
> Something like that.  :)
>
> s
>
>>
>> On Fri, Sep 15, 2017 at 10:37 AM, Sage Weil <sage@newdream.net> wrote:
>> > On Fri, 15 Sep 2017, Two Spirit wrote:
>> >> few questions
>> >
>> > I'm assuming you're talking about CephFS snapshots here:
>> >
>> >> 1) Is the idea of snapshotting about 100TB of data doable with Ceph?
>> >
>> > You can snapshot the entire file system (petabytes) if you like.
>> >
>> >> 2) How long would such a task take? Are we talking seconds, minutes,
>> >> hours, days, weeks?
>> >
>> > Seconds (if that).
>> >
>> >> 3) what does "stop i/o" mean. Does the filesystem unavailable to the
>> >> user during the snapshot time, or is this administratively unavailable
>> >> to the user, or does ceph stop io somewhere while in parallel the data
>> >> can be read/written to?
>> >
>> > There's no IO stoppage.  Clients essentially mark a barrier in their
>> > writeback caches so that previously buffered writes are contained in the
>> > snapshot and new writes are not.  How long it takes for that data to be
>> > flushed and stable/durable on OSDs depends on how big your client caches
>> > are, but that does not cause any io stoppage or gap in availability for
>> > users of the file system.
>> >
>> > sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
