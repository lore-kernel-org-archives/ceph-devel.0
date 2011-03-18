From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: vstart -d -n not working in 0.25.1
Date: Thu, 17 Mar 2011 17:02:03 -0700
Message-ID: <20110318000203.GB23005@dreamer>
References: <24DF3893-B686-4B01-AA71-BB249BBF5625@cs.ucsc.edu>
 <20110317235456.GA23005@dreamer>
 <4EB6395D-5648-4C65-93F6-CA0A1E3F3774@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52828 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755982Ab1CRACI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2011 20:02:08 -0400
Content-Disposition: inline
In-Reply-To: <4EB6395D-5648-4C65-93F6-CA0A1E3F3774@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Thu, Mar 17, 2011 at 04:57:00PM -0700, Noah Watkins wrote:
> I was just poking around in vstart. Looks like the IP is determined
> by `hostname --ip-address`, which for some reason my machine is
> returning IPv6. Solution is ./vstart --localhost which then selects
> the IP to be 127.0.0.1. Not sure why my machine was returning:

Yes, that'll work when you're running on just one machine.

The ticket for this is http://tracker.newdream.net/issues/898

-- 
:(){ :|:&};:
