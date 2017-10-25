From: John Spray <jspray@redhat.com>
Subject: Re: about "osd: stateful health warnings: mgr->mon"
Date: Wed, 25 Oct 2017 16:04:02 +0200
Message-ID: <CALe9h7dYP8LDu47cToaTctkCc_VpRrXDokXx6AefeFn=yWZkow@mail.gmail.com>
References: <CAJE9aOPYDJs1rXUqUMFZx_QKTk2s-fST6pKijvk+19zNis6Vow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:48775 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbdJYOEY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Oct 2017 10:04:24 -0400
Received: by mail-wm0-f41.google.com with SMTP id p75so2125766wmg.3
        for <ceph-devel@vger.kernel.org>; Wed, 25 Oct 2017 07:04:23 -0700 (PDT)
In-Reply-To: <CAJE9aOPYDJs1rXUqUMFZx_QKTk2s-fST6pKijvk+19zNis6Vow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Oct 25, 2017 at 11:29 AM, kefu chai <tchaikov@gmail.com> wrote:
> hi John and Sage,
>
> as you know, i am working on [1]. but slow-requests alert are pretty
> much a list of strings, in which the first one is a summary, and the
> following ones are the details: like
>
> - 1 slow requests, 1 included below; oldest blocked for > 30.005692 secs
> - slow request 30.005692 seconds old, received at {date-time}:
> osd_op(client.4240.0:8 benchmark_data_ceph-1_39426_object7 [write
> 0~4194304] 0.69848840) v4 currently waiting for subops from [610]
>
> this fits well into a health_check_t struct. and we can add a field in
> MMgrReport, and send it to mgr periodically. but at the mgr side, it
> is supposed to compose a single std::map<string, health_check_t> in
> MMonMgrReport, and send it to monitor.
>
> if we put all slow requests from all osds into this map with the key
> like "OSD_SLOW_OPS/${osd_id}". the monstore will be loaded by a slow
> cluster, and the "health" section of "ceph status" will be flooded
> with the slow requests. or we can just collect all the slow request
> details into a single bucket of "OSD_SLOW_OPS".

The original MDS health items go into a separate store
(MDS_HEALTHPREFIX in MDSMonitor.cc), with a separate structure for
each MDS.  However, since the new encode_health stuff in Luminous,
we're also writing all of those to one data structure in
MDSMonitor::encode_health.  So I guess we have exactly the same issue
there as we would for multiple OSD_SLOW_OPS/${osd_id} buckets.

This is perhaps an unacceptable load on the mon in any case, as those
OSD detail messages will keep changing and we'll end up writing
O(N_osds)-sized health objects continuously.  We probably need to make
sure that the *persisted* part only contains the slowly-changing
summary (the boolean of whether each OSD has slow ops), and then have
the detail of it be only an in-memory somehow.

Would it be terrible to just expect the user to go do a "ceph tell
osd.<id> ..." command to find out about the detail of slow requests?
We could also retain the existing OSD slow request log messages (at
DEBUG severity) so that it is possible for them to find out some
information retroactively too.

John

> but if we just send the summaries from OSDs as the
> "health_check_t::detail" with the alert code of "OSD_SLOW_OPS". all
> the details are practically stripped off. and the total *number* of
> slow requests can be found nowhere unless the user parses the summary
> lines, and sum it up manually.
>
> we could refactor the OpTracker::check_ops_in_flight() so it returns
> an array of info describing slow requests instead of a list of
> human-readable strings. but we still need to face this problem of
> level-of-details.
>
> any thoughts?



>
>
> ---
> https://trello.com/c/8f9y0YM6/51-osd-stateful-health-warnings-to-mgr-mon-eg-slow-requests
>
>
> --
> Regards
> Kefu Chai
