From: Gregory Farnum <greg@inktank.com>
Subject: Re: Suspend and the ceph clients
Date: Thu, 15 May 2014 15:19:34 -0700
Message-ID: <CAPYLRzj-vssL4J_VT6zsM3oU-EDP3m800o1b3vdPYKWkP+PAbQ@mail.gmail.com>
References: <CAPYLRzhr7XA9sBArqe=5bPaXd3XPwgVGo_QOM024-J_ovh93BA@mail.gmail.com>
	<alpine.DEB.2.00.1405150720080.28306@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:53158 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbaEOWTf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 May 2014 18:19:35 -0400
Received: by mail-qc0-f181.google.com with SMTP id m20so2970441qcx.12
        for <ceph-devel@vger.kernel.org>; Thu, 15 May 2014 15:19:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1405150720080.28306@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Zheng Yan <ukernel@gmail.com>

On Thu, May 15, 2014 at 1:13 AM, Holger Hoffst=C3=A4tte
<holger.hoffstaette@googlemail.com> wrote:
> On Wed, 14 May 2014 15:07:44 -0700, Gregory Farnum wrote:
>> [..]
>> Unfortunately, I don't know anything about Linux's suspend
>> functionality or APIs, and my weak attempts at googling and grepping
>> aren't turning anything up. So a question to everybody:
>>
>> 2) What notifications does Linux send, and what filesystem mechanism=
s
>> does it invoke, when it is suspending?
>
> Is this what you're looking for?
> https://www.kernel.org/doc/Documentation/power/freezing-of-tasks.txt

Well, it's the kernel interface, but it's not very useful for ceph-fuse=
=2E..

> User space is usually controlled by ("legacy") pm-utils, which simply
> executes a bunch of scripts (packaged and user provided) in various
> stages. It works reasonably well but is of course fragile - typical
> scripted duct tape.
>
> systemd has its own (IMHO much less fragile) way of doing things:
> http://www.freedesktop.org/software/systemd/man/systemd-sleep.conf.ht=
ml

But these pointers are great. It looks like both systems let us just
drop an executable into the appropriate directory and it will wait for
those to complete before continuing, so we can send ceph-fuse admin
socket messages to prepare and flush data, or whatever. Thanks!

On Thu, May 15, 2014 at 7:29 AM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 14 May 2014, Gregory Farnum wrote:
>> 1) What is the kernel client doing after suspend? Does it in fact
>> reconnect under situations where ceph-fuse won't, and what are they?
>
> It looks to me like it is making a blind attempt to reconnect via
> peer_reset(), which is probably wrong.  Haven't thought through it,
> though.

Zheng seemed to think this was broken as well.

> There is an ancient ticket to make the client do a best-effort reconn=
ect
> after the MDS reconnect period, but it's a hard to impossible task.
>
> For me, the minimum that we need to support well today is to make it
> clearly visible on the client whether or now we were disconnected so =
that
> any applications or humans using that mount can tell what happened.
> Zheng's patch for ceph-fuse that added the STALE state accomplishes t=
his
> (by dumping mds_sessions on the ceph-fuse admin socket), and I backpo=
rted
> just that patch to firefly (and dumpling? I forget).
>
> I think we should do the same thing for the kernel client so that you=
 can
> look in /sys/kernel/debug/ceph/*/mdsc to get the same info.

Yeah. http://tracker.ceph.com/issues/8368

>> More interestingly, while suspended systems aren't part of our norma=
l
>> target use case, they'd be nice to support well. The trivial solutio=
n
>> would be to somehow flush out all dirty data on suspend, and then on
>> wake or when we discover we have a reset session, we can clean out o=
ur
>> cache and reconnect as a new client if we have no dirty data.
>
> This will at least avoid losing client data, but I think it will take
> significant work to keep the client mount alive in any meaningful way=
=2E
> Even if all of the cache contents (including dentry) are blown away,
> there are still open files that may not exist afterwards, so at a min=
imum
> there needs to be a way to identify and mark those deleted inode refs
> as stale at reconnect time.  Perhaps it could all be a client-side th=
ing
> based on fresh MDS sessions and open-by-ino?

Hmm, I hadn't considered the obvious problem of held-open files, but
yes, I was definitely thinking about this as a 100% client-side thing.
We could set up socket commands to flush everything and drop caps
(though this might take a while, but I guess that's what you get
anyway if you try and suspend with a lot of dirty data), and then on
resume get whatever we can on our open files. That leaves the
possibility of a third party deleting files you were working on or
something, but that pretty much seems like what you get; we can't
realistically stop it anyway.

>
>> Unfortunately, I don't know anything about Linux's suspend
>> functionality or APIs, and my weak attempts at googling and grepping
>> aren't turning anything up. So a question to everybody:
>>
>> 2) What notifications does Linux send, and what filesystem mechanism=
s
>> does it invoke, when it is suspending?
>> I see that it has in the past forced a sync whenever suspending, but=
 I
>> think that's no longer required. Are there other interfaces we can
>> rely on, or use heuristically?
>
> There is a bunch of in-kernel infrastructure for doing sleep/wake stu=
ff.
> For userspace, it sounds like Holger's systemd pointer is the most
> promising?

Yeah. I do notice that in the general case, doing a suspend with USB
drives attached will cause them to fail as well, so we're at least not
on our own in handling it badly (Documentation/power/swsusp.txt and
Documentation/usb/persist.txt). Looking at, e.g.
Documentation/power/s2ram.txt actually makes me think that the "sync"
has to come from userspace, rather than being automatic, so maybe the
kernel will just have to be opportunistic about this (or we can set up
ioctls or something).

Anyway, that's enough for me to think this is feasible but not urgent,
nor trivial. Maybe a good project for an intern or something. Thanks
guys! :) http://tracker.ceph.com/issues/8369
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
