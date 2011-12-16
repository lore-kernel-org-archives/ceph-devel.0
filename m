From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Assert in OSD::build_incremental_map_msg
Date: Fri, 16 Dec 2011 14:43:57 -0800
Message-ID: <CACLRD_0+0-NTszjVtira9Og80J-NGt+wBh3hcBp4==gHWdstLg@mail.gmail.com>
References: <4EEB7AE9.5080601@sandia.gov>
	<Pine.LNX.4.64.1112160955040.25421@cobra.newdream.net>
	<4EEB8D4A.5020506@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54070 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030259Ab1LPWn7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 17:43:59 -0500
Received: by wgbdr13 with SMTP id dr13so6969139wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 14:43:57 -0800 (PST)
In-Reply-To: <4EEB8D4A.5020506@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

bfbde5b18525406fc3b678751459e989ea5d4977 in master should fix it.
-Sam

On Fri, Dec 16, 2011 at 10:26 AM, Jim Schutt <jaschut@sandia.gov> wrote=
:
> On 12/16/2011 10:56 AM, Sage Weil wrote:
>>
>> Hi Jim,
>>
>> Are you able to generate an osd log leading up to this crash?
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0debug osd =3D 20
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0debug filestore =3D 10
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0debug ms =3D 1
>
>
> Sent by private email.
>
> Thanks for taking a look.
>
> -- Jim
>
>
>>
>> sage
>>
>>
>> On Fri, 16 Dec 2011, Jim Schutt wrote:
>>
>>> Hi,
>>>
>>> I've been seeing current master branch assert in
>>> OSD::build_incremental_map_msg during peering when starting
>>> a new filesystem for the first time.
>>>
>>> This behavior bisects to commit 0807e7d523:
>>>
>>> =C2=A0 =C2=A0 hobject_t: make filestore_hobject_key_t 64 bits
>>>
>>> =C2=A0 =C2=A0 So we can return 0x100000000 when max=3Dtrue.
>>>
>>> =C2=A0 =C2=A0 Signed-off-by: Sage Weil<sage.weil@dreamhost.com>
>>>
>>>
>>> Here's an example of the assert:
>>>
>>> (gdb) bt
>>> #0 =C2=A0__memcpy_ssse3_back () at
>>> ../sysdeps/x86_64/multiarch/memcpy-ssse3-back.S:1631
>>> #1 =C2=A00x00000000008f4be7 in ceph::BackTrace::print (this=3D0x7f2=
b89908270,
>>> out=3D...) at common/BackTrace.cc:37
>>> #2 =C2=A00x00000000008e2627 in handle_fatal_signal (signum=3D11) at
>>> global/signal_handler.cc:103
>>> #3<signal handler called>
>>> #4 =C2=A0__memcpy_ssse3_back () at
>>> ../sysdeps/x86_64/multiarch/memcpy-ssse3-back.S:1475
>>> #5 =C2=A00x00000000008f4be7 in ceph::BackTrace::print (this=3D0x7f2=
b89909030,
>>> out=3D...) at common/BackTrace.cc:37
>>> #6 =C2=A00x00000000008e2627 in handle_fatal_signal (signum=3D6) at
>>> global/signal_handler.cc:103
>>> #7<signal handler called>
>>> #8 =C2=A00x00007f2b9500f885 in raise (sig=3D6) at
>>> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
>>> #9 =C2=A00x00007f2b95011065 in abort () at abort.c:92
>>> #10 0x0000003be84bea7d in __gnu_cxx::__verbose_terminate_handler() =
()
>>> from
>>> /usr/lib64/libstdc++.so.6
>>> #11 0x0000003be84bcc06 in ?? () from /usr/lib64/libstdc++.so.6
>>> #12 0x0000003be84bcc33 in std::terminate() () from
>>> /usr/lib64/libstdc++.so.6
>>> #13 0x0000003be84bcd2e in __cxa_throw () from /usr/lib64/libstdc++.=
so.6
>>> #14 0x00000000008fd19d in ceph::__ceph_assert_fail (assertion=3D0xa=
c97b0 "0
>>> =3D=3D
>>> \"missing an osdmap on disk\"",
>>> =C2=A0 =C2=A0 file=3D0xac777f "osd/OSD.cc", line=3D3662, func=3D0xa=
cb240 "MOSDMap*
>>> OSD::build_incremental_map_msg(epoch_t, epoch_t)")
>>> =C2=A0 =C2=A0 at common/assert.cc:70
>>> #15 0x000000000087b558 in OSD::build_incremental_map_msg (this=3D0x=
21d8000,
>>> since=3D16, to=3D22) at osd/OSD.cc:3662
>>> #16 0x000000000087b95c in OSD::send_incremental_map (this=3D0x21d80=
00,
>>> since=3D16,
>>> inst=3D..., lazy=3Dfalse) at osd/OSD.cc:3699
>>> #17 0x0000000000870d20 in OSD::_share_map_outgoing (this=3D0x21d800=
0,
>>> inst=3D...)
>>> at osd/OSD.cc:2627
>>> #18 0x0000000000866a5a in OSD::handle_osd_ping (this=3D0x21d8000,
>>> m=3D0x2542fc0)
>>> at osd/OSD.cc:1613
>>> #19 0x00000000008712d3 in OSD::heartbeat_dispatch (this=3D0x21d8000=
,
>>> m=3D0x2542fc0) at osd/OSD.cc:2652
>>> #20 0x00000000008962bd in OSD::HeartbeatDispatcher::ms_dispatch
>>> (this=3D0x21d8a48, m=3D0x2542fc0) at osd/OSD.h:283
>>> #21 0x000000000091e941 in Messenger::ms_deliver_dispatch (this=3D0x=
21a0500,
>>> m=3D0x2542fc0) at msg/Messenger.h:102
>>> #22 0x00000000009081b0 in SimpleMessenger::dispatch_entry
>>> (this=3D0x21a0500) at
>>> msg/SimpleMessenger.cc:360
>>> #23 0x00000000007a0c0e in SimpleMessenger::DispatchThread::entry
>>> (this=3D0x21a0998) at msg/SimpleMessenger.h:544
>>> #24 0x0000000000969d1b in Thread::_entry_func (arg=3D0x21a0998) at
>>> common/Thread.cc:41
>>> #25 0x00007f2b95d057f1 in start_thread (arg=3D0x7f2b8990d700) at
>>> pthread_create.c:301
>>> #26 0x00007f2b950c270d in clone () at
>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:115
>>>
>>>
>>> Thanks -- Jim
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>>
>>>
>>
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
