From: Sage Weil <sage@newdream.net>
Subject: Re: ceph recovery policy
Date: Thu, 28 May 2015 08:40:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505280839460.6462@cobra.newdream.net>
References: <CAE63xUPYX=d-Xq4Qq1nnw_JvYBda3DtQYKrn_BkeN8baOxmoZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34031 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbbE1Pkc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 11:40:32 -0400
In-Reply-To: <CAE63xUPYX=d-Xq4Qq1nnw_JvYBda3DtQYKrn_BkeN8baOxmoZw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ugis <ugis22@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On Thu, 28 May 2015, Ugis wrote:
> Hi!
> 
> I have been watching changes in "ceph -s" output for a while and
> noticed that in this line:
>  3324/7888981 objects degraded (0.042%); 1995972/7888981 objects
> misplaced (25.301%)
> rather misplaced object count drops constantly, but degraded object
> count drops just occasionally.
> 
> Quick googling did not reveal any mention of recovery/rebalancing
> policy(except client vs recovery io).
> Is there any?
> I mean - it would be reasonable to recover degraded objects in first
> place and only then to rebalance misplaced objects as that would
> reduce risk of losing data.
> 
> That could be default recovey policy, but if other policy needed -
> that could be specifyable via some recovery variable, like it is now
> in recovery section here:
> http://dachary.org/loic/ceph-doc/rados/configuration/osd-config-ref/
> 
> P.S. no active client I/O currently present.

If the recovery and rebalancing ever contend for the same node, recovery 
is prioritized.  What is probaly happening in your case is that the 
rebalancing is happening elsewhere in the cluster where nothing is 
degraded...

sage
