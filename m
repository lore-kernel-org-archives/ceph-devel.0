From: Martin Mailand <martin@tuxadero.com>
Subject: Re: osd/OSD.cc: 5534: FAILED assert(pending_ops > 0)
Date: Thu, 24 Nov 2011 14:23:44 +0100
Message-ID: <4ECE4560.9090500@tuxadero.com>
References: <4EC11FF2.1030109@tuxadero.com> <CAF3hT9BZh8cFy+weYxuRSH+B36mf0z18ai4whqtcfyCAUPAu1Q@mail.gmail.com> <4EC16FF1.1080002@tuxadero.com> <CAF3hT9AqayxNCSKNZ8TfYMhOhPk0uEmGNKjJz+TTYAGMHfK3Jw@mail.gmail.com> <Pine.LNX.4.64.1111141220460.29742@cobra.newdream.net> <4EC2F026.7000109@tuxadero.com> <Pine.LNX.4.64.1111161311220.6368@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:47098 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab1KXNX6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Nov 2011 08:23:58 -0500
In-Reply-To: <Pine.LNX.4.64.1111161311220.6368@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

Hi Sage,
I hit it again, this time on another osd

ceph version 0.38-181-g2e19550 
(commit:2e195500b5d3a8ab8512bcf2a219a6b7ff922c97)

Thread 1 (Thread 2951):
#0  0x00007f36bbb41b3b in raise () from 
/lib/x86_64-linux-gnu/libpthread.so.0
#1  0x00000000005f5852 in reraise_fatal (signum=6) at 
global/signal_handler.cc:59
#2  0x00000000005f5e4a in handle_fatal_signal (signum=6) at 
global/signal_handler.cc:106
#3  <signal handler called>
#4  0x00007f36ba0c2d05 in raise () from /lib/x86_64-linux-gnu/libc.so.6
#5  0x00007f36ba0c6ab6 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#6  0x00007f36ba9796dd in __gnu_cxx::__verbose_terminate_handler() () 
from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
---Type <return> to continue, or q <return> to quit---
#7  0x00007f36ba977926 in ?? () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#8  0x00007f36ba977953 in std::terminate() () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#9  0x00007f36ba977a5e in __cxa_throw () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#10 0x00000000005f6956 in ceph::__ceph_assert_fail (assertion=<value 
optimized out>, file=<value optimized out>, line=<value optimized out>,
     func=<value optimized out>) at common/assert.cc:70
#11 0x000000000056616a in OSD::dequeue_op (this=0x25b0000, pg=<value 
optimized out>) at osd/OSD.cc:5518
#12 0x00000000005d4406 in ThreadPool::worker (this=0x25b0408) at 
common/WorkQueue.cc:54
#13 0x00000000005822dd in ThreadPool::WorkThread::entry (this=<value 
optimized out>) at ./common/WorkQueue.h:120
#14 0x00007f36bbb38d8c in start_thread () from 
/lib/x86_64-linux-gnu/libpthread.so.0
#15 0x00007f36ba17504d in clone () from /lib/x86_64-linux-gnu/libc.so.6
#16 0x0000000000000000 in ?? ()
(gdb) thread 1
[Switching to thread 1 (Thread 2951)]#0  0x00007f36bbb41b3b in raise () 
from /lib/x86_64-linux-gnu/libpthread.so.0
(gdb) frame 11
#11 0x000000000056616a in OSD::dequeue_op (this=0x25b0000, pg=<value 
optimized out>) at osd/OSD.cc:5518
5518    osd/OSD.cc: No such file or directory.
         in osd/OSD.cc
(gdb) p pending_ops
$1 = 0



-martin


Am 16.11.2011 22:12, schrieb Sage Weil:
> Hi Martin,
>
> I've reread the code twice now and it's really not clear to me how
> pending_ops could get out of sync with the actual queue size.  I've pushed
> a couple of patches that remove surrounding dead code and add an
> additional assert sanity check to master.    Have you seen this again, or
> just that once?
>
> Opened http://tracker.newdream.net/issues/1727
>
> Thanks-
> sage
>
>
> On Wed, 16 Nov 2011, Martin Mailand wrote:
>
>> Hi,
>> so after a little help from greg.
>>
>> (gdb) print pending_ops
>> $1 = 0
>>
>> -martin
>>
>> Sage Weil schrieb:
>>> On Mon, 14 Nov 2011, Gregory Farnum wrote:
>>>> It's not a big deal; logging is expensive. :) Just a backtrace isn't a
>>>> lot to go on, but it's better than nothing!
>>>>
>>>> On Mon, Nov 14, 2011 at 11:45 AM, Martin Mailand<martin@tuxadero.com>
>>>> wrote:
>>>>> Hi Gregory,
>>>>> I do not have more at the moment. As I cannot have the debug log always
>>>>> on,
>>>>> a core dump would be the best solution?
>>>
>>> I'm mainly interested in whether pending_ops is 0 or<  0.  A 'thread apply
>>> all bt' may also be useful.
>>>
>>> Thanks!
>>> sage
>>>
>>>
>>>>> -martin
>>>>>
>>>>> Gregory Farnum schrieb:
>>>>>> Do you have any other system state? (More logs, core dumps.)
>>>>>>
>>>>>> Make a bug in the tracker either way so it doesn't get lost track of.
>>>>>> :)
>>>>>> -Greg
>>>>>>
>>>>>> On Mon, Nov 14, 2011 at 6:04 AM, Martin Mailand<martin@tuxadero.com>
>>>>>> wrote:
>>>>>>> Hi,
>>>>>>> today one of my ods died, the log is.
>>>>>>>
>>>>>>> sd/OSD.cc: In function 'void OSD::dequeue_op(PG*)', in thread
>>>>>>> '7faeb6139700'
>>>>>>> osd/OSD.cc: 5534: FAILED assert(pending_ops>  0)
>>>>>>>   ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)
>>>>>>>   1: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
>>>>>>>   2: (ThreadPool::worker()+0x6e6) [0x5b7b16]
>>>>>>>   3: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
>>>>>>>   4: (()+0x6d8c) [0x7faec4d12d8c]
>>>>>>>   5: (clone()+0x6d) [0x7faec355404d]
>>>>>>>   ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)
>>>>>>>   1: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
>>>>>>>   2: (ThreadPool::worker()+0x6e6) [0x5b7b16]
>>>>>>>   3: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
>>>>>>>   4: (()+0x6d8c) [0x7faec4d12d8c]
>>>>>>>   5: (clone()+0x6d) [0x7faec355404d]
>>>>>>> *** Caught signal (Aborted) **
>>>>>>>   in thread 7faeb6139700
>>>>>>>   ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)
>>>>>>>   1: /usr/bin/ceph-osd() [0x5b8b52]
>>>>>>>   2: (()+0xfc60) [0x7faec4d1bc60]
>>>>>>>   3: (gsignal()+0x35) [0x7faec34a1d05]
>>>>>>>   4: (abort()+0x186) [0x7faec34a5ab6]
>>>>>>>   5: (__gnu_cxx::__verbose_terminate_handler()+0x11d)
>>>>>>> [0x7faec3d586dd]
>>>>>>>   6: (()+0xb9926) [0x7faec3d56926]
>>>>>>>   7: (()+0xb9953) [0x7faec3d56953]
>>>>>>>   8: (()+0xb9a5e) [0x7faec3d56a5e]
>>>>>>>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>>>>>> const*)+0x396) [0x5bddb6]
>>>>>>>   10: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
>>>>>>>   11: (ThreadPool::worker()+0x6e6) [0x5b7b16]
>>>>>>>   12: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
>>>>>>>   13: (()+0x6d8c) [0x7faec4d12d8c]
>>>>>>>   14: (clone()+0x6d) [0x7faec355404d]
>>>>>>>
>>>>>>> Anything else needed to debug this?
>>>>>>>
>>>>>>> -martin
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>> ceph-devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
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

