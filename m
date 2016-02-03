From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: ceph-fuse hang issue
Date: Wed, 3 Feb 2016 14:07:45 +0800
Message-ID: <CAAM7YAmMZRkmS2GDh_BV8vbcQxRAGzG5=kRr-4-3strZ5oVTaw@mail.gmail.com>
References: <CAGkCoN+3rzQUuV6r9h4kQ8_Gj4fb=jF2DdKKeGh6RQr_XsWhmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34418 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972AbcBCGHq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 01:07:46 -0500
Received: by mail-lb0-f182.google.com with SMTP id cw1so5919083lbb.1
        for <ceph-devel@vger.kernel.org>; Tue, 02 Feb 2016 22:07:46 -0800 (PST)
In-Reply-To: <CAGkCoN+3rzQUuV6r9h4kQ8_Gj4fb=jF2DdKKeGh6RQr_XsWhmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhi Zhang <zhang.david2011@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Which version kernel/ceph-fuse are you using? Besides, please use gdb
to get backtrace of all threads in ceph-fuse and send the backtrace to
us.

Regards
Yan, Zheng

On Wed, Feb 3, 2016 at 12:54 PM, Zhi Zhang <zhang.david2011@gmail.com> wrote:
> Hi ceph-devel,
>
> I know this mail might be better to send to fuse-devel, but I haven't
> been approved by fuse-devel yet since I subscribed it.
>
> Occasionally we met ceph-fuse hanging issue when mapping ceph-fuse
> directory into docker container using aufs.
>
> Here is the dmesg:
>
> [809401.613923] aufs au_opts_verify:1602:docker[36838]: dirperm1
> breaks the protection by the permission bits on the lower branch
> [825359.968412] aufs au_opts_verify:1602:docker[32013]: dirperm1
> breaks the protection by the permission bits on the lower branch
> [825359.970719] aufs au_opts_verify:1602:docker[32013]: dirperm1
> breaks the protection by the permission bits on the lower branch
> [825359.973689] aufs au_opts_verify:1602:docker[44954]: dirperm1
> breaks the protection by the permission bits on the lower branch
> [836447.630952] INFO: task df:30614 blocked for more than 120 seconds.
> [836447.630955] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [836447.630957] df              D ffff88203f851e00     0 30614      1 0x00000004
> [836447.630960]  ffff880a27b6fd08 0000000000000002 ffff880a27b6ffd8
> 0000000000011e00
> [836447.630964]  ffff880a27b6ffd8 0000000000011e00 ffff880fe93f4b60
> ffff880009f98000
> [836447.630967]  ffff881074050320 ffff881fd6333000 ffff880a27b6fd30
> ffff881074050400
> [836447.630970] Call Trace:
> [836447.630977]  [<ffffffff81acb689>] schedule+0x29/0x70
> [836447.630983]  [<ffffffff812be96d>] __fuse_request_send+0xdd/0x290
> [836447.630987]  [<ffffffff81066150>] ? wake_up_bit+0x30/0x30
> [836447.630989]  [<ffffffff812beb32>] fuse_request_send+0x12/0x20
> [836447.630992]  [<ffffffff812c3859>] fuse_do_getattr+0x109/0x2a0
> [836447.630995]  [<ffffffff812c4cd5>] fuse_update_attributes+0x75/0x80
> [836447.630997]  [<ffffffff812c4d23>] fuse_getattr+0x43/0x50
> [836447.631001]  [<ffffffff81168249>] vfs_getattr+0x29/0x40
> [836447.631002]  [<ffffffff811683b2>] vfs_fstatat+0x62/0xa0
> [836447.631004]  [<ffffffff8116859f>] SYSC_newstat+0x1f/0x40
> [836447.631009]  [<ffffffff8100e4f8>] ? syscall_trace_enter+0x18/0x210
> [836447.631012]  [<ffffffff81ad50bc>] ? tracesys+0x7e/0xe2
> [836447.631014]  [<ffffffff811689ee>] SyS_newstat+0xe/0x10
> [836447.631016]  [<ffffffff81ad511b>] tracesys+0xdd/0xe2
>
>
> From above msg, it seems to be hung at __fuse_request_send, which will
> queue request and wait for reply from ceph-fuse. When this happens,
> 'ls' ceph-fuse directory or 'df' outside docker container will also
> get hang.
>
> I generated ceph-fuse's core dump and found client_lock was not held
> by any thread. So I wonder if something wrong with ceph-fuse that
> can't get the request from the fuse's queue? Or something else related
> to fuse itself?
>
> Thanks.
>
> Regards,
> Zhi Zhang (David)
> Contact: zhang.david2011@gmail.com
>               zhangz.david@outlook.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
