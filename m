From: ruslan usifov <ruslan.usifov@gmail.com>
Subject: Ceph mon crash
Date: Mon, 19 Mar 2012 18:33:09 +0400
Message-ID: <CAHULbCk1Lqp7fe6+0hSZkJp57Aht57zzoF8bXLpuBa+TCfcX4w@mail.gmail.com>
References: <CAHULbCnEs7o6E5mvUtMjN7NxJ3-fn8M-nriUdCqqceiBOvXKKA@mail.gmail.com>
	<CAHULbCk9RkaDUKYncp4-cYB3H9uhU8rjP+z0PW7YRD+goTORcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45803 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030834Ab2CSOdK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Mar 2012 10:33:10 -0400
Received: by ghrr11 with SMTP id r11so5448568ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 07:33:09 -0700 (PDT)
In-Reply-To: <CAHULbCk9RkaDUKYncp4-cYB3H9uhU8rjP+z0PW7YRD+goTORcg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello

I have follow stack trace:

#0=A0 0xb77fa424 in __kernel_vsyscall ()
(gdb) bt
#0=A0 0xb77fa424 in __kernel_vsyscall ()
#1=A0 0xb77e98a0 in raise () from /lib/i386-linux-gnu/
libpthread.so.0
#2=A0 0x08230f8b in ?? ()
#3=A0 <signal handler called>
#4=A0 0xb77fa424 in __kernel_vsyscall ()
#5=A0 0xb70eae71 in raise () from /lib/i386-linux-gnu/libc.so.6
#6=A0 0xb70ee34e in abort () from /lib/i386-linux-gnu/libc.so.6
#7=A0 0xb73130b5 in __gnu_cxx::__verbose_terminate_handler() () from
/usr/lib/i386-linux-gnu/libstdc++.so.6
#8=A0 0xb7310fa5 in ?? () from /usr/lib/i386-linux-gnu/libstdc++.so.6
#9=A0 0xb7310fe2 in std::terminate() () from
/usr/lib/i386-linux-gnu/libstdc++.so.6
#10 0xb731114e in __cxa_throw () from /usr/lib/i386-linux-gnu/libstdc++=
=2Eso.6
#11 0x0822f8c7 in ceph::__ceph_assert_fail(char const*, char const*,
int, char const*) ()
#12 0x081cf8a4 in MDSMap::get_health(std::basic_ostream<char,
std::char_traits<char> >&) const ()
#13 0x0811e8a7 in MDSMonitor::get_health(std::basic_ostream<char,
std::char_traits<char> >&) const ()
#14 0x080c4977 in Monitor::handle_command(MMonCommand*) ()
#15 0x080cf244 in Monitor::_ms_dispatch(Message*) ()
#16 0x080df1a4 in Monitor::ms_dispatch(Message*) ()
#17 0x081f706d in SimpleMessenger::dispatch_entry() ()
#18 0x080b27d2 in SimpleMessenger::DispatchThread::entry() ()
#19 0x081b5d81 in Thread::_entry_func(void*) ()
#20 0xb77e0e99 in start_thread () from /lib/i386-linux-gnu/libpthread.s=
o.0
#21 0xb71919ee in clone () from /lib/i386-linux-gnu/libc.so.6


And when one mon crashes all other monitors in cluster will crashes
too:-((. So one time in cluster not any alive mons
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
