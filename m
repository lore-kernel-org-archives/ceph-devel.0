From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: segfault in bluestore during random writes
Date: Wed, 6 Jul 2016 13:06:50 +0000
Message-ID: <BLUPR0201MB1908C9EF330B85886C477C73E23A0@BLUPR0201MB1908.namprd02.prod.outlook.com>
References: <0b69c134-ffa9-1918-b4f5-ca9cc0cd7fbe@redhat.com>
 <BLUPR0201MB1908E4B6055CAF348E4B8703E23A0@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <6AA21C22F0A5DA478922644AD2EC308C373B488E@SHSMSX101.ccr.corp.intel.com>
 <BLUPR0201MB19082342428A7176F07E84FCE23A0@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <6AA21C22F0A5DA478922644AD2EC308C373B4938@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0078.outbound.protection.outlook.com ([104.47.40.78]:24807
	"EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751853AbcGFNGx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jul 2016 09:06:53 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yeah. I can reproduce the issue with 64k block size with sequential
write. Looking at the trace now. Update once i have some details about
the issue.

Varada

On Wednesday 06 July 2016 05:25 PM, Ma, Jianpeng wrote:
> With this patch:
> @@ -6122,7 +6127,7 @@ int BlueStore::_do_write(
>    if (length == 0) {
>      return 0;
>    }
> -
> +  o->flush();
>    uint64_t end = offset + length;
>  
>    WriteContext wctx;
>
> This bug can't reproduce. But I don't know why?
>
>
> -----Original Message-----
> From: Varada Kari [mailto:Varada.Kari@sandisk.com] 
> Sent: Wednesday, July 6, 2016 4:47 PM
> To: Ma, Jianpeng <jianpeng.ma@intel.com>; Mark Nelson <mnelson@redhat.com>; ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: segfault in bluestore during random writes
>
> Okay. I haven't tried sequential write, will try now. Thanks for the help.
>
> Varada
>
> On Wednesday 06 July 2016 02:10 PM, Ma, Jianpeng wrote:
>> I use fio(engine=rbd) for seqwrite on 30G rbd image, this bug 100% occur.
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org 
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Varada Kari
>> Sent: Wednesday, July 6, 2016 2:45 PM
>> To: Mark Nelson <mnelson@redhat.com>; ceph-devel 
>> <ceph-devel@vger.kernel.org>
>> Subject: Re: segfault in bluestore during random writes
>>
>> Hi mark,
>>
>> I have tried reproducing the issue with latest master, so far no luck with 128k and 512k block sizes on a 1000GB rbd image.
>> I couldn't find #5e07e5a3446ee39189c5b959be624411561175f5 in master, are you using any private changes?
>>
>> I will try some more time today to reproduce the issue. Seems blob map got corrupted in your case.
>>
>> Varada
>>
>> On Tuesday 05 July 2016 09:06 PM, Mark Nelson wrote:
>>> Hi Guys,
>>>
>>> This is primarily for Varada but if anyone else wants to take a look 
>>> feel free.  We are hitting segfaults in tc_state_proc during random 
>>> writes.  I was able to reproduce with logging enabled and got a core 
>>> dump.  I've only briefly looked at the code/logs, but I haven't 
>>> really looked through it in earnest yet.  Unfortunately the logs are 
>>> about 4GB and the core dump is 2GB, so I'll only attach the last 10k lines.
>>> Hopefully it should be fairly reproducible.  I'll try to see if I can 
>>> narrow down commits that have touched the write path over the last 4 
>>> weeks and see if anything looks relevant.
>>>
>>> Varada: let me know if you can reproduce.  Thanks!
>>>
>>> gdb bt:
>>>
>>>> (gdb) bt
>>>> #0  0x00007f9c59708fcb in raise (sig=11) at
>>>> ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:37
>>>> #1  0x0000000000bd7505 in reraise_fatal (signum=11) at
>>>> /home/ubuntu/src/markhpc/ceph/src/global/signal_handler.cc:69
>>>> #2  handle_fatal_signal (signum=11) at
>>>> /home/ubuntu/src/markhpc/ceph/src/global/signal_handler.cc:133
>>>> #3  <signal handler called>
>>>> #4  next_node (node=<synthetic pointer>) at
>>>> /usr/include/boost/intrusive/detail/tree_algorithms.hpp:446
>>>> #5  next_node (p=<synthetic pointer>) at
>>>> /usr/include/boost/intrusive/rbtree_algorithms.hpp:352
>>>> #6  operator++ (this=<synthetic pointer>) at
>>>> /usr/include/boost/intrusive/detail/tree_node.hpp:128
>>>> #7  BlueStore::_txc_state_proc (this=this@entry=0xaff6000,
>>>> txc=txc@entry=0x192c8c80) at
>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueStore.cc:4568
>>>> #8  0x0000000000aeddb7 in BlueStore::_txc_finish_io 
>>>> (this=this@entry=0xaff6000, txc=txc@entry=0x192c8c80) at
>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueStore.cc:4669
>>>> #9  0x0000000000aed23f in BlueStore::_txc_state_proc 
>>>> (this=0xaff6000,
>>>> txc=0x192c8c80) at
>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueStore.cc:4559
>>>> #10 0x0000000000bc134a in KernelDevice::_aio_thread (this=0xaf20960) 
>>>> at 
>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/KernelDevice.cc:270
>>>> #11 0x0000000000bc588d in KernelDevice::AioCompletionThread::entry
>>>> (this=<optimized out>) at
>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/KernelDevice.h:49
>>>> #12 0x00007f9c59701dc5 in start_thread (arg=0x7f9c4da2e700) at
>>>> pthread_create.c:308
>>>> #13 0x00007f9c575fc28d in clone () at
>>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:113
>>>> (gdb) frame 7
>>>> #7  BlueStore::_txc_state_proc (this=this@entry=0xaff6000,
>>>> txc=txc@entry=0x192c8c80) at
>>>> /home/ubuntu/src/markhpc/ceph/src/os/bluestore/BlueStore.cc:4568
>>>> 4568for (auto& p : o->blob_map.blob_map) {
>>> Mark
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>

