From: Samuel Just <sjust@redhat.com>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Thu, 14 Apr 2016 11:30:23 -0700
Message-ID: <CAN=+7FWgJ847myrN2f_JJRJm5jjwXJ8z4uTH4oAn0BPx4WU5uw@mail.gmail.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
	<alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com>
	<4CD9DBC4-1A26-4C03-8DC6-BF36A1156611@schermer.cz>
	<alpine.DEB.2.11.1604121345060.29593@cpach.fuggernut.com>
	<8CF37229-17C6-4E49-A623-FB8933631F60@schermer.cz>
	<alpine.DEB.2.11.1604121525020.29593@cpach.fuggernut.com>
	<2CBEF339-052C-42D8-A6EA-5BA9C5B8DE9F@schermer.cz>
	<alpine.DEB.2.11.1604121639590.29593@cpach.fuggernut.com>
	<alpine.DEB.2.11.1604122137200.24055@cpach.fuggernut.com>
	<CAB=cV2TvwZ946soq-YDbjrb+miXJe7BJzHPsxe9hm7iNdNqgJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:32975 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703AbcDNSaY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2016 14:30:24 -0400
Received: by mail-yw0-f181.google.com with SMTP id t10so113049233ywa.0
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2016 11:30:24 -0700 (PDT)
In-Reply-To: <CAB=cV2TvwZ946soq-YDbjrb+miXJe7BJzHPsxe9hm7iNdNqgJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jianjian Huo <samuel.huo@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Jan Schermer <jan@schermer.cz>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

It doesn't seem like it would be wise to run such systems on top of rbd.
-Sam

On Thu, Apr 14, 2016 at 11:05 AM, Jianjian Huo <samuel.huo@gmail.com> wrote:
> On Wed, Apr 13, 2016 at 6:06 AM, Sage Weil <sage@newdream.net> wrote:
>> On Tue, 12 Apr 2016, Jan Schermer wrote:
>>> Who needs to have exactly the same data in two separate objects
>>> (replicas)? Ceph needs it because "consistency"?, but the app (VM
>>> filesystem) is fine with whatever version because the flush didn't
>>> happen (if it did the contents would be the same).
>>
>> While we're talking/thinking about this, here's a simple example of why
>> the simple solution (let the replicas be out of sync), which seems
>> reasonable at first, can blow up in your face.
>>
>> If a disk block contains A and you write B over the top of it and then
>> there is a failure (e.g. power loss before you issue a flush), it's okay
>> for the disk to contain either A or B.  In a replicated system, let's say
>> 2x mirroring (call them R1 and R2), you might end up with B on R1 and A
>> on R2.  If you don't immediately clean it up, then at some point down the
>> line you might switch from reading R1 to reading R2 and the disk block
>> will go "back in time" (previously you read B, now you read A).  A
>> single disk/replica will never do that, and applications can break.
>>
>> For example, if the block in question is a journal block, we might see B
>> the first time (valid journal!), the do a bunch of work and
>> journal/write new stuff to the blocks that follow.  Then we lose
>> power again, lose R1, replay the journal, read A from R2, and stop journal
>> replay early... missing out on all the new stuff.  This can easily corrupt
>> a file system or database or whatever else.
>
> If data is critical, applications use their own replicas, MySQL,
> Cassandra, MongoDB... if above scenario happens and one replica is out
> of sync, they use quorum like protocol to guarantee reading the latest
> data, and repair those out-of-sync replicas. so eventual consistency
> in storage is acceptable for them?
>
> Jianjian
>>
>> It might sound unlikely, but keep in mind that writes to these
>> all-important metadata and commit blocks are extremely frequent.  It's the
>> kind of thing you can usually get away with, until you don't, and then you
>> have a very bad day...
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
