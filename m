From: Dan van der Ster <dan@vanderster.com>
Subject: Re: scrub randomization and load threshold
Date: Thu, 12 Nov 2015 15:36:08 +0100
Message-ID: <CABZ+qqnj81gQDe6mApNdGa-HK2LbeKJwHH-7Lj9ovq2+ci1MgA@mail.gmail.com>
References: <CABZ+qq=7izv5o-5ACygqZyr=ho58nLoKb7XmRKT2yyTqKFwrZQ@mail.gmail.com>
 <alpine.DEB.2.00.1511120526390.7964@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:32783 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbbKLOgw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Nov 2015 09:36:52 -0500
Received: by lffz63 with SMTP id z63so35176026lff.0
        for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2015 06:36:50 -0800 (PST)
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com. [209.85.217.178])
        by smtp.gmail.com with ESMTPSA id 88sm2340680lfq.3.2015.11.12.06.36.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2015 06:36:48 -0800 (PST)
Received: by lbbsy6 with SMTP id sy6so7533510lbb.2
        for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2015 06:36:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511120526390.7964@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Herve Rousseau <herve.rousseau@cern.ch>

On Thu, Nov 12, 2015 at 2:29 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 12 Nov 2015, Dan van der Ster wrote:
>> Hi,
>>
>> Firstly, we just had a look at the new
>> osd_scrub_interval_randomize_ratio option and found that it doesn't
>> really solve the deep scrubbing problem. Given the default options,
>>
>> osd_scrub_min_interval = 60*60*24
>> osd_scrub_max_interval = 7*60*60*24
>> osd_scrub_interval_randomize_ratio = 0.5
>> osd_deep_scrub_interval = 60*60*24*7
>>
>> we understand that the new option changes the min interval to the
>> range 1-1.5 days. However, this doesn't do anything for the thundering
>> herd of deep scrubs which will happen every 7 days. We've found a
>> configuration that should randomize deep scrubbing across two weeks,
>> e.g.:
>>
>> osd_scrub_min_interval = 60*60*24*7
>> osd_scrub_max_interval = 100*60*60*24 // effectively disabling this option
>> osd_scrub_load_threshold = 10 // effectively disabling this option
>> osd_scrub_interval_randomize_ratio = 2.0
>> osd_deep_scrub_interval = 60*60*24*7
>>
>> but that (a) doesn't allow shallow scrubs to run daily and (b) is so
>> far off the defaults that its basically an abuse of the intended
>> behaviour.
>>
>> So we'd like to simplify how deep scrubbing can be randomized. Our PR
>> (http://github.com/ceph/ceph/pull/6550) adds a new option
>> osd_deep_scrub_randomize_ratio which  controls a coin flip to randomly
>> turn scrubs into deep scrubs. The default is tuned so roughly 1 in 7
>> scrubs will be run deeply.
>
> The coin flip seems reasonable to me.  But wouldn't it also/instead make
> sense to apply the randomize ratio to the deep_scrub_interval?  My just
> adding in the random factor here:
>
> https://github.com/ceph/ceph/pull/6550/files#diff-dfb9ddca0a3ee32b266623e8fa489626R3247
>
> That is what I would have expected to happen, and if the coin flip is also
> there then you have two knobs controlling the same thing, which'll cause
> confusion...
>

That was our first idea. But that has a couple downsides:

  1.  If we use the random range for the deep scrub intervals, e.g.
deep every 1-1.5 weeks, we still get quite bursty scrubbing until it
randomizes over a period of many weeks/months. And I fear it might
even lead to lower frequency harmonics of many concurrent deep scrubs.
Using a coin flip guarantees uniformity starting immediately from time
zero.

  2. In our PR osd_deep_scrub_interval is still used as an upper limit
on how long a PG can go without being deeply scrubbed. This way
there's no confusion such as PGs going undeep-scrubbed longer than
expected. (In general, I think this random range is unintuitive and
difficult to tune (e.g. see my 2 week deep scrubbing config above).

For me, the most intuitive configuration (maintaining randomness) would be:

  a. drop the osd_scrub_interval_randomize_ratio because there is no
shallow scrub thundering herd problem (AFAIK), and it just complicates
the configuration. (But this is in a stable release now so I don't
know if you want to back it out).
  b. perform a (usually shallow) scrub every
osd_scrub_interval_(min/max) depending on a self-tuning load
threshold.
  c. do a coin flip each (b) to occasionally turn it into deep scrub.
  optionally: d. remove osd_deep_scrub_randomize_ratio and replace it
with  osd_scrub_interval_min/osd_deep_scrub_interval.

>> Secondly, we'd also like to discuss the osd_scrub_load_threshold
>> option, where we see two problems:
>>    - the default is so low that it disables all the shallow scrub
>> randomization on all but completely idle clusters.
>>    - finding the correct osd_scrub_load_threshold for a cluster is
>> surely unclear/difficult and probably a moving target for most prod
>> clusters.
>>
>> Given those observations, IMHO the smart Ceph admin should set
>> osd_scrub_load_threshold = 10 or higher, to effectively disable that
>> functionality. In the spirit of having good defaults, I therefore
>> propose that we increase the default osd_scrub_load_threshold (to at
>> least 5.0) and consider removing the load threshold logic completely.
>
> This sounds reasonable to me.  It would be great if we could use a 24-hour
> average as the baseline or something so that it was self-tuning (e.g., set
> threshold to .8 of daily average), but that's a bit trickier.  Generally
> all for self-tuning, though... too many knobs...

Yes, but we probably would need to make your 0.8 a function of the
stddev of the loadavg over a day, to handle clusters with flat
loadavgs as well as varying ones.

In order to randomly spread the deep scrubs across the week, it's
essential to give each PG many opportunities to scrub throughout the
week. If PGs are only shallow scrubbed once a week (at interval_max),
then every scrub would become a deep scrub and we again have the
thundering herd problem.

I'll push 5.0 for now.

-- dan
