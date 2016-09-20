From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Potential double mutex_lock bug in net/ceph/auth.c
Date: Tue, 20 Sep 2016 23:41:12 +0200
Message-ID: <CAOi1vP_+1udm7ufMrzm_rQMnM_QwU7RQtBHsPLpJYx0n03tJ7g@mail.gmail.com>
References: <CAGbDTvo5zF_vO7KwG8frD7H0gf3fkJc_oTXiZ=tKbiD9GpPXmQ@mail.gmail.com>
 <CAGbDTvqLfpdb=iOL63WtpeXNRwUe8scgn0P77GBRmBUTQrukMw@mail.gmail.com>
 <CAGbDTvrfK9whVUFD5nRFqC3pLhc=QSBDqyToJvRpx9ZaMYvFBw@mail.gmail.com>
 <20160919121202.3d7c9b5c@redhat.com> <CAGbDTvq_Fny20iDwuFVfz4JWJ-aKcQo3Z9qX4kOh2NCgO6t9jw@mail.gmail.com>
 <20160920143459.1807f12d@redhat.com> <CAGbDTvrH45B1gmmdLx79UXerp+8sKV4gGFw3igE6LODTYM1PTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f169.google.com ([209.85.213.169]:34713 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932457AbcITVlN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2016 17:41:13 -0400
Received: by mail-yb0-f169.google.com with SMTP id x93so14340613ybh.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2016 14:41:13 -0700 (PDT)
In-Reply-To: <CAGbDTvrH45B1gmmdLx79UXerp+8sKV4gGFw3igE6LODTYM1PTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Iago Abal <iari@itu.dk>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Jesper Dangaard Brouer <brouer@redhat.com>

On Tue, Sep 20, 2016 at 11:26 PM, Iago Abal <iari@itu.dk> wrote:
> Hi,
>
> I may have found a double mutex_lock in net/ceph/auth.c and, if confirmed, I
> could help with a patch. The trace leading to the error is as follows:
>
>   1. Starting in function ceph_build_auth, the first lock is at 261:
> mutex_lock(& ac->mutex);
>       (see
> https://github.com/torvalds/linux/blob/master/net/ceph/auth.c#L261)
>   2. Assume that condition (!ac->protocol) evaluates to true at 262.
>   3. Call function ceph_auth_build_hello at 263, passing the same `ac'.
>   4. The second lock is at 108: mutex_lock(& ac->mutex);
>       (see
> https://github.com/torvalds/linux/blob/master/net/ceph/auth.c#L108)
>
> This seems to have been introduced by commit e9966076cdd9 ("libceph: wrap
> auth methods in a mutex").
>
> Function ceph_auth_build_hello is extern, so it makes sense that it takes
> the ac->mutex lock itself. On the other hand, ceph_build_auth_request is
> static, so it's fine if the caller is responsible for acquiring the
> ac->mutex.
>
> Assuming that this is a bug I can think of two simple solutions:
>
> Solution 1: Add an extra argument to ceph_auth_build_hello(..., int lock) so
> that the caller can decide whether to acquire the lock or not.
>
> Solution 2: Rewrite lines 261-266 so that ceph_auth_build_hello is called
> without the lock held. For instance,
>
>      if (!ac->protocol) {
> +       mutex_unlock(ac->mutex);
>           ret = ceph_auth_build_hello(ac, msg_buf, msg_len);
>      }
>
> PS: I have reported this bug back in June, but I didn't receive any
> feedback. I believe this can be an actual bug, so I'm insisting. :-)

Hi Iago,

Sorry about that.  I think it doesn't come up in practice because
ceph_build_auth() is only called when validating the existing auth,
which means ac->protocol != 0.

I'll take a look.

Thanks,

                Ilya
