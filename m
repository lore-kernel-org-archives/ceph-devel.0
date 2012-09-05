From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: e: mon memory issue
Date: Wed, 5 Sep 2012 20:44:14 +0200
Message-ID: <CAMwB3Tjm7hS8pjmidDUkBikTW3MaaFd60iFiokWHV7LLcUMZgQ@mail.gmail.com>
References: <50407DA0.7070608@gmail.com>
	<alpine.DEB.2.00.1208310858070.1531@cobra.newdream.net>
	<CAMwB3TjnbB=2iqxWudhNJwffFfwjj+EFU2mD=p=73gq0-7F43w@mail.gmail.com>
	<CAMwB3ThMDq5H8P4-u4yy=oKZZZR2_2E025mUGKiUTzgUofaVtg@mail.gmail.com>
	<alpine.DEB.2.00.1209042031240.10849@cobra.newdream.net>
	<CAMwB3TidRA=6n-TcOaQjD8msLduFqt_CU7w540-f8qbLuP_SCA@mail.gmail.com>
	<alpine.DEB.2.00.1209050850090.8916@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44083 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab2IESoP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 14:44:15 -0400
Received: by qaas11 with SMTP id s11so4821687qaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 11:44:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209050850090.8916@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Xiaopong Tran <xiaopong.tran@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Sep 5, 2012 at 5:51 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 5 Sep 2012, S?awomir Skowron wrote:
>> Unfortunately here is the problem in my Ubuntu 12.04.1
>>
>> --9399-- You may be able to write your own handler.
>> --9399-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
>> --9399-- Nevertheless we consider this a bug.  Please report
>> --9399-- it at http://valgrind.org/support/bug_reports.html.
>> =3D=3D9399=3D=3D Warning: noted but unhandled ioctl 0x9408 with no s=
ize/direction hints
>> =3D=3D9399=3D=3D    This could cause spurious value errors to appear=
=2E
>> =3D=3D9399=3D=3D    See README_MISSING_SYSCALL_OR_IOCTL for guidance=
 on
>> writing a proper wrapper.
>> --9399-- WARNING: unhandled syscall: 306
>> --9399-- You may be able to write your own handler.
>> --9399-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
>> --9399-- Nevertheless we consider this a bug.  Please report
>> --9399-- it at http://valgrind.org/support/bug_reports.html.
>> =3D=3D9399=3D=3D Warning: noted but unhandled ioctl 0x9408 with no s=
ize/direction hints
>> =3D=3D9399=3D=3D    This could cause spurious value errors to appear=
=2E
>> =3D=3D9399=3D=3D    See README_MISSING_SYSCALL_OR_IOCTL for guidance=
 on
>> writing a proper wrapper.
>
> These are harmless; it just doesn't recognize syncfs(2) or one of the
> ioctls, but everything else works.
>
>> ^C2012-09-05 09:13:18.660048 a964700 -1 mon.0@0(leader) e4 *** Got
>> Signal Interrupt ***
>> =3D=3D9399=3D=3D
>
> Did you hit control-c?
>
> If you leave it running it should gather the memory utilization info =
we
> need...

Yes it's running now, and  i will see tomorrow how much memory mon cons=
umes.

>
> sage
>
>>
>>
>> On Wed, Sep 5, 2012 at 5:32 AM, Sage Weil <sage@inktank.com> wrote:
>> > On Tue, 4 Sep 2012, S?awomir Skowron wrote:
>> >> Valgrind returns nothing.
>> >>
>> >> valgrind --tool=3Dmassif --log-file=3Dceph_mon_valgrind ceph-mon =
-i 0 > log.txt
>> >
>> > The fork is probably confusing it.  I usually pass -f to ceph-mon =
(or
>> > ceph-osd etc) to keep it in the foreground.  Can you give that a g=
o?
>> > e.g.,
>> >
>> >         valgrind --tool-massif ceph-mon -i 0 -f &
>> >
>> > and watch for the massif.out.$pid file.
>> >
>> > Thanks!
>> > sage
>> >
>> >
>> >>
>> >> =3D=3D30491=3D=3D Massif, a heap profiler
>> >> =3D=3D30491=3D=3D Copyright (C) 2003-2011, and GNU GPL'd, by Nich=
olas Nethercote
>> >> =3D=3D30491=3D=3D Using Valgrind-3.7.0 and LibVEX; rerun with -h =
for copyright info
>> >> =3D=3D30491=3D=3D Command: ceph-mon -i 0
>> >> =3D=3D30491=3D=3D Parent PID: 4013
>> >> =3D=3D30491=3D=3D
>> >> =3D=3D30491=3D=3D
>> >>
>> >> cat massif.out.26201
>> >> desc: (none)
>> >> cmd: ceph-mon -i 0
>> >> time_unit: i
>> >> #-----------
>> >> snapshot=3D0
>> >> #-----------
>> >> time=3D0
>> >> mem_heap_B=3D0
>> >> mem_heap_extra_B=3D0
>> >> mem_stacks_B=3D0
>> >> heap_tree=3Dempty
>> >>
>> >> What i have done wrong ??
>> >>
>> >> On Fri, Aug 31, 2012 at 8:34 PM, S?awomir Skowron <szibis@gmail.c=
om> wrote:
>> >> > I have this problem too. My mon's in 0.48.1 cluster have 10GB R=
AM
>> >> > each, with 78 osd, and 2k request per minute (max) in radosgw.
>> >> >
>> >> > Now i have run one via valgrind. I will send output when mon gr=
ow up.
>> >> >
>> >> > On Fri, Aug 31, 2012 at 6:03 PM, Sage Weil <sage@inktank.com> w=
rote:
>> >> >> On Fri, 31 Aug 2012, Xiaopong Tran wrote:
>> >> >>
>> >> >>> Hi,
>> >> >>>
>> >> >>> Is there any known memory issue with mon? We have 3 mons runn=
ing, and
>> >> >>> on keeps on crashing after 2 or 3 days, and I think it's beca=
use mon
>> >> >>> sucks up all memory.
>> >> >>>
>> >> >>> Here's mon after starting for 10 minutes:
>> >> >>>
>> >> >>>   PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+ =
 COMMAND
>> >> >>> 13700 root      20   0  163m  32m 3712 S   4.3  0.1   0:05.15=
 ceph-mon
>> >> >>>  2595 root      20   0 1672m 523m    0 S   1.7  1.6 954:33.56=
 ceph-osd
>> >> >>>  1941 root      20   0 1292m 220m    0 S   0.7  0.7 946:40.69=
 ceph-osd
>> >> >>>  2316 root      20   0 1169m 198m    0 S   0.7  0.6 420:26.74=
 ceph-osd
>> >> >>>  2395 root      20   0 1149m 184m    0 S   0.7  0.6 364:29.08=
 ceph-osd
>> >> >>>  2487 root      20   0 1354m 373m    0 S   0.7  1.2 401:13.97=
 ceph-osd
>> >> >>>   235 root      20   0     0    0    0 S   0.3  0.0   0:37.68=
 kworker/4:1
>> >> >>>  1304 root      20   0     0    0    0 S   0.3  0.0   0:00.16=
 jbd2/sda3-8
>> >> >>>  1327 root      20   0     0    0    0 S   0.3  0.0  13:07.00=
 xfsaild/sdf1
>> >> >>>  2011 root      20   0 1240m 177m    0 S   0.3  0.6 411:52.91=
 ceph-osd
>> >> >>>  2153 root      20   0 1095m 166m    0 S   0.3  0.5 370:56.01=
 ceph-osd
>> >> >>>  2725 root      20   0 1214m 186m    0 S   0.3  0.6 378:16.59=
 ceph-osd
>> >> >>>
>> >> >>> Here's the memory situation of mon on another machine, after =
mon has
>> >> >>> been running for 3 hours:
>> >> >>>
>> >> >>>   PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+ =
 COMMAND
>> >> >>>  1716 root      20   0 1923m 1.6g 4028 S   7.6  5.2   8:45.82=
 ceph-mon
>> >> >>>  1923 root      20   0  774m 138m 5052 S   0.7  0.4   1:28.56=
 ceph-osd
>> >> >>>  2114 root      20   0  836m 143m 4864 S   0.7  0.4   1:20.14=
 ceph-osd
>> >> >>>  2304 root      20   0  863m 176m 4988 S   0.7  0.5   1:13.30=
 ceph-osd
>> >> >>>  2578 root      20   0  823m 150m 5056 S   0.7  0.5   1:24.55=
 ceph-osd
>> >> >>>  2781 root      20   0  819m 131m 4900 S   0.7  0.4   1:12.14=
 ceph-osd
>> >> >>>  2995 root      20   0  863m 179m 5024 S   0.7  0.6   1:41.96=
 ceph-osd
>> >> >>>  3474 root      20   0  888m 208m 5608 S   0.7  0.6   7:08.08=
 ceph-osd
>> >> >>>  1228 root      20   0     0    0    0 S   0.3  0.0   0:07.01=
 jbd2/sda3-8
>> >> >>>  1853 root      20   0  859m 176m 4820 S   0.3  0.5   1:17.01=
 ceph-osd
>> >> >>>  3373 root      20   0  789m 118m 4916 S   0.3  0.4   1:06.26=
 ceph-osd
>> >> >>>
>> >> >>> And here is the situation on a third node, mon has been runni=
ng
>> >> >>> for over a week:
>> >> >>>
>> >> >>>   PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+ =
 COMMAND
>> >> >>>  1717 root      20   0 68.8g  26g 2044 S  91.5 84.1   9220:40=
 ceph-mon
>> >> >>>  1986 root      20   0 1281m 226m    0 S   1.7  0.7   1225:28=
 ceph-osd
>> >> >>>  2196 root      20   0 1501m 538m    0 S   1.0  1.7   1221:54=
 ceph-osd
>> >> >>>  2266 root      20   0 1121m 176m    0 S   0.7  0.5 399:23.70=
 ceph-osd
>> >> >>>  2056 root      20   0 1072m 167m    0 S   0.3  0.5 403:49.76=
 ceph-osd
>> >> >>>  2126 root      20   0 1412m 458m    0 S   0.3  1.4   1215:48=
 ceph-osd
>> >> >>>  2337 root      20   0 1128m 188m    0 S   0.3  0.6 408:31.88=
 ceph-osd
>> >> >>>
>> >> >>> So, after a while, sooner or later, mon is going to crash, ju=
st
>> >> >>> a matter of time.
>> >> >>>
>> >> >>> Does anyone see anything like this? This is kinda scary.
>> >> >>>
>> >> >>> OS: Debian Wheezy 3.2.0-3-amd64
>> >> >>> Ceph: 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2=
bf2030)
>> >> >>
>> >> >> Can you try with 0.48.1argonaut?
>> >> >>
>> >> >> If it still happens, can you run ceph-mon through massif?
>> >> >>
>> >> >>  valgrind --tool=3Dmassif ceph-mon -i whatever
>> >> >>
>> >> >> That'll generate a massif.out file (make sure it's there; you =
may need to
>> >> >> specify the output file for valgrind) over time.  Once ceph-mo=
n starts
>> >> >> eating ram, send us a copy of the file and we can hopefully se=
e what is
>> >> >> leaking.
>> >> >>
>> >> >> Thanks!
>> >> >> sage
>> >> >>
>> >> >>
>> >> >>>
>> >> >>> With this issue on hand, I'll have to monitor it closely and
>> >> >>> restart mon once in a while, or I will get a crash (which is
>> >> >>> still good enough), or a system that does not respond at
>> >> >>> all because memory is exhausted, and the whole ceph cluster
>> >> >>> is unreachable. We had this problem in the morning, mon on on=
e
>> >> >>> node exhausted the memory, none of the ceph command responds
>> >> >>> anymore, the only thing left to do is to hard reset the node.
>> >> >>> The whole cluster was basically done at that time.
>> >> >>>
>> >> >>> Here is our usage situation:
>> >> >>>
>> >> >>> 1) A few applications which read and write data through
>> >> >>> librados API, we have about 20-30 connections at any one time=
=2E
>> >> >>> So far, our apps have no such memory issue, we have been
>> >> >>> monitoring them closely.
>> >> >>>
>> >> >>> 2) We have a few scripts which pull data from an old storage
>> >> >>> system, and use the rados command to put it into ceph.
>> >> >>> Basically, just shell script. Each rados command is run
>> >> >>> to write one object (one file), and exit. We run about
>> >> >>> 25 scripts simultaneously, which means at any one time,
>> >> >>> there are at most 25 connections.
>> >> >>>
>> >> >>> I don't think this is a very busy system. But this
>> >> >>> memory issue is definitely a problem for us.
>> >> >>>
>> >> >>> Thanks for helping.
>> >> >>>
>> >> >>> Xiaopong
>> >> >>> --
>> >> >>> To unsubscribe from this list: send the line "unsubscribe cep=
h-devel" in
>> >> >>> the body of a message to majordomo@vger.kernel.org
>> >> >>> More majordomo info at  http://vger.kernel.org/majordomo-info=
=2Ehtml
>> >> >>>
>> >> >>>
>> >> >> --
>> >> >> To unsubscribe from this list: send the line "unsubscribe ceph=
-devel" in
>> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.=
html
>> >> >
>> >> >
>> >> >
>> >> > --
>> >> > -----
>> >> > Pozdrawiam
>> >> >
>> >> > S?awek "sZiBis" Skowron
>> >>
>> >>
>> >>
>> >> --
>> >> -----
>> >> Pozdrawiam
>> >>
>> >> S?awek "sZiBis" Skowron
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>> >>
>> >>
>>
>>
>>
>> --
>> -----
>> Pozdrawiam
>>
>> S?awek "sZiBis" Skowron
>>
>>



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
