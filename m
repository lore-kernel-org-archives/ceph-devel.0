From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: "No space left on device" when doing massive directory deletion.
Date: Mon, 18 Dec 2017 15:09:03 +0800
Message-ID: <CAAM7YA=3m59=mKP6ARjn83mB4wF=xPD-bvt399hQ4Dpg7AwoFA@mail.gmail.com>
References: <CAJACTufKA2fyLY-Y6nTJmgRyWMJC+SUaXZ1iVLNGDdMxogoniQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34257 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757743AbdLRHJE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Dec 2017 02:09:04 -0500
Received: by mail-oi0-f50.google.com with SMTP id u193so9971226oie.1
        for <ceph-devel@vger.kernel.org>; Sun, 17 Dec 2017 23:09:04 -0800 (PST)
In-Reply-To: <CAJACTufKA2fyLY-Y6nTJmgRyWMJC+SUaXZ1iVLNGDdMxogoniQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xuehan Xu <xxhdx1985126@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Dec 18, 2017 at 12:47 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> Hi, everyone.
>
> Recently, when we were doing a massive directory deletion test in
> which totally 7 million directories are to be removed, we found that
> the client occasionally receive "ENOSPC" errors while there were still
> plenty of spare space in the underlying cephfs space. Having read some
> related source codes, we found that the reason may be that the "STRAY"
> directories are never fragmented, and when doing our test, the number
> of stray directories in some of these "STRAY" dirs might reach the
> limit "mds_bal_fragment_size_max". So we modified the level of output
> in "Server::check_fragment_space" to 0 and did the test again. And
> when clients received "ENOSPC", we found lots of logs as the
> following:
>
> 2017-12-18 12:22:31.370524 7f6672fff700  0 mds.0.server fragment [dir
> 0x603 ~mds0/stray3/ [2,head] auth pv=17728973 v=17497895
> cv=17019435/17019435 ap=80055+160110+160110 state=1610645506|complete
> f(v7 m2017-12-18 12:08:23.017000 55429=0+55429) n(v7 rc2017-12-18
> 12:08:51.473000 55429=0+55429) hs=55429+121382,ss=0+0 dirty=96756 |
> child=1 sticky=1 dirty=1 waiter=0 authpin=1 0x7f66652b1080] size
> exceeds 100000 (ENOSPC)
> 2017-12-18 12:22:31.370769 7f6672fff700  0 mds.0.server fragment [dir
> 0x603 ~mds0/stray3/ [2,head] auth pv=17728973 v=17497895
> cv=17019435/17019435 ap=80055+160110+160110 state=1610645506|complete
> f(v7 m2017-12-18 12:08:23.017000 55429=0+55429) n(v7 rc2017-12-18
> 12:08:51.473000 55429=0+55429) hs=55429+121382,ss=0+0 dirty=96756 |
> child=1 sticky=1 dirty=1 waiter=0 authpin=1 0x7f66652b1080] size
> exceeds 100000 (ENOSPC)
> 2017-12-18 12:22:31.370836 7f6672fff700  0 mds.0.server fragment [dir
> 0x603 ~mds0/stray3/ [2,head] auth pv=17728973 v=17497895
> cv=17019435/17019435 ap=80055+160110+160110 state=1610645506|complete
> f(v7 m2017-12-18 12:08:23.017000 55429=0+55429) n(v7 rc2017-12-18
> 12:08:51.473000 55429=0+55429) hs=55429+121382,ss=0+0 dirty=96756 |
> child=1 sticky=1 dirty=1 waiter=0 authpin=1 0x7f66652b1080] size
> exceeds 100000 (ENOSPC)
> 2017-12-18 12:22:31.370907 7f6672fff700  0 mds.0.server fragment [dir
> 0x603 ~mds0/stray3/ [2,head] auth pv=17728973 v=17497895
> cv=17019435/17019435 ap=80055+160110+160110 state=1610645506|complete
> f(v7 m2017-12-18 12:08:23.017000 55429=0+55429) n(v7 rc2017-12-18
> 12:08:51.473000 55429=0+55429) hs=55429+121382,ss=0+0 dirty=96756 |
> child=1 sticky=1 dirty=1 waiter=0 authpin=1 0x7f66652b1080] size
> exceeds 100000 (ENOSPC)
> 2017-12-18 12:22:31.370968 7f6672fff700  0 mds.0.server fragment [dir
> 0x603 ~mds0/stray3/ [2,head] auth pv=17728973 v=17497895
> cv=17019435/17019435 ap=80055+160110+160110 state=1610645506|complete
> f(v7 m2017-12-18 12:08:23.017000 55429=0+55429) n(v7 rc2017-12-18
> 12:08:51.473000 55429=0+55429) hs=55429+121382,ss=0+0 dirty=96756 |
> child=1 sticky=1 dirty=1 waiter=0 authpin=1 0x7f66652b1080] size
> exceeds 100000 (ENOSPC)
>
>
> It seems that our guest is right. Is this by design?

You are right and this is by design. are you using jewel release?  In
luminous release, we introduced purge queue. This issue is unlikely to
happen.

>
> Thanks:-)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
