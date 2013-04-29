From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [ceph-users] Backporting the kernel client
Date: Mon, 29 Apr 2013 07:29:12 -0700
Message-ID: <CABBk=J8CCB6JtGAFxoMbgZ1R3sWtTvotXOw+fPwNSkr6wHWcjg@mail.gmail.com>
References: <alpine.DEB.2.02.1304291544340.23141@orbit.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:51836 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab3D2O3N (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 10:29:13 -0400
Received: by mail-vb0-f47.google.com with SMTP id x14so660672vbb.34
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 07:29:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1304291544340.23141@orbit.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Juha Aatrokoski <jha@kurp.hut.fi>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Mon, Apr 29, 2013 at 6:16 AM, Juha Aatrokoski <jha@kurp.hut.fi> wrote:
> I'm probably not the only one who would like to run a distribution-provided
> kernel (which for Debian Wheezy/Ubuntu Precise is 3.2) and still have a
> recent-enough Ceph kernel client. So I'm wondering whether it's feasible to
> backport the kernel client to an earlier kernel. The plan is as follows:
>
> 1) Grab the Ceph files from https://github.com/ceph/ceph-client (and put
> them over the older kernel sources). If I got it right the files are:
> include/keys/ceph-type.h include/linux/ceph/* fs/ceph/* net/ceph/*
> drivers/block/rbd.c drivers/block/rbd_types.h
>
> 2) Make (trivial) adjustments to the source code to account for changed
> kernel interfaces.
>
> 3) Compile as modules and install the new Ceph modules under /lib/modules.
>
> 4) Reboot to a standard distribution kernel with up-to-date Ceph client.
>
>
> Now the main questions are:
>
> Q1: Is the Ceph client contained in the files mentioned in 1), or does it
> include changes elsewhere in the kernel that cannot be built as modules?

The ceph stuff is mostly there, if you exclude make file changes.
Don't think there's anything outside.
>
> Q2: Regarding 2), are there any nontrivial interface changes i.e. Ceph
> actually using newly introduced features instead of just adapting to a
> changed syntax?

I don't really know, haven't been actively looking at the kernel side
for a while. It used to compile on that kernel version, so you can
always refer to the older version and see how it used to work. Usually
you can just try to compile it, see where it fails and then try to
figure out what has changed there.



Yehuda
