From: Sage Weil <sage@newdream.net>
Subject: Re: PG state issue
Date: Thu, 1 Mar 2012 08:14:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203010810330.30824@cobra.newdream.net>
References: <CANExM-MJ6eSifymHe-aSwwyPkBaTSbLUVZGHVwvrcUFGpNopoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36883 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab2CAQOW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Mar 2012 11:14:22 -0500
In-Reply-To: <CANExM-MJ6eSifymHe-aSwwyPkBaTSbLUVZGHVwvrcUFGpNopoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Henry, Wido,

On Thu, 1 Mar 2012, Henry C Chang wrote:
> With version 0.42, I found that the pg's state is not in "degrade" any
> more if the number of osds is smaller than that of the replication.
> For example, if I create a cluster of one osd with replication 2, all
> pgs are in active+clean state. (The pgs were in active+clean+degrade
> state in the earlier versions.)

The PG states were tweaked a fair bit for v0.43:

- new 'recovering' state means we are actively recovering the PG (no 
  longer implied by lack of 'clean')
- 'remapped' means we have temporarily remapped a pg to a specific set of 
  OSDs (other than what CRUSH gives us)
- 'clean' specifically means we have the right number of replicas and 
  aren't remapped.

...and the 'degraded' thing you are seeing is fixed.  This is all in place 
in the 'next' or 'master' branches.

> I think it should be a bug in terms of cluster status although it does
> not cause any other problems to me so far.

Yeah, it's simply a matter of how the internal state is displayed/reported 
to the moitor.

sage
