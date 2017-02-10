From: John Spray <jspray@redhat.com>
Subject: Re: Command `rbd ls` hangs if cluster health HEALTH_ERR
Date: Fri, 10 Feb 2017 18:10:55 +0000
Message-ID: <CALe9h7d2+qKO=d3aZiWCHWrmms7Ydg8jy2deuUp6UaAzdAe-1A@mail.gmail.com>
References: <7c376967-0bb3-657a-0020-eb738bd78122@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38393 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbdBJSLR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2017 13:11:17 -0500
Received: by mail-wm0-f48.google.com with SMTP id r141so55480312wmg.1
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2017 10:11:17 -0800 (PST)
In-Reply-To: <7c376967-0bb3-657a-0020-eb738bd78122@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shubhendu Tripathi <shtripat@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Feb 9, 2017 at 11:07 AM, Shubhendu Tripathi <shtripat@redhat.com> wrote:
> Hi,
>
> Need a help regarding rbd CLI commands hanging if the cluster is in error
> state.
> Somehow I ended up having my cluster in HEALTH_ERR by creating a pool with
> huge PGnum whereas cluster has very less no of OSDs.
>
> Now when I run the command `rbd ls` it simply hangs and does not come out.
> It requires a ctrl+C to come back to command line.

RBD images are stored in RADOS, so if your RADOS cluster is not
accessible then your rbd operations will block until it is.

John

> What could be a workaround or solution to this?
>
> Regards,
> Shubhendu
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
