From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds fails to start on SL6
Date: Fri, 6 Jul 2012 09:38:03 -0700
Message-ID: <CAPYLRzgfbJwH067PTOs7Yz+MnPG=KUYorwPvg_M3wwgrsW6B8Q@mail.gmail.com>
References: <DC5475EA-BEE8-4623-BFE7-C6BBB68C8C35@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63446 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757679Ab2GFQiE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 12:38:04 -0400
Received: by bkwj10 with SMTP id j10so4581453bkw.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jul 2012 09:38:03 -0700 (PDT)
In-Reply-To: <DC5475EA-BEE8-4623-BFE7-C6BBB68C8C35@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: ceph-devel@vger.kernel.org

Do you have more in the log? It looks like it's being instructed to
shut down before it's fully come up (thus the error in the Objecter
http://tracker.newdream.net/issues/2740, but is not the root cause),
but I can't see why.
-Greg

On Fri, Jul 6, 2012 at 8:42 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
> Hi All,
>
> I was giving ceph 0.48 a try on SL6x, the OSD's startup okay, but the=
 mds fails to start, below is a snippet of the error,
>
>
> 2012-07-06 16:38:17.838055 7f2d6828d700 -1 mds.-1.0 *** got signal Te=
rminated ***
> 2012-07-06 16:38:17.838139 7f2d6828d700 =A01 mds.-1.0 suicide. =A0wan=
ted down:dne, now up:boot
> 2012-07-06 16:38:17.839020 7f2d6828d700 -1 osdc/Objecter.cc: In funct=
ion 'void Objecter::shutdown()' thread 7f2d6828d700 time 2012-07-06 16:=
38:17.838156
> osdc/Objecter.cc: 221: FAILED assert(initialized)
>
> =A0ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446=
a2bf2030)
> =A01: (Objecter::shutdown()+0x170) [0x6e2e20]
> =A02: (MDS::suicide()+0xc9) [0x4ad829]
> =A03: (MDS::handle_signal(int)+0x1bb) [0x4b447b]
> =A04: (SignalHandler::entry()+0x283) [0x803d53]
> =A05: /lib64/libpthread.so.0() [0x3b3ea077f1]
> =A06: (clone()+0x6d) [0x3b3e6e5ccd]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
>
> --- begin dump of recent events ---
> =A0 =A0 -3> 2012-07-06 16:37:57.786954 7f2d6b496760 =A00 ceph version=
 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030), proces=
s ceph-mds, pid 12537
> =A0 =A0 -2> 2012-07-06 16:38:17.838055 7f2d6828d700 -1 mds.-1.0 *** g=
ot signal Terminated ***
> =A0 =A0 -1> 2012-07-06 16:38:17.838139 7f2d6828d700 =A01 mds.-1.0 sui=
cide. =A0wanted down:dne, now up:boot
> =A0 =A0 =A00> 2012-07-06 16:38:17.839020 7f2d6828d700 -1 osdc/Objecte=
r.cc: In function 'void Objecter::shutdown()' thread 7f2d6828d700 time =
2012-07-06 16:38:17.838156
> osdc/Objecter.cc: 221: FAILED assert(initialized)
>
> =A0ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446=
a2bf2030)
> =A01: (Objecter::shutdown()+0x170) [0x6e2e20]
> =A02: (MDS::suicide()+0xc9) [0x4ad829]
> =A03: (MDS::handle_signal(int)+0x1bb) [0x4b447b]
> =A04: (SignalHandler::entry()+0x283) [0x803d53]
> =A05: /lib64/libpthread.so.0() [0x3b3ea077f1]
> =A06: (clone()+0x6d) [0x3b3e6e5ccd]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
>
> --- end dump of recent events ---
> 2012-07-06 16:38:17.840237 7f2d6828d700 -1 *** Caught signal (Aborted=
) **
> =A0in thread 7f2d6828d700
>
> =A0ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446=
a2bf2030)
> =A01: /usr/bin/ceph-mds() [0x803309]
> =A02: /lib64/libpthread.so.0() [0x3b3ea0f4a0]
> =A03: (gsignal()+0x35) [0x3b3e632885]
> =A04: (abort()+0x175) [0x3b3e634065]
> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3b432bea7d]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
>
> --- begin dump of recent events ---
> =A0 =A0 =A00> 2012-07-06 16:38:17.840237 7f2d6828d700 -1 *** Caught s=
ignal (Aborted) **
> =A0in thread 7f2d6828d700
>
> =A0ceph version 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446=
a2bf2030)
> =A01: /usr/bin/ceph-mds() [0x803309]
> =A02: /lib64/libpthread.so.0() [0x3b3ea0f4a0]
> =A03: (gsignal()+0x35) [0x3b3e632885]
> =A04: (abort()+0x175) [0x3b3e634065]
> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3b432bea7d]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
>
> --- end dump of recent events ---
>
>
>
>
>
> Regards,
> Jimmy Tang
>
> --
> Senior Software Engineer, Digital Repository of Ireland (DRI)
> Trinity Centre for High Performance Computing,
> Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
> http://www.tchpc.tcd.ie/
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
