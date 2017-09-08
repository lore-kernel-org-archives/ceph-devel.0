From: Sage Weil <sage@newdream.net>
Subject: Re: very slow backfill on Luminous + Bluestore
Date: Fri, 8 Sep 2017 15:29:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709081528560.16664@piezo.novalocal>
References: <CAEYCsV+eUcNKAa5s6X9tZKjJ+off2WXR6o_Ayggv0ZW_E6obVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33668 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755916AbdIHP3e (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Sep 2017 11:29:34 -0400
In-Reply-To: <CAEYCsV+eUcNKAa5s6X9tZKjJ+off2WXR6o_Ayggv0ZW_E6obVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 8 Sep 2017, Xiaoxi Chen wrote:
> Hi,
> 
>      We consistently saw very slow backfilling speed on our cluster,
> although max_backfill set to 50 and do have tens of PGs in
> backfilling, but the recovery speed still are only tens of MB, even 0
> in some time.
> 
>       The background is, we first have a pool with all bluestore(on
> hdd, db also on hdd) hosting ~ 6TB data across 24 OSDs.  Then we have
> another 24 OSDs with db on SSD.  I was trying to migrade the data from
> the old 24 OSDs to new 24 OSDs, with DB on SSD.
>       So what I did is reweight crush weight of all old OSD to 0 and
> all new OSDs to 5, obviously almost all object will goes to misplaced
> state and PGs are in "active + remaped+ backfilling/wait_backfill".
> Everything looks fine except the backfilling speed is extermply low.
> 
> See below pg stat output for instance, pls ignore the degraded PG ,
> that was due to I manually mark down 2 old OSDs, just to see if it
> could change anything, but nothing.
> 
>     Every 2.0s: ceph pg stat --cluster pre-prod
> 
>                  Fri Sep  8 08:13:10 2017
> 
> 8192 pgs: 89 undersized+degraded+remapped+backfilling+peered, 324
> undersized+degraded+remapped+backfill_wait+peered, 36
> active+undersized+degraded+remapped+backfilling, 2595 activ
> e+undersized+degraded+remapped+backfill_wait, 1088 active+clean, 46
> active+remapped+backfilling, 4014 active+remapped+backfill_wait; 5494
> GB data, 18768 GB used, 3047 TB / 3065 TB
>  avail; 325 kB/s wr, 64 op/s; 539794/4301028 objects degraded
> (12.550%); 3025778/4301028 objects misplaced (70.350%); 28794 kB/s, 7
> objects/s recovering

Can you try setting

  osd_recovery_sleep = 0

on the OSDs and see if that makes a difference?

sage

