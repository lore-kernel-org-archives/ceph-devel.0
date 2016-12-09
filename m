From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: 10.2.4 Jewel released -- IMPORTANT
Date: Thu, 8 Dec 2016 16:25:19 -0800
Message-ID: <CAJ4mKGbLAuVxqsfR-KAFmVthikBiMLPu1UAn+HfpYsqNbY0etg@mail.gmail.com>
References: <877f7c3p6k.fsf@suse.com> <alpine.DEB.2.11.1612072305350.26733@piezo.novalocal>
 <CAC7t81a4Ctd8z7x55k+qzYHE+T5M8Y-3PyFe3t3BtZgNK54FmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:36375 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753847AbcLIAZt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2016 19:25:49 -0500
Received: by mail-io0-f178.google.com with SMTP id a81so27022083ioe.3
        for <ceph-devel@vger.kernel.org>; Thu, 08 Dec 2016 16:25:20 -0800 (PST)
In-Reply-To: <CAC7t81a4Ctd8z7x55k+qzYHE+T5M8Y-3PyFe3t3BtZgNK54FmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexey Sheplyakov <asheplyakov@mirantis.com>
Cc: Sage Weil <sage@newdream.net>, Abhishek L <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Dec 8, 2016 at 12:38 AM, Alexey Sheplyakov
<asheplyakov@mirantis.com> wrote:
> Hi,
>
>> It triggers a bug in SimpleMessenger that causes threads for broken connections to spin, eating CPU.
>
> #0  0x00007ff431d0c8cf in __libc_recv (fd=190, buf=0x7ff3b3c23000,
> n=4096, flags=64) at ../sysdeps/unix/sysv/linux/x86_64/recv.c:28
> #1  0x0000559d723e46f6 in Pipe::do_recv(char*, unsigned long, int) ()
> #2  0x0000559d723e4a57 in Pipe::buffered_recv(char*, unsigned long, int) ()
> #3  0x0000559d723e4b53 in Pipe::tcp_read_nonblocking(char*, unsigned int) ()
> #4  0x0000559d723e4e0d in Pipe::tcp_read(char*, unsigned int) ()
> #5  0x0000559d723f2577 in Pipe::reader() ()
> #6  0x0000559d723fc51d in Pipe::Reader::entry() ()
> #7  0x00007ff431d0370a in start_thread (arg=0x7ff3c3afc700) at
> pthread_create.c:333
> #8  0x00007ff42fd7c82d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
>
> https://github.com/ceph/ceph/blob/jewel/src/msg/simple/Pipe.cc#L2522-L2525
>
> Under Linux, select/poll/epoll may report a socket file descriptor as
> "ready for reading",
> while nevertheless a subsequent read blocks, or returns an error
> (EAGAIN) in non-blocking mode.
> Pipe::do_recv() should stop on EAGAIN (at least when using nonblocking
> IO) instead of retrying.

Hmm, I'd assume in the case of a checksum error you'd expect the data
to show up again pretty quickly.

In any case I've updated https://github.com/ceph/ceph/pull/12374 to
deal with that more gracefully by setting a configurable number of
retry attempts on EAGAIN. I think we've tracked down what we need to.
-Greg
