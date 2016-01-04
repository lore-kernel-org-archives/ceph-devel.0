From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Create one millon empty files with cephfs
Date: Mon, 4 Jan 2016 06:57:54 -0800
Message-ID: <CAJ4mKGYdccz9qo6a=g-i8TG8Ym4ND03wXKL7iPUCFmJLOh=YUQ@mail.gmail.com>
References: <CAJ2LqzhCi0mCmyi6Uu_1KguYqyO9aUfDDkDJukOBTBP+P9S_AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36686 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbcADO5z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jan 2016 09:57:55 -0500
Received: by mail-wm0-f42.google.com with SMTP id l65so165741917wmf.1
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jan 2016 06:57:55 -0800 (PST)
In-Reply-To: <CAJ2LqzhCi0mCmyi6Uu_1KguYqyO9aUfDDkDJukOBTBP+P9S_AQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fengguang Gong <fengguanggong@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 29, 2015 at 4:55 AM, Fengguang Gong <fengguanggong@gmail.co=
m> wrote:
> hi,
> We create one million empty files through filebench, here is the test=
 env:
> MDS: one MDS
> MON: one MON
> OSD: two OSD, each with one Inter P3700; data on OSD with 2x replica
> Network: all nodes are connected through 10 gigabit network
>
> We use more than one client to create files, to test the scalability =
of
> MDS. Here are the results:
> IOPS under one client: 850
> IOPS under two client: 1150
> IOPS under four client: 1180
>
> As we can see, the IOPS almost maintains unchanged when the number of
> client increase from 2 to 4.
>
> Cephfs may have a low scalability under one MDS, and we think its the=
 big
> lock in
> MDSDamon::ms_dispatch()::Mutex::locker(every request acquires this lo=
ck),
> who limits the
> scalability of MDS.
>
> We think this big lock could be removed through the following steps:
> 1. separate the process of ClientRequest with other requests, so we c=
an
> parallel the process
> of ClientRequest
> 2. use some small granularity locks instead of big lock to ensure
> consistency
>
> Wondering this idea is reasonable?

Parallelizing the MDS is probably a very big job; it's on our radar
but not for a while yet.

If one were to do it, yes, breaking down the big MDS lock would be the
way forward. I'm not sure entirely what that involves =E2=80=94 you'd n=
eed to
significantly chunk up the locking on our more critical data
structures, most especially the MDCache. Luckily there is *some* help
there in terms of the file cap locking structures we already have in
place, but it's a *huge* project and not one to be undertaken lightly.
A special processing mechanism for ClientRequests versus other
requests is not an assumption I'd start with.

I think you'll find that file creates are just about the least
scalable thing you can do on CephFS right now, though, so there is
some easier ground. One obvious approach is to extend the current
inode preallocation =E2=80=94 it already allocates inodes per-client an=
d has a
fast path inside of the MDS for handing them back. It'd be great if
clients were aware of that preallocation and could create files
without waiting for the MDS to talk back to them! The issue with this
is two-fold:
1) need to update the cap flushing protocol to deal with files newly
created by the client
2) need to handle all the backtrace stuff normally performed by the
MDS on file create (which still needs to happen, on either the client
or the server)
There's also clean up in case of a client failure, but we've already
got a model for that in how we figure out real file sizes and things
based on max size.

I think there's a ticket about this somewhere, but I can't find it off-=
hand...
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
