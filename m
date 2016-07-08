From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: deadlocks in rbd unmap and map
Date: Fri, 8 Jul 2016 13:40:31 +0200
Message-ID: <CAOi1vP8NhgYHpfZT8w=meFf6vwPrS-izRZnvSPwrRc+3vwvAWQ@mail.gmail.com>
References: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36294 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbcGHLkd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2016 07:40:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so4740067wma.3
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2016 04:40:32 -0700 (PDT)
In-Reply-To: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McLean <patrickm@gaikai.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 8, 2016 at 3:28 AM, Patrick McLean <patrickm@gaikai.com> wrote:
> This is on linus git master as of 2016/07/01
>
> These appear to be two separate deadlocks, one on a a map operation,
> and one on an unmap operation. We can reproduce these pretty
> regularly, but it seems like there is some sort of race condition, as
> it happens no where near every time.
>
> We are currently working to reproduce on a kernel with lockdep
> enabled, as well as better debugging information. Please let me know
> if I can provide any more information.

I can see what happened from the traces, so no need to bother with
lockdep.  Figuring out how and why is trickier...

It's a single deadlock between "rbd map" and a kworker thread, a later
"rbd unmap" is just a victim.

Are you mapping the same image more than once?

Thanks,

                Ilya
