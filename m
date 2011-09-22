From: Sage Weil <sage@newdream.net>
Subject: Re: radosgw should support cdmi?
Date: Thu, 22 Sep 2011 09:21:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109220919320.17520@cobra.newdream.net>
References: <Pine.LNX.4.64.1109192033450.23670@cobra.newdream.net>
 <CAMwB3Ti3J8cdstYzpe_m7+wRfnctoTN=w+FY1w_jW4hiFH5KOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38655 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab1IVQVc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2011 12:21:32 -0400
In-Reply-To: <CAMwB3Ti3J8cdstYzpe_m7+wRfnctoTN=w+FY1w_jW4hiFH5KOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 22 Sep 2011, S?awomir Skowron wrote:
> Any decision ?? I would like to see this in RadosGW, especially, range
> support in Object Restfull API.

The obvious answer is that yes, we should support it.  The only reason I 
can see not doing so it because there is some uglyness in what SNIA ended 
up with, or it is sufficiently divigergent from the S3 and Swift APIs that 
it doesn't make sense to put it in the same proxy.

The real question is how to prioritize that support relative to 
everything else we have on our roadmap.  That we won't know until we've 
looked more closely at the standard...

Has anyone here worked with CDMI?

sage
