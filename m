From: Sage Weil <sage@newdream.net>
Subject: Re: scrub randomization and load threshold
Date: Thu, 12 Nov 2015 05:29:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511120526390.7964@cobra.newdream.net>
References: <CABZ+qq=7izv5o-5ACygqZyr=ho58nLoKb7XmRKT2yyTqKFwrZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35280 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbbKLN3Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Nov 2015 08:29:24 -0500
In-Reply-To: <CABZ+qq=7izv5o-5ACygqZyr=ho58nLoKb7XmRKT2yyTqKFwrZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Herve Rousseau <herve.rousseau@cern.ch>

On Thu, 12 Nov 2015, Dan van der Ster wrote:
> Hi,
> 
> Firstly, we just had a look at the new
> osd_scrub_interval_randomize_ratio option and found that it doesn't
> really solve the deep scrubbing problem. Given the default options,
> 
> osd_scrub_min_interval = 60*60*24
> osd_scrub_max_interval = 7*60*60*24
> osd_scrub_interval_randomize_ratio = 0.5
> osd_deep_scrub_interval = 60*60*24*7
> 
> we understand that the new option changes the min interval to the
> range 1-1.5 days. However, this doesn't do anything for the thundering
> herd of deep scrubs which will happen every 7 days. We've found a
> configuration that should randomize deep scrubbing across two weeks,
> e.g.:
> 
> osd_scrub_min_interval = 60*60*24*7
> osd_scrub_max_interval = 100*60*60*24 // effectively disabling this option
> osd_scrub_load_threshold = 10 // effectively disabling this option
> osd_scrub_interval_randomize_ratio = 2.0
> osd_deep_scrub_interval = 60*60*24*7
> 
> but that (a) doesn't allow shallow scrubs to run daily and (b) is so
> far off the defaults that its basically an abuse of the intended
> behaviour.
> 
> So we'd like to simplify how deep scrubbing can be randomized. Our PR
> (http://github.com/ceph/ceph/pull/6550) adds a new option
> osd_deep_scrub_randomize_ratio which  controls a coin flip to randomly
> turn scrubs into deep scrubs. The default is tuned so roughly 1 in 7
> scrubs will be run deeply.

The coin flip seems reasonable to me.  But wouldn't it also/instead make 
sense to apply the randomize ratio to the deep_scrub_interval?  My just 
adding in the random factor here:

https://github.com/ceph/ceph/pull/6550/files#diff-dfb9ddca0a3ee32b266623e8fa489626R3247

That is what I would have expected to happen, and if the coin flip is also 
there then you have two knobs controlling the same thing, which'll cause 
confusion...

> Secondly, we'd also like to discuss the osd_scrub_load_threshold
> option, where we see two problems:
>    - the default is so low that it disables all the shallow scrub
> randomization on all but completely idle clusters.
>    - finding the correct osd_scrub_load_threshold for a cluster is
> surely unclear/difficult and probably a moving target for most prod
> clusters.
> 
> Given those observations, IMHO the smart Ceph admin should set
> osd_scrub_load_threshold = 10 or higher, to effectively disable that
> functionality. In the spirit of having good defaults, I therefore
> propose that we increase the default osd_scrub_load_threshold (to at
> least 5.0) and consider removing the load threshold logic completely.

This sounds reasonable to me.  It would be great if we could use a 24-hour 
average as the baseline or something so that it was self-tuning (e.g., set 
threshold to .8 of daily average), but that's a bit trickier.  Generally 
all for self-tuning, though... too many knobs...

sage
