From: Xinze Chi <xmdxcxz@gmail.com>
Subject: Re: scrub scheduling
Date: Mon, 9 Feb 2015 09:44:33 +0800
Message-ID: <CANE=7sW1oL2wpgdHdY4=KNgZBQKdXFRUF=EuJsB8xApG=g7C8Q@mail.gmail.com>
References: <alpine.DEB.2.00.1502081318090.5713@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:61335 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579AbbBIBoe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Feb 2015 20:44:34 -0500
Received: by mail-ob0-f179.google.com with SMTP id wp4so22532127obc.10
        for <ceph-devel@vger.kernel.org>; Sun, 08 Feb 2015 17:44:33 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502081318090.5713@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi=EF=BC=8Ccepher:

      I have already pull request
https://github.com/ceph/ceph/pull/3422 which could limit the disk
bandwidth used when does deep scrub.

      Can you give some comment on my request. Thus ceph can do more be=
tter.

      Thanks

2015-02-09 5:38 GMT+08:00 Sage Weil <sweil@redhat.com>:
> Simon Leinen at Switch did a greaet post recently about the impact of
> scrub on their cluster(s):
>
>         http://blog.simon.leinen.ch/2015/02/ceph-deep-scrubbing-impac=
t.html
>
> Basically the 2 week deep scrub interval kicks in on exactly a 2 week
> cycle and the cluster goes crazy for a few hours and then does nothin=
g
> (but client IO) for the next two weeks.
>
> The options governing this are:
>
> OPTION(osd_scrub_min_interval, OPT_FLOAT, 60*60*24)    // if load is =
low
> OPTION(osd_scrub_max_interval, OPT_FLOAT, 7*60*60*24)  // regardless =
of load
> OPTION(osd_deep_scrub_interval, OPT_FLOAT, 60*60*24*7) // once a week
> OPTION(osd_scrub_load_threshold, OPT_FLOAT, 0.5)
>
> That is, if the load is < .5 (probably almost never on a real cluster=
) it
> will scrub every day, otherwise (regardless of load) it will scrub ea=
ch PG
> at least once a week.
>
> Several things we can do here:
>
> 1- Maybe the shallow scrub interval should be less than the deep scru=
b
> interval?
>
> 2- There is a new feature for hammer that limits scrub to certain tim=
es of
> day, contributed by Xinze Chi:
>
> OPTION(osd_scrub_begin_hour, OPT_INT, 0)
> OPTION(osd_scrub_end_hour, OPT_INT, 24)
>
> That is, by default, scrubs can happen at any time.  You can use this=
 to
> limit to certain hour sof the night, or whatever is appropriate for y=
our
> cluster.  That only sort of helps, though; Simon's scrub frenzy will =
still
> happen one day a week, all at once (or maybe spread over 2 nights).
>
> 3- We can spread them out during the allowed window.  But how to do t=
hat?
> We could make the scrub interval randomly +/- a value of up to 50% of=
 the
> total interval.  Or we could somehow look at the current rate of scru=
bbing
> (average time to completeion for the current pool, maybe).. any look =
at
> the total number of items in the scrub queue?
>
> 4- Ric pointed out to me that even if we spread these out, scrubbing =
at
> full speed has an impact.  Even if we do all the prioritization magic=
 we
> can there will still be a buch of large IOs in the queue.  What if we=
 have
> a hard throttle on the scrub rate, objects per second and/or bytes pe=
r
> second?  In the end the same number of IOs traverse the queue and
> potentially interfere with client IO, but they would be spread out ov=
er a
> longer period of time and be less noticeable (i.e., slow down client =
IOs
> from different workloads and not all the same workload).  I'm not tot=
ally
> convinced this is an improvement over a strategy where we have only 1
> scrub IO in flight at all times, but that isn't quite how scrub sched=
ules
> itself so it's hard to compare it that way, and in the end the user
> experience and perceived impact should be lower...
>
> 5- Auto-adjust the above scrub rate based on the total amount of data=
,
> scrub interval, and scrub hours so that we are scrubbing at the slowe=
st
> rate possible that meets the schedule.  We'd have to be slightly clev=
er to
> have the right feedback in place here...
>
> Thoughts?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
