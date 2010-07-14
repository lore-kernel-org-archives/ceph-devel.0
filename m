From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Linux 2.6.35-rc5
Date: Wed, 14 Jul 2010 11:46:23 -0700
Message-ID: <AANLkTinnIr6Z9AhxvObLje3tmXonvVnrWQmsFUE8wFJT@mail.gmail.com>
References: <AANLkTikro3L1Hy3BYmY-KE8-KviZIrWOCAb54FkF7eX-@mail.gmail.com>
	<20100714174138.GC27457@skl-net.de>
	<AANLkTilbabX3IoxHvC5ljAsNpKRg6YRhJ0GjyspIEh47@mail.gmail.com>
	<20100714180551.GK16603@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34428 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0GNSqZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jul 2010 14:46:25 -0400
Received: by vws5 with SMTP id 5so74481vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jul 2010 11:46:24 -0700 (PDT)
In-Reply-To: <20100714180551.GK16603@skl-net.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Gregory Farnum <gregf@hq.newdream.net>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Wed, Jul 14, 2010 at 11:05 AM, Andre Noll <maan@systemlinux.org> wrote:
> On Wed, Jul 14, 10:49, Gregory Farnum wrote:
>> Check out the backports at
>> http://git.kernel.org/?p=linux/kernel/git/sage/ceph-client-standalone.git;a=summary.
>
> Thanks. In order to compile e.g. the master branch of this repo,
> one has to replace fs/ceph dir of the kernel tree by the checked-out
> copy of the ceph-client-standalone repo. Is that correct?

That's one option, although for older kernels you wouldn't have the
fs/ceph directory and you'll also have to update the fs/Kconfig file.
Another option for building the standalone is just running 'make
KERNELDIR=<yourkerneldir>'  inside your ceph-client-standalone tree.

>
> Another question: How do I tell which kernel version is compatible with
> any of the the various branches of the ceph-client-standalone repo?

The backport branches currently support 2.6.28 and up.

Yehuda
