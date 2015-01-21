From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: rbd option listing and tcp_nodelay support
Date: Wed, 21 Jan 2015 22:18:30 +0300
Message-ID: <CALFYKtCn-gGfjZ0qnjRoiS_ksX2KC4PJMcLO0gW5znXgbVAQgg@mail.gmail.com>
References: <alpine.DEB.2.10.1501220029310.28090@Ubuntu-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:44718 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbbAUTSb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jan 2015 14:18:31 -0500
Received: by mail-qg0-f52.google.com with SMTP id z107so14646573qgd.11
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2015 11:18:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.10.1501220029310.28090@Ubuntu-VirtualBox>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <chaitanya.huilgol@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jan 21, 2015 at 10:00 PM, Chaitanya Huilgol
<chaitanya.huilgol@gmail.com> wrote:
> From: Chaitanya Huilgol <chaitanya.huilgol@sandisk.com>
>
> Option keys supported by libceph and rbd modules is readable
> as a comma separated string via /sys/bus/rbd/options read-only
> interface. This will allow user app (rbd cli) to check for
> supported option keys before passing options to the kernel and
> remain compatible with older kernels which do not support a
> particular feature.
> Messenger specific options moved to messenger layer.
> tcp_nodelay(default)/no_tcp_nodelay option added for setting
> TCP_NODELAY on messenger socket connections. Covers both rbd
> and cephfs

Hi Chaitanya,

Just couple high level comments - I'll take a closer look tomorrow.

Option listing and tcp_nodelay should be two separate patches

rbd: add option sysfs attiribute
libceph: add tcp_nodelay option

or something like that.  The "Messenger specific options moved to
messenger layer" part should probably be a separate patch as well.

More importantly, I'm missing the whole point of exporting supported
rbd options.  Adding a new libceph option does not break compatibility
in either way, as old kernels will simply fail to map/mount if a bad
(unknown, let through by new rbd cli) option is encountered.

Thanks,

                Ilya
