From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: Why gdb can't find symbol table when trying to debug ceph?
Date: Wed, 30 Nov 2016 18:16:12 +0000
Message-ID: <1297F9E4-F1CE-42CB-A357-5C9CF20C6A8A@Teradata.com>
References: <46ed7fdb.45dc.1587c3e763c.Coremail.xxhdx1985126@163.com>
 <CABAwU-aLAisvzEPc25H8=dY-TvTgiN7yCkkZWX-f6Tv=fPAvvw@mail.gmail.com>
 <7d40c922.2c59.158809be358.Coremail.xxhdx1985126@163.com>
 <CABAwU-ZykAV85h6mhCruDc6vOjFXDn3iROYV10kfV0O0vf1eOw@mail.gmail.com>
 <5af207ce.2d28.15880a4148d.Coremail.xxhdx1985126@163.com>
 <CABAwU-aJ9DSBpEA_hB0yCKWJQxjF+-8EXezbJZWeU4XW134exQ@mail.gmail.com>
 <f91dec5.3fa0.158814870d1.Coremail.xxhdx1985126@163.com>
 <20161121005905.GB26846@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33331 "EHLO
        rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964824AbcK3SQQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 13:16:16 -0500
In-Reply-To: <20161121005905.GB26846@rskikr.localdomain>
Content-Language: en-US
Content-ID: <D922474295E8934AA6A624DA2647C884@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: xxhdx1985126 <xxhdx1985126@163.com>, huang jun <hjwsm1989@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> On Nov 20, 2016, at 4:59 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
> 
> 
> On Sun, Nov 20, 2016 at 8:29 PM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
>> 
>> 
>> 
>> Hi, thanks for your help.
>> 
>> 
>> I checked the version of both my ceph and ceph-debuginfo package are the same. Is there any other possible cause?
>> Thank you:-)
> 
> Check the recent thread titled "debug coredump on teuthology" for details of how
> to match a binary with the correct debuginfo via the buildid. A truncated
> coredump could certainly cause this as could not having the debuginfo loaded for
> all of the binaries involved or having the wrong versions. gdb should give you
> clues as to what is wrong and matching binaries and debuginfo by buildid should
> ensure you get the right versions. "info shared" will show you all .so involved.
> 
>> 
>> 
>> 
>> 
>> 
>> 
>> 
>> At 2016-11-20 15:40:29, "huang jun" <hjwsm1989@gmail.com> wrote:
>>> For first question, you can reinstall the ceph-debuginfo package
>>> released with your ceph package.
>>> for the assert problem, you can create an issue to track this
>>> http://tracker.ceph.com/projects/ceph/issues
>>> 
>>> 
>>> 2016-11-20 15:29 GMT+08:00 xxhdx1985126 <xxhdx1985126@163.com>:
>>>> 
>>>> No, how to verify it? And do you have any clue what made that assert fail? Thank you
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> At 2016-11-20 15:28:26, "huang jun" <hjwsm1989@gmail.com> wrote:
>>>>> seems like the ceph and ceph-debuginfo package version not match, do
>>>>> you verified it?
>>>>> 
>>>>> 2016-11-20 15:20 GMT+08:00 xxhdx1985126 <xxhdx1985126@163.com>:
>>>>>> In my test today, the same problem came up even there is no such warning....
>>>>>> 
>>>>>> By the way, the problem of ceph that I want to fix is as such: some of my osd can't finish the recovery+backfilling process due to the failure of the following assert:
>>>>>> 
>>>>>> 2016-11-19 07:00:49.133814 7fc7a77ff700 -1 error_msg osd/ReplicatedPG.cc: In function 'void ReplicatedPG::wait_for_unreadable_object(const hobject_t&, OpRequestRef)' thread 7fc7a77ff700 time 2016-11-19 07:00:48.914231
>>>>>> osd/ReplicatedPG.cc: 387: FAILED assert(needs_recovery)
>>>>>> 
>>>>>> ceph version 0.94.5-12-g83f56a1 (83f56a1c84e3dbd95a4c394335a7b1dc926dd1c4)
>>>>>> 1: (ReplicatedPG::wait_for_unreadable_object(hobject_t const&, std::tr1::shared_ptr<OpRequest>)+0x3f5) [0x8b5a65]
>>>>>> 2: (ReplicatedPG::do_op(std::tr1::shared_ptr<OpRequest>&)+0x5e9) [0x8f0c79]
>>>>>> 3: (ReplicatedPG::do_request(std::tr1::shared_ptr<OpRequest>&, ThreadPool::TPHandle&)+0x4e3) [0x87fdc3]
>>>>>> 4: (OSD::dequeue_op(boost::intrusive_ptr<PG>, std::tr1::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x178) [0x66b3f8]
>>>>>> 5: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x59e) [0x66f8ee]
>>>>>> 6: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x795) [0xa76d85]
>>>>>> 7: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xa7a610]
>>>>>> 8: /lib64/libpthread.so.0() [0x393da07a51]
>>>>>> 9: (clone()+0x6d) [0x393d6e893d]
>>>>>> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>>>>>> 
>>>>>> I'm using ceph-0.94.5 which should be the version "Hammer".
>>>>>> Do you have any clue about what made this assert fail?
>>>>>> 
>>>>>> 
>>>>>> At 2016-11-20 09:51:47, "huang jun" <hjwsm1989@gmail.com> wrote:
>>>>>>> that maybe the reason, do you have the same problem if there is no such warning?
>>>>>>> 
>>>>>>> 2016-11-19 19:00 GMT+08:00 xxhdx1985126 <xxhdx1985126@163.com>:
>>>>>>>> 
>>>>>>>> Hi, everyone.
>>>>>>>> 
>>>>>>>> 
>>>>>>>> I'm trying to fix a problem in ceph using its core file and gdb.
>>>>>>>> gdb successfully loaded debug symbol from ceph-debuginfo:
>>>>>>>> 
>>>>>>>> 
>>>>>>>> Reading symbols from /usr/bin/ceph-osd...Reading symbols from /usr/lib/debug/usr/bin/ceph-osd.debug...done.
>>>>>>>> 
>>>>>>>> 
>>>>>>>> However, it still can't find the symbol table when I use "bt" to trace the stack:
>>>>>>>> 
>>>>>>>> 
>>>>>>>> #0  0x000000393da0f65b in ?? ()
>>>>>>>> No symbol table info available.
>>>>>>>> #1  0x0000000000a51636 in install_standard_sighandlers () at global/signal_handler.cc:121
>>>>>>>> No locals.
>>>>>>>> #2  0x00007fc7a77f9ed0 in ?? ()
>>>>>>>> No symbol table info available.
>>>>>>>> #3  0x00007fc7a77f9e10 in ?? ()
>>>>>>>> No symbol table info available.
>>>>>>>> #4  0x00007fc7a77f9b90 in ?? ()
>>>>>>>> No symbol table info available.
>>>>>>>> #5  0x00007fc66d3142e0 in ?? ()
>>>>>>>> No symbol table info available.
>>>>>>>> #6  0x00007fc7fac64100 in ?? ()
>>>>>>>> No symbol table info available.
>>>>>>>> #7  0x0000003900000000 in ?? ()
>>>>>>>> No symbol table info available.
>>>>>>>> #8  0x0000000000a51155 in SignalHandler::unregister_handler (this=0x1105440, signum=<value optimized out>, handler=<value optimized out>) at global/signal_handler.cc:317
>>>>>>>> No locals.
>>>>>>>> #9  0x000000393eabcc33 in ?? ()
>>>>>>>> No symbol table info available.
>>>>>>>> #10 0x000000393eabcd2e in ?? ()
>>>>>>>> No symbol table info available.
>>>>>>>> 
>>>>>>>> 
>>>>>>>> Why is this happening?
>>>>>>>> 
>>>>>>>> 
>>>>>>>> PS: when gdb started running, it prompted the following warning:
>>>>>>>> 
>>>>>>>> 
>>>>>>>> BFD: Warning: /home/xuxuehan/online_problems.2016-11-19.7-01/core-ceph-osd-6-32337-32337-19906-1479510049 is truncated: expected core file size >= 8372899840, found: 7439335424
>>>>>>>> 

This is ~8GB core file. It is possible you ran out of space at the time of saving the core dump. 

Nitin
>>>>>>>> 
>>>>>>>> Could this be the cause of gdb not finding the symbol table?
>>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>>> --
>>>>>>> Thank you!
>>>>>>> HuangJun
>>>>> 
>>>>> 
>>>>> 
>>>>> --
>>>>> Thank you!
>>>>> HuangJun
>>>> 
>>>> 
>>>> 
>>>> 
>>> 
>>> 
>>> 
>>> --
>>> Thank you!
>>> HuangJun
>> 
>> 
>> 
>> 
> 
> 
> 
> -- 
> Cheers,
> Brad
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

