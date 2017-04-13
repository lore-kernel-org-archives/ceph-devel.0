From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Measuring lock conention
Date: Thu, 13 Apr 2017 18:50:46 -0400
Message-ID: <CANP1eJEHWBa+t9xC=LD_-4Fiqd=anxODDoViWanbGet+n86zVQ@mail.gmail.com>
References: <90991cbf-c59e-d080-783e-e712540a99b1@suse.com>
 <61444443-9337-c5ce-76ba-7e8a7a765232@redhat.com> <6481e2a7-0913-de41-2f35-40e44043bb0a@suse.com>
 <CANP1eJFwsSrEchc0cMxtQKBnDWV6r9gPTerXywA0DpebwL0AGA@mail.gmail.com> <be8aaf0b-5d48-793a-9f40-ce35d8c75b3f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33124 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdDMWut (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Apr 2017 18:50:49 -0400
Received: by mail-wr0-f172.google.com with SMTP id l28so43374758wre.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Apr 2017 15:50:48 -0700 (PDT)
In-Reply-To: <be8aaf0b-5d48-793a-9f40-ce35d8c75b3f@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Mohamad Gebai <mgebai@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 13, 2017 at 4:54 PM, Mark Nelson <mnelson@redhat.com> wrote:
>
> On 04/13/2017 03:38 PM, Milosz Tanski wrote:
>>
>> On Thu, Apr 13, 2017 at 2:02 PM, Mohamad Gebai <mgebai@suse.com> wrote:
>>>
>>>
>>> On 04/13/2017 01:20 PM, Mark Nelson wrote:
>>>>
>>>>
>>>> Nice!  I will give it a try and see how it goes. Specifically I want t=
o
>>>> compare it to what I ended up working on yesterday.  After the meeting=
 I
>>>> ended up doing major surgery on an existing gdb based wallclock profil=
er and
>>>> modified it to a) work b) be thread aware c) print inverse call-graphs=
.  The
>>>> code is still pretty rough but you can see it here:
>>>>
>>>> https://github.com/markhpc/gdbprof
>>>
>>>
>>> Very neat, thank you for this. Please let me know what happens, I'm
>>> interested to see which tool ends up working best for this use case. Al=
so,
>>> could you share some information about what you're trying to find out?
>>>
>>> If I'm not mistaken, there's work being done to add the call stack of a
>>> process within the context of LTTng events. That way we could have this
>>> information when a process blocks in sys_futex.
>>>
>>> PS: found it, it's still in RFC -
>>> https://lists.lttng.org/pipermail/lttng-dev/2017-March/026985.html
>>>
>>>
>>
>> You can also use perf's syscall tracepoints to capture the
>> syscalls:sys_enter_futex event. This way you get contended mutex. The
>> nice thing about it is all the normal perf tools apply, so you can see
>> source annotation, frequency (hot points) and also examine the
>> callgraph of the hot points.
>>
>
> Hi Milosz,
>
> Do you know of any examples showing this technique?  I've suspected there=
 was a way to do this (and similar things) with perf, but always ran into r=
oadblocks that made it not work.  Potentially one of those roadblocks might=
 have been errors on my part. ;)
>
> Mark

Mark, here's crash tutorial example.

    # Build a mutex benchmark I stole from github
    mtanski@crunchy:~/tmp/bench$ g++ --std=3Dc++11 -Og -g -pthread
bench.cpp -o bench

    # I can only make the syscall probes work as root :(
    mtanski@crunchy:~/tmp/bench$ sudo -s

    root@crunchy:~/tmp/bench# /usr/bin/perf record -F 4096 -g
--call-graph dwarf -e syscalls:sys_exit_futex ./bench
    lock with 1 threads throughput =3D 48333
    lock with 2 threads throughput =3D 19551
    lock with 4 threads throughput =3D 14307
    lock_guard with 1 threads throughput =3D 57499
    lock_guard with 2 threads throughput =3D 16919
    lock_guard with 4 threads throughput =3D 14460
    atomic with 1 threads throughput =3D 175000
    atomic with 2 threads throughput =3D 63888
    atomic with 4 threads throughput =3D 65833
    [ perf record: Woken up 296 times to write data ]
    [ perf record: Captured and wrote 76.438 MB perf.data (9448 samples) ]

    root@crunchy:~/tmp/bench# perf report --stdio
    ...
        59.77%    59.77%  0x0
                |
                 --59.75%--__clone
                           start_thread
                           0xb8c80
                           |

|--22.46%--_ZNSt6thread5_ImplISt12_Bind_simpleIFZ16bench_lock_guardILi4EEvv=
EUlvE_vEEE6_M_runEv
                           |          |
                           |          |--19.28%--pthread_mutex_unlock
                           |          |          __lll_unlock_wake
                           |          |
                           |           --3.17%--pthread_mutex_lock
                           |                     __lll_lock_wait
                           |

|--21.77%--_ZNSt6thread5_ImplISt12_Bind_simpleIFZ10bench_lockILi4EEvvEUlvE_=
vEEE6_M_runEv
                           |          |
                           |          |--19.29%--pthread_mutex_unlock
                           |          |          __lll_unlock_wake
                           |          |
                           |           --2.48%--pthread_mutex_lock
                           |                     __lll_lock_wait
    ...

Notes:
* Ubuntu's built in perf is built without symbol demangling. I haven't
rebuilt my own perf; please ignore that.
* If you're running on a newer system, you can use the SDT events. And
then glibc/pthreads expose their own event called
'sdt_libc:lll_lock_wait' that you can use.
* You're going to see the pthread_mutex_(un)lock here because the
futex also needs to be called to wakeup waiters. That's why
'sdt_libc:lll_lock_wait' is a better event.
* Unless your glibc is built with frame pointers you have to use dwarf
call graphs. Otherwise you'll lose the call graph symbol at __lll
* If you use the 'syscalls:sys_enter_futex' you will also get the
uaddr of the futex and you can look at which mutex that corresponds to
as well.
* On an application with a lot mutex contention play with the event
capture limits. I've generated 32GB perf files that perf report chokes
on.


Similarly you can use other perf (like live perf top with various lock even=
ts)

Best,
- Milosz

--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
