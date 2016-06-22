From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v2 21/24] libceph: Replace CURRENT_TIME with ktime_get_real_ts
Date: Tue, 21 Jun 2016 17:56:07 -0700
Message-ID: <CABeXuvr80F+3sBnVgTNL80V3HX+DZHhDNQ47JP7AQ0j5oSUFQQ@mail.gmail.com>
References: <1466382443-11063-1-git-send-email-deepa.kernel@gmail.com>
 <1466382443-11063-22-git-send-email-deepa.kernel@gmail.com> <936f4df1-dfb9-1906-019e-8f82b8e950eb@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33483 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbcFVA4O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2016 20:56:14 -0400
Received: by mail-it0-f66.google.com with SMTP id y93so3762704ita.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jun 2016 17:56:08 -0700 (PDT)
In-Reply-To: <936f4df1-dfb9-1906-019e-8f82b8e950eb@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

Adding Arnd, as he is the overall y2038 project lead.

>> CURRENT_TIME is not y2038 safe.
>> The macro will be deleted and all the references to it
>> will be replaced by ktime_get_* apis.
>>
>> struct timespec is also not y2038 safe.
>> Retain timespec for timestamp representation here as ceph
>> uses it internally everywhere.
>> These references will be changed to use struct timespec64
>> in a separate patch.
> Hi Deepa,
>
> Although I applaud 64-bit timestamps,
> the ktime_get_* api seems to be a Linux only API.
> So IF ever things need to be the least bit portable, I suggest wrapping
> these routines into a class of itself. So that porting confines itself
> to only that class. (plus/minus hairy semantic details)

ktime_get_* apis just return 64 bit timestamps.
They are the equivalent of CURRENT_TIME.
Did you have a wrapper for CURRENT_TIME?

Are these concerns about all of ceph kernel code or just that the libceph
is expected to be portable?

> For what is now committed the change is not really that big.
>
> On the other hand, I 'll have to start figuring out if FreeBSD really
> does do 64bit timestamps...

From what I can see here:
http://fxr.watson.org/fxr/ident?im=10;i=__time_t,

FreeBSD time_t is already 64 bit long.
So it supports 64 bit timestamps already.

> So I would welcome a more elaborate description of the problem (it seems
> that Linux is going 64bit in its inodes??) and what is being fixed and
> how. So that in the porting case not only the code will be the source to
> figure out what is going on.

Yes, all inode timestamps are going to be switched over to use timespec64 i.e.,
64 bit timestamps.
We will switch over just the vfs layer: struct inode, struct attr and
struct kstat.
End filesystems such as ceph will still use timespec at this time.
So whenever they access vfs timestamps, they will go through conversion apis:
timespec64_to_timespec() / timespec_to_timespec64().

My reference tree is https://github.com/deepa-hub/vfs/tree/y2038 .

This gives you an overall idea of the changes.
Only a few names have to be updated according to review discussions.
But, you can see what the end filesystems will look like after the vfs
switch-over.

The problem with ceph is really that the timestamps sent over wire use the same
encode/ decode function calls whether the timestamp is related to files or not.
I'm not sure what the plan for wire protocol is here. As Sage
suggested on the thread:
http://www.spinics.net/lists/ceph-devel/msg28960.html , you could
interpret time values as u32.

After this, porting to BSD should be straight forward.
Then, you can substitute nanotime() for ktime_get_real_ts64()?:
http://fxr.watson.org/fxr/source/kern/kern_tc.c?im=3#L387,938

-Deepa
