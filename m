From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Make libcephfs return error when unmounted?
Date: Wed, 11 Apr 2012 11:32:51 -0700
Message-ID: <2A75BD433C7F498CAB63CC83680D90C0@dreamhost.com>
References: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu>
 <4D23FD899165483BAF0CEEDC9FF75D61@dreamhost.com>
 <D283FDD9-61D3-4F93-9650-5A27F61C9E60@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49349 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab2DKScy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 14:32:54 -0400
Received: by ghrr11 with SMTP id r11so645437ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 11:32:54 -0700 (PDT)
In-Reply-To: <D283FDD9-61D3-4F93-9650-5A27F61C9E60@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Wednesday, April 11, 2012 at 11:25 AM, Noah Watkins wrote:
> 
> On Apr 11, 2012, at 11:22 AM, Greg Farnum wrote:
> 
> > On Wednesday, April 11, 2012 at 11:12 AM, Noah Watkins wrote:
> > > Hi all,
> > > 
> > > -Noah 
> > I'm not sure where the "-1004" came from,
> 
> ceph_mount(..) seems to return some random error codes (-1000, 1001) already :)

<grumble> legacy undocumented grr </grumble>
Let's try to use standard error codes where available, and (if we have to create our own) document any new ones with user-accessible names and explanations. I don't know which one is "best" but I see a lot of applicable choices when scanning errno-base et al.

Also, what Yehuda said. :)
-Greg

