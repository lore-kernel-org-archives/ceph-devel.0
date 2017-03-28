From: Sage Weil <sage@newdream.net>
Subject: Re: some question about ceph qa case
Date: Tue, 28 Mar 2017 13:41:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703281335290.10776@piezo.novalocal>
References: <CANE=7sUCuyDjq61wPZsEGt_XcpTHv96L-aUpsdUoy_vcJBYx4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2019932727-1490708488=:10776"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54311 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932470AbdC1Nls (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Mar 2017 09:41:48 -0400
In-Reply-To: <CANE=7sUCuyDjq61wPZsEGt_XcpTHv96L-aUpsdUoy_vcJBYx4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?Q?Xinze_Chi_=28=D0=C5=D4=F3=29?= <xmdxcxz@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2019932727-1490708488=:10776
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 28 Mar 2017, Xinze Chi (信泽) wrote:
> hi, all:
> 
>      Recently, I read some qa case.  I confuse about pg move case.
> 
>      In teuthology log, I see the log "Moving pg 1.3 from osd.1 to
> osd.5". In this case, maybe the lastest data is in osd.1. After move
> the pg to osd.5, the lastest data is in osd.5.
> 
>      But in peering process, we get pg info from osd.1 instead of
> osd.5 base on osdmap. It would be wrong, right? Do I ignore some
> important info?
> 
>      Could anyone explain the pg move case in detail?

You're exactly right.  And there is a hard-to-hit race where peering 
will make a bad inference because of that; see

	http://tracker.ceph.com/issues/16003

Most of the time, though, the OSD with the imported PG copy comes up and 
notifies the new primary that it has a copy before the new primary 
concludes that the recent PG events don't exist.  Or the test model in 
ceph_test_rados just doesn't notice the resulting inconsistency.

sage
--8323329-2019932727-1490708488=:10776--
