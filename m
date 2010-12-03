From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] msgr: Correctly handle half-open connections.
Date: Fri, 3 Dec 2010 09:18:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012030918120.1982@cobra.newdream.net>
References: <1291318895-11879-1-git-send-email-jaschut@sandia.gov>
 <1291323999.4879.198.camel@sale659.sandia.gov> <1291394903.4879.206.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35675 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab0LCROI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Dec 2010 12:14:08 -0500
In-Reply-To: <1291394903.4879.206.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 3 Dec 2010, Jim Schutt wrote:
> FWIW, I've seen no sign of this client hung task issue 
> since I started testing with server code built from 
> current unstable branch (63fab458f625) + current
> rc branch (39b42b21e980) + current testing branch
> (1a4ad835de66) + my half-open connection patch.
> 
> This combination has survived the heaviest write loads
> (64 clients against 13 osds) that I've tested with to date.
> 
> I still see lots of clients resetting osds, but it has no
> ill effects now.

Great to hear.  I've applied the msgr fix and pushed to the 'rc' branch.

Thanks Jim!
sage
