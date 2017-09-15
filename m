From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: snapshots
Date: Fri, 15 Sep 2017 17:23:00 -0400
Message-ID: <CAGbvivKoNjjE03nG=d0vrNH=eJDjFHPMQV=geeqqY990ebFeGQ@mail.gmail.com>
References: <CAKRxpuukift+7ovzeDnTbNtAzKM6=sBEmoQyLbQUebLJ9rwCQQ@mail.gmail.com>
 <alpine.DEB.2.11.1709151734310.16664@piezo.novalocal> <CAKRxputBSva77sH_xhHKoHZL6xKY+Hp0jdzMFnGgn0Z4Udrz=g@mail.gmail.com>
 <alpine.DEB.2.11.1709151825080.16664@piezo.novalocal> <CA+9C14Yk=p8wEPj8Z0mK81jAt6mtr-r=oFWdvndWoBeSw8w_yw@mail.gmail.com>
 <CAGbviv+F8b3qSZ-JBKoWPdgU2F9rdDj4tLEasVe_TLOg9N9ehg@mail.gmail.com> <alpine.DEB.2.11.1709152021250.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:55361 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdIOVXB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 17:23:01 -0400
Received: by mail-it0-f49.google.com with SMTP id 4so4821654itv.4
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 14:23:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709152021250.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Eric Eastman <eric.eastman@keepertech.com>, Two Spirit <twospirit6905@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Its 10.2.7 and yes, I will file a bug soon.

On Fri, Sep 15, 2017 at 4:22 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 15 Sep 2017, Wyllys Ingersoll wrote:
>> Following up on this issue:
>>
>> Does having too many cephfs snapshots prevent the deletion of older
>> ones? We've got about 4800 snapshots and attempted to purge some older
>> ones, but the "rmdir" of the old snapshots seems to hang and is not
>> ever completing.
>>
>> ceph -s shows an ever increasing number of blocked requests while this
>> is going on. I waited over 10 minutes for 1 snapshot to delete before
>> I finally killed the "find" command that was attempting to remove the
>> old snapshots.  The blocked request count keeps going up anyway and
>> the .snap directory seems unresponsive to 'ls' or other commands.
>
> Sounds like a bug; it should be a quick operation.  What version?  Can you
> submit a bug report?  Preferably with a matching MDS log (and debug mds =
> 20, debug ms = 1).
>
> sage
>
>>
>>
>>
>> On Fri, Sep 15, 2017 at 2:59 PM, Eric Eastman
>> <eric.eastman@keepertech.com> wrote:
>> > Just watch how many snapshots you create.  We hit an issues around
>> > 4,700 snapshots of a singe file system.  See:
>> > https://www.spinics.net/lists/ceph-devel/msg38203.html
>> >
>> > Eric
>> >
>> > On Fri, Sep 15, 2017 at 12:25 PM, Sage Weil <sage@newdream.net> wrote:
>> >> On Fri, 15 Sep 2017, Two Spirit wrote:
>> >>> Excellent. Yes  was takling about CephFS. So basically it tags and
>> >>> versions all objects and their corresponding metadata. Doesn't
>> >>> actually replicate anything, and keeps the old objects around in the
>> >>> OSDs?
>> >>
>> >> Something like that.  :)
>> >>
>> >> s
>> >>
>> >>>
>> >>> On Fri, Sep 15, 2017 at 10:37 AM, Sage Weil <sage@newdream.net> wrote:
>> >>> > On Fri, 15 Sep 2017, Two Spirit wrote:
>> >>> >> few questions
>> >>> >
>> >>> > I'm assuming you're talking about CephFS snapshots here:
>> >>> >
>> >>> >> 1) Is the idea of snapshotting about 100TB of data doable with Ceph?
>> >>> >
>> >>> > You can snapshot the entire file system (petabytes) if you like.
>> >>> >
>> >>> >> 2) How long would such a task take? Are we talking seconds, minutes,
>> >>> >> hours, days, weeks?
>> >>> >
>> >>> > Seconds (if that).
>> >>> >
>> >>> >> 3) what does "stop i/o" mean. Does the filesystem unavailable to the
>> >>> >> user during the snapshot time, or is this administratively unavailable
>> >>> >> to the user, or does ceph stop io somewhere while in parallel the data
>> >>> >> can be read/written to?
>> >>> >
>> >>> > There's no IO stoppage.  Clients essentially mark a barrier in their
>> >>> > writeback caches so that previously buffered writes are contained in the
>> >>> > snapshot and new writes are not.  How long it takes for that data to be
>> >>> > flushed and stable/durable on OSDs depends on how big your client caches
>> >>> > are, but that does not cause any io stoppage or gap in availability for
>> >>> > users of the file system.
>> >>> >
>> >>> > sage
>> >>> --
>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >>> the body of a message to majordomo@vger.kernel.org
>> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>>
>> >>>
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
