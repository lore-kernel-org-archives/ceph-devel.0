From: Simone Gotti <simone.gotti@gmail.com>
Subject: [PATCH] msgr: Fix crash in policy.throttler->get(message_size) when
 message_size == 0
Date: Fri, 18 Jun 2010 15:08:06 +0200
Message-ID: <4C1B6FB6.6020606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:51582 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761214Ab0FRNIK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jun 2010 09:08:10 -0400
Received: by ey-out-2122.google.com with SMTP id 25so96709eya.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jun 2010 06:08:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

using the unstable branch I noticed that sometimes the various servers
and the clients were crashing with this backtrace:

#0  0x00000035d02329a5 in raise () from /lib64/libc.so.6
#1  0x00000035d0234185 in abort () from /lib64/libc.so.6
#2  0x00000035d76be8cd in __gnu_cxx::__verbose_terminate_handler() ()
from /usr/lib64/libstdc++.so.6
#3  0x00000035d76bca56 in ?? () from /usr/lib64/libstdc++.so.6
#4  0x00000035d76bca83 in std::terminate() () from /usr/lib64/libstdc++.so.6
#5  0x00000035d76bcb7e in __cxa_throw () from /usr/lib64/libstdc++.so.6
#6  0x00000000005a4b08 in ceph::__ceph_assert_fail (assertion=0x5ca23c
"c > 0", file=<value optimized out>, line=72, func=<value optimized
out>) at common/assert.cc:30
#7  0x0000000000460080 in get (this=0x7fec78001800) at
./common/Throttle.h:72
#8  SimpleMessenger::Pipe::read_message (this=0x7fec78001800) at
msg/SimpleMessenger.cc:1751
#9  0x0000000000464265 in SimpleMessenger::Pipe::reader
(this=0x7fec78001800) at msg/SimpleMessenger.cc:1499
#10 0x00000000004552ad in SimpleMessenger::Pipe::Reader::entry
(this=<value optimized out>) at msg/SimpleMessenger.h:168
#11 0x0000000000467a3a in Thread::_entry_func (arg=<value optimized
out>) at ./common/Thread.h:39
#12 0x00000035d0607761 in start_thread () from /lib64/libpthread.so.0
#13 0x00000035d02e14dd in clone () from /lib64/libc.so.6


From what I understand probably the same check for zero size messages
done for the messenger->message_throttler.get(message_size) should be
done also for the next policy.throttler->get(message_size) or it will
trigger the assert(c > 0) in Throttle::get .


Thanks!

Regards,
Simone Gotti


P.S. Sorry but I cannot reply mails for a week as I'll be on vacation.




Signed-off-by: Simone Gotti <simone.gotti@gmail.com>
---
 src/msg/SimpleMessenger.cc |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index a30e075..c15fa04 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -1746,9 +1746,10 @@ Message *SimpleMessenger::Pipe::read_message()
        << messenger->message_throttler.get_max() << dendl;
   uint64_t message_size = header.front_len  + header.middle_len
     + header.data_len;
-  if (message_size)
+  if (message_size) {
     messenger->message_throttler.get(message_size);
-  if (policy.throttler) policy.throttler->get(message_size);
+    if (policy.throttler) policy.throttler->get(message_size);
+  }
 
   // read front
   bufferlist front;
-- 
1.7.0.1





