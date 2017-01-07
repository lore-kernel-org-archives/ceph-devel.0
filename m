From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Possible bug in krbd (4.4.0)
Date: Sat, 7 Jan 2017 19:08:57 +0300
Message-ID: <CAOi1vP9Jvnepv3PxFA1PO_vZnEJ-DRBsax_+U136GSWPzCc1Xw@mail.gmail.com>
References: <CAJDfiske056EADPT4g0fRUx=uh7C-F3ZzUh6A1ummfUZ6vMuTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37740 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964963AbdAGQI7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Jan 2017 11:08:59 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so67182623wmt.0
        for <ceph-devel@vger.kernel.org>; Sat, 07 Jan 2017 08:08:59 -0800 (PST)
In-Reply-To: <CAJDfiske056EADPT4g0fRUx=uh7C-F3ZzUh6A1ummfUZ6vMuTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Max Yehorov <myehorov@skytap.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 4, 2017 at 3:13 AM, Max Yehorov <myehorov@skytap.com> wrote:
> Hi,
>
> I have encountered a weird possible bug. There is an rbd image mapped
> and mounted on a client machine. It is not possible to umount it. Both
> lsof and fuser show no mention of neither device nor mountpoint. It is
> not exported via nfs kernel server, so unlikely it is blocked by
> kernel.
>
> There is an odd pattern in syslog, two osds are constantly loose
> connections. A wild guess is that umount tries to contact primary osd
> and fails?

Does umount error out or hang forever?

>
> After I enabled kernel debug I saw the following:
>
> [9586733.605792] libceph:  con_open ffff880748f58030 10.80.16.74:6812
> [9586733.623876] libceph:  connect 10.80.16.74:6812
> [9586733.625091] libceph:  connect 10.80.16.74:6812 EINPROGRESS sk_state = 2
> [9586756.681246] libceph:  con_keepalive ffff881057d082b8
> [9586767.713067] libceph:  fault ffff880748f59830 state 5 to peer
> 10.80.16.78:6812
> [9586767.713593] libceph: osd27 10.80.16.78:6812 socket closed (con state OPEN)
> [9586767.721145] libceph:  con_close ffff880748f59830 peer 10.80.16.78:6812
> [9586767.724440] libceph:  con_open ffff880748f59830 10.80.16.78:6812
> [9586767.742487] libceph:  connect 10.80.16.78:6812
> [9586767.743696] libceph:  connect 10.80.16.78:6812 EINPROGRESS sk_state = 2
> [9587346.956812] libceph:  try_read start on ffff881057d082b8 state 5
> [9587466.968125] libceph:  try_write start ffff881057d082b8 state 5
> [9587634.021257] libceph:  fault ffff880748f58030 state 5 to peer
> 10.80.16.74:6812
> [9587634.021781] libceph: osd19 10.80.16.74:6812 socket closed (con state OPEN)
> [9587634.029336] libceph:  con_close ffff880748f58030 peer 10.80.16.74:6812
> [9587634.032628] libceph:  con_open ffff880748f58030 10.80.16.74:6812
> [9587634.050677] libceph:  connect 10.80.16.74:6812
> [9587634.051888] libceph:  connect 10.80.16.74:6812 EINPROGRESS sk_state = 2
> [9587668.124746] libceph:  fault ffff880748f59830 state 5 to peer
> 10.80.16.78:6812

How many rbd images were mapped on that machine at that time?  This
looks like two idle mappings reestablishing watch connections - if you
look closely, you'll notice that those "fault to peer" messages are
exactly 15 minutes apart.  This behaviour is annoying, but harmless.

If umount hangs, an output of

$ cat /sys/kernel/debug/ceph/<fsid>/osdc
$ echo w >/proc/sysrq-trigger
$ echo t >/proc/sysrq-trigger

might have helped.

Thanks,

                Ilya
