From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: handling fs errors
Date: Tue, 22 Jan 2013 10:25:28 +0300
Message-ID: <CABYiri-yT9fKVJMYE0TcU_yWea+vOZ0hHWRQet2TuL7JN1t3EA@mail.gmail.com>
References: <alpine.DEB.2.00.1301212200031.29915@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:34334 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab3AVHZt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 02:25:49 -0500
Received: by mail-oa0-f42.google.com with SMTP id j1so7015149oag.29
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 23:25:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301212200031.29915@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 22, 2013 at 10:05 AM, Sage Weil <sage@inktank.com> wrote:
> We observed an interesting situation over the weekend.  The XFS volume
> ceph-osd locked up (hung in xfs_ilock) for somewhere between 2 and 4
> minutes.  After 3 minutes (180s), ceph-osd gave up waiting and committed
> suicide.  XFS seemed to unwedge itself a bit after that, as the daemon was
> able to restart and continue.
>
> The problem is that during that 180s the OSD was claiming to be alive but
> not able to do any IO.  That heartbeat check is meant as a sanity check
> against a wedged kernel, but waiting so long meant that the ceph-osd
> wasn't failed by the cluster quickly enough and client IO stalled.
>
> We could simply change that timeout to something close to the heartbeat
> interval (currently default is 20s).  That will make ceph-osd much more
> sensitive to fs stalls that may be transient (high load, whatever).
>
> Another option would be to make the osd heartbeat replies conditional on
> whether the internal heartbeat is healthy.  Then the heartbeat warnings
> could start at 10-20s, ping replies would pause, but the suicide could
> still be 180s out.  If the stall is short-lived, pings will continue, the
> osd will mark itself back up (if it was marked down) and continue.
>
> Having written that out, the last option sounds like the obvious choice.
> Any other thoughts?
>
> sage

Seems to be possible to run in domino-style failing marks there if
lock is triggered frequently enough and depends only on pure amount of
workload. By the way, was that fs aged or you`re able to catch the
lock on fresh one? And which kernel you have run there?

Thanks!

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
