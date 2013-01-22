From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: handling fs errors
Date: Mon, 21 Jan 2013 22:12:50 -0800
Message-ID: <CAC-hyiHnGXrr5hiZF__BP_uWZeSrhFk_psphAcRPwb5qGa69cw@mail.gmail.com>
References: <alpine.DEB.2.00.1301212200031.29915@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:54184 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab3AVGMv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 01:12:51 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so10977233ieb.17
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 22:12:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301212200031.29915@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 21, 2013 at 10:05 PM, Sage Weil <sage@inktank.com> wrote:
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

Another option would be to have the osd reply to the ping with some
health description.

Yehuda
