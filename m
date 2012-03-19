From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Ceph mon crash
Date: Mon, 19 Mar 2012 10:06:56 -0700
Message-ID: <66BEE4F342554A54BA21F31CB051E2C4@dreamhost.com>
References: <CAHULbCnEs7o6E5mvUtMjN7NxJ3-fn8M-nriUdCqqceiBOvXKKA@mail.gmail.com>
 <CAHULbCk9RkaDUKYncp4-cYB3H9uhU8rjP+z0PW7YRD+goTORcg@mail.gmail.com>
 <CAHULbCk1Lqp7fe6+0hSZkJp57Aht57zzoF8bXLpuBa+TCfcX4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61947 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162083Ab2CSRG7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Mar 2012 13:06:59 -0400
Received: by obbeh20 with SMTP id eh20so1059553obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 10:06:58 -0700 (PDT)
In-Reply-To: <CAHULbCk1Lqp7fe6+0hSZkJp57Aht57zzoF8bXLpuBa+TCfcX4w@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ruslan usifov <ruslan.usifov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Monday, March 19, 2012 at 7:33 AM, ruslan usifov wrote:
> Hello
> =20
> I have follow stack trace:
> =20
> #0 0xb77fa424 in __kernel_vsyscall ()
> (gdb) bt
> #0 0xb77fa424 in __kernel_vsyscall ()
> #1 0xb77e98a0 in raise () from /lib/i386-linux-gnu/
> libpthread.so.0
> #2 0x08230f8b in ?? ()
> #3 <signal handler called>
> #4 0xb77fa424 in __kernel_vsyscall ()
> #5 0xb70eae71 in raise () from /lib/i386-linux-gnu/libc.so.6
> #6 0xb70ee34e in abort () from /lib/i386-linux-gnu/libc.so.6
> #7 0xb73130b5 in __gnu_cxx::__verbose_terminate_handler() () from
> /usr/lib/i386-linux-gnu/libstdc++.so.6
> #8 0xb7310fa5 in ?? () from /usr/lib/i386-linux-gnu/libstdc++.so.6
> #9 0xb7310fe2 in std::terminate() () from
> /usr/lib/i386-linux-gnu/libstdc++.so.6
> #10 0xb731114e in __cxa_throw () from /usr/lib/i386-linux-gnu/libstdc=
++.so.6
> #11 0x0822f8c7 in ceph::__ceph_assert_fail(char const*, char const*,
> int, char const*) ()
> #12 0x081cf8a4 in MDSMap::get_health(std::basic_ostream<char,
> std::char_traits<char> >&) const ()
> #13 0x0811e8a7 in MDSMonitor::get_health(std::basic_ostream<char,
> std::char_traits<char> >&) const ()
> #14 0x080c4977 in Monitor::handle_command(MMonCommand*) ()
> #15 0x080cf244 in Monitor::_ms_dispatch(Message*) ()
> #16 0x080df1a4 in Monitor::ms_dispatch(Message*) ()
> #17 0x081f706d in SimpleMessenger::dispatch_entry() ()
> #18 0x080b27d2 in SimpleMessenger::DispatchThread::entry() ()
> #19 0x081b5d81 in Thread::_entry_func(void*) ()
> #20 0xb77e0e99 in start_thread () from /lib/i386-linux-gnu/libpthread=
=2Eso.0
> #21 0xb71919ee in clone () from /lib/i386-linux-gnu/libc.so.6

Can you get the line number from frame 12? (f 12 <enter>, then just pas=
te the output) Also the output of "ceph -s" if things are still running=
=2E The only assert I see in get_health() is that each "up" MDS be in m=
ds_info, which really ought to be true=E2=80=A6.
 =20
> And when one mon crashes all other monitors in cluster will crashes
> too:-((. So one time in cluster not any alive mons

Yeah, this is because the crash is being triggered by a get_health comm=
and and it's trying it out on each monitor in turn as they fail.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
