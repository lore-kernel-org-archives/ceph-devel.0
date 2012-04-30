From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: OSD died
Date: Mon, 30 Apr 2012 09:53:31 -0700
Message-ID: <CACLRD_2r0cWt6Nq6FyKWmmCXmOfKq32VjXAxzcG+Xws8W=iXsA@mail.gmail.com>
References: <CAMvP8PD-zKg6OhWEjM4QWSdtXmkdoca-6LghvgTgdHoiOyPPwg@mail.gmail.com>
	<CAMvP8PAs+4AW-PiVO=5p7Q2CLC3=uz-hSUKD7C9NW-dcDCJ=1w@mail.gmail.com>
	<CAMvP8PCj604hc9Y=wNkFs4_ZUBG3tvD3Dk+Dy84NpHvH7OVC_g@mail.gmail.com>
	<CAMvP8PCAbS2LVTwDNxKTwiLfogMDx-3isajw_VsGQ84duyi3sw@mail.gmail.com>
	<CAMvP8PDt+koqBAXAgNAcbv3i023-2mCxnYCUvhYvo8G6XJ4mkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:38520 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab2D3Qxc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 12:53:32 -0400
Received: by wejx9 with SMTP id x9so1923596wej.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 09:53:31 -0700 (PDT)
In-Reply-To: <CAMvP8PDt+koqBAXAgNAcbv3i023-2mCxnYCUvhYvo8G6XJ4mkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Paszkowski <ss7pro@gmail.com>
Cc: ceph-devel@vger.kernel.org

I apologise for the delay in getting back to you.  I just pushed a
branch called wip-snap-workaround based on v0.45.  It should at least
avoid the crash you saw.  Let me know if you hit further trouble.
-Sam

On Thu, Apr 26, 2012 at 8:12 AM, Tomasz Paszkowski <ss7pro@gmail.com> w=
rote:
> Hi,
>
> Anyone have any idea how to fix this ? Can i just correct conflict
> data in osdmaps ?
>
>
> On Wed, Apr 25, 2012 at 3:42 PM, Tomasz Paszkowski <ss7pro@gmail.com>=
 wrote:
>> After removing pool snapshot I was trying to make self managed
>> snapshot and after reading source this was the root cause of this
>> problem.
>>
>>
>> On Wed, Apr 25, 2012 at 1:24 PM, Tomasz Paszkowski <ss7pro@gmail.com=
> wrote:
>>> after upgrade to v0.45 stack trace is as follows:
>>>
>>> Program received signal SIGABRT, Aborted.
>>> [Switching to Thread 0x7fffeac55700 (LWP 11011)]
>>> 0x00007ffff5ebb445 in raise () from /lib/x86_64-linux-gnu/libc.so.6
>>> (gdb) bt
>>> #0 =C2=A00x00007ffff5ebb445 in raise () from /lib/x86_64-linux-gnu/=
libc.so.6
>>> #1 =C2=A00x00007ffff5ebebab in abort () from /lib/x86_64-linux-gnu/=
libc.so.6
>>> #2 =C2=A00x00007ffff680969d in __gnu_cxx::__verbose_terminate_handl=
er() ()
>>> =C2=A0 from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>> #3 =C2=A00x00007ffff6807846 in ?? () from /usr/lib/x86_64-linux-gnu=
/libstdc++.so.6
>>> #4 =C2=A00x00007ffff6807873 in std::terminate() ()
>>> =C2=A0 from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>> #5 =C2=A00x00007ffff680796e in __cxa_throw ()
>>> =C2=A0 from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>> #6 =C2=A00x0000000000695ec0 in ceph::__ceph_assert_fail (
>>> =C2=A0 =C2=A0assertion=3D0x80b1ed "_size >=3D 0", file=3D0x80a222 "=
=2E/include/interval_set.h",
>>> =C2=A0 =C2=A0line=3D382,
>>> =C2=A0 =C2=A0func=3D0x81bf60 "void interval_set<T>::erase(T, T) [wi=
th T =3D snapid_t]")
>>> =C2=A0 =C2=A0at common/assert.cc:75
>>> #7 =C2=A00x00000000005d1359 in erase (len=3D..., start=3D..., this=3D=
0xbe5738)
>>> =C2=A0 =C2=A0at ./include/interval_set.h:382
>>> #8 =C2=A0subtract (a=3D..., this=3D0xbe5738) at ./include/interval_=
set.h:404
>>> #9 =C2=A0OSD::advance_map (this=3D0xbca000, t=3D..., tfin=3D<optimi=
zed out>)
>>> =C2=A0 =C2=A0at osd/OSD.cc:3475
>>> #10 0x00000000005d33bf in OSD::handle_osd_map (this=3D0xbca000, m=3D=
0x2a4c800)
>>> =C2=A0 =C2=A0at osd/OSD.cc:3272
>>> #11 0x00000000005d4c9b in OSD::_dispatch (this=3D0xbca000, m=3D0x2a=
4c800)
>>> =C2=A0 =C2=A0at osd/OSD.cc:2780
>>> ---Type <return> to continue, or q <return> to quit---
>>> #12 0x00000000005d52a5 in OSD::ms_dispatch (this=3D0xbca000, m=3D0x=
2a4c800)
>>> =C2=A0 =C2=A0at osd/OSD.cc:2605
>>> #13 0x000000000067a91b in ms_deliver_dispatch (m=3D0x2a4c800, this=3D=
0xba8680)
>>> =C2=A0 =C2=A0at msg/Messenger.h:178
>>> #14 SimpleMessenger::dispatch_entry (this=3D0xba8680)
>>> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:363
>>> #15 0x0000000000648f1d in SimpleMessenger::DispatchThread::entry (
>>> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:560
>>> #16 0x00007ffff79c2e9a in start_thread ()
>>> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
>>> #17 0x00007ffff5f774bd in clone () from /lib/x86_64-linux-gnu/libc.=
so.6
>>> #18 0x0000000000000000 in ?? ()
>>>
>>>
>>> On Wed, Apr 25, 2012 at 12:11 PM, Tomasz Paszkowski <ss7pro@gmail.c=
om> wrote:
>>>> osd dump is like this:
>>>>
>>>> pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_n=
um
>>>> 768 pgp_num 768 lpg_num 2 lpgp_num 2 last_change 1 owner 0
>>>> crash_replay_interval 45
>>>> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins
>>>> pg_num 768 pgp_num 768 lpg_num 2 lpgp_num 2 last_change 1 owner 0
>>>> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_nu=
m
>>>> 768 pgp_num 768 lpg_num 2 lpgp_num 2 last_change 1 owner 0
>>>> pool 9 'nova' rep size 2 crush_ruleset 0 object_hash rjenkins pg_n=
um
>>>> 2568 pgp_num 2568 lpg_num 0 lpgp_num 0 last_change 1435 owner
>>>> 18446744073709551615
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0removed_snaps [1~1]
>>>> pool 10 'glance' rep size 2 crush_ruleset 0 object_hash rjenkins
>>>> pg_num 2568 pgp_num 2568 lpg_num 0 lpgp_num 0 last_change 132 owne=
r
>>>> 18446744073709551615
>>>>
>>>>
>>>> On Wed, Apr 25, 2012 at 11:04 AM, Tomasz Paszkowski <ss7pro@gmail.=
com> wrote:
>>>>> Hi,
>>>>>
>>>>> After making and removing snapshot from one of the pools, all of =
the
>>>>> osd in cluster are dying with log like below:
>>>>>
>>>>>
>>>>> 2012-04-25 11:01:00.938313 7f66694b9700 osd.1 1434 =C2=A0removing=
 old
>>>>> osdmap epoch 966
>>>>> 2012-04-25 11:01:00.938330 7f66694b9700 osd.1 1434 =C2=A0removing=
 old
>>>>> osdmap epoch 967
>>>>> 2012-04-25 11:01:00.938348 7f66694b9700 osd.1 1434 =C2=A0advance =
to epoch
>>>>> 1435 (<=3D newest 1470)
>>>>> 2012-04-25 11:01:00.939437 7f66694b9700 osd.1 1435 advance_map ep=
och
>>>>> 1435 =C2=A01325 pgs
>>>>> 2012-04-25 11:01:00.939455 7f66694b9700 osd.1 1435 =C2=A0pool 0 r=
emoved
>>>>> snaps [], unchanged (snap_epoch =3D 0)
>>>>> 2012-04-25 11:01:00.939469 7f66694b9700 osd.1 1435 =C2=A0pool 1 r=
emoved
>>>>> snaps [], unchanged (snap_epoch =3D 0)
>>>>> 2012-04-25 11:01:00.939482 7f66694b9700 osd.1 1435 =C2=A0pool 2 r=
emoved
>>>>> snaps [], unchanged (snap_epoch =3D 0)
>>>>> ./include/interval_set.h: In function 'void interval_set<T>::eras=
e(T,
>>>>> T) [with T =3D snapid_t]' thread 7f66694b9700 time 2012-04-25
>>>>> 11:01:00.939509
>>>>> ./include/interval_set.h: 382: FAILED assert(_size >=3D 0)
>>>>> =C2=A0ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855=
358199dee)
>>>>> =C2=A01: (OSD::advance_map(ObjectStore::Transaction&, C_Contexts*=
)+0x2971) [0x5cfb51]
>>>>> =C2=A02: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
>>>>> =C2=A03: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
>>>>> =C2=A04: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
>>>>> =C2=A05: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
>>>>> =C2=A06: (SimpleMessenger::DispatchThread::entry()+0xd) [0x52124d=
]
>>>>> =C2=A07: (()+0x7e9a) [0x7f6676226e9a]
>>>>> =C2=A08: (clone()+0x6d) [0x7f66747db4bd]
>>>>> =C2=A0ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855=
358199dee)
>>>>> =C2=A01: (OSD::advance_map(ObjectStore::Transaction&, C_Contexts*=
)+0x2971) [0x5cfb51]
>>>>> =C2=A02: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
>>>>> =C2=A03: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
>>>>> =C2=A04: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
>>>>> =C2=A05: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
>>>>> =C2=A06: (SimpleMessenger::DispatchThread::entry()+0xd) [0x52124d=
]
>>>>> =C2=A07: (()+0x7e9a) [0x7f6676226e9a]
>>>>> =C2=A08: (clone()+0x6d) [0x7f66747db4bd]
>>>>> *** Caught signal (Aborted) **
>>>>> =C2=A0in thread 7f66694b9700
>>>>> =C2=A0ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855=
358199dee)
>>>>> =C2=A01: /usr/bin/ceph-osd() [0x6fa0c6]
>>>>> =C2=A02: (()+0xfcb0) [0x7f667622ecb0]
>>>>> =C2=A03: (gsignal()+0x35) [0x7f667471f445]
>>>>> =C2=A04: (abort()+0x17b) [0x7f6674722bab]
>>>>> =C2=A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f66=
7506d69d]
>>>>> =C2=A06: (()+0xb5846) [0x7f667506b846]
>>>>> =C2=A07: (()+0xb5873) [0x7f667506b873]
>>>>> =C2=A08: (()+0xb596e) [0x7f667506b96e]
>>>>> =C2=A09: (ceph::__ceph_assert_fail(char const*, char const*, int,=
 char
>>>>> const*)+0x200) [0x68f420]
>>>>> =C2=A010: (OSD::advance_map(ObjectStore::Transaction&, C_Contexts=
*)+0x2971)
>>>>> [0x5cfb51]
>>>>> =C2=A011: (OSD::handle_osd_map(MOSDMap*)+0x193c) [0x5d162c]
>>>>> =C2=A012: (OSD::_dispatch(Message*)+0x2eb) [0x5d34fb]
>>>>> =C2=A013: (OSD::ms_dispatch(Message*)+0x129) [0x5d3a59]
>>>>> =C2=A014: (SimpleMessenger::dispatch_entry()+0x78b) [0x67513b]
>>>>> =C2=A015: (SimpleMessenger::DispatchThread::entry()+0xd) [0x52124=
d]
>>>>> =C2=A016: (()+0x7e9a) [0x7f6676226e9a]
>>>>> =C2=A017: (clone()+0x6d) [0x7f66747db4bd]
>>>>>
>>>>>
>>>>> --
>>>>> Tomasz Paszkowski
>>>>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>>>>> +48500166299
>>>>
>>>>
>>>>
>>>> --
>>>> Tomasz Paszkowski
>>>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>>>> +48500166299
>>>
>>>
>>>
>>> --
>>> Tomasz Paszkowski
>>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>>> +48500166299
>>
>>
>>
>> --
>> Tomasz Paszkowski
>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>> +48500166299
>
>
>
> --
> Tomasz Paszkowski
> SS7, Asterisk, SAN, Datacenter, Cloud Computing
> +48500166299
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
