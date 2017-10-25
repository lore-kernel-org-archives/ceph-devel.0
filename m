From: Sage Weil <sage@newdream.net>
Subject: Re: about "osd: stateful health warnings: mgr->mon"
Date: Wed, 25 Oct 2017 15:19:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710251513590.22592@piezo.us.to>
References: <CAJE9aOPYDJs1rXUqUMFZx_QKTk2s-fST6pKijvk+19zNis6Vow@mail.gmail.com> <CALe9h7dYP8LDu47cToaTctkCc_VpRrXDokXx6AefeFn=yWZkow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:35033 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdJYPTz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Oct 2017 11:19:55 -0400
In-Reply-To: <CALe9h7dYP8LDu47cToaTctkCc_VpRrXDokXx6AefeFn=yWZkow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 25 Oct 2017, John Spray wrote:
> On Wed, Oct 25, 2017 at 11:29 AM, kefu chai <tchaikov@gmail.com> wrote:
> > hi John and Sage,
> >
> > as you know, i am working on [1]. but slow-requests alert are pretty
> > much a list of strings, in which the first one is a summary, and the
> > following ones are the details: like
> >
> > - 1 slow requests, 1 included below; oldest blocked for > 30.005692 secs
> > - slow request 30.005692 seconds old, received at {date-time}:
> > osd_op(client.4240.0:8 benchmark_data_ceph-1_39426_object7 [write
> > 0~4194304] 0.69848840) v4 currently waiting for subops from [610]
> >
> > this fits well into a health_check_t struct. and we can add a field in
> > MMgrReport, and send it to mgr periodically. but at the mgr side, it
> > is supposed to compose a single std::map<string, health_check_t> in
> > MMonMgrReport, and send it to monitor.
> >
> > if we put all slow requests from all osds into this map with the key
> > like "OSD_SLOW_OPS/${osd_id}". the monstore will be loaded by a slow
> > cluster, and the "health" section of "ceph status" will be flooded
> > with the slow requests. or we can just collect all the slow request
> > details into a single bucket of "OSD_SLOW_OPS".
> 
> The original MDS health items go into a separate store
> (MDS_HEALTHPREFIX in MDSMonitor.cc), with a separate structure for
> each MDS.  However, since the new encode_health stuff in Luminous,
> we're also writing all of those to one data structure in
> MDSMonitor::encode_health.  So I guess we have exactly the same issue
> there as we would for multiple OSD_SLOW_OPS/${osd_id} buckets.
> 
> This is perhaps an unacceptable load on the mon in any case, as those
> OSD detail messages will keep changing and we'll end up writing
> O(N_osds)-sized health objects continuously.  We probably need to make
> sure that the *persisted* part only contains the slowly-changing
> summary (the boolean of whether each OSD has slow ops), and then have
> the detail of it be only an in-memory somehow.

I'm not sure this matters too much.. we're persisting something every 2 
seconds from the mgr's summary and PGMapDigest.  The health map will have 
a limit if 50 (by default) detail items, so it won't be big.

I was originally thinking of a generic health_check_map_t passed from OSD 
(or other daemons), with a %num% substitution in the summary string (and 
perhaps a few other substitutions).  

For something like this, though, it's easy to see value beyond that.  For 
example, we can (should?) roll up slow request counts by # of osds with 
laggy counts or # laggy requests per pool (I think both are directly 
useful to the operator)... which suggests either a structure that is 
specific to this, or a structured detail message (e.g., {"num_requests": 
23, "slowest_op_delay": 363.222, "requests_by_pool": {"1": 20, "2": 3}}) 
and the ability to roll summation or min or max up in the mgr.  That might 
be getting too fancy, though!

> Would it be terrible to just expect the user to go do a "ceph tell
> osd.<id> ..." command to find out about the detail of slow requests?
> We could also retain the existing OSD slow request log messages (at
> DEBUG severity) so that it is possible for them to find out some
> information retroactively too.

That seems reasonable to me.. there's no way we'll be enumerating actual 
slow requests in the health message.  We should wire up the "ops" command 
to tell (or perhaps better yet unify the tell and admin socket commands).

sage



> 
> John
> 
> > but if we just send the summaries from OSDs as the
> > "health_check_t::detail" with the alert code of "OSD_SLOW_OPS". all
> > the details are practically stripped off. and the total *number* of
> > slow requests can be found nowhere unless the user parses the summary
> > lines, and sum it up manually.
> >
> > we could refactor the OpTracker::check_ops_in_flight() so it returns
> > an array of info describing slow requests instead of a list of
> > human-readable strings. but we still need to face this problem of
> > level-of-details.
> >
> > any thoughts?
> 
> 
> 
> >
> >
> > ---
> > https://trello.com/c/8f9y0YM6/51-osd-stateful-health-warnings-to-mgr-mon-eg-slow-requests
> >
> >
> > --
> > Regards
> > Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
