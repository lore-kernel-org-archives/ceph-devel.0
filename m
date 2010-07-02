From: Paul <paul_chiang@tcloudcomputing.com>
Subject: Re: OSD scalability & thread stacksize
Date: Fri, 2 Jul 2010 11:10:30 +0800
Message-ID: <AANLkTikMO6VLTd4VyGhxWnJhgGbXHFNc10Z7uf-GRA66@mail.gmail.com>
References: <AANLkTilDYesH_4FFEPUdLGvQRoZcW99czwfGru44RW3i@mail.gmail.com>
	<Pine.LNX.4.64.1007010724060.5822@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34071 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0GBDKd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jul 2010 23:10:33 -0400
Received: by iwn7 with SMTP id 7so2748959iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jul 2010 20:10:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1007010724060.5822@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Jul 1, 2010 at 10:51 PM, Sage Weil <sage@newdream.net> wrote:
> Hi Paul,
>
> On Thu, 1 Jul 2010, Paul wrote:
>> Follow up on the discussion on IRC late last night:
>>
>> On x86_64 2.6 kernels, pthread_create seems to allocate by default
>> 8196KB stack size for the newly created thread. Since there can be
>> potentially a large number of SimpleMessenger::Pipe instances (for
>> example, when there are many OSDs and they need to heartbeat each
>> other) and each instance has a reader and writer thread, a system ca=
n
>> quickly run out of available memory to create new threads.
>
> This is surprising to me. =A0My understanding is that each thread is
> allocated a big chunk of _virtual_ memory for its stack, but no physi=
cal
> pages are allocated until that memory is actually touched. =A0That, a=
t
> least, is what I take away from e.g.
>
> http://www.kegel.com/stackcheck/
>
> Also, looking at the memory map for a random cmon process, I see the =
8MB
> stack, but Rss is only 8 KB:
>
> $ cat /proc/$pid/smaps
> [...]
> 7f18b27fe000-7f18b2ffe000 rw-p 00000000 00:00 0
> Size: =A0 =A0 =A0 =A0 =A0 =A0 =A0 8192 kB
> Rss: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8 kB
> Pss: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8 kB
> Shared_Clean: =A0 =A0 =A0 =A0 =A00 kB
> Shared_Dirty: =A0 =A0 =A0 =A0 =A00 kB
> Private_Clean: =A0 =A0 =A0 =A0 0 kB
> Private_Dirty: =A0 =A0 =A0 =A0 8 kB
> Referenced: =A0 =A0 =A0 =A0 =A0 =A08 kB
> Swap: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 kB
> KernelPageSize: =A0 =A0 =A0 =A04 kB
> MMUPageSize: =A0 =A0 =A0 =A0 =A0 4 kB
> 7f18b2ffe000-7f18b2fff000 ---p 00000000 00:00 0
> Size: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04 kB
> Rss: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 kB
> Pss: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 kB
> Shared_Clean: =A0 =A0 =A0 =A0 =A00 kB
> Shared_Dirty: =A0 =A0 =A0 =A0 =A00 kB
> Private_Clean: =A0 =A0 =A0 =A0 0 kB
> Private_Dirty: =A0 =A0 =A0 =A0 0 kB
> Referenced: =A0 =A0 =A0 =A0 =A0 =A00 kB
> Swap: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 kB
> KernelPageSize: =A0 =A0 =A0 =A04 kB
> MMUPageSize: =A0 =A0 =A0 =A0 =A0 4 kB
>
> Do you see a large Rss in your environment? =A0Maybe it's a library b=
ehavior
> thing?
>
> Or maybe the problem is just that the virtual memory reserved for thr=
ead
> stacks is exhausted. =A0Maybe there is some way to make the process
> initialization reserve a larger area of memory for thread stacks?
>
Yes, this seems to be what is happening. Taking a look, our kernels
had ulimit -v set to equal total physical memory. After setting ulimit
-v to unlimited, 32748 threads can be created regardless of what stack
size is allocated to each thread, at which point pthread_create
returns ENOMEM rather than EAGAIN. I'd still prefer to manage the
allocated size though, since kernel settings might not be totally
within our control.

>> A short term solution would be to decrease the amount of stack space
>> allocated for the reader and writer threads. I guess something along
>> the lines of:
>> http://github.com/tcloud/ceph/commit/39ffa236f3de2082c475a5ea5edc8af=
a09941bd6
>> and
>> http://github.com/tcloud/ceph/commit/1dbd42a5c4b064c581ddc152d41b955=
3f346df8a
>
> This seems reasonable as a workaround.
>
>> Yehudasa suggested a stacksize of 512KB, and it seems to work fine.
>
> Looking at the Rss value for stack threads in /proc/$pid/smaps would =
be a
> pretty good way to see what kind of stack utilization those threads a=
re
> seeing. =A0I suspect something much smaller than 512KB would be safe =
(16
> KB?).
>
Here's an excerpt of smaps from a random OSD's smaps:
7fecf7974000-7fecf79f4000 rw-p 00000000 00:00 0
Size:                512 kB
Rss:                  12 kB
Pss:                  12 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        12 kB
Referenced:           12 kB
Swap:                  0 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB

This is great info (and much more precise than trial and error!) -- it
would appear 16KB is a safe minimum.

>> However, as the cluster grows, there will eventually be some point
>> where we hit a hard limit on either the number of concurrent threads
>> or the number of concurrent tcp connections. Is it possible to
>> redesign SimpleMessenger and/or the heartbeat mechanism so that only=
 a
>> constant number of connections are established?
>
> Well, the number of peers an OSD has is generally bounded (it's relat=
ed to
> the number of PGs each OSD gets). =A0The number of clients is not, th=
ough.
> The messenger should put the Pipes in some sort of LRU so that it can
> close out old, idle connections. =A0For the MDS the connection state =
needs
> to stick around, but it shouldn't be hard to make the reader/writer
> threads stop when it goes into a STANDBY state (if they don't already=
).
>
> Adding a hard limit is also doable, although I would worry about that=
 just
> slowing things down in large clusters when peers keep having to recon=
nect.
>
> sage
>

Thanks,
Paul C
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
