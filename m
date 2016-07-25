From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: CephFS usability
Date: Mon, 25 Jul 2016 10:15:42 +0200
Message-ID: <CAOi1vP-142Dv0iTwzj_HQu9bXc-+NWAwH7AdNE+qXQhaYDbreA@mail.gmail.com>
References: <CALe9h7c3Mt958UhVEJdCYgKb4Cz6Gg2Gk4iz5JR9E-jtOnS=Xw@mail.gmail.com>
 <CAGkCoNJuoEx9OkW9e0UdDdmo=Vp6+RTc7dhSqK+nH6OubDsq+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37103 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbcGYIPp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jul 2016 04:15:45 -0400
Received: by mail-wm0-f48.google.com with SMTP id i5so144404860wmg.0
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jul 2016 01:15:44 -0700 (PDT)
In-Reply-To: <CAGkCoNJuoEx9OkW9e0UdDdmo=Vp6+RTc7dhSqK+nH6OubDsq+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhi Zhang <zhang.david2011@gmail.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 25, 2016 at 7:40 AM, Zhi Zhang <zhang.david2011@gmail.com> wrote:
> Hi John,
>
> Thanks for sharing CephFS to-do list to us. It could make CephFS users
> to better know the forward direction of CephFS. We have worked on
> kernel CephFS for more than 1 year and already put it on production to
> server some user scenarios. We are planning to adopt kernel CephFS to
> server more our users.
>
> Here are 3 items from my past experience on kernel CephFS. I think
> they could make CephFS more easier and faster to adopt.
>
> 1. Backport fixes from higher kernel version to standard linux
> distribution's kernel
> * Current most of linux distribution's kernel is still 3.10.x. Kernel

I don't think that's true ;)

> CephFS has some functional and stability issues on 3.10.x even on the
> latest 3.10.101. And AFAIK, some companies including mine, don't allow
> to upgrading kernel to 4.x easily. So I have to backport nearly 3+
> years' fixes into 3.10.x gradually and also deal with fixing's
> incompatible issue among different kernel. It costs lots of time and
> effort to backport, test and verify them, but the benefit is obvious
> that kernel CephFS becomes quite stable and well-performed for us. So
> I think if we can try to backport each fixing to lower kernel version
> when it is committed, it could save lots of effort and make things
> much more easier.

While we can certainly do a better job of backporting select CephFS
fixes to upstream stable kernels, it can only get us so far, especially
if the target is a 3 year old kernel.

Have you considered using RHEL7 kernels?  They are 3.10-based, with RBD
and CephFS regularly rebased to later upstream versions.  They include
a large number of upstream fixes, and some features too.

>
> 2. Differentiate log's level
> * Currently ceph's kernel modules have very few log levels. Once we
> enable the logs to reproduce some performance or stability bugs, the
> whole system might hang because of log flood, so I have to add logs by
> myself on critical path. If we can differentiate log's level, I think
> it could benefit and help developers.

That's definitely a problem, especially with rate limiting and
wide-spread adoption of journald.  I've been wanting to add an ftrace
option, but that depends on a kernel patch which I need to finish.
Different log levels or at least tracepoints in functions like send()
and handle_reply() (so you don't have to enable logging) are on the
TODO list.

Thanks,

                Ilya
