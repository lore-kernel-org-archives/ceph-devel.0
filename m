From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Assert in OSD::build_incremental_map_msg
Date: Fri, 16 Dec 2011 11:26:18 -0700
Message-ID: <4EEB8D4A.5020506@sandia.gov>
References: <4EEB7AE9.5080601@sandia.gov>
 <Pine.LNX.4.64.1112160955040.25421@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:58441 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760409Ab1LPS0z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 13:26:55 -0500
In-Reply-To: <Pine.LNX.4.64.1112160955040.25421@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/16/2011 10:56 AM, Sage Weil wrote:
> Hi Jim,
>
> Are you able to generate an osd log leading up to this crash?
>
> 	debug osd = 20
> 	debug filestore = 10
> 	debug ms = 1

Sent by private email.

Thanks for taking a look.

-- Jim

>
> sage
>
>
> On Fri, 16 Dec 2011, Jim Schutt wrote:
>
>> Hi,
>>
>> I've been seeing current master branch assert in
>> OSD::build_incremental_map_msg during peering when starting
>> a new filesystem for the first time.
>>
>> This behavior bisects to commit 0807e7d523:
>>
>>      hobject_t: make filestore_hobject_key_t 64 bits
>>
>>      So we can return 0x100000000 when max=true.
>>
>>      Signed-off-by: Sage Weil<sage.weil@dreamhost.com>
>>
>>
>> Here's an example of the assert:
>>
>> (gdb) bt
>> #0  __memcpy_ssse3_back () at
>> ../sysdeps/x86_64/multiarch/memcpy-ssse3-back.S:1631
>> #1  0x00000000008f4be7 in ceph::BackTrace::print (this=0x7f2b89908270,
>> out=...) at common/BackTrace.cc:37
>> #2  0x00000000008e2627 in handle_fatal_signal (signum=11) at
>> global/signal_handler.cc:103
>> #3<signal handler called>
>> #4  __memcpy_ssse3_back () at
>> ../sysdeps/x86_64/multiarch/memcpy-ssse3-back.S:1475
>> #5  0x00000000008f4be7 in ceph::BackTrace::print (this=0x7f2b89909030,
>> out=...) at common/BackTrace.cc:37
>> #6  0x00000000008e2627 in handle_fatal_signal (signum=6) at
>> global/signal_handler.cc:103
>> #7<signal handler called>
>> #8  0x00007f2b9500f885 in raise (sig=6) at
>> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
>> #9  0x00007f2b95011065 in abort () at abort.c:92
>> #10 0x0000003be84bea7d in __gnu_cxx::__verbose_terminate_handler() () from
>> /usr/lib64/libstdc++.so.6
>> #11 0x0000003be84bcc06 in ?? () from /usr/lib64/libstdc++.so.6
>> #12 0x0000003be84bcc33 in std::terminate() () from /usr/lib64/libstdc++.so.6
>> #13 0x0000003be84bcd2e in __cxa_throw () from /usr/lib64/libstdc++.so.6
>> #14 0x00000000008fd19d in ceph::__ceph_assert_fail (assertion=0xac97b0 "0 ==
>> \"missing an osdmap on disk\"",
>>      file=0xac777f "osd/OSD.cc", line=3662, func=0xacb240 "MOSDMap*
>> OSD::build_incremental_map_msg(epoch_t, epoch_t)")
>>      at common/assert.cc:70
>> #15 0x000000000087b558 in OSD::build_incremental_map_msg (this=0x21d8000,
>> since=16, to=22) at osd/OSD.cc:3662
>> #16 0x000000000087b95c in OSD::send_incremental_map (this=0x21d8000, since=16,
>> inst=..., lazy=false) at osd/OSD.cc:3699
>> #17 0x0000000000870d20 in OSD::_share_map_outgoing (this=0x21d8000, inst=...)
>> at osd/OSD.cc:2627
>> #18 0x0000000000866a5a in OSD::handle_osd_ping (this=0x21d8000, m=0x2542fc0)
>> at osd/OSD.cc:1613
>> #19 0x00000000008712d3 in OSD::heartbeat_dispatch (this=0x21d8000,
>> m=0x2542fc0) at osd/OSD.cc:2652
>> #20 0x00000000008962bd in OSD::HeartbeatDispatcher::ms_dispatch
>> (this=0x21d8a48, m=0x2542fc0) at osd/OSD.h:283
>> #21 0x000000000091e941 in Messenger::ms_deliver_dispatch (this=0x21a0500,
>> m=0x2542fc0) at msg/Messenger.h:102
>> #22 0x00000000009081b0 in SimpleMessenger::dispatch_entry (this=0x21a0500) at
>> msg/SimpleMessenger.cc:360
>> #23 0x00000000007a0c0e in SimpleMessenger::DispatchThread::entry
>> (this=0x21a0998) at msg/SimpleMessenger.h:544
>> #24 0x0000000000969d1b in Thread::_entry_func (arg=0x21a0998) at
>> common/Thread.cc:41
>> #25 0x00007f2b95d057f1 in start_thread (arg=0x7f2b8990d700) at
>> pthread_create.c:301
>> #26 0x00007f2b950c270d in clone () at
>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:115
>>
>>
>> Thanks -- Jim
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
>


