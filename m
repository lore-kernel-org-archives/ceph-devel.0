From: Sage Weil <sage@newdream.net>
Subject: Re: crush rule definitions
Date: Wed, 4 May 2011 11:21:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105041119310.648@cobra.newdream.net>
References: <4DC197F3.3050200@provocation.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49244 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab1EDSVT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 14:21:19 -0400
In-Reply-To: <4DC197F3.3050200@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Wed, 4 May 2011, Zenon Panoussis wrote:
> I thought that min_size in crush is obvious, but the more I read the more
> I tend to doubt. So I might as well ask:
> 
> With a crushmap like this
> 
> ===
> type 0 device
> type 1 host
> type 2 root
> 
> [definitions for the above; hosts contain devices, root contains hosts]
> 
> rule data {
>         ruleset 0
>         type replicated
>         min_size 2
>         max_size 2
>         step take root
>         step chooseleaf firstn 0 type host
>         step emit
> }
> ===
> 
> does "min_size 2, max_size 2" mean that I want "2 copies of the data on each
> host" or "2 copies of the data in total in the entire cluster"?

Neither, actually.  It means that this rule will be used when we ask crush 
for ruleset 0 and 2 replicas.  If you change a pg to have 3x replication, 
ceph will ask for ruleset 0 and 3 replicas, and this rule won't be used.

You probably want min_size 1 and max_size 10.

The motivation is that you might have different placement rules depending 
on how many replicas there are.  That's why it's "ruleset 0" and not 
"rule 0".

sage
