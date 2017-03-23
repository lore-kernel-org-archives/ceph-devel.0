From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Re: [PATCH] libceph: force GFP_NOIO for socket allocations
Date: Thu, 23 Mar 2017 11:54:17 +0100
Message-ID: <CAOi1vP87QM+5rXprvQqEQkHUJP9ZYgR+Nr1AvBM9hR7RQUgW1w@mail.gmail.com>
References: <1490181164-7822-1-git-send-email-idryomov@gmail.com>
 <1490215769.3921.4.camel@redhat.com> <201703230858170977508@gmail.com> <1490235971.3921.7.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35223 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754331AbdCWKyT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Mar 2017 06:54:19 -0400
Received: by mail-vk0-f66.google.com with SMTP id z204so12588326vkd.2
        for <ceph-devel@vger.kernel.org>; Thu, 23 Mar 2017 03:54:18 -0700 (PDT)
In-Reply-To: <1490235971.3921.7.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: penglaiyxy <penglaiyxy@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 23, 2017 at 3:26 AM, Jeff Layton <jlayton@redhat.com> wrote:
> I think you're correct that NOFS would have prevented the recursion
> shown in the stack trace below.
>
> However, if you (for instance) had a userland program that was
> accessing the krbd device directly with buffered I/O, then I think you
> could still end up deadlocked here.
>
> NOIO is more restrictive than NOFS and should prevent that situation in
> addition to the one in the patch description.

What Jeff said and also, less importantly, there is no corresponding
memalloc_nofs_{save,restore}() API -- it's still being debated on the
mailing lists.

Thanks,

                Ilya
