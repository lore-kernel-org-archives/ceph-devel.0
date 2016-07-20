From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: deadlocks in rbd unmap and map
Date: Wed, 20 Jul 2016 15:14:14 +0200
Message-ID: <CAOi1vP_maPag+tTABWKnFYQhs6UamzWc9e3Zw9J6m24WgcHncQ@mail.gmail.com>
References: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
 <CAOi1vP8NhgYHpfZT8w=meFf6vwPrS-izRZnvSPwrRc+3vwvAWQ@mail.gmail.com>
 <CAE2NFgW0ntzuFkRup5QCGfYMBuHo4Er9+y+OtKDTeaXBBtgE3g@mail.gmail.com>
 <CAOi1vP_HwML=7+iZrJFzJpbRcSomKBX5r8RT2hnRGF23agN1FQ@mail.gmail.com>
 <CAE2NFgVVth4BRQNCy6SFOnLnLf0NQ=kgoHcuMLpnz5beG3w-nQ@mail.gmail.com>
 <CAOi1vP8fg4cmAvOOKQWZUcvNpiQ5CzpVr1q=rjhtTjasa85msQ@mail.gmail.com>
 <CAE2NFgXvtZYzD9EGp+GHxcSndS3AoKyvpZkwdmsTr2rB9KF__w@mail.gmail.com>
 <CAOi1vP_7dHOVnxTHEhfYsiXQGvd+e8ecsPf10cg0s33Ry4Vt9Q@mail.gmail.com> <CAE2NFgUxwvS_LnsoNp+zTK+4e+DSF24i==sPW2ARcZ9LJn1Otg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35342 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbcGTNOQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jul 2016 09:14:16 -0400
Received: by mail-wm0-f47.google.com with SMTP id f65so175313215wmi.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jul 2016 06:14:16 -0700 (PDT)
In-Reply-To: <CAE2NFgUxwvS_LnsoNp+zTK+4e+DSF24i==sPW2ARcZ9LJn1Otg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McLean <patrickm@gaikai.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Victor Payno <vpayno@gaikai.com>, Cliff Pajaro <cpajaro@gaikai.com>, Roderick Colenbrander <roderick@gaikai.com>, Rae Yip <ryip@gaikai.com>, Frank Reed <freed@gaikai.com>

On Wed, Jul 20, 2016 at 1:23 AM, Patrick McLean <patrickm@gaikai.com> wrote:
> We got this on our rbd clients this morning, it is not actually a
> panic, but networking seems to have died on those boxes and since they
> are netbooted, they were dead.
>
> It looks like a crash in rbd_watch_cb:
>
> [68479.925931] Call Trace:
> [68479.928632]  [<ffffffff81140f2e>] ? wq_worker_sleeping+0xe/0x90
> [68479.934793]  [<ffffffff819738bc>] __schedule+0x50c/0xb90
> [68479.940349]  [<ffffffff81445db5>] ? put_io_context_active+0xa5/0xc0
> [68479.946866]  [<ffffffff81973f7c>] schedule+0x3c/0x90
> [68479.952077]  [<ffffffff81126554>] do_exit+0x7b4/0xc60
> [68479.957373]  [<ffffffff8109891c>] oops_end+0x9c/0xd0
> [68479.962579]  [<ffffffff81098d8b>] die+0x4b/0x70
> [68479.967357]  [<ffffffff81095d15>] do_general_protection+0xe5/0x1b0
> [68479.973780]  [<ffffffff8197b988>] general_protection+0x28/0x30
> [68479.979857]  [<ffffffffa01be161>] ? rbd_watch_cb+0x21/0x100 [rbd]
> [68479.986202]  [<ffffffff81173f8f>] ? up_read+0x1f/0x40
> [68479.991506]  [<ffffffffa00c3c09>] do_watch_notify+0x99/0x170 [libceph]
> [68479.998279]  [<ffffffff8114003a>] process_one_work+0x1da/0x660
> [68480.004352]  [<ffffffff8113ffac>] ? process_one_work+0x14c/0x660
> [68480.010601]  [<ffffffff8114050e>] worker_thread+0x4e/0x490
> [68480.016326]  [<ffffffff811404c0>] ? process_one_work+0x660/0x660
> [68480.022578]  [<ffffffff811404c0>] ? process_one_work+0x660/0x660
> [68480.028823]  [<ffffffff81146c51>] kthread+0x101/0x120
> [68480.034149]  [<ffffffff81979baf>] ret_from_fork+0x1f/0x40
> [68480.039796]  [<ffffffff81146b50>] ? kthread_create_on_node+0x250/0x250

The attached log starts with [68479.452369].  Do you have an earlier
chunk?  I'm specifically looking for whether the rbd_watch_cb() was the
first splat.

Any luck reproducing the hang with logging enabled?

Thanks,

                Ilya
