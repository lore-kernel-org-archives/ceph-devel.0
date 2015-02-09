From: Gregory Farnum <greg@gregs42.com>
Subject: Re: scrub scheduling
Date: Mon, 9 Feb 2015 07:41:12 -0800
Message-ID: <CAC6JEv_zpYhH9kBrNGwf3ij9oWZFB5GFQxrATr7jKGEQ8Ba2Fg@mail.gmail.com>
References: <alpine.DEB.2.00.1502081318090.5713@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33571 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226AbbBIPlN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 10:41:13 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so17143870igq.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Feb 2015 07:41:12 -0800 (PST)
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com. [209.85.213.179])
        by mx.google.com with ESMTPSA id d1sm5774073igr.20.2015.02.09.07.41.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Feb 2015 07:41:12 -0800 (PST)
Received: by mail-ig0-f179.google.com with SMTP id l13so17090922iga.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Feb 2015 07:41:12 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502081318090.5713@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, simon.leinen@gmail.com

On Sun, Feb 8, 2015 at 1:38 PM, Sage Weil <sweil@redhat.com> wrote:
> Simon Leinen at Switch did a greaet post recently about the impact of
> scrub on their cluster(s):
>
>         http://blog.simon.leinen.ch/2015/02/ceph-deep-scrubbing-impact.html
>
> Basically the 2 week deep scrub interval kicks in on exactly a 2 week
> cycle and the cluster goes crazy for a few hours and then does nothing
> (but client IO) for the next two weeks.
>
> The options governing this are:
>
> OPTION(osd_scrub_min_interval, OPT_FLOAT, 60*60*24)    // if load is low
> OPTION(osd_scrub_max_interval, OPT_FLOAT, 7*60*60*24)  // regardless of load
> OPTION(osd_deep_scrub_interval, OPT_FLOAT, 60*60*24*7) // once a week
> OPTION(osd_scrub_load_threshold, OPT_FLOAT, 0.5)
>
> That is, if the load is < .5 (probably almost never on a real cluster) it
> will scrub every day, otherwise (regardless of load) it will scrub each PG
> at least once a week.
>
> Several things we can do here:
>
> 1- Maybe the shallow scrub interval should be less than the deep scrub
> interval?
>
> 2- There is a new feature for hammer that limits scrub to certain times of
> day, contributed by Xinze Chi:
>
> OPTION(osd_scrub_begin_hour, OPT_INT, 0)
> OPTION(osd_scrub_end_hour, OPT_INT, 24)
>
> That is, by default, scrubs can happen at any time.  You can use this to
> limit to certain hour sof the night, or whatever is appropriate for your
> cluster.  That only sort of helps, though; Simon's scrub frenzy will still
> happen one day a week, all at once (or maybe spread over 2 nights).
>
> 3- We can spread them out during the allowed window.  But how to do that?
> We could make the scrub interval randomly +/- a value of up to 50% of the
> total interval.  Or we could somehow look at the current rate of scrubbing
> (average time to completeion for the current pool, maybe).. any look at
> the total number of items in the scrub queue?
>
> 4- Ric pointed out to me that even if we spread these out, scrubbing at
> full speed has an impact.  Even if we do all the prioritization magic we
> can there will still be a buch of large IOs in the queue.  What if we have
> a hard throttle on the scrub rate, objects per second and/or bytes per
> second?  In the end the same number of IOs traverse the queue and
> potentially interfere with client IO, but they would be spread out over a
> longer period of time and be less noticeable (i.e., slow down client IOs
> from different workloads and not all the same workload).  I'm not totally
> convinced this is an improvement over a strategy where we have only 1
> scrub IO in flight at all times, but that isn't quite how scrub schedules
> itself so it's hard to compare it that way, and in the end the user
> experience and perceived impact should be lower...
>
> 5- Auto-adjust the above scrub rate based on the total amount of data,
> scrub interval, and scrub hours so that we are scrubbing at the slowest
> rate possible that meets the schedule.  We'd have to be slightly clever to
> have the right feedback in place here...

Right. Fundamentally what we're trying to do here is schedule N IOs
against a cluster within time period T, ideally without impacting any
of the client IOs issued against the cluster. Depending on how many
client IOs there are, and when they come in, that might be easy or
might be imposslble (because they're using up all the IO capacity in
the cluster themselves).

So scheduling options can help by directing the scrubbing to occur at
times when we don't expect client IO (at night or whatever), but in
the general case I don't think we can actually solve it. What we can
do is:
1) Try and figure out how much IO is required to do scrubbing, and
alert users if their configuration won't succeed,
2) Prioritize scrubbing traffic against client IO more effectively
than we do right now.

I think (2) been on Sam's list of things to do for a while now, by
making scrub ops into normal operations that go through a shared work
queue with priority attached: http://tracker.ceph.com/issues/8635
There's not a lot of detail there unfortunately, but if scrubbing was
a regular operation it would solve many of the conflicts:
* low priority would mean that instead of being 1 IO at a time, it
would get time roughly proportional to its priority
* scheduling would make it less likely to hit conflicts, and mean that
in future we could even get clever about avoiding or backing off scrub
on something in use by clients
* it more naturally spreads out the scrub workload and makes it
quickly apparent if the requested scrub rate is unsustainable (just
track the rate of scrub completions against what we'd need it to be
for success)

I think that's probably a useful first step, and I'm pretty sure the
general case doesn't have a closed-form solution so I'm leery of
trying to build up a big system before it's in place.
-Greg
