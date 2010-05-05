From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: qemu-kvm/rbd: aio patch in git
Date: Wed, 5 May 2010 11:41:55 -0700
Message-ID: <y2ga37615151005051141i2912e0dftc76eb9c0ade806f7@mail.gmail.com>
References: <20100504223315.GA42090@ncolin.muc.de>
	 <v2ra37615151005051048ya839625ejbbe44c5fc2202785@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34035 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757772Ab0EESl5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 May 2010 14:41:57 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 45DD926AA8
	for <ceph-devel@vger.kernel.org>; Wed,  5 May 2010 11:41:57 -0700 (PDT)
Received: from mail-vw0-f46.google.com (mail-vw0-f46.google.com [209.85.212.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 1A5A1269FA
	for <ceph-devel@vger.kernel.org>; Wed,  5 May 2010 11:41:57 -0700 (PDT)
Received: by vws12 with SMTP id 12so1248541vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 May 2010 11:41:56 -0700 (PDT)
In-Reply-To: <v2ra37615151005051048ya839625ejbbe44c5fc2202785@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Tue, May 4, 2010 at 3:33 PM, Christian Brunner <chb@muc.de> wrote:
>
> Hi Yehuda,
>
> I've seen that my initial aio implementation is now in the git repository.
> This patch isn't working very well. Could you revert it, please?
Done.

>
> I'm still having problems with aio handling, but I'll try to send an
>
> updated patch by the weekend.
>
Great!

We're currently working on rbd snapshots and there were a few header
changes. Currently snapshot creation is being done via the rbd kernel
driver, but we're planning in adding that capability to the rbdtool.
Once this works, it'll be easy to implement the kvm-rbd snapshots.
Note that at this point snapshots are read-only. Adding a writable
snapshots, as well as snapshots branching would be awesome, however,
it looks like it's not going to be easy to integrate it easily into
the current system. So probably the easiest at this point would be to
have some revert-to-snapshot capability.

The next thing would be making it safer for multiple clients to
collaborate on a single rbd image., e.g., adding atomic header
modification operations and such. This requires some changes in the
osd (new ops), and will probably require adding some new librados api
functions.

Yehuda
