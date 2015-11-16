From: Dan van der Ster <dan@vanderster.com>
Subject: Re: scrub randomization and load threshold
Date: Mon, 16 Nov 2015 15:25:45 +0100
Message-ID: <CABZ+qqma+-bOPcPr3K_9mZaDHE54pvNtWw0OmiAFCYH1zX3Ysw@mail.gmail.com>
References: <CABZ+qq=7izv5o-5ACygqZyr=ho58nLoKb7XmRKT2yyTqKFwrZQ@mail.gmail.com>
 <alpine.DEB.2.00.1511120526390.7964@cobra.newdream.net> <CABZ+qqnj81gQDe6mApNdGa-HK2LbeKJwHH-7Lj9ovq2+ci1MgA@mail.gmail.com>
 <alpine.DEB.2.00.1511120705240.614@cobra.newdream.net> <CABZ+qq=hEkD1QwqoYeytOGKanbSKVBodQmmsb_sXSTsGwDKimA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36601 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbKPO03 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Nov 2015 09:26:29 -0500
Received: by lbblt2 with SMTP id lt2so89668278lbb.3
        for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2015 06:26:27 -0800 (PST)
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com. [209.85.217.176])
        by smtp.gmail.com with ESMTPSA id ea3sm3489252lbc.18.2015.11.16.06.26.25
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2015 06:26:25 -0800 (PST)
Received: by lbbkw15 with SMTP id kw15so89363776lbb.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2015 06:26:25 -0800 (PST)
In-Reply-To: <CABZ+qq=hEkD1QwqoYeytOGKanbSKVBodQmmsb_sXSTsGwDKimA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Herve Rousseau <herve.rousseau@cern.ch>

On Thu, Nov 12, 2015 at 4:34 PM, Dan van der Ster <dan@vanderster.com> wrote:
> On Thu, Nov 12, 2015 at 4:10 PM, Sage Weil <sage@newdream.net> wrote:
>> On Thu, 12 Nov 2015, Dan van der Ster wrote:
>>> On Thu, Nov 12, 2015 at 2:29 PM, Sage Weil <sage@newdream.net> wrote:
>>> > On Thu, 12 Nov 2015, Dan van der Ster wrote:
>>> >> Hi,
>>> >>
>>> >> Firstly, we just had a look at the new
>>> >> osd_scrub_interval_randomize_ratio option and found that it doesn't
>>> >> really solve the deep scrubbing problem. Given the default options,
>>> >>
>>> >> osd_scrub_min_interval = 60*60*24
>>> >> osd_scrub_max_interval = 7*60*60*24
>>> >> osd_scrub_interval_randomize_ratio = 0.5
>>> >> osd_deep_scrub_interval = 60*60*24*7
>>> >>
>>> >> we understand that the new option changes the min interval to the
>>> >> range 1-1.5 days. However, this doesn't do anything for the thundering
>>> >> herd of deep scrubs which will happen every 7 days. We've found a
>>> >> configuration that should randomize deep scrubbing across two weeks,
>>> >> e.g.:
>>> >>
>>> >> osd_scrub_min_interval = 60*60*24*7
>>> >> osd_scrub_max_interval = 100*60*60*24 // effectively disabling this option
>>> >> osd_scrub_load_threshold = 10 // effectively disabling this option
>>> >> osd_scrub_interval_randomize_ratio = 2.0
>>> >> osd_deep_scrub_interval = 60*60*24*7
>>> >>
>>> >> but that (a) doesn't allow shallow scrubs to run daily and (b) is so
>>> >> far off the defaults that its basically an abuse of the intended
>>> >> behaviour.
>>> >>
>>> >> So we'd like to simplify how deep scrubbing can be randomized. Our PR
>>> >> (http://github.com/ceph/ceph/pull/6550) adds a new option
>>> >> osd_deep_scrub_randomize_ratio which  controls a coin flip to randomly
>>> >> turn scrubs into deep scrubs. The default is tuned so roughly 1 in 7
>>> >> scrubs will be run deeply.
>>> >
>>> > The coin flip seems reasonable to me.  But wouldn't it also/instead make
>>> > sense to apply the randomize ratio to the deep_scrub_interval?  My just
>>> > adding in the random factor here:
>>> >
>>> > https://github.com/ceph/ceph/pull/6550/files#diff-dfb9ddca0a3ee32b266623e8fa489626R3247
>>> >
>>> > That is what I would have expected to happen, and if the coin flip is also
>>> > there then you have two knobs controlling the same thing, which'll cause
>>> > confusion...
>>> >
>>>
>>> That was our first idea. But that has a couple downsides:
>>>
>>>   1.  If we use the random range for the deep scrub intervals, e.g.
>>> deep every 1-1.5 weeks, we still get quite bursty scrubbing until it
>>> randomizes over a period of many weeks/months. And I fear it might
>>> even lead to lower frequency harmonics of many concurrent deep scrubs.
>>> Using a coin flip guarantees uniformity starting immediately from time
>>> zero.
>>>
>>>   2. In our PR osd_deep_scrub_interval is still used as an upper limit
>>> on how long a PG can go without being deeply scrubbed. This way
>>> there's no confusion such as PGs going undeep-scrubbed longer than
>>> expected. (In general, I think this random range is unintuitive and
>>> difficult to tune (e.g. see my 2 week deep scrubbing config above).
>>
>> Fair enough..
>>
>>> For me, the most intuitive configuration (maintaining randomness) would be:
>>>
>>>   a. drop the osd_scrub_interval_randomize_ratio because there is no
>>> shallow scrub thundering herd problem (AFAIK), and it just complicates
>>> the configuration. (But this is in a stable release now so I don't
>>> know if you want to back it out).
>>
>> I'm inclined to leave it, even if it complicates config: just because we
>> haven't noticed the shallow scrub thundering herd doesn't mean it doesn't
>> exist, and I fully expect that it is there.  Also, if the shallow scrubs
>> are lumpy and we're promoting some of them to deep scrubs, then the deep
>> scrubs will be lumpy too.
>>
>
> Sounds good.
>
>>>   b. perform a (usually shallow) scrub every
>>> osd_scrub_interval_(min/max) depending on a self-tuning load
>>> threshold.
>>
>> Yep, although as you note we have some work to do to get there.  :)
>>
>>>   c. do a coin flip each (b) to occasionally turn it into deep scrub.
>>
>> Works for me.
>>
>>>   optionally: d. remove osd_deep_scrub_randomize_ratio and replace it
>>> with  osd_scrub_interval_min/osd_deep_scrub_interval.
>>
>> There is no osd_deep_scrub_randomize_ratio.  Do you mean replace
>> osd_deep_scrub_interval with osd_deep_scrub_{min,max}_interval?
>
> osd_deep_scrub_randomize_ratio is the new option we proposed in the
> PR. We chose 0.15 because it's roughly 1/7 (i.e.
> osd_scrub_interval_min/osd_deep_scrub_interval = 1/7 in the default
> config). But the coin flip could use
> osd_scrub_interval_min/osd_deep_scrub_interval instead of adding this
> extra configurable.
>
> My preference would be to keep it separately configurable.
>
>>> >> Secondly, we'd also like to discuss the osd_scrub_load_threshold
>>> >> option, where we see two problems:
>>> >>    - the default is so low that it disables all the shallow scrub
>>> >> randomization on all but completely idle clusters.
>>> >>    - finding the correct osd_scrub_load_threshold for a cluster is
>>> >> surely unclear/difficult and probably a moving target for most prod
>>> >> clusters.
>>> >>
>>> >> Given those observations, IMHO the smart Ceph admin should set
>>> >> osd_scrub_load_threshold = 10 or higher, to effectively disable that
>>> >> functionality. In the spirit of having good defaults, I therefore
>>> >> propose that we increase the default osd_scrub_load_threshold (to at
>>> >> least 5.0) and consider removing the load threshold logic completely.
>>> >
>>> > This sounds reasonable to me.  It would be great if we could use a 24-hour
>>> > average as the baseline or something so that it was self-tuning (e.g., set
>>> > threshold to .8 of daily average), but that's a bit trickier.  Generally
>>> > all for self-tuning, though... too many knobs...
>>>
>>> Yes, but we probably would need to make your 0.8 a function of the
>>> stddev of the loadavg over a day, to handle clusters with flat
>>> loadavgs as well as varying ones.
>>>
>>> In order to randomly spread the deep scrubs across the week, it's
>>> essential to give each PG many opportunities to scrub throughout the
>>> week. If PGs are only shallow scrubbed once a week (at interval_max),
>>> then every scrub would become a deep scrub and we again have the
>>> thundering herd problem.
>>>
>>> I'll push 5.0 for now.
>>
>> Sounds good.
>>
>> I would still love to see someone tackle the auto-tuning approach,
>> though! :)
>
> I should have some time next week to have a look, if nobody beat me to it.

Instead of keeping a 24hr loadavg, how about we allow scrubs whenever
the loadavg is decreasing (or below the threshold)? As long as the
1min loadavg is less than the 15min loadavg, we should be ok to allow
new scrubs. If you agree I'll add the patch below to my PR.

-- dan


diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 0562eed..464162d 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -6065,20 +6065,24 @@ bool OSD::scrub_time_permit(utime_t now)

 bool OSD::scrub_load_below_threshold()
 {
-  double loadavgs[1];
-  if (getloadavg(loadavgs, 1) != 1) {
+  double loadavgs[3];
+  if (getloadavg(loadavgs, 3) != 3) {
     dout(10) << __func__ << " couldn't read loadavgs\n" << dendl;
     return false;
   }

   if (loadavgs[0] >= cct->_conf->osd_scrub_load_threshold) {
-    dout(20) << __func__ << " loadavg " << loadavgs[0]
-            << " >= max " << cct->_conf->osd_scrub_load_threshold
-            << " = no, load too high" << dendl;
-    return false;
+    if (loadavgs[0] >= loadavgs[2]) {
+      dout(20) << __func__ << " loadavg " << loadavgs[0]
+              << " >= max " << cct->_conf->osd_scrub_load_threshold
+               << " and >= 15m avg " << loadavgs[2]
+              << " = no, load too high" << dendl;
+      return false;
+    }
   } else {
     dout(20) << __func__ << " loadavg " << loadavgs[0]
             << " < max " << cct->_conf->osd_scrub_load_threshold
+            << " or < 15 min avg " << loadavgs[2]
             << " = yes" << dendl;
     return true;
   }
