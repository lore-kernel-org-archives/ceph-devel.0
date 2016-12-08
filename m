From: Alexey Sheplyakov <asheplyakov@mirantis.com>
Subject: Re: 10.2.4 Jewel released -- IMPORTANT
Date: Thu, 8 Dec 2016 11:38:27 +0300
Message-ID: <CAC7t81a4Ctd8z7x55k+qzYHE+T5M8Y-3PyFe3t3BtZgNK54FmQ@mail.gmail.com>
References: <877f7c3p6k.fsf@suse.com> <alpine.DEB.2.11.1612072305350.26733@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35216 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLHIi2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2016 03:38:28 -0500
Received: by mail-yw0-f172.google.com with SMTP id i145so317685799ywg.2
        for <ceph-devel@vger.kernel.org>; Thu, 08 Dec 2016 00:38:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612072305350.26733@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Abhishek L <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

> It triggers a bug in SimpleMessenger that causes threads for broken connections to spin, eating CPU.

#0  0x00007ff431d0c8cf in __libc_recv (fd=190, buf=0x7ff3b3c23000,
n=4096, flags=64) at ../sysdeps/unix/sysv/linux/x86_64/recv.c:28
#1  0x0000559d723e46f6 in Pipe::do_recv(char*, unsigned long, int) ()
#2  0x0000559d723e4a57 in Pipe::buffered_recv(char*, unsigned long, int) ()
#3  0x0000559d723e4b53 in Pipe::tcp_read_nonblocking(char*, unsigned int) ()
#4  0x0000559d723e4e0d in Pipe::tcp_read(char*, unsigned int) ()
#5  0x0000559d723f2577 in Pipe::reader() ()
#6  0x0000559d723fc51d in Pipe::Reader::entry() ()
#7  0x00007ff431d0370a in start_thread (arg=0x7ff3c3afc700) at
pthread_create.c:333
#8  0x00007ff42fd7c82d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

https://github.com/ceph/ceph/blob/jewel/src/msg/simple/Pipe.cc#L2522-L2525

Under Linux, select/poll/epoll may report a socket file descriptor as
"ready for reading",
while nevertheless a subsequent read blocks, or returns an error
(EAGAIN) in non-blocking mode.
Pipe::do_recv() should stop on EAGAIN (at least when using nonblocking
IO) instead of retrying.

Best regards,
      Alexey
