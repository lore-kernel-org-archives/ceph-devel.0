From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-resource-agents
Date: Thu, 16 Feb 2012 15:09:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202161506340.20265@cobra.newdream.net>
References: <989BA3D6-5844-4566-AA9B-69A0472C0228@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47890 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab2BPXJX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2012 18:09:23 -0500
In-Reply-To: <989BA3D6-5844-4566-AA9B-69A0472C0228@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Thu, 16 Feb 2012, Noah Watkins wrote:
> On Ubuntu LTS 10.04, ceph-resource-agents package depends on resource-agents that seems to have not shown up until 11.10 so there is a dependency problem:
> 
> nwatkins@piha:~/Projects/ceph$ sudo apt-get install ceph-resource-agents
> Reading package lists... Done
> Building dependency tree       
> Reading state information... Done
> ceph-resource-agents is already the newest version.
> You might want to run 'apt-get -f install' to correct these:
> The following packages have unmet dependencies:
>  ceph-resource-agents : Depends: resource-agents but it is not installable
>                         Recommends: pacemaker but it is not going to be installed
> E: Unmet dependencies. Try 'apt-get -f install' with no packages (or specify a solution).
> 
> 
> Aside from that dependency problem, is it safe to completely omit the 
> ceph-resource-agents package for a Ceph install?

Yeah.  It just has the ocf resource agent hooks, which you probably don't 
need.

That package is a recommends, right?  This doesn't break the ceph package 
itself?

sage
