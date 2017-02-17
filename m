From: Sage Weil <sage@newdream.net>
Subject: Re: bluestore SMR update?
Date: Fri, 17 Feb 2017 19:59:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702171953280.21487@piezo.novalocal>
References: <04EA9170BFDB1B4BB5C8DF4AA2815C11BE932837@KNEX2.knc.local> <04EA9170BFDB1B4BB5C8DF4AA2815C11BE932B5D@KNEX2.knc.local> <04EA9170BFDB1B4BB5C8DF4AA2815C11BE932B8F@KNEX2.knc.local> <alpine.DEB.2.11.1611091407370.29278@piezo.us.to>
 <20170217195249.mxgbbfjbgg75d36b@b635a87d083f65bdd9c43521>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48667 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934995AbdBQT7I (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2017 14:59:08 -0500
In-Reply-To: <20170217195249.mxgbbfjbgg75d36b@b635a87d083f65bdd9c43521>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>
Cc: Darrell Enns <darrelle@knowledge.ca>, "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

On Fri, 17 Feb 2017, Martin Millnert wrote:
> Sage,
> 
> are there any further changes since the last update on November 9?

Nope!

There is some new work in ext4 for SMR that showns that pretty modest 
changes can make things perform pretty reasonably on a drive-managed SMR 
disk.  There's an upcoming paper about it in FAST (see 
https://www.usenix.org/conference/fast17/technical-sessions 'Evolving ext4 
for shingled disks') and the patches are pending for ext4 upstream.

To me this suggests that bluestore will probably reasonbly well as is on 
drive-managed SMR disks for RGW workloads (which write larger objects in 
their entirely).  Different drives have different approaches to managing 
the 'scratch space', though; with a bit of testing we can probably 
recommend which ones will work best (my guess is those that demonstrate 
fixed overhead instead allowing a large amount of deferred work to 
accumulate).

Longer term, I think it may still be best to have bluestore manage it's 
overwrites more carefully, but depending on how well the drive-managed 
ones work it may not be worth the investment.

sage


> 
> Best,
> Martin
> 
> On Wed, Nov 09, 2016 at 02:08:25PM +0000, Sage Weil wrote:
> > On Wed, 9 Nov 2016, Darrell Enns wrote:
> > > Is there any update on the GSOC Bluestore SMR project? It seems that the 
> > > progress report wiki page has not been updated since May. I'm very 
> > > interested in the findings and what (if anything) has yet to be done to 
> > > improve bluestore SMR support.
> > 
> > We didn't complete the project, and work here as stalled while we focus on 
> > higher priority issues.  If you're interested in picking the work back 
> > up, we'd love to talk about it!
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
