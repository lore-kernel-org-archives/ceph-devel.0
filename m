From: Dan van der Ster <dan@vanderster.com>
Subject: scrub randomization and load threshold
Date: Thu, 12 Nov 2015 10:24:15 +0100
Message-ID: <CABZ+qq=7izv5o-5ACygqZyr=ho58nLoKb7XmRKT2yyTqKFwrZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33020 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbbKLJY7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Nov 2015 04:24:59 -0500
Received: by lbbkw15 with SMTP id kw15so31495795lbb.0
        for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2015 01:24:57 -0800 (PST)
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com. [209.85.217.174])
        by smtp.gmail.com with ESMTPSA id e1sm2115409lbs.44.2015.11.12.01.24.55
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2015 01:24:55 -0800 (PST)
Received: by lbbcs9 with SMTP id cs9so31387959lbb.1
        for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2015 01:24:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Herve Rousseau <herve.rousseau@cern.ch>

Hi,

Firstly, we just had a look at the new
osd_scrub_interval_randomize_ratio option and found that it doesn't
really solve the deep scrubbing problem. Given the default options,

osd_scrub_min_interval = 60*60*24
osd_scrub_max_interval = 7*60*60*24
osd_scrub_interval_randomize_ratio = 0.5
osd_deep_scrub_interval = 60*60*24*7

we understand that the new option changes the min interval to the
range 1-1.5 days. However, this doesn't do anything for the thundering
herd of deep scrubs which will happen every 7 days. We've found a
configuration that should randomize deep scrubbing across two weeks,
e.g.:

osd_scrub_min_interval = 60*60*24*7
osd_scrub_max_interval = 100*60*60*24 // effectively disabling this option
osd_scrub_load_threshold = 10 // effectively disabling this option
osd_scrub_interval_randomize_ratio = 2.0
osd_deep_scrub_interval = 60*60*24*7

but that (a) doesn't allow shallow scrubs to run daily and (b) is so
far off the defaults that its basically an abuse of the intended
behaviour.

So we'd like to simplify how deep scrubbing can be randomized. Our PR
(http://github.com/ceph/ceph/pull/6550) adds a new option
osd_deep_scrub_randomize_ratio which  controls a coin flip to randomly
turn scrubs into deep scrubs. The default is tuned so roughly 1 in 7
scrubs will be run deeply.

Secondly, we'd also like to discuss the osd_scrub_load_threshold
option, where we see two problems:
   - the default is so low that it disables all the shallow scrub
randomization on all but completely idle clusters.
   - finding the correct osd_scrub_load_threshold for a cluster is
surely unclear/difficult and probably a moving target for most prod
clusters.

Given those observations, IMHO the smart Ceph admin should set
osd_scrub_load_threshold = 10 or higher, to effectively disable that
functionality. In the spirit of having good defaults, I therefore
propose that we increase the default osd_scrub_load_threshold (to at
least 5.0) and consider removing the load threshold logic completely.

Cheers,

Dan
