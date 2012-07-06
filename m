From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds fails to start on SL6
Date: Fri, 6 Jul 2012 13:19:33 -0700
Message-ID: <CAPYLRzjDaBryDYrb2s1rdnxBiEF0K2X-9woVGeSx3oLY8QGQFQ@mail.gmail.com>
References: <DC5475EA-BEE8-4623-BFE7-C6BBB68C8C35@tchpc.tcd.ie>
	<5D7F9996EA547448BC6C54C8C5AAF4E565342B69@CERNXCHG01.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49064 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab2GFUTf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 16:19:35 -0400
Received: by lbbgm6 with SMTP id gm6so15922560lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jul 2012 13:19:33 -0700 (PDT)
In-Reply-To: <5D7F9996EA547448BC6C54C8C5AAF4E565342B69@CERNXCHG01.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Bell <Tim.Bell@cern.ch>
Cc: Jimmy Tang <jtang@tchpc.tcd.ie>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jul 6, 2012 at 12:07 PM, Tim Bell <Tim.Bell@cern.ch> wrote:
>
> Does SL6 have the kernel level required ?

The MDS is a userspace daemon that demands absolutely nothing unusual
from the kernel. :)
-Greg

> Tim
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Jimmy Tang
>> Sent: 06 July 2012 17:43
>> To: ceph-devel@vger.kernel.org
>> Subject: mds fails to start on SL6
>>
>> Hi All,
>>
>> I was giving ceph 0.48 a try on SL6x, the OSD's startup okay, but th=
e mds
> fails
>> to start, below is a snippet of the error,
>>
>>
>> 2012-07-06 16:38:17.838055 7f2d6828d700 -1 mds.-1.0 *** got signal
>> Terminated ***
>> 2012-07-06 16:38:17.838139 7f2d6828d700 =A01 mds.-1.0 suicide. =A0wa=
nted
>> down:dne, now up:boot
>> 2012-07-06 16:38:17.839020 7f2d6828d700 -1 osdc/Objecter.cc: In func=
tion
>> 'void Objecter::shutdown()' thread 7f2d6828d700 time 2012-07-06
>> 16:38:17.838156
>> osdc/Objecter.cc: 221: FAILED assert(initialized)
>>
>> =A0ceph version 0.48argonaut
>> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>> =A01: (Objecter::shutdown()+0x170) [0x6e2e20]
>> =A02: (MDS::suicide()+0xc9) [0x4ad829]
>> =A03: (MDS::handle_signal(int)+0x1bb) [0x4b447b]
>> =A04: (SignalHandler::entry()+0x283) [0x803d53]
>> =A05: /lib64/libpthread.so.0() [0x3b3ea077f1]
>> =A06: (clone()+0x6d) [0x3b3e6e5ccd]
>> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is=
 needed
>> to interpret this.
>>
>> --- begin dump of recent events ---
>> =A0 =A0 -3> 2012-07-06 16:37:57.786954 7f2d6b496760 =A00 ceph versio=
n
> 0.48argonaut
>> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030), process ceph-mds,
>> pid 12537
>> =A0 =A0 -2> 2012-07-06 16:38:17.838055 7f2d6828d700 -1 mds.-1.0 *** =
got signal
>> Terminated ***
>> =A0 =A0 -1> 2012-07-06 16:38:17.838139 7f2d6828d700 =A01 mds.-1.0 su=
icide.
> wanted
>> down:dne, now up:boot
>> =A0 =A0 =A00> 2012-07-06 16:38:17.839020 7f2d6828d700 -1 osdc/Object=
er.cc: In
>> function 'void Objecter::shutdown()' thread 7f2d6828d700 time 2012-0=
7-06
>> 16:38:17.838156
>> osdc/Objecter.cc: 221: FAILED assert(initialized)
>>
>> =A0ceph version 0.48argonaut
>> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>> =A01: (Objecter::shutdown()+0x170) [0x6e2e20]
>> =A02: (MDS::suicide()+0xc9) [0x4ad829]
>> =A03: (MDS::handle_signal(int)+0x1bb) [0x4b447b]
>> =A04: (SignalHandler::entry()+0x283) [0x803d53]
>> =A05: /lib64/libpthread.so.0() [0x3b3ea077f1]
>> =A06: (clone()+0x6d) [0x3b3e6e5ccd]
>> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is=
 needed
>> to interpret this.
>>
>> --- end dump of recent events ---
>> 2012-07-06 16:38:17.840237 7f2d6828d700 -1 *** Caught signal (Aborte=
d) **
>> in thread 7f2d6828d700
>>
>> =A0ceph version 0.48argonaut
>> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>> =A01: /usr/bin/ceph-mds() [0x803309]
>> =A02: /lib64/libpthread.so.0() [0x3b3ea0f4a0]
>> =A03: (gsignal()+0x35) [0x3b3e632885]
>> =A04: (abort()+0x175) [0x3b3e634065]
>> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3b432bea7d=
]
>> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is=
 needed
>> to interpret this.
>>
>> --- begin dump of recent events ---
>> =A0 =A0 =A00> 2012-07-06 16:38:17.840237 7f2d6828d700 -1 *** Caught =
signal
>> (Aborted) ** =A0in thread 7f2d6828d700
>>
>> =A0ceph version 0.48argonaut
>> (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)
>> =A01: /usr/bin/ceph-mds() [0x803309]
>> =A02: /lib64/libpthread.so.0() [0x3b3ea0f4a0]
>> =A03: (gsignal()+0x35) [0x3b3e632885]
>> =A04: (abort()+0x175) [0x3b3e634065]
>> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3b432bea7d=
]
>> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is=
 needed
>> to interpret this.
>>
>> --- end dump of recent events ---
>>
>>
>>
>>
>>
>> Regards,
>> Jimmy Tang
>>
>> --
>> Senior Software Engineer, Digital Repository of Ireland (DRI) Trinit=
y
> Centre
>> for High Performance Computing, Lloyd Building, Trinity College Dubl=
in,
>> Dublin 2, Ireland.
>> http://www.tchpc.tcd.ie/
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
> the
>> body of a message to majordomo@vger.kernel.org More majordomo info a=
t
>> http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
