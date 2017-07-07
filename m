From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: kraken <--> luminous osd map decoding
Date: Fri, 7 Jul 2017 13:53:01 -0700
Message-ID: <CAB2gnbUvHPR92Tva=t3==+0EjJGvomvpkSZeGxpP1Nq-BkZr7g@mail.gmail.com>
References: <CAB2gnbVuTdkGbW38h1Tu7+9ebXH_6-4NPCHNOdT+zNJMCB=Awg@mail.gmail.com>
 <CAB2gnbVtfEGpp1z1ipVk7rCC2uM_6hea64vsLZTPX9X0wh+W=Q@mail.gmail.com>
 <CAJ4mKGZFc7b5xQaiRd5S9WgCQ32Jzfy4B=i3ub4z1TRC0FO6pw@mail.gmail.com>
 <CAB2gnbWUqjOTk3jwzxyAJAbqSg0Xq7rsRZnNkEqFm4631HDKoQ@mail.gmail.com> <CAJ4mKGZyXkEtkqKm0bZYcx6Qju4yxmaBA5xzcowsWkM4g1AZvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35098 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdGGUxD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jul 2017 16:53:03 -0400
Received: by mail-yb0-f175.google.com with SMTP id p207so14321967yba.2
        for <ceph-devel@vger.kernel.org>; Fri, 07 Jul 2017 13:53:02 -0700 (PDT)
In-Reply-To: <CAJ4mKGZyXkEtkqKm0bZYcx6Qju4yxmaBA5xzcowsWkM4g1AZvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 7, 2017 at 1:47 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> Yeah, I need the actual commit IDs please so I make sure I'm looking
> at the right place. Checking out kraken on my box isn't showing
> anything sensible with your backtraces. ;)

The Kraken version is whatever is here from an hour ago:
https://download.ceph.com/debian-kraken/. The backtrace is from "some
version of kraken", but the errors I'm reporting are all still valid
for kraken taken from download.ceph.com.

> Also your timeouts make me think something else has gone wrong for
> you. We *do* test with clients that have differing versions, although
> I'm not sure how complete the matrix is.

I see. I'll try to reproduce this outside the CI environment.

>
> On Fri, Jul 7, 2017 at 1:43 PM, Noah Watkins <noahwatkins@gmail.com> wrote:
>> So far the summary of pass/fail from messing around with the test matrix is:
>>
>> - Everything is installed fresh from download.ceph.com
>>
>> - The OSD in all tests is:
>>   Ubuntu Xenial + Latest Luminous
>>
>> - Client Setup 1:
>>
>> Client: jessie, trusty, xenial, yakkety, zesty + Kraken
>>   - buffer error from above
>> Client: centos7, fedora 23 + Kraken
>>   - timeouts on connect
>> Client: fedora 24, 25 + Kraken
>>   - everything works fine
>>
>> - Client Setup 2:
>>
>> Same as setup 1 but used Luminous in Debian/Ubuntu clients. All errors
>> went away. So only the timeouts remain on cento7 and fedora 23.
>>
>> - Client Setup 3:
>>
>> Same as setup 1 but used Luminous in rhel/centos/fedora and centos7
>> and fedora 23 still timeout.
>>
>> We haven't really messed around with our CI matrix setup, so this all
>> started sometime in the last month or so.
>>
>> On Fri, Jul 7, 2017 at 1:09 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> Exactly what version/release is this?
>>>
>>> And are you saying everything works fine on newish Fedora nodes, but
>>> you get timeouts on Centos7 and that failure on Debian derivatives?
>>> That is super weird.
>>>
>>> On Fri, Jul 7, 2017 at 11:42 AM, Noah Watkins <noahwatkins@gmail.com> wrote:
>>>> An important thing I noticed:
>>>>
>>>> Fedora 24/25: no errors
>>>> CentOS 7 and Fedora 23: cluster.connect => -ETIMEDOUT
>>>> All debian/ubuntu: above error: ceph::buffer::end_of_buffer
>>>>
>>>> On Fri, Jul 7, 2017 at 11:39 AM, Noah Watkins <noahwatkins@gmail.com> wrote:
>>>>> I'm getting osd map decoding errors on cluster connection from a
>>>>> kraken client with a luminous backend. I searched around the mailing
>>>>> list but didn't see this reported, or any note on backwards
>>>>> incompatibility. Back trace:
>>>>>
>>>>> ===
>>>>>
>>>>> terminate called after throwing an instance of 'ceph::buffer::end_of_buffer'
>>>>>   what():  buffer::end_of_buffer
>>>>>
>>>>> Thread 9 "ms_dispatch" received signal SIGABRT, Aborted.
>>>>> [Switching to Thread 0x7fffd3fff700 (LWP 43060)]
>>>>> 0x00007fffee73c428 in __GI_raise (sig=sig@entry=6) at
>>>>> ../sysdeps/unix/sysv/linux/raise.c:54
>>>>> 54      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
>>>>> (gdb) bt
>>>>> #0  0x00007fffee73c428 in __GI_raise (sig=sig@entry=6) at
>>>>> ../sysdeps/unix/sysv/linux/raise.c:54
>>>>> #1  0x00007fffee73e02a in __GI_abort () at abort.c:89
>>>>> #2  0x00007fffeed7684d in __gnu_cxx::__verbose_terminate_handler() ()
>>>>> from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>>> #3  0x00007fffeed746b6 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>>> #4  0x00007fffeed74701 in std::terminate() () from
>>>>> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>>> #5  0x00007fffeed74919 in __cxa_throw () from
>>>>> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>>> #6  0x00007fffef49cbb2 in ceph::buffer::ptr::iterator::get_pos_add
>>>>> (this=<optimized out>, this=<optimized out>, n=4) at
>>>>> /home/nwatkins/ceph/src/include/buffer.h:196
>>>>> #7  0x00007fffef4b5509 in ceph::buffer::ptr::iterator::get_pos_add
>>>>> (this=<synthetic pointer>, this=<synthetic pointer>, n=4) at
>>>>> /usr/include/c++/5/bits/stl_vector.h:676
>>>>> #8  denc_traits<unsigned int, void>::decode (p=<synthetic pointer>,
>>>>> o=<optimized out>) at /home/nwatkins/ceph/src/include/denc.h:224
>>>>> #9  denc<unsigned int, denc_traits<unsigned int, void> > (features=0,
>>>>> p=<synthetic pointer>, o=<optimized out>) at
>>>>> /home/nwatkins/ceph/src/include/denc.h:496
>>>>> #10 denc_traits<std::vector<unsigned int, std::allocator<unsigned int>
>>>>>>, void>::decode (p=<synthetic pointer>, s=std::vector of length
>>>>> 16777216, capacity 16777216 = {...})
>>>>>     at /home/nwatkins/ceph/src/include/denc.h:796
>>>>> #11 decode<std::vector<unsigned int, std::allocator<unsigned int> >,
>>>>> denc_traits<std::vector<unsigned int, std::allocator<unsigned int> >,
>>>>> void> > (
>>>>>     o=std::vector of length 16777216, capacity 16777216 = {...},
>>>>> p=...) at /home/nwatkins/ceph/src/include/denc.h:1157
>>>>> #12 0x00007fffef4aee0c in OSDMap::decode (this=this@entry=0x817f20,
>>>>> bl=...) at /home/nwatkins/ceph/src/osd/OSDMap.cc:2144
>>>>> #13 0x00007fffef4b0b2e in OSDMap::decode (this=0x817f20, bl=...) at
>>>>> /home/nwatkins/ceph/src/osd/OSDMap.cc:1991
>>>>> #14 0x00007fffef387d2b in Objecter::handle_osd_map
>>>>> (this=this@entry=0x8178a0, m=m@entry=0x7fffd80012e0) at
>>>>> /home/nwatkins/ceph/src/osdc/Objecter.cc:1242
>>>>> #15 0x00007fffef388a87 in Objecter::ms_dispatch (this=0x8178a0,
>>>>> m=0x7fffd80012e0) at /home/nwatkins/ceph/src/osdc/Objecter.cc:1005
>>>>> #16 0x00007fffef5fd8ca in Messenger::ms_deliver_dispatch
>>>>> (m=0x7fffd80012e0, this=0x789fb0) at
>>>>> /home/nwatkins/ceph/src/msg/Messenger.h:593
>>>>> #17 DispatchQueue::entry (this=0x78a128) at
>>>>> /home/nwatkins/ceph/src/msg/DispatchQueue.cc:197
>>>>> #18 0x00007fffef47968d in DispatchQueue::DispatchThread::entry
>>>>> (this=<optimized out>) at
>>>>> /home/nwatkins/ceph/src/msg/DispatchQueue.h:103
>>>>> #19 0x00007fffef0706ba in start_thread (arg=0x7fffd3fff700) at
>>>>> pthread_create.c:333
>>>>> #20 0x00007fffee80e3dd in clone () at
>>>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
