From: Sage Weil <sweil@redhat.com>
Subject: Re: Stopping ceph daemons during the upgrade
Date: Mon, 18 Aug 2014 09:08:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408180907501.28244@cobra.newdream.net>
References: <53F21994.5000202@dachary.org> <A856D71F-CC6F-4A6A-B29B-FD19FB511482@cern.ch> <53F22300.6080702@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56126 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbaHRQIw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 12:08:52 -0400
In-Reply-To: <53F22300.6080702@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Dan Van Der Ster <daniel.vanderster@cern.ch>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 18 Aug 2014, Loic Dachary wrote:
> Hi Dan,
> 
> Pre-loading the erasure code plugins will reduce this race condition 
> (i.e. the files will have to be modified between the start of the 
> ceph-osd process and the bootstrap phase where it loads the plugins for 
> it to happen) and it seems to be preferable to stopping the daemons. 
> Thanks for giving an additional incentive to go in this direction !

BTW Loic, one other thing would could do is have a number or string in the 
.so interface that we bump when the interface changes.  Then loading the 
plugin could fail with a friendly message instead of crashing.

sage
