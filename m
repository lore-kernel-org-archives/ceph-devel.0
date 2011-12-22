From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Assertion: ./messages/MOSDRepScrub.h: 64: FAILED assert(v == 0)
Date: Thu, 22 Dec 2011 13:08:39 -0800
Message-ID: <CACLRD_2C4S9jAS9s1OoMCtOM6K1nCaJ_VasvvDngENPV2T-q6g@mail.gmail.com>
References: <4EF3351A.5050404@tuxadero.com>
	<CAF3hT9Cjq7x1gf8oieZu7E7jG0S28Ox+6fwkbzHKuvRCM_kpBw@mail.gmail.com>
	<4EF395C3.3010104@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39782 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab1LVVIl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 16:08:41 -0500
Received: by wibhm6 with SMTP id hm6so2791394wib.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 13:08:40 -0800 (PST)
In-Reply-To: <4EF395C3.3010104@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

Martin, that bug should actually be fixed in current master.  You'll
need to upgrade the whole cluster, though.
-Sam

On Thu, Dec 22, 2011 at 12:40 PM, Martin Mailand <martin@tuxadero.com> =
wrote:
> Hi Greg,
> ok, I also have at the moment one pg which stays in scrubbing, is tha=
t also
> a result of the different versions I am running?
> Do you know if Sam needs the cluster in this state to debug the scrub=
bing
> problem? Or is it unusable for that due to the different versions?
>
>
> -martin
>
> Am 22.12.2011 21:24, schrieb Gregory Farnum:
>
>> I see you're following master! :) You got bit by a wire-incompatible
>> change in one of the OSD messages that Sam made, although I think he=
's
>> actually going to be walking it back after a conversation we just ha=
d.
>> In any case, restarting all of your OSDs so they're running the same
>> code will fix it. :)
>> -Greg
>>
>> On Thu, Dec 22, 2011 at 5:48 AM, Martin Mailand<martin@tuxadero.com>
>> =C2=A0wrote:
>>>
>>> Hi
>>> today 2 of my osds (osd.4 and osd.7) crashed with the same error.
>>>
>>> 2011-12-21 14:41:18.896008 7fae9f3a5700 journal check_for_full at
>>> 80625664 :
>>> JOURNAL FULL 80625664>=3D 368639 (max_size 107372544 start 80994304=
)
>>> 2011-12-21 14:41:23.205993 7fae9fba6700 journal =C2=A0FULL_FULL -> =
=C2=A0FULL_WAIT.
>>> =C2=A0last commit epoch committed, waiting for a new one to start.
>>> 2011-12-21 14:41:24.075990 7fae9fba6700 journal =C2=A0FULL_WAIT ->
>>> =C2=A0FULL_NOTFULL.
>>> =C2=A0journal now active, setting completion plug.
>>> ./messages/MOSDRepScrub.h: In function 'virtual void
>>> MOSDRepScrub::decode_payload(CephContext*)', in thread '7fae9397770=
0'
>>> ./messages/MOSDRepScrub.h: 64: FAILED assert(v =3D=3D 0)
>>> =C2=A0ceph version 0.39-171-gdcedda8
>>> (commit:dcedda84d0e1f69af985c301276c67c1b11e7efc)
>>> =C2=A01: /usr/bin/ceph-osd() [0x685e77]
>>> =C2=A02: (decode_message(CephContext*, ceph_msg_header&, ceph_msg_f=
ooter&,
>>> ceph::buffer::list&, ceph::buffer::list&, ceph::buffer::list&)+0xcd=
2)
>>> [0x6a7202]
>>> =C2=A03: (SimpleMessenger::Pipe::read_message(Message**)+0x136d) [0=
x62c9cd]
>>> =C2=A04: (SimpleMessenger::Pipe::reader()+0xb99) [0x6357d9]
>>> =C2=A05: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x4c244d]
>>> =C2=A06: (()+0x6d8c) [0x7faea6873d8c]
>>> =C2=A07: (clone()+0x6d) [0x7faea4eb004d]
>>> =C2=A0ceph version 0.39-171-gdcedda8
>>> (commit:dcedda84d0e1f69af985c301276c67c1b11e7efc)
>>> =C2=A01: /usr/bin/ceph-osd() [0x685e77]
>>> =C2=A02: (decode_message(CephContext*, ceph_msg_header&, ceph_msg_f=
ooter&,
>>> ceph::buffer::list&, ceph::buffer::list&, ceph::buffer::list&)+0xcd=
2)
>>> [0x6a7202]
>>> =C2=A03: (SimpleMessenger::Pipe::read_message(Message**)+0x136d) [0=
x62c9cd]
>>> =C2=A04: (SimpleMessenger::Pipe::reader()+0xb99) [0x6357d9]
>>> =C2=A05: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x4c244d]
>>> =C2=A06: (()+0x6d8c) [0x7faea6873d8c]
>>> =C2=A07: (clone()+0x6d) [0x7faea4eb004d]
>>> *** Caught signal (Aborted) **
>>> =C2=A0in thread 7fae93977700
>>> =C2=A0ceph version 0.39-171-gdcedda8
>>> (commit:dcedda84d0e1f69af985c301276c67c1b11e7efc)
>>> =C2=A01: /usr/bin/ceph-osd() [0x645172]
>>> =C2=A02: (()+0xfc60) [0x7faea687cc60]
>>> =C2=A03: (gsignal()+0x35) [0x7faea4dfdd05]
>>> =C2=A04: (abort()+0x186) [0x7faea4e01ab6]
>>> =C2=A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7faea5=
6b46dd]
>>> =C2=A06: (()+0xb9926) [0x7faea56b2926]
>>> =C2=A07: (()+0xb9953) [0x7faea56b2953]
>>> =C2=A08: (()+0xb9a5e) [0x7faea56b2a5e]
>>> =C2=A09: (ceph::__ceph_assert_fail(char const*, char const*, int, c=
har
>>> const*)+0x396) [0x6193d6]
>>> =C2=A010: /usr/bin/ceph-osd() [0x685e77]
>>> =C2=A011: (decode_message(CephContext*, ceph_msg_header&, ceph_msg_=
footer&,
>>> ceph::buffer::list&, ceph::buffer::list&, ceph::buffer::list&)+0xcd=
2)
>>> [0x6a7202]
>>> =C2=A012: (SimpleMessenger::Pipe::read_message(Message**)+0x136d) [=
0x62c9cd]
>>> =C2=A013: (SimpleMessenger::Pipe::reader()+0xb99) [0x6357d9]
>>> =C2=A014: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x4c244d]
>>> =C2=A015: (()+0x6d8c) [0x7faea6873d8c]
>>> =C2=A016: (clone()+0x6d) [0x7faea4eb004d]
>>>
>>>
>>> (gdb) thread apply all bt
>>>
>>> <snip>
>>>
>>> Thread 1 (Thread 2400):
>>> #0 =C2=A00x00007faea687cb3b in raise () from
>>> /lib/x86_64-linux-gnu/libpthread.so.0
>>> #1 =C2=A00x0000000000644dc2 in reraise_fatal (signum=3D6) at
>>> global/signal_handler.cc:59
>>> #2 =C2=A00x00000000006453ba in handle_fatal_signal (signum=3D6) at
>>> global/signal_handler.cc:106
>>> #3<signal handler called>
>>> ---Type<return> =C2=A0to continue, or q<return> =C2=A0to quit---
>>> #4 =C2=A00x00007faea4dfdd05 in raise () from /lib/x86_64-linux-gnu/=
libc.so.6
>>> #5 =C2=A00x00007faea4e01ab6 in abort () from /lib/x86_64-linux-gnu/=
libc.so.6
>>> #6 =C2=A00x00007faea56b46dd in __gnu_cxx::__verbose_terminate_handl=
er() ()
>>> from
>>> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>> #7 =C2=A00x00007faea56b2926 in ?? () from
>>> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>> #8 =C2=A00x00007faea56b2953 in std::terminate() () from
>>> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>> #9 =C2=A00x00007faea56b2a5e in __cxa_throw () from
>>> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>> #10 0x00000000006193d6 in ceph::__ceph_assert_fail (assertion=3D<va=
lue
>>> optimized out>, file=3D<value optimized out>, line=3D<value optimiz=
ed out>,
>>> =C2=A0 =C2=A0func=3D<value optimized out>) at common/assert.cc:70
>>> #11 0x0000000000685e77 in MOSDRepScrub::decode_payload (this=3D0x33=
c0c40,
>>> cct=3D<value optimized out>) at ./messages/MOSDRepScrub.h:64
>>> #12 0x00000000006a7202 in decode_message (cct=3D0x2722000, header=3D=
=2E..,
>>> footer=3D<value optimized out>, front=3D<value optimized out>, midd=
le=3D<value
>>> optimized out>,
>>> =C2=A0 =C2=A0data=3D...) at msg/Message.cc:551
>>> #13 0x000000000062c9cd in SimpleMessenger::Pipe::read_message
>>> (this=3D0x2ed3780, pm=3D0x7fae93976d88) at msg/SimpleMessenger.cc:1=
987
>>> #14 0x00000000006357d9 in SimpleMessenger::Pipe::reader (this=3D0x2=
ed3780)
>>> at
>>> msg/SimpleMessenger.cc:1601
>>> #15 0x00000000004c244d in SimpleMessenger::Pipe::Reader::entry
>>> (this=3D<value
>>> optimized out>) at msg/SimpleMessenger.h:208
>>> #16 0x00007faea6873d8c in start_thread () from
>>> /lib/x86_64-linux-gnu/libpthread.so.0
>>> #17 0x00007faea4eb004d in clone () from /lib/x86_64-linux-gnu/libc.=
so.6
>>> #18 0x0000000000000000 in ?? ()
>>> (gdb) thread 1
>>> [Switching to thread 1 (Thread 2400)]#0 =C2=A00x00007faea687cb3b in=
 raise ()
>>> from
>>> /lib/x86_64-linux-gnu/libpthread.so.0
>>> (gdb) frame 11
>>> #11 0x0000000000685e77 in MOSDRepScrub::decode_payload (this=3D0x33=
c0c40,
>>> cct=3D<value optimized out>) at ./messages/MOSDRepScrub.h:64
>>> 64 =C2=A0 =C2=A0 =C2=A0./messages/MOSDRepScrub.h: No such file or d=
irectory.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0in ./messages/MOSDRepScrub.h
>>> (gdb) p v
>>> $1 =3D 1 '\001'
>>>
>>>
>>> -martin
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
