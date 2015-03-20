From: Sage Weil <sage@newdream.net>
Subject: Re: adding "{mds,mon} metadata" asok command
Date: Fri, 20 Mar 2015 06:30:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503200628150.7043@cobra.newdream.net>
References: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51269 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbCTNal (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Mar 2015 09:30:41 -0400
In-Reply-To: <CAJE9aOP2g4=Pw-oGY4m90aXayc=Kx_GP8yLC+tTkSE62V6ObuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 20 Mar 2015, kefu chai wrote:
> on the mon side, i will apply the same approach to MMonJoin and
> MonmapMonitor, but with another prefix when putting encoding metadata
> into transaction.

The MMonJoin is only used when expanding the cluster, i.e. when first 
adding the new monitor during cluster configuration time.

> @joao, IIRC, you were suggesting me to add another paxos service for
> this purpose but is it feasible to put this data into MMonJoin and
> persist it into the paxos service's storage?
> 
> any suggestion or comments would be appreciated. if no objections, i
> will be on it.

Instead, I suggest having each mon generate the metadata during startup.  
Then, somewhere during bootstrap(), compare the stored metadata (they all 
have a copy of the mon data set) with the actual metadata, and if it 
varies send a new message (MMonUpdateMetadata?) to the leader requesting a 
change.

Joao, what do you think?

sage

