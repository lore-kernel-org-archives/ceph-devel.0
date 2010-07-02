From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: OSD scalability & thread stacksize
Date: Thu, 1 Jul 2010 20:54:54 -0700
Message-ID: <AANLkTikEIfL3PHooTvOmJKAYo-VxdMfbgTirE6c59jR7@mail.gmail.com>
References: <AANLkTilDYesH_4FFEPUdLGvQRoZcW99czwfGru44RW3i@mail.gmail.com>
	<Pine.LNX.4.64.1007010724060.5822@cobra.newdream.net>
	<AANLkTikMO6VLTd4VyGhxWnJhgGbXHFNc10Z7uf-GRA66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60085 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab0GBDyz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jul 2010 23:54:55 -0400
Received: by vws5 with SMTP id 5so3231902vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jul 2010 20:54:55 -0700 (PDT)
In-Reply-To: <AANLkTikMO6VLTd4VyGhxWnJhgGbXHFNc10Z7uf-GRA66@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul <paul_chiang@tcloudcomputing.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Thu, Jul 1, 2010 at 8:10 PM, Paul <paul_chiang@tcloudcomputing.com> =
wrote:
>
> On Thu, Jul 1, 2010 at 10:51 PM, Sage Weil <sage@newdream.net> wrote:
> > Hi Paul,
> >
> > On Thu, 1 Jul 2010, Paul wrote:
> >> Follow up on the discussion on IRC late last night:
> >>
> >> On x86_64 2.6 kernels, pthread_create seems to allocate by default
> >> 8196KB stack size for the newly created thread. Since there can be
> >> potentially a large number of SimpleMessenger::Pipe instances (for
> >> example, when there are many OSDs and they need to heartbeat each
> >> other) and each instance has a reader and writer thread, a system =
can
> >> quickly run out of available memory to create new threads.
> >
> > This is surprising to me. =A0My understanding is that each thread i=
s
> > allocated a big chunk of _virtual_ memory for its stack, but no phy=
sical
> > pages are allocated until that memory is actually touched. =A0That,=
 at
> > least, is what I take away from e.g.
> >
> > http://www.kegel.com/stackcheck/
> >
> > Also, looking at the memory map for a random cmon process, I see th=
e 8MB
> > stack, but Rss is only 8 KB:
> >
> > $ cat /proc/$pid/smaps
> > [...]
> > 7f18b27fe000-7f18b2ffe000 rw-p 00000000 00:00 0
> > Size: =A0 =A0 =A0 =A0 =A0 =A0 =A0 8192 kB
> > Rss: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8 kB
> > Pss: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8 kB
> > Shared_Clean: =A0 =A0 =A0 =A0 =A00 kB
> > Shared_Dirty: =A0 =A0 =A0 =A0 =A00 kB
> > Private_Clean: =A0 =A0 =A0 =A0 0 kB
> > Private_Dirty: =A0 =A0 =A0 =A0 8 kB
> > Referenced: =A0 =A0 =A0 =A0 =A0 =A08 kB
> > Swap: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 kB
> > KernelPageSize: =A0 =A0 =A0 =A04 kB
> > MMUPageSize: =A0 =A0 =A0 =A0 =A0 4 kB
> > 7f18b2ffe000-7f18b2fff000 ---p 00000000 00:00 0
> > Size: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04 kB
> > Rss: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 kB
> > Pss: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 kB
> > Shared_Clean: =A0 =A0 =A0 =A0 =A00 kB
> > Shared_Dirty: =A0 =A0 =A0 =A0 =A00 kB
> > Private_Clean: =A0 =A0 =A0 =A0 0 kB
> > Private_Dirty: =A0 =A0 =A0 =A0 0 kB
> > Referenced: =A0 =A0 =A0 =A0 =A0 =A00 kB
> > Swap: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 kB
> > KernelPageSize: =A0 =A0 =A0 =A04 kB
> > MMUPageSize: =A0 =A0 =A0 =A0 =A0 4 kB
> >
> > Do you see a large Rss in your environment? =A0Maybe it's a library=
 behavior
> > thing?
> >
> > Or maybe the problem is just that the virtual memory reserved for t=
hread
> > stacks is exhausted. =A0Maybe there is some way to make the process
> > initialization reserve a larger area of memory for thread stacks?
> >
> Yes, this seems to be what is happening. Taking a look, our kernels
> had ulimit -v set to equal total physical memory. After setting ulimi=
t
> -v to unlimited, 32748 threads can be created regardless of what stac=
k
> size is allocated to each thread, at which point pthread_create
> returns ENOMEM rather than EAGAIN. I'd still prefer to manage the
> allocated size though, since kernel settings might not be totally
> within our control.
>
> >> A short term solution would be to decrease the amount of stack spa=
ce
> >> allocated for the reader and writer threads. I guess something alo=
ng
> >> the lines of:
> >> http://github.com/tcloud/ceph/commit/39ffa236f3de2082c475a5ea5edc8=
afa09941bd6
> >> and
> >> http://github.com/tcloud/ceph/commit/1dbd42a5c4b064c581ddc152d41b9=
553f346df8a
> >
> > This seems reasonable as a workaround.
> >
> >> Yehudasa suggested a stacksize of 512KB, and it seems to work fine=
=2E
> >
> > Looking at the Rss value for stack threads in /proc/$pid/smaps woul=
d be a
> > pretty good way to see what kind of stack utilization those threads=
 are
> > seeing. =A0I suspect something much smaller than 512KB would be saf=
e (16
> > KB?).
> >
> Here's an excerpt of smaps from a random OSD's smaps:
> 7fecf7974000-7fecf79f4000 rw-p 00000000 00:00 0
> Size: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0512 kB
> Rss: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A012 kB
> Pss: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A012 kB
> Shared_Clean: =A0 =A0 =A0 =A0 =A00 kB
> Shared_Dirty: =A0 =A0 =A0 =A0 =A00 kB
> Private_Clean: =A0 =A0 =A0 =A0 0 kB
> Private_Dirty: =A0 =A0 =A0 =A012 kB
> Referenced: =A0 =A0 =A0 =A0 =A0 12 kB
> Swap: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 kB
> KernelPageSize: =A0 =A0 =A0 =A04 kB
> MMUPageSize: =A0 =A0 =A0 =A0 =A0 4 kB
>
> This is great info (and much more precise than trial and error!) -- i=
t
> would appear 16KB is a safe minimum.

(resending reply due to some technical problem)

I'd be really careful about that. 16KB is pretty low (for userspace
applications), and there a few places where we allocate stuff
dynamically on the stack, so this test might not give you the true
requirements. We do need to make sure our stack allocation is
conservative.


Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
