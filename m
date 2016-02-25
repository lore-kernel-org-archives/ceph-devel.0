From: John Spray <jspray@redhat.com>
Subject: Re: vstart and Python bindings
Date: Thu, 25 Feb 2016 11:41:46 +0000
Message-ID: <CALe9h7dfBm1hvCMDZQb4TERjUMh2GhcsUyWFe16k7ZJ8fon2nQ@mail.gmail.com>
References: <20160224233718.6a8c7569@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36585 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbcBYLmI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Feb 2016 06:42:08 -0500
Received: by mail-lb0-f170.google.com with SMTP id x1so27253244lbj.3
        for <ceph-devel@vger.kernel.org>; Thu, 25 Feb 2016 03:42:07 -0800 (PST)
In-Reply-To: <20160224233718.6a8c7569@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Feb 25, 2016 at 6:37 AM, Pete Zaitcev <zaitcev@redhat.com> wrote:
> I did a git pull today and rebuilt. Ran vstart, and it produced a
> Python traceback, ending with:
>
> ImportError: No module named rados
>
> Oooookay... This box never had Python bindings installed, but okay,
> someone innovated something. Fine, I thought. Installed python-rados,
> and ./ceph -w tracebacks:
>
> Traceback (most recent call last):
>   File "./ceph", line 953, in <module>
>     retval = main()
>   File "./ceph", line 778, in main
>     run_in_thread(cluster_handle.monitor_log, level, watch_cb, 0)
> AttributeError: 'Rados' object has no attribute 'monitor_log'
>
> Of course. The system version of pybind is obsolete, but ./ceph gets
> wrong one. Actually, it's not even getting built from .pyx anymore.
>
> Could whoever did all this please undo?

I don't think we're undoing this, but I too would like to see prompt
fixes.  The cython changes broke cmake (amaredia mentioned in IRC he
was working on a fix?) and libcephfs's python bindings (fix
https://github.com/ceph/ceph/pull/7745).  With hindsight the cython
change needed more scrutiny before it merged.

John
