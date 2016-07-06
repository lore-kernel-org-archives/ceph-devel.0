From: Mark Nelson <mnelson@redhat.com>
Subject: Re: segfault in bluestore during random writes
Date: Wed, 6 Jul 2016 09:45:10 -0500
Message-ID: <bff138a5-edf4-89c5-3456-00fd8b0b679c@redhat.com>
References: <0b69c134-ffa9-1918-b4f5-ca9cc0cd7fbe@redhat.com>
 <BLUPR0201MB1908E4B6055CAF348E4B8703E23A0@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <bc890855-35dc-223b-b44c-fa1e677babcb@redhat.com>
 <15694cfc-1e84-52e8-d63e-21ca4ddf0be0@redhat.com>
 <BL2PR02MB211579CAD7EAEE72AF0494EAF43A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57716 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825AbcGFOpN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jul 2016 10:45:13 -0400
In-Reply-To: <BL2PR02MB211579CAD7EAEE72AF0494EAF43A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Varada Kari <Varada.Kari@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Ah, sorry I missed it.  Do you remember when you first encountered it? 
Might help track down the commit where it first appeared.

Mark

On 07/06/2016 09:32 AM, Somnath Roy wrote:
> Mark,
> This is the same trace I got (and posted in community)  while you were in vacation. I can still reproduce this in my setup easily.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Wednesday, July 06, 2016 7:02 AM
> To: Varada Kari; ceph-devel
> Subject: Re: segfault in bluestore during random writes
>
> Oh, sorry, this wasn't memdbstore, this was trim cache on reads which got applied earlier this week.  I was testing 06178de9 with the trim cache on reads PR applied.
>
> Mark
>
> On 07/06/2016 07:00 AM, Mark Nelson wrote:
>> Hi Varada,
>>
>> Ah, this version happens to be with the memstoredb patch applied,
>> though it is unused in this test.  I don't believe this should be
>> causing the problem, but I'll verify it is happening without that patch as well.
>>
>> Mark
>>
>> On 07/06/2016 01:45 AM, Varada Kari wrote:
>>> Hi mark,
>>>
>>> I have tried reproducing the issue with latest master, so far no luck
>>> with 128k and 512k block sizes on a 1000GB rbd image.
>>> I couldn't find #5e07e5a3446ee39189c5b959be624411561175f5 in master,
>>> are you using any private changes?
>>>
>>> I will try some more time today to reproduce the issue. Seems blob
>>> map got corrupted in your case.
>>>
>>> Varada
>>>
>>> On Tuesday 05 July 2016 09:06 PM, Mark Nelson wrote:
>>>> Hi Guys,
>>>>
>>>> This is primarily for Varada but if anyone else wants to take a look
>>>> feel free.  We are hitting segfaults in tc_state_proc during random
>>>> writes.  I was able to reproduce with logging enabled and got a core
>>>> dump.  I've only briefly looked at the code/logs, but I haven't
>>>> really looked through it in earnest yet.  Unfortunately the logs are
>>>> about 4GB and the core dump is 2GB, so I'll only attach the last 10k lines.
>>>> Hopefully it should be fairly reproducible.  I'll try to see if I
>>>> can narrow down commits that have touched the write path over the
>>>> last 4 weeks and see if anything looks relevant.
>>>>
>>>> Varada: let me know if you can reproduce.  Thanks!
>>>>
>>>> gdb bt:
>>>>
>>>>> (gdb) bt
>>>>> #0  0x00007f9c59708fcb in raise (sig=11) at
>>>>> ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:37
>>>>> #1  0x0000000000bd7505 in reraise_fatal (signum=11) at
>>>>> /home/ubuntu/src/markhpc/ceph/src/global/signal_handler.cc:69
>>>>> #2  handle_fatal_signal (signum=11) at
>>>>> /home/ubuntu/src/markhpc/ceph/src/global/signal_handler.cc:133
>>>>> #3  <signal handler called>
>>>>> #4  next_node (node=<synthetic pointer>) at
>>>>> /usr/include/boost/intrusive/detail/tree_algorithms.hpp:446
>>>>> #5  next_node (p=<synthetic pointer>) at
>>>>> /usr/include/boost/intrusive/rbtree_algorithms.hpp:352
>>>>> #6  operator++ (this=<synthetic pointer>) at
>>>>> /usr/include/boost/intrusive/detail/tree_node.hpp:128
>>>>> #7  BlueStore::_txc_state_proc (this=this@entry=0xaff6000,
>>>>> txc=txc@entry=0x192c8c80) at
>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueStore.cc:4568
>>>>> #8  0x0000000000aeddb7 in BlueStore::_txc_finish_io
>>>>> (this=this@entry=0xaff6000, txc=txc@entry=0x192c8c80) at
>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueStore.cc:4669
>>>>> #9  0x0000000000aed23f in BlueStore::_txc_state_proc
>>>>> (this=0xaff6000, txc=0x192c8c80) at
>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueStore.cc:4559
>>>>> #10 0x0000000000bc134a in KernelDevice::_aio_thread
>>>>> (this=0xaf20960) at
>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/KernelDevice.cc:270
>>>>> #11 0x0000000000bc588d in KernelDevice::AioCompletionThread::entry
>>>>> (this=<optimized out>) at
>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/KernelDevice.h:49
>>>>> #12 0x00007f9c59701dc5 in start_thread (arg=0x7f9c4da2e700) at
>>>>> pthread_create.c:308
>>>>> #13 0x00007f9c575fc28d in clone () at
>>>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:113
>>>>> (gdb) frame 7
>>>>> #7  BlueStore::_txc_state_proc (this=this@entry=0xaff6000,
>>>>> txc=txc@entry=0x192c8c80) at
>>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueStore.cc:4568
>>>>> 4568for (auto& p : o->blob_map.blob_map) {
>>>> Mark
>>>
>>> PLEASE NOTE: The information contained in this electronic mail
>>> message is intended only for the use of the designated recipient(s)
>>> named above. If the reader of this message is not the intended
>>> recipient, you are hereby notified that you have received this
>>> message in error and that any review, dissemination, distribution, or
>>> copying of this message is strictly prohibited. If you have received
>>> this communication in error, please notify the sender by telephone or
>>> e-mail (as shown above) immediately and destroy any and all copies of
>>> this message in your possession (whether hard copies or
>>> electronically stored copies).
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
