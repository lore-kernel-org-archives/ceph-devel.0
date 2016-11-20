From: huang jun <hjwsm1989@gmail.com>
Subject: Re: Why gdb can't find symbol table when trying to debug ceph?
Date: Sun, 20 Nov 2016 09:51:47 +0800
Message-ID: <CABAwU-aLAisvzEPc25H8=dY-TvTgiN7yCkkZWX-f6Tv=fPAvvw@mail.gmail.com>
References: <46ed7fdb.45dc.1587c3e763c.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33218 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbcKTBvt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Nov 2016 20:51:49 -0500
Received: by mail-qk0-f172.google.com with SMTP id x190so311126590qkb.0
        for <ceph-devel@vger.kernel.org>; Sat, 19 Nov 2016 17:51:49 -0800 (PST)
In-Reply-To: <46ed7fdb.45dc.1587c3e763c.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

that maybe the reason, do you have the same problem if there is no such warning?

2016-11-19 19:00 GMT+08:00 xxhdx1985126 <xxhdx1985126@163.com>:
>
> Hi, everyone.
>
>
> I'm trying to fix a problem in ceph using its core file and gdb.
> gdb successfully loaded debug symbol from ceph-debuginfo:
>
>
> Reading symbols from /usr/bin/ceph-osd...Reading symbols from /usr/lib/debug/usr/bin/ceph-osd.debug...done.
>
>
> However, it still can't find the symbol table when I use "bt" to trace the stack:
>
>
> #0  0x000000393da0f65b in ?? ()
> No symbol table info available.
> #1  0x0000000000a51636 in install_standard_sighandlers () at global/signal_handler.cc:121
> No locals.
> #2  0x00007fc7a77f9ed0 in ?? ()
> No symbol table info available.
> #3  0x00007fc7a77f9e10 in ?? ()
> No symbol table info available.
> #4  0x00007fc7a77f9b90 in ?? ()
> No symbol table info available.
> #5  0x00007fc66d3142e0 in ?? ()
> No symbol table info available.
> #6  0x00007fc7fac64100 in ?? ()
> No symbol table info available.
> #7  0x0000003900000000 in ?? ()
> No symbol table info available.
> #8  0x0000000000a51155 in SignalHandler::unregister_handler (this=0x1105440, signum=<value optimized out>, handler=<value optimized out>) at global/signal_handler.cc:317
> No locals.
> #9  0x000000393eabcc33 in ?? ()
> No symbol table info available.
> #10 0x000000393eabcd2e in ?? ()
> No symbol table info available.
>
>
> Why is this happening?
>
>
> PS: when gdb started running, it prompted the following warning:
>
>
> BFD: Warning: /home/xuxuehan/online_problems.2016-11-19.7-01/core-ceph-osd-6-32337-32337-19906-1479510049 is truncated: expected core file size >= 8372899840, found: 7439335424
>
>
> Could this be the cause of gdb not finding the symbol table?



-- 
Thank you!
HuangJun
